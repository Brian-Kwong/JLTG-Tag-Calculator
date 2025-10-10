import { find } from "geo-tz";
import { DateTime } from "luxon";

const determineDepartureDateTimeBasedOnLocation = (
    locationCoord: string,
    departureTime?: string
) => {
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
};

export { determineDepartureDateTimeBasedOnLocation };