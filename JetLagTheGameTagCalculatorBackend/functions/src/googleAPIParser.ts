import { decode, encode } from "@googlemaps/polyline-codec";
import { decode as hereDecode } from "@here/flexpolyline";

/**
 * Functions to parse responses from Google Maps and HERE Maps APIs into a
 * standardized shared format to be sent back to the client.
 * @module googleAPIParser
 * @module hereAPIParser
 *
 * Created by Kitty Brian on 10/4/25.
 */

import {
    GOOGLE_MAPS_API_RESPONSE,
    RouteResponse,
    ResponseStep,
    transportationMode,
    transportationModeCost,
    HERE_API_RESPONSE,
} from "./routeTypes";
import { determineDepartureDateTimeBasedOnLocation } from "./utils";

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
 * Parse the Google Maps API response to extract relevant information to return back to the client.
 * @param {GOOGLE_MAPS_API_RESPONSE} response - The response object from Google Maps API
 * @return {RouteResponse[]} - An array of RouteResponse objects
 */
function parseGoogleMapsResponse(response: GOOGLE_MAPS_API_RESPONSE) {
    const routes = response.routes;
    const walkingsSteps: Array<{
        distanceMeters: number;
        staticDuration: string;
        polyline: string;
        startLocation: {
            latLng: {
                latitude: number;
                longitude: number;
            };
        };
        endLocation: {
            latLng: {
                latitude: number;
                longitude: number;
            };
        };
        travelMode: string;
    }> = [];

    const responseSteps: ResponseStep[] = [];
    const parsedRoute: RouteResponse[] = [];
    for (const route of routes) {
        for (const leg of route.legs) {
            for (const step of leg.steps) {
                if (step.travelMode === "WALK") {
                    walkingsSteps.push({
                        distanceMeters: step.distanceMeters || 0,
                        staticDuration: step.staticDuration,
                        polyline: step.polyline.encodedPolyline,
                        startLocation: {
                            latLng: {
                                latitude: step.startLocation.latLng.latitude,
                                longitude: step.startLocation.latLng.longitude,
                            },
                        },
                        endLocation: {
                            latLng: {
                                latitude: step.endLocation.latLng.latitude,
                                longitude: step.endLocation.latLng.longitude,
                            },
                        },
                        travelMode: step.travelMode,
                    });
                } else if (step.travelMode === "TRANSIT") {
                    // Collect all the walking steps into one
                    // Get total walking distance and duration
                    if (walkingsSteps.length > 0) {
                        let totalWalkingDistance = 0;
                        let totalWalkingDuration = 0;
                        const polyLineArray: number[][] = [];
                        let polyline = "";

                        // Get the last transit station as the start location of the walking segment
                        const startLocationName = responseSteps.length
                            ? responseSteps[responseSteps.length - 1]
                                  .endLocation.name
                            : walkingsSteps[0].startLocation.latLng.latitude +
                              ", " +
                              walkingsSteps[0].startLocation.latLng.longitude;
                        const endLocationName = step.transitDetails
                            ? step.transitDetails.stopDetails.departureStop.name
                            : walkingsSteps[walkingsSteps.length - 1]
                                  .endLocation.latLng.latitude +
                              ", " +
                              walkingsSteps[walkingsSteps.length - 1]
                                  .endLocation.latLng.longitude;
                        // Get the first transit station as the end location of the walking segment
                        for (const walkingStep of walkingsSteps) {
                            totalWalkingDistance += walkingStep.distanceMeters;
                            totalWalkingDuration += parseInt(
                                walkingStep.staticDuration
                            );
                            polyLineArray.push(
                                ...decode(walkingStep.polyline, 5)
                            );
                        }
                        polyline = encode(polyLineArray, 5);
                        responseSteps.push({
                            transportationMode: "WALKING",
                            distance: totalWalkingDistance,
                            polyline: polyline,
                            startLocation: {
                                name:
                                    startLocationName ||
                                    walkingsSteps[0].startLocation.latLng
                                        .latitude +
                                        ", " +
                                        walkingsSteps[0].startLocation.latLng
                                            .longitude,
                                lat: walkingsSteps[0].startLocation.latLng
                                    .latitude,
                                lng: walkingsSteps[0].startLocation.latLng
                                    .longitude,
                            },
                            endLocation: {
                                name:
                                    endLocationName ||
                                    walkingsSteps[walkingsSteps.length - 1]
                                        .endLocation.latLng.latitude +
                                        ", " +
                                        walkingsSteps[walkingsSteps.length - 1]
                                            .endLocation.latLng.longitude,
                                lat: walkingsSteps[walkingsSteps.length - 1]
                                    .endLocation.latLng.latitude,
                                lng: walkingsSteps[walkingsSteps.length - 1]
                                    .endLocation.latLng.longitude,
                            },
                            duration: totalWalkingDuration,
                            journeyCost: Math.ceil(
                                transportationModeCost.WALKING *
                                    (totalWalkingDuration / 60)
                            ),
                        departureTime: determineDepartureDateTimeBasedOnLocation(
                            `${walkingsSteps[0].startLocation.latLng.latitude},${walkingsSteps[0].startLocation.latLng.longitude}`,
                            ""
                        ).toISO() || new Date().toISOString(),
                        arrivalTime: determineDepartureDateTimeBasedOnLocation(
                            `${walkingsSteps[walkingsSteps.length - 1].endLocation.latLng.latitude},${walkingsSteps[walkingsSteps.length - 1].endLocation.latLng.longitude}`,
                            ""
                        ).toISO() || new Date().toISOString(),
                        });
                        walkingsSteps.length = 0; // Clear the walking steps
                    }
                    if (step.transitDetails) {
                        const transportationMode = determineTransportationMode(
                            step.transitDetails.transitLine.vehicle.type.toUpperCase()
                        );
                        responseSteps.push({
                            transportationMode:
                                transportationMode as keyof typeof transportationModeCost,
                            startLocation: {
                                name: step.transitDetails.stopDetails
                                    .departureStop.name,
                                lat: step.startLocation.latLng.latitude,
                                lng: step.startLocation.latLng.longitude,
                            },
                            endLocation: {
                                name: step.transitDetails.stopDetails
                                    .arrivalStop.name,
                                lat: step.endLocation.latLng.latitude,
                                lng: step.endLocation.latLng.longitude,
                            },
                            distance: step.distanceMeters,
                            polyline: step.polyline.encodedPolyline,
                            duration: parseInt(step.staticDuration),
                            journeyCost: Math.ceil(
                                transportationModeCost[
                                    transportationMode as keyof typeof transportationModeCost
                                ] *
                                    (parseInt(step.staticDuration) / 60)
                            ),
                            lineName: determineLineName(
                                step.transitDetails.transitLine.name,
                                step.transitDetails.transitLine.nameShort,
                                transportationMode as keyof typeof transportationModeCost,
                                step.transitDetails.transitLine.vehicle.name
                                    .text
                            ),
                            vehicleType:
                                step.transitDetails.transitLine.vehicle.name
                                    .text,
                            departureTime:
                                determineDepartureDateTimeBasedOnLocation(
                                    `${step.startLocation.latLng.latitude},${step.startLocation.latLng.longitude}`,
                                    step.transitDetails.stopDetails
                                        .departureTime
                                ).toISO() || new Date().toISOString(),
                            arrivalTime:
                                determineDepartureDateTimeBasedOnLocation(
                                    `${step.endLocation.latLng.latitude},${step.endLocation.latLng.longitude}`,
                                    step.transitDetails.stopDetails.arrivalTime
                                ).toISO() || new Date().toISOString(),
                            numStops: step.transitDetails.stopCount,
                            transitLineFinalDestination:
                                step.transitDetails.headsign,
                        });
                    }
                } else {
                    continue;
                }
            }
        }
        // Filter for any steps that have the same start and end location (some walking steps can be like this provided by the Google Maps API)
        const filteredResponseSteps = responseSteps.filter(
            (step) =>
                !(
                    step.startLocation.name === step.endLocation.name ||
                    (step.startLocation.lat === step.endLocation.lat &&
                        step.startLocation.lng === step.endLocation.lng)
                )
        );
        responseSteps.length = 0;
        responseSteps.push(...filteredResponseSteps);
        if (responseSteps.length === 0) {
            // Skip there are no valid steps
            continue;
        }
        parsedRoute.push({
            departureLocation: {
                name: responseSteps[0].startLocation.name,
                lat: responseSteps[0].startLocation.lat,
                lng: responseSteps[0].startLocation.lng,
            },
            arrivalLocation: {
                name: responseSteps[responseSteps.length - 1].endLocation.name,
                lat: responseSteps[responseSteps.length - 1].endLocation.lat,
                lng: responseSteps[responseSteps.length - 1].endLocation.lng,
            },
            departureDate: (determineDepartureDateTimeBasedOnLocation(
                `${responseSteps[0].startLocation.lat},${responseSteps[0].startLocation.lng}`,
                responseSteps[0].departureTime
            ).toISO() || new Date().toISOString())
                .split("T")[0],
            arrivalDate: (determineDepartureDateTimeBasedOnLocation(
                `${responseSteps[responseSteps.length - 1].endLocation.lat},${responseSteps[responseSteps.length - 1].endLocation.lng}`,
                responseSteps[responseSteps.length - 1].arrivalTime
            )
                .toISO() || new Date().toISOString())
                .split("T")[0],
            departureTime: (determineDepartureDateTimeBasedOnLocation(
                `${responseSteps[0].startLocation.lat},${responseSteps[0].startLocation.lng}`,
                responseSteps[0].departureTime
            )
                .toISO() || new Date().toISOString())
                .split("T")[1]
                .split(".")[0],
            arrivalTime: (determineDepartureDateTimeBasedOnLocation(
                `${responseSteps[responseSteps.length - 1].endLocation.lat},${responseSteps[responseSteps.length - 1].endLocation.lng}`,
                responseSteps[responseSteps.length - 1].arrivalTime
            )
                .toISO() || new Date().toISOString())
                .split("T")[1]
                .split(".")[0],
            totalDuration: Math.ceil(
                responseSteps.reduce((acc, step) => acc + step.duration, 0)
            ),
            totalDistance: responseSteps.reduce(
                (acc, step) => acc + step.distance,
                0
            ),
            totalCost: responseSteps.reduce(
                (acc, step) => acc + (step.journeyCost || 0),
                0
            ),
            numTransfers:
                responseSteps.filter(
                    (step) => step.transportationMode !== "WALKING"
                ).length - 1,
            numSteps: responseSteps.length,
            steps: structuredClone(responseSteps),
        });
        responseSteps.length = 0; // Clear for the next route
    }
    return updateLocationNames(parsedRoute);
}

