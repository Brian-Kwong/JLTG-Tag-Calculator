import { encode } from "@googlemaps/polyline-codec";
import { decode as hereDecode } from "@here/flexpolyline";
import translate from "google-translate-api-x";

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
    GOOGLE_WALKING_STEP,
    RouteResponse,
    ResponseStep,
    transportationModeCost,
    HERE_API_RESPONSE,
} from "./routeTypes";
import {
    determineDepartureDateTimeBasedOnLocation,
    updateLocationNames,
    determineTransportationMode,
    determineLineName,
    aggregatesWalkingSteps,
} from "./utils";

/**
 * Parse the Google Maps API response to extract relevant information to return back to the client.
 * @param {GOOGLE_MAPS_API_RESPONSE} response - The response object from Google Maps API
 * @param {string} [startTime] - Optional start time in ISO format to use for the first departure time if not provided by the API
 * @return {RouteResponse[]} - An array of RouteResponse objects
 */
function parseGoogleMapsResponse(
    response: GOOGLE_MAPS_API_RESPONSE,
    startTime?: string
) {
    const routes = response.routes;
    const walkingsSteps: GOOGLE_WALKING_STEP[] = [];

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
                    if (walkingsSteps.length > 0) {
                        const aggregatedWalkingStep = aggregatesWalkingSteps(
                            walkingsSteps,
                            parsedRoute,
                            step,
                            startTime
                        );
                        if (aggregatedWalkingStep) {
                            responseSteps.push(aggregatedWalkingStep);
                        }
                        walkingsSteps.length = 0; // Clear walking steps after aggregation
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

        if (walkingsSteps.length > 0) {
            const aggregatedWalkingStep = aggregatesWalkingSteps(
                walkingsSteps,
                parsedRoute,
                undefined,
                startTime
            );
            if (aggregatedWalkingStep) {
                responseSteps.push(aggregatedWalkingStep);
            }
            walkingsSteps.length = 0; // Clear walking steps after aggregation
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
            departureDate: (
                determineDepartureDateTimeBasedOnLocation(
                    `${responseSteps[0].startLocation.lat},${responseSteps[0].startLocation.lng}`,
                    responseSteps[0].departureTime
                ).toISO() || new Date().toISOString()
            ).split("T")[0],
            arrivalDate: (
                determineDepartureDateTimeBasedOnLocation(
                    `${responseSteps[responseSteps.length - 1].endLocation.lat},${responseSteps[responseSteps.length - 1].endLocation.lng}`,
                    responseSteps[responseSteps.length - 1].arrivalTime
                ).toISO() || new Date().toISOString()
            ).split("T")[0],
            departureTime: (
                determineDepartureDateTimeBasedOnLocation(
                    `${responseSteps[0].startLocation.lat},${responseSteps[0].startLocation.lng}`,
                    responseSteps[0].departureTime
                ).toISO() || new Date().toISOString()
            )
                .split("T")[1]
                .split(".")[0],
            arrivalTime: (
                determineDepartureDateTimeBasedOnLocation(
                    `${responseSteps[responseSteps.length - 1].endLocation.lat},${responseSteps[responseSteps.length - 1].endLocation.lng}`,
                    responseSteps[responseSteps.length - 1].arrivalTime
                ).toISO() || new Date().toISOString()
            )
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
async function parseHEREMapsResponse(response: HERE_API_RESPONSE) {
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
                departureTime:
                    determineDepartureDateTimeBasedOnLocation(
                        `${section.departure.place.location.lat}, ${section.departure.place.location.lng}`,
                        section.departure.time
                    ).toISO() || new Date().toISOString(),
                arrivalTime:
                    determineDepartureDateTimeBasedOnLocation(
                        `${section.arrival.place.location.lat}, ${section.arrival.place.location.lng}`,
                        section.arrival.time
                    ).toISO() || new Date().toISOString(),
                numStops: undefined,
                transitLineFinalDestination:
                    section.transport.headsign || undefined,
            });
            // If there are incidents, add them to the step
            if (section.incidents && section.incidents.length > 0) {
                steps[steps.length - 1].incidents = await Promise.all(
                    section.incidents.map(async (incident) => ({
                        summary: (
                            await translate(
                                incident.summary || "Announcement",
                                { to: "en" }
                            )
                        ).text,
                        description: (
                            await translate(incident.description || "", {
                                to: "en",
                            })
                        ).text,
                        type: incident.type,
                        effect: incident.effect,
                        validFrom: incident.validFrom,
                        validUntil: incident.validUntil,
                        url: incident.url,
                    }))
                );
            }
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
            departureDate: (
                determineDepartureDateTimeBasedOnLocation(
                    `${steps[0].startLocation.lat},${steps[0].startLocation.lng}`,
                    steps[0].departureTime
                ).toISO() || new Date().toISOString()
            ).split("T")[0],
            arrivalDate: (
                determineDepartureDateTimeBasedOnLocation(
                    `${steps[steps.length - 1].endLocation.lat},${steps[steps.length - 1].endLocation.lng}`,
                    steps[steps.length - 1].arrivalTime
                ).toISO() || new Date().toISOString()
            ).split("T")[0],
            departureTime: (
                determineDepartureDateTimeBasedOnLocation(
                    `${steps[0].startLocation.lat},${steps[0].startLocation.lng}`,
                    steps[0].departureTime
                ).toISO() || new Date().toISOString()
            )
                .split("T")[1]
                .split(".")[0],
            arrivalTime: (
                determineDepartureDateTimeBasedOnLocation(
                    `${steps[steps.length - 1].endLocation.lat},${steps[steps.length - 1].endLocation.lng}`,
                    steps[steps.length - 1].arrivalTime
                ).toISO() || new Date().toISOString()
            )
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
            incidents: steps.flatMap((step) => step.incidents || []),
        });
        steps.length = 0;
    }
    return updateLocationNames(parsedRoutes);
}

export { parseGoogleMapsResponse, parseHEREMapsResponse };
