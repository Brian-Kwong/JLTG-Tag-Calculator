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
    determineStationType,
} from "./utils";
import haversine from "haversine-distance";

/**
 * This function groups departures from related stations (e.g., multiple platforms or companies at the same station)
 * @param {NextDepartures} departures
 * @return {NextDepartures[]} The grouped departures by station
 */
function groupRelatedStationsDepartures(
    departures: NextDepartures[]
): NextDepartures[] {
    // Stations are grouped by name and location (lat, lng)
    const groupedStations = new Map<
        string,
        {
            station: NextDepartures["station"];
            departures: NextDepartures["departures"];
        }
    >();
    for (const station of departures) {
        const key = `${station.station.name}`;
        if (!groupedStations.has(key)) {
            groupedStations.set(key, {
                station: station.station,
                departures: station.departures,
            });
        } else {
            const existing = groupedStations.get(key);
            if (existing) {
                existing.departures.push(...station.departures);
                existing.station.type = determineStationType(
                    existing.departures
                );
                existing.departures.sort((a, b) => {
                    return a.time.localeCompare(b.time);
                });
            }
        }
    }
    return Array.from(groupedStations.values());
}

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
        nearbyDepartures.push({
            station: {
                name: board.place.name.replace("/", "&"),
                id: board.place.id,
                lat: board.place.location.lat,
                lng: board.place.location.lng,
                type: determineStationType(departures),
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
    return groupRelatedStationsDepartures(nearbyDepartures);
}

export { parseDepartureAPIResponse };