/** Parse the HERE Maps API response to extract relevant information to return back to the client.
 * @param {HERE_API_RESPONSE} response - The response object from HERE Maps API
 * @return {RouteResponse[]} - An array of RouteResponse objects
 */
function parseHEREMapsResponse(response: HERE_API_RESPONSE) {
    const routes = response.routes;
    const steps: ResponseStep[] = [];
    const parsedRoutes: RouteResponse[] = [];
    for (const route of routes) {
        for (const section of route.sections) {
            const transportationMode = determineTransportationMode(
                section.transport.mode
            );
            steps.push({
                transportationMode:
                    transportationMode as keyof typeof transportationModeCost,
                startLocation: {
                    name:
                        section.departure.place.name ||
                        `${section.departure.place.location.lat}, ${section.departure.place.location.lng}`,
                    lat: section.departure.place.location.lat,
                    lng: section.departure.place.location.lng,
                },
                endLocation: {
                    name:
                        section.arrival.place.name ||
                        `${section.arrival.place.location.lat}, ${section.arrival.place.location.lng}`,
                    lat: section.arrival.place.location.lat,
                    lng: section.arrival.place.location.lng,
                },
                duration:
                    new Date(section.arrival.time).getTime() / 1000 -
                    new Date(section.departure.time).getTime() / 1000,
                distance: section.travelSummary?.length || 0,
                polyline: encode(hereDecode(section.polyline).polyline, 5),
                journeyCost: Math.ceil(
                    transportationModeCost[
                        transportationMode as keyof typeof transportationModeCost
                    ] *
                        ((new Date(section.arrival.time).getTime() / 1000 -
                            new Date(section.departure.time).getTime() / 1000) /
                            60)
                ),
                lineName: determineLineName(
                    section.transport.name,
                    section.transport.shortName,
                    transportationMode as keyof typeof transportationModeCost,
                    section.transport.description || undefined
                ),
                vehicleType: section.transport.mode || undefined,
                departureTime: determineDepartureDateTimeBasedOnLocation(
                    `${section.departure.place.location.lat}, ${section.departure.place.location.lng}`,
                    section.departure.time
                ).toISO() || new Date().toISOString(),
                arrivalTime: determineDepartureDateTimeBasedOnLocation(
                    `${section.arrival.place.location.lat}, ${section.arrival.place.location.lng}`,
                    section.arrival.time
                ).toISO() || new Date().toISOString(),
                numStops: undefined,
                transitLineFinalDestination:
                    section.transport.headsign || undefined,
            });
        }
        parsedRoutes.push({
            departureLocation: {
                name: steps[0].startLocation.name,
                lat: steps[0].startLocation.lat,
                lng: steps[0].startLocation.lng,
            },
            arrivalLocation: {
                name: steps[steps.length - 1].endLocation.name,
                lat: steps[steps.length - 1].endLocation.lat,
                lng: steps[steps.length - 1].endLocation.lng,
            },
            departureDate: (determineDepartureDateTimeBasedOnLocation(
                `${steps[0].startLocation.lat},${steps[0].startLocation.lng}`,
                steps[0].departureTime
            ).toISO() || new Date().toISOString())
                .split("T")[0],
            arrivalDate: (determineDepartureDateTimeBasedOnLocation(
                `${steps[steps.length - 1].endLocation.lat},${steps[steps.length - 1].endLocation.lng}`,
                steps[steps.length - 1].arrivalTime
            )
                .toISO() || new Date().toISOString())
                .split("T")[0],
            departureTime: (determineDepartureDateTimeBasedOnLocation(
                `${steps[0].startLocation.lat},${steps[0].startLocation.lng}`,
                steps[0].departureTime
            ).toISO() || new Date().toISOString())
                .split("T")[1]
                .split(".")[0],
            arrivalTime: (determineDepartureDateTimeBasedOnLocation(
                `${steps[steps.length - 1].endLocation.lat},${steps[steps.length - 1].endLocation.lng}`,
                steps[steps.length - 1].arrivalTime
            ).toISO() || new Date().toISOString())
                .split("T")[1]
                .split(".")[0],
            totalDistance: Math.ceil(
                steps.reduce((acc, step) => acc + step.distance, 0)
            ),
            totalDuration: steps.reduce((acc, step) => acc + step.duration, 0),
            totalCost: steps.reduce(
                (acc, step) => acc + (step.journeyCost || 0),
                0
            ),
            numTransfers:
                steps.filter((step) => step.transportationMode !== "WALKING")
                    .length - 1,
            numSteps: steps.length,
            steps: structuredClone(steps),
        });
        steps.length = 0;
    }
    return updateLocationNames(parsedRoutes);
}

export { parseGoogleMapsResponse, parseHEREMapsResponse };
