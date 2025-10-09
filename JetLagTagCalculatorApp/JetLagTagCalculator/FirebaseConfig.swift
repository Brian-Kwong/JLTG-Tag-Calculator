//
//  FirebaseConfig.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/8/25.
//

import Firebase
import FirebaseAppCheck
import FirebaseCore
import SwiftUI

class AppCheckFactory: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        return AppCheckDebugProvider(app: app)
        //  return AppAttestProvider(app: app)
    }
}

class FirebaseAppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        AppCheck.setAppCheckProviderFactory(AppCheckFactory())
        FirebaseApp.configure()
        return true
    }
}

func getFirebaseToken() async -> String? {
    do {
        let appCheckToken = try await AppCheck.appCheck().token(forcingRefresh: false)
        print("Fetched App Check token: \(appCheckToken.token)")
        return appCheckToken.token
    } catch {
        print("Error fetching App Check token: \(error)")
        return nil
    }
}

