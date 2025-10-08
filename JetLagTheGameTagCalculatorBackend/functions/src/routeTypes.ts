const transportationMode = {
  HIGH_SPEED_RAIL: ["highSpeedTrain", "HIGH_SPEED_TRAIN"],
  LOW_SPEED_RAIL: [
    "intercityTrain",
    "interRegionalTrain",
    "regionalTrain",
    "cityTrain",
    "COMMUTER_TRAIN",
    "HEAVY_RAIL",
    "LONG_DISTANCE_TRAIN",
    "OTHER",
    "RAIL",
    "TRANSIT_VEHICLE_TYPE_UNSPECIFIED",
  ],
  METRO: [
    "subway",
    "lightRail",
    "inclined",
    "aerial",
    "monorail",
    "CABLE_CAR",
    "FUNICULAR",
    "GONDOLA_LIFT",
    "METRO_RAIL",
    "MONORAIL",
    "SUBWAY",
    "TRAM",
    "TROLLEYBUS",
  ],
  BUS: ["bus", "busRapid", "BUS", "INTERCITY_BUS"],
  FERRY: ["ferry", "FERRY"],
  FLIGHT: ["flight"],
};

enum transportationModeCost {
  HIGH_SPEED_RAIL = 25,
  LOW_SPEED_RAIL = 10,
  METRO = 5,
  BUS = 5,
  FERRY = 10,
  FLIGHT = 100,
  WALKING = 0,
}

type HERE_API_RESPONSE = {
  routes: [
    {
      id: string;
      sections: [
        {
          id: string;
          type: string;
          travelSummary: {
            duration: number;
            length: number;
          };
          bookingLinks?: [
            {
              href: string;
              type: string;
            },
          ];
          polyline: string;
          departure: {
            time: string;
            place: {
              name?: string;
              type: string;
              location: {
                lat: number;
                lng: number;
              };
              id?: string;
            };
          };
          arrival: {
            time: string;
            place: {
              name?: string;
              type: string;
              location: {
                lat: number;
                lng: number;
              };
              id?: string;
            };
          };
          transport: {
            mode: keyof typeof transportationModeCost | "pedestrian";
            name?: string;
            category?: string;
            headsign?: string;
            shortName?: string;
            description?: string;
          };
          agency?: {
            id: string;
            name: string;
            website: string;
          };
        },
      ];
    },
  ];
};

type GOOGLE_MAPS_API_RESPONSE = {
  routes: [
    {
      legs: [
        {
          steps: [
            {
              distanceMeters: number;
              staticDuration: string;
              polyline: {
                encodedPolyline: string;
              };
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
              transitDetails?: {
                stopDetails: {
                  arrivalStop: {
                    name: string;
                    location: {
                      latLng: {
                        latitude: number;
                        longitude: number;
                      };
                    };
                  };
                  arrivalTime: string;
                  departureStop: {
                    name: string;
                    location: {
                      latLng: {
                        latitude: number;
                        longitude: number;
                      };
                    };
                  };
                  departureTime: string;
                };
                headsign: string;
                transitLine: {
                  agencies: [
                    {
                      name: string;
                      phoneNumber: string;
                      uri: string;
                    },
                  ];
                  name: string;
                  color: string;
                  nameShort: string;
                  textColor: string;
                  vehicle: {
                    name: {
                      text: string;
                    };
                    type: string;
                    iconUri: string;
                  };
                };
                stopCount: number;
              };
            },
          ];
        },
      ];
    },
  ];
};

type ResponseStep = {
  transportationMode: keyof typeof transportationModeCost;
  startLocation: {
    name: string;
    lat: number;
    lng: number;
  };
  endLocation: {
    name: string;
    lat: number;
    lng: number;
  };
  duration: number;
  distance: number;
  polyline: string;
  journeyCost: number;
  lineName?: string;
  vehicleType?: string;
  departureTime?: string;
  arrivalTime?: string;
  numStops?: number;
  transitLineFinalDestination?: string;
};

type RouteResponse = {
  departureLocation: {
    name: string;
    lat: number;
    lng: number;
  };
  arrivalLocation: {
    name: string;
    lat: number;
    lng: number;
  };
  departureDate: string;
  arrivalDate: string;
  departureTime: string;
  arrivalTime: string;
  totalDuration: number;
  totalDistance: number;
  totalCost: number;
  numTransfers: number;
  numSteps: number;
  steps: ResponseStep[];
};

export { transportationMode, transportationModeCost };
export type {
  HERE_API_RESPONSE,
  GOOGLE_MAPS_API_RESPONSE,
  ResponseStep,
  RouteResponse,
};
