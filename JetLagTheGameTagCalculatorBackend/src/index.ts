import {
  DynamoDBClient,
  DeleteTableCommand,
  CreateTableCommand,
  waitUntilTableExists,
  waitUntilTableNotExists,
  BillingMode,
} from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
  GetCommand,
  PutCommand,
} from "@aws-sdk/lib-dynamodb";
import express from "express";
import serverless from "serverless-http";
import { v4 as uuidv4 } from "uuid";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import {parseGoogleMapsResponse, parseHEREMapsResponse} from "./googleAPIParser";
dotenv.config();

if (!process.env.JWT_SECRET) {
  throw new Error("JWT_SECRET is not defined in environment variables");
}
if (!process.env.HERE_API_KEY) {
  throw new Error("HERE_API_KEY is not defined in environment variables");
}
if (!process.env.GOOGLE_API_KEY) {
  throw new Error("GOOGLE_API_KEY is not defined in environment variables");
}

const app = express();

const USERS_TABLE = process.env.USERS_TABLE;
const client = new DynamoDBClient();
const dynamoDbClient = DynamoDBDocumentClient.from(client);

app.use(express.json());

// Validation middleware for JWT
app.use((req, res, next) => {
  // Unprotected routes
  if (req.path === "/registerNewDevice") {
    return next();
  }

  // Check for Authorization header
  const authHeader = req.headers.authorization;
  if (!authHeader) {
    return res.status(401).json({ error: "Authorization header missing" });
  }

  // Extract and verify token
  const token = authHeader.split(" ")[1];
  if (!token) {
    return res
      .status(401)
      .json({ error: "Token missing from Authorization header" });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET as string);
    (req as any).user = decoded;

    // Look for user in db and make sure its valid
    const params = {
      TableName: USERS_TABLE,
      Key: {
        userId: (decoded as any).userId,
      },
    };

    dynamoDbClient
      .send(new GetCommand(params))
      .then(({ Item }) => {
        if (!Item) {
          return res.status(401).json({ error: "Invalid token" });
        }
        return next();
      })
      .catch((error) => {
        console.error(error);
        return res.status(500).json({ error: "Could not retreive user" });
      });
  } catch (err) {
    return res.status(401).json({ error: "Invalid token" });
  }
});

app.post("/registerNewDevice", async function (_req, res) {
  const userUUID = uuidv4();
  const newToken = jwt.sign({ userId: userUUID }, process.env.JWT_SECRET, {
    algorithm: "HS256",
  });

  const newUser = {
    TableName: USERS_TABLE,
    Item: {
      userId: userUUID,
      token: newToken,
    },
  };

  try {
    await dynamoDbClient.send(new PutCommand(newUser));
    res.json({ token: newToken });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not create user" });
  }
});

// For dev only drop all items in the table
app.post("/reset", async function (_req, res) {
  try {
    const command = new DeleteTableCommand({
      TableName: USERS_TABLE,
    });

    await client.send(command);
    await waitUntilTableNotExists(
      { client, maxWaitTime: 120 },
      { TableName: USERS_TABLE },
    );
    const createTableParams = {
      TableName: USERS_TABLE,
      KeySchema: [{ AttributeName: "userId", KeyType: "HASH" as const }],
      AttributeDefinitions: [
        { AttributeName: "userId", AttributeType: "S" as const },
      ],
      BillingMode: BillingMode.PAY_PER_REQUEST,
    };
    await client.send(new CreateTableCommand(createTableParams));
    await waitUntilTableExists(
      { client, maxWaitTime: 120 },
      { TableName: USERS_TABLE },
    );
    console.log("Table recreated successfully");
    res.json({ message: "Table deleted and recreated successfully" });
  } catch (error) {
    console.error("Error deleting table:", error);
    res.status(500).json({ error: "Could not delete table" });
  }
});

const calculateRouteBasedOffHERE_API = async (req) => {
  const { originCoord, destinationCoord } = req.query;
  const hereApiKey = process.env.HERE_API_KEY;
  const transitURL = `https://transit.router.hereapi.com/v8/routes?apiKey=${hereApiKey}&origin=${originCoord}&destination=${destinationCoord}&alternatives=10`;
  try {
    const transitResponse = await fetch(`${transitURL}`);
    if (!transitResponse.ok) {
      console.error(
        "Error fetching transit data:",
        await transitResponse.text(),
      );
      return {
        status: transitResponse.status,
        message: "Error fetching transit data",
      };
    }
    const transitData = await transitResponse.json();
    if (!transitData.routes || transitData.routes.length === 0) {
      return {
        status: 400,
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

const calculateRouteBasedOffGoogle_API = async (req) => {
  const { originCoord, destinationCoord } = req.query;
  const googleApiKey = process.env.GOOGLE_API_KEY;
  const googleURL = `https://routes.googleapis.com/directions/v2:computeRoutes`;
  const body = {
    origin: {
      location: {
        latLng: {
          latitude: originCoord.split(",")[0],
          longitude: originCoord.split(",")[1],
        },
      },
    },
    destination: {
      location: {
        latLng: {
          latitude: destinationCoord.split(",")[0],
          longitude: destinationCoord.split(",")[1],
        },
      },
    },
    travelMode: "TRANSIT",
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
      },
      body: JSON.stringify(body),
    });
    if (!googleResponse.ok) {
      console.error("Error fetching Google data:", await googleResponse.text());
      return {
        status: googleResponse.status,
        message: "Error fetching Google data",
      };
    }
    const googleData = await googleResponse.json();
    if (!googleData.routes || googleData.routes.length === 0) {
      return {
        status: 400,
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

app.get("/calculateRoute", async function (req, res) {
  const { originCoord, destinationCoord } = req.query;
  if (!originCoord || !destinationCoord) {
    return res
      .status(400)
      .json({ error: "originCoord and destinationCoord are required" });
  }
  const routeResult = await calculateRouteBasedOffHERE_API(req);
  if (routeResult.status !== 200) {
    // Fallback to Google API
    console.log("Falling back to Google API");
    const googleRouteResult = await calculateRouteBasedOffGoogle_API(req);
    return res
      .status(googleRouteResult.status)
      .json(googleRouteResult.data || { error: googleRouteResult.message });
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

app.use((_req, res, _next) => {
  return res.status(404).json({
    error: "The requested resource was not found",
  });
});

export const handler = serverless(app);
