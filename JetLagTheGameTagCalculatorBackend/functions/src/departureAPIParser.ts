/**
 * Parse the departure API response from HERE API
 * @module departureAPIParser
 *
 * Created by Kitty Brian on 10/6/25.
 */
import {
    HERE_API_NEXT_DEPARTURE_RESPONSE,
    NextDepartures,
    transportationModeCost,
} from "./routeTypes";
import {
    determineDepartureDateTimeBasedOnLocation,
    determineTransportationMode,
} from "./utils";
import haversine from "haversine-distance";
/**
 * The function to parse the next departures from HERE API response
 * @param {HERE_API_NEXT_DEPARTURE_RESPONSE} nextDepartures The next departures from a radius of stations from HERE API
 * @param {string} originalLocation The original location coordinates used to fetch the departures
 * @return {NextDepartures[]} A simplified object containing the next departures information
 */
function parseDepartureAPIResponse(
    nextDepartures: HERE_API_NEXT_DEPARTURE_RESPONSE,
    originalLocation: string
): NextDepartures[] {
    const nearbyDepartures: NextDepartures[] = [];
    for (const board of nextDepartures.boards) {
        const departures = board.departures.map((dep) => {
            return {
                time:
                    determineDepartureDateTimeBasedOnLocation(
                        board.place.location.lat +
                            "," +
                            board.place.location.lng,
                        dep.time
                    ).toISO() ?? "",
                delay: dep.delay,
                status: dep.status,
                platform: dep.platform,
                line: {
                    mode: determineTransportationMode(
                        dep.transport.mode
                    ) as keyof typeof transportationModeCost,
                    name: dep.transport.name,
                    color: dep.transport.color,
                    transitLineFinalDestination: dep.transport.headsign,
                },
                agency: {
                    id: dep.agency.id,
                    name: dep.agency.name,
                    website: dep.agency.website,
                },
            };
        });
        // Determine station type by checking the transportation modes of its departures
        const modes = new Map<keyof typeof transportationModeCost, number>();
        let maxCount = 0;
        for (const dep of departures) {
            const count = (modes.get(dep.line.mode) || 0) + 1;
            if (count > maxCount) {
                maxCount = count;
                board.place.type = dep.line.mode;
            }
            modes.set(dep.line.mode, count);
        }
        nearbyDepartures.push({
            station: {
                name: board.place.name,
                id: board.place.id,
                lat: board.place.location.lat,
                lng: board.place.location.lng,
                type: board.place.type,
                distance: haversine(
                    {
                        latitude: parseFloat(originalLocation.split(",")[0]),
                        longitude: parseFloat(originalLocation.split(",")[1]),
                    },
                    {
                        latitude: board.place.location.lat,
                        longitude: board.place.location.lng,
                    }
                ),
            },
            departures: departures as NextDepartures["departures"],
        });
    }
    return nearbyDepartures;
}

export { parseDepartureAPIResponse };
