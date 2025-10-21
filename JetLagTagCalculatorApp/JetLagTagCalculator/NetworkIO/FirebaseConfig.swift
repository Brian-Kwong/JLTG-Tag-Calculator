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
        // If debugging, use the debug provider
        // return AppCheckDebugProvider(app: app)
        return AppAttestProvider(app: app)
    }
}

class DeviceCheckFactory: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        return DeviceCheckProvider(app: app)
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
        // Turn on App Check enforcement for production builds
        let appCheckToken = try await AppCheck.appCheck().token(
            forcingRefresh: false
        )
        return appCheckToken.token
    } catch {
        return nil
    }
}
