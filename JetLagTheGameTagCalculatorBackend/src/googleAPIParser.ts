import {
  GOOGLE_MAPS_API_RESPONSE,
  RouteResponse,
  ResponseStep,
  transportationMode,
  transportationModeCost,
  HERE_API_RESPONSE,
} from "./routeTypes";

function updateLocationNames(parsedRoutes: RouteResponse[]) {
  // Replace the first route departure name with "Start Location" and last route arrival name with "End Location"
  if (parsedRoutes.length > 0) {
    for (const route of parsedRoutes) {
      // Match if coordinates then replace with "Start Location" or "End Location"
      if (
        route.departureLocation.name.match(
          /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?((1[0-7]\d)|([1-9]?\d)(\.\d+)?|180(\.0+)?)$/,
        )
      ) {
        route.departureLocation.name = "Start Location";
      }
      if (
        route.arrivalLocation.name.match(
          /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?((1[0-7]\d)|([1-9]?\d)(\.\d+)?|180(\.0+)?)$/,
        )
      ) {
        route.arrivalLocation.name = "End Location";
      }
      // Also replace in steps 0 and last
      if (
        route.steps[0].startLocation.name.match(
          /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?((1[0-7]\d)|([1-9]?\d)(\.\d+)?|180(\.0+)?)$/,
        )
      ) {
        route.steps[0].startLocation.name = "Start Location";
      }
      if (
        route.steps[route.steps.length - 1].endLocation.name.match(
          /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?((1[0-7]\d)|([1-9]?\d)(\.\d+)?|180(\.0+)?)$/,
        )
      ) {
        route.steps[route.steps.length - 1].endLocation.name = "End Location";
      }
    }
  }
  return parsedRoutes;
}

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
            let polyline = "";
            for (const walkingStep of walkingsSteps) {
              totalWalkingDistance += walkingStep.distanceMeters;
              totalWalkingDuration += parseInt(walkingStep.staticDuration);
              polyline += walkingStep.polyline;
            }
            responseSteps.push({
              transportationMode: "WALKING",
              distance: totalWalkingDistance,
              polyline: polyline,
              startLocation: {
                name:
                  walkingsSteps[0].startLocation.latLng.latitude +
                  ", " +
                  walkingsSteps[0].startLocation.latLng.longitude,
                lat: walkingsSteps[0].startLocation.latLng.latitude,
                lng: walkingsSteps[0].startLocation.latLng.longitude,
              },
              endLocation: {
                name:
                  walkingsSteps[walkingsSteps.length - 1].endLocation.latLng
                    .latitude +
                  ", " +
                  walkingsSteps[walkingsSteps.length - 1].endLocation.latLng
                    .longitude,
                lat: walkingsSteps[walkingsSteps.length - 1].endLocation.latLng
                  .latitude,
                lng: walkingsSteps[walkingsSteps.length - 1].endLocation.latLng
                  .longitude,
              },
              duration: totalWalkingDuration,
              journeyCost:
                transportationModeCost.WALKING * (totalWalkingDuration / 60),
            });
            walkingsSteps.length = 0; // Clear the walking steps
          }
          const transportationMode = determineTransportationMode(
            step.transitDetails.transitLine.vehicle.type.toUpperCase(),
          );
          responseSteps.push({
            transportationMode:
              transportationMode as keyof typeof transportationModeCost,
            startLocation: {
              name: step.transitDetails.stopDetails.departureStop.name,
              lat: step.startLocation.latLng.latitude,
              lng: step.startLocation.latLng.longitude,
            },
            endLocation: {
              name: step.transitDetails.stopDetails.arrivalStop.name,
              lat: step.endLocation.latLng.latitude,
              lng: step.endLocation.latLng.longitude,
            },
            distance: step.distanceMeters,
            polyline: step.polyline.encodedPolyline,
            duration: parseInt(step.staticDuration),
            journeyCost:
              transportationModeCost[
                transportationMode as keyof typeof transportationModeCost
              ] *
              (parseInt(step.staticDuration) / 60),
            lineName: step.transitDetails.transitLine.name,
            vehicleType: step.transitDetails.transitLine.vehicle.name.text,
            departureTime: step.transitDetails.stopDetails.departureTime,
            arrivalTime: step.transitDetails.stopDetails.arrivalTime,
            numStops: step.transitDetails.stopCount,
            transitLineFinalDestination: step.transitDetails.headsign,
          });
        } else {
          continue;
        }
      }
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
      departureDate: new Date().toISOString().split("T")[0],
      arrivalDate: new Date(
        responseSteps[responseSteps.length - 1].arrivalTime || "",
      )
        .toISOString()
        .split("T")[0],
      departureTime: new Date()
        .toISOString()
        .split("T")[1]
        .split(".")[0],
      arrivalTime: new Date(
        responseSteps[responseSteps.length - 1].arrivalTime || "",
      )
        .toISOString()
        .split("T")[1]
        .split(".")[0],
      totalDuration: responseSteps.reduce(
        (acc, step) => acc + step.duration,
        0,
      ),
      totalDistance: responseSteps.reduce(
        (acc, step) => acc + step.distance,
        0,
      ),
      totalCost: responseSteps.reduce(
        (acc, step) => acc + (step.journeyCost || 0),
        0,
      ),
      numTransfers:
        responseSteps.filter((step) => step.transportationMode !== "WALKING")
          .length - 1,
      numSteps: responseSteps.length,
      steps: structuredClone(responseSteps),
    });
    responseSteps.length = 0; // Clear for the next route
  }
  return updateLocationNames(parsedRoute);
}

function parseHEREMapsResponse(response: HERE_API_RESPONSE) {
  const routes = response.routes;
  const steps: ResponseStep[] = [];
  const parsedRoutes: RouteResponse[] = [];
  for (const route of routes) {
    for (const section of route.sections) {
      const transportationMode = determineTransportationMode(
        section.transport.mode,
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
        polyline: section.polyline || "",
        journeyCost:
          transportationModeCost[
            transportationMode as keyof typeof transportationModeCost
          ] *
          ((new Date(section.arrival.time).getTime() / 1000 -
            new Date(section.departure.time).getTime() / 1000) /
            60),
        lineName: section.transport.name || undefined,
        vehicleType: section.transport.mode || undefined,
        departureTime: section.departure.time,
        arrivalTime: section.arrival.time,
        numStops: undefined,
        transitLineFinalDestination: section.transport.headsign || undefined,
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
      departureDate: new Date(steps[0].departureTime || "")
        .toISOString()
        .split("T")[0],
      arrivalDate: new Date(steps[steps.length - 1].arrivalTime || "")
        .toISOString()
        .split("T")[0],
      departureTime: new Date(steps[0].departureTime || "")
        .toISOString()
        .split("T")[1]
        .split(".")[0],
      arrivalTime: new Date(steps[steps.length - 1].arrivalTime || "")
        .toISOString()
        .split("T")[1]
        .split(".")[0],
      totalDistance: steps.reduce((acc, step) => acc + step.distance, 0),
      totalDuration: steps.reduce((acc, step) => acc + step.duration, 0),
      totalCost: steps.reduce((acc, step) => acc + (step.journeyCost || 0), 0),
      numTransfers:
        steps.filter((step) => step.transportationMode !== "WALKING").length -
        1,
      numSteps: steps.length,
      steps: structuredClone(steps),
    });
    steps.length = 0;
  }
  return updateLocationNames(parsedRoutes);
}

export { parseGoogleMapsResponse, parseHEREMapsResponse };
