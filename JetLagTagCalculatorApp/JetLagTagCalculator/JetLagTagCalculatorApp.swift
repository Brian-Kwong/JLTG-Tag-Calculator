//
//  JetLagTagCalculatorApp.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/2/25.
//

import SwiftUI
import GooglePlacesSwift
import _ConfidentialKit

@main
struct JetLagTagCalculatorApp: App {
    
    init(){
        @UIApplicationDelegateAdaptor(FirebaseAppDelegate.self) var delegate
        let apiKey = ObfuscatedLiterals.$googlePlacesAPIKey
        if PlacesClient.provideAPIKey(apiKey){
            print("Google Places API Key provided successfully.")
        } else {
            fatalError("Failed to provide Google Places API Key.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                Color("JetLagBackground")
                    .ignoresSafeArea()
                SearchRoute()
            }
        }
    }
}
