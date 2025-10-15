/**
 * Middleware to cache responses for GET requests to improve performance.
 * Caches responses for a specified duration (default is 1 minutes).
 *
 * @module cache
 *
 * Created by Kitty Brian on 10/6/25.
 */
import { Request, Response, NextFunction } from "express";

/**
 * Middleware to cache GET request responses for a specified duration.
 * @param {Request} req - Express request object
 * @param {Response} res - Express response object
 * @param {NextFunction} next - Express next middleware function
 * @return {void}
 */
async function cacheResults(
    req: Request,
    res: Response,
    next: NextFunction
): Promise<void> {
    const duration = 60; // Cache duration in seconds
    if (req.method !== "GET") {
        return next();
    }
    if (req.fresh) {
        res.status(304).end();
        return;
    }
    res.set("Cache-Control", `public, max-age=${duration}`);
    return next();
}

export default cacheResults;
