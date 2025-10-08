import admin from "firebase-admin";

import serviceAccount from "./serviceInfo.json" assert { type: "json" };
const APP_WEB_ID = "1:207232064363:web:cb1e62b7767493c40dca2e";

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

/**
 * Generates a custom debug token for a user with the specified appWebId.
 * This token can be used for testing and development purposes.
 */
async function generateDebugToken() {
  console.log("Generating custom debug token...");
  try {
    const customToken = await admin.appCheck().createToken(APP_WEB_ID);
    console.log("Custom debug token generated successfully:");
    console.log(customToken.token);
  } catch (error) {
    console.error("Error generating custom debug token:", error);
  }
}

generateDebugToken().then(() => process.exit());
