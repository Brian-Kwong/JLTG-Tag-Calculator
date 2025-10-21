/*
 * Main entry point for Firebase Cloud Functions.
 * Sets up an Express app with routes for transit calculations,
 * Adds auth protected by Firebase App Check authentication.
 *
 * @module index
 *
 * Created by Kitty Brian on 10/3/25.
 */

import { https } from "firebase-functions/v2";
import { defineSecret } from "firebase-functions/params";
import admin from "firebase-admin";
import express from "express";
import transitRoutes from "./fetchRoutes";
import verifyToken from "./auth";
import cacheResults from "./cache";

admin.initializeApp();
const app = express();
app.use(express.json());
app.use("/transit", verifyToken, cacheResults, transitRoutes);

const HERE_API_KEY = defineSecret("HERE_API_KEY");
const GOOGLE_API_KEY = defineSecret("GOOGLE_API_KEY");

export const appFunction = https.onRequest(
    { secrets: [HERE_API_KEY, GOOGLE_API_KEY] },
    app
);
