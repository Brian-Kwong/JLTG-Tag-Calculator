import admin from "firebase-admin";
import { Request, Response, NextFunction } from "express";

/**
 *
 * Middleware to verify Firebase App Check token or allow debug token in development.
 * In production, only valid App Check tokens are accepted.
 * In development, a debug token can be used for testing purposes.
 *
 * @param {Request} req - Express request object
 * @param {Response} res - Express response object
 * @param {NextFunction} next - Express next middleware function
 */
async function verifyAppTestToken(
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> {
  const appCheckToken =
    req.header("X-Firebase-AppCheck") || req.header("X-Firebase-Debug");
  if (!appCheckToken) {
    res
      .status(401)
      .json({ message: "Unauthorized: No App Check or Debug token provided" });
    return;
  }
  try {
    await admin.appCheck().verifyToken(appCheckToken);
    return next();
  } catch (error) {
    console.error("Error verifying App Check token:", error);
    res.status(401).json({ message: "Unauthorized: Invalid App Check token" });
    return;
  }
}

export default verifyAppTestToken;
