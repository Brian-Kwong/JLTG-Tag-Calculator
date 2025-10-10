/**
 * Express router to handle route calculation requests using HERE and Google Maps routing APIs.
 * For production, HERE API will be used primarily, with Google Maps as a fallback.
 * @module fetchRoutes
 *
 * Created by Kitty Brian on 10/4/25.
 */

import express from "express";
import dotenv from "dotenv";
import {
  parseGoogleMapsResponse,
  parseHEREMapsResponse,
} from "./googleAPIParser";
import haversine from "haversine-distance";
import { determineDepartureDateTimeBasedOnLocation } from "./utils";

dotenv.config();

const createRouter = express.Router;
const router = createRouter();


const calculateRouteBasedOffHereApi = async (req: express.Request) => {
    const { originCoord, destinationCoord, departureTime } = req.query;
    if (!originCoord || !destinationCoord) {
        return {
            status: 400,
            message: "originCoord and destinationCoord are required",
        };
    }
    if (departureTime) {
        const depTime = new Date(departureTime as string);
        if (isNaN(depTime.getTime())) {
            return {
                status: 400,
                message: "Invalid departureTime format",
            };
        }
    }
    const hereApiKey = process.env.HERE_API_KEY;
    const transitURL =
        `https://transit.router.hereapi.com/v8/routes?apiKey=${hereApiKey}&origin=${originCoord}&destination=${destinationCoord}&alternatives=10&return=bookingLinks,polyline,travelSummary` +
        (departureTime
            ? `&departureTime=${determineDepartureDateTimeBasedOnLocation(
                  originCoord as string,
                  departureTime as string
              ).toISO()}`
            : "");
    try {
        const transitResponse = await fetch(`${transitURL}`);
        if (!transitResponse.ok) {
            console.error(
                "Error fetching transit data:",
                await transitResponse.text()
            );
            return {
                status: transitResponse.status,
                message: "Error fetching transit data",
            };
        }
        const transitData = await transitResponse.json();
        if (!transitData.routes || transitData.routes.length === 0) {
            return {
                status: 404,
                message: "No routes found",
            };
        }
        const parsedTransitData = parseHEREMapsResponse(transitData);

        console.log("HERE API used for route calculation");
        return {
            status: 200,
            data: parsedTransitData,
        };
    } catch (error) {
        console.error("Error parsing transit data:", error);
        return {
            status: 500,
            message: "Error parsing transit data",
        };
    }
};

const calculateRouteBasedOffGoogleApi = async (req: express.Request) => {
    const { originCoord, destinationCoord, departureTime } = req.query;
    if (!originCoord || !destinationCoord) {
        return {
            status: 400,
            message: "originCoord and destinationCoord are required",
        };
    }
    const googleApiKey = process.env.GOOGLE_API_KEY;
    const googleURL =
        "https://routes.googleapis.com/directions/v2:computeRoutes";
    if (departureTime) {
        const depTime = new Date(departureTime as string);
        if (isNaN(depTime.getTime())) {
            return {
                status: 400,
                message: "Invalid departureTime format",
            };
        }
    }
    const body = {
        origin: {
            location: {
                latLng: {
                    latitude: (originCoord as string).split(",")[0],
                    longitude: (originCoord as string).split(",")[1],
                },
            },
        },
        destination: {
            location: {
                latLng: {
                    latitude: (destinationCoord as string).split(",")[0],
                    longitude: (destinationCoord as string).split(",")[1],
                },
            },
        },
        travelMode: "TRANSIT",
        departureTime: determineDepartureDateTimeBasedOnLocation(
            originCoord as string,
            departureTime as string | undefined
        ).toISO(),
        computeAlternativeRoutes: true,
        languageCode: "en",
    };
    try {
        const googleResponse = await fetch(`${googleURL}`, {
            method: "POST",
            headers: {
                "X-Goog-Api-Key": googleApiKey,
                "Content-Type": "application/json",
                "X-Goog-FieldMask": "routes.legs.steps.*",
            } as Record<string, string>,
            body: JSON.stringify(body),
        });
        if (!googleResponse.ok) {
            console.error(
                "Error fetching Google data:",
                await googleResponse.text()
            );
            return {
                status: googleResponse.status,
                message: "Error fetching Google data",
            };
        }
        const googleData = await googleResponse.json();
        if (!googleData.routes || googleData.routes.length === 0) {
            return {
                status: 404,
                message: "No routes found",
            };
        }
        const parsedResponse = parseGoogleMapsResponse(googleData);
        return {
            status: 200,
            data: parsedResponse,
        };
    } catch (error) {
        console.error("Error fetching Google data:", error);
        return {
            status: 500,
            message: "Error fetching Google data",
        };
    }
};

router.get("/calculateRoute", async function (req, res) {
    const { originCoord, destinationCoord } = req.query;
    if (!originCoord || !destinationCoord) {
        return res
            .status(400)
            .json({ error: "originCoord and destinationCoord are required" });
    }

    // If its more than a day in the future or greater than 750km, use Google API directly
    const departureTime = req.query.departureTime
        ? new Date(req.query.departureTime as string)
        : new Date();
    const now = new Date();
    const oneDayFromNow = new Date(now.getTime() + 24 * 60 * 60 * 1000);

    // Check the distance between the two locations
    const distance = haversine(
        {
            lat: parseFloat((originCoord as string).split(",")[0]),
            lng: parseFloat((originCoord as string).split(",")[1]),
        },
        {
            lat: parseFloat((destinationCoord as string).split(",")[0]),
            lng: parseFloat((destinationCoord as string).split(",")[1]),
        }
    );

    if (departureTime > oneDayFromNow || distance > 1000 * 750) {
        const googleRouteResult = await calculateRouteBasedOffGoogleApi(req);
        return res
            .status(googleRouteResult.status)
            .json(
                googleRouteResult.data || { error: googleRouteResult.message }
            );
    }

    const routeResult = await calculateRouteBasedOffHereApi(req);
    if (routeResult.status !== 200) {
        // Fallback to Google API
        console.log("Falling back to Google API");
        const googleRouteResult = await calculateRouteBasedOffGoogleApi(req);
        return res
            .status(googleRouteResult.status)
            .json(
                googleRouteResult.data || { error: googleRouteResult.message }
            );
    }
    if (routeResult.status !== 200) {
        return res
            .status(routeResult.status)
            .json({ error: routeResult.message || "Error calculating route" });
    }
    return res
        .status(routeResult.status)
        .json(routeResult.data || { error: routeResult.message });
});

router.use((_req, res) => {
  return res.status(404).json({
    error: "The requested resource was not found",
  });
});

export default router;
