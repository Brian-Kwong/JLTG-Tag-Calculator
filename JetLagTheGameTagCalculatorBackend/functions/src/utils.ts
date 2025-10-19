import { find } from "geo-tz";
import { DateTime } from "luxon";
import {
    Departure,
    RouteResponse,
    transportationMode,
    transportationModeCost,
} from "./routeTypes";

/**
 * Determine the departure DateTime based on the provided location coordinates and optional departure time.
 * If the departure time is not provided or invalid, the current time in the location's timezone is used.
 * @param {string} locationCoord - The coordinates of the location in "latitude,longitude" format
 * @param {string | undefined} departureTime - Optional departure time in a format ISO 8601 string or any format parsable by Date constructor
 * @return {DateTime} - The determined DateTime object in the location's timezone
 */
function determineDepartureDateTimeBasedOnLocation(
    locationCoord: string,
    departureTime?: string
): DateTime {
    let timeZone = "UTC";
    try {
        const timezones = find(
            parseFloat((locationCoord as string).split(",")[0]),
            parseFloat((locationCoord as string).split(",")[1])
        );
        if (timezones && timezones.length > 0) {
            timeZone = timezones[0];
        }
    } catch {
        // Just use UTC
    }
    try {
        const departureDateTime = departureTime
            ? DateTime.fromJSDate(new Date(departureTime as string)).setZone(
                  timeZone
              )
            : DateTime.now().setZone(timeZone);
        return departureDateTime;
    } catch {
        // If invalid format, just use now
        const departureDateTime = DateTime.now().setZone(timeZone);
        return departureDateTime;
    }
}

/**
 * Update the location names to "Start Location" and "End Location" if they are coordinates.
 * @param {RouteResponse[]} parsedRoutes - array of RouteResponse objects to inspect and update
 * @return {RouteResponse[]} - the same array with departure and arrival names replaced when they are coordinate strings
 */
function updateLocationNames(parsedRoutes: RouteResponse[]): RouteResponse[] {
    if (parsedRoutes.length > 0) {
        for (const route of parsedRoutes) {
            // Match if coordinates then replace with "Start Location" or "End Location"
            if (
                route.departureLocation.name.match(
                    /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/
                )
            ) {
                route.departureLocation.name = "Start Location";
            }
            if (
                route.arrivalLocation.name.match(
                    /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/
                )
            ) {
                route.arrivalLocation.name = "End Location";
            }
            // Also replace in steps 0 and last
            if (
                route.steps[0].startLocation.name.match(
                    /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/
                )
            ) {
                route.steps[0].startLocation.name = "Start Location";
            }
            if (
                route.steps[route.steps.length - 1].endLocation.name.match(
                    /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/
                )
            ) {
                route.steps[route.steps.length - 1].endLocation.name =
                    "End Location";
            }
        }
    }
    return parsedRoutes;
}

/**
 * Determine the transportation mode based on the Google Maps API response vehicle type.
 * @param {string} type - transportation type from Google Maps API
 * @return {string} - the determined transportation mode
 */
function determineTransportationMode(type: string) {
    if (transportationMode.HIGH_SPEED_RAIL.includes(type)) {
        return "HIGH_SPEED_RAIL";
    } else if (transportationMode.LOW_SPEED_RAIL.includes(type)) {
        return "LOW_SPEED_RAIL";
    } else if (transportationMode.METRO.includes(type)) {
        return "METRO";
    } else if (transportationMode.BUS.includes(type)) {
        return "BUS";
    } else if (transportationMode.FERRY.includes(type)) {
        return "FERRY";
    } else if (transportationMode.FLIGHT.includes(type)) {
        return "FLIGHT";
    } else if (type === "WALK" || type === "pedestrian") {
        return "WALKING";
    } else {
        return "LOW_SPEED_RAIL";
    }
}

/** Determine the line name based on the provided name and short name.
 * @param {string | undefined} name - The full name of the line
 * @param {string | undefined} shortName - The short name of the line
 * @param { transportationMode } transport
 * @param {string | undefined} vehicleName - The specific name of the vehicle (e.g., bus, regional train)
 * @return {string | undefined} - The determined line name or undefined if both are not provided
 */
function determineLineName(
    name: string | undefined,
    shortName: string | undefined,
    transport: keyof typeof transportationModeCost,
    vehicleName: string | undefined
) {
    if (shortName && shortName.trim() === "" && name && name.trim() === "") {
        return undefined;
    }
    let baseName = "";
    if (name && name.trim() !== "") {
        baseName += `${name.trim()}`;
    } else if (shortName && shortName.trim() !== "") {
        if (baseName !== "") {
            baseName += ` (${shortName.trim()})`;
        } else {
            baseName += `${shortName.trim()}`;
        }
    }
    if (transport === "BUS" || transport === "METRO") {
        baseName = `Line ${baseName}`;
    } else {
        if (vehicleName && vehicleName.trim() !== "") {
            baseName = `${baseName} ${vehicleName.trim()}`;
        }
    }
    return baseName.trim() === "" ? undefined : baseName.trim();
}

/**
 * Convert transportation modes from the application to HERE API format.
 * @param {string} mode The transportation category
 * @return {string[]} The corresponding HERE API transport modes NOTE that an empty array means walking only since HERE doesn't have a exclusion for walking
 */
function transportationModeToHereTransportModes(mode: string) : string[] {
    switch (mode) {
        case "HIGH_SPEED_RAIL":
            return ["highSpeedTrain"];
        case "LOW_SPEED_RAIL":
            return ["intercityTrain","interRegionalTrain","regionalTrain","cityTrain"];
        case "METRO":
            return ["subway","lightRail","inclined","aerial","monorail"];
        case "BUS":
            return ["bus", "busRapid"]
        case "FERRY":
            return ["ferry"];
        case "FLIGHT":
            return ["flight"];
        case "WALKING":
            return [];
        default:
            return [];
    }
}

/**
 * Determine the station type based on the transportation modes of its departures.
 * @param {Departure[]} departures
 * @return {transportationModeCost} The determined station type
 */
function determineStationType(departures : Departure []) : keyof typeof transportationModeCost {
            // Determine station type by checking the transportation modes of its departures
            const modes = new Map<keyof typeof transportationModeCost, number>();
            let type : keyof typeof transportationModeCost = "LOW_SPEED_RAIL"; // Default type
            let maxCount = 0;
            for (const dep of departures) {
                const count = (modes.get(dep.line.mode) || 0) + 1;
                if (count > maxCount) {
                    maxCount = count;
                    type = dep.line.mode;
                }
                modes.set(dep.line.mode, count);
            }
            return type;
}

export {
    determineDepartureDateTimeBasedOnLocation,
    updateLocationNames,
    determineTransportationMode,
    determineLineName,
    transportationModeToHereTransportModes,
    determineStationType
};
