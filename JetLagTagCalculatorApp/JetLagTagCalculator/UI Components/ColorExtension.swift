//
//  ColorExtension.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/14/25.
//

import Foundation
import SwiftUI

extension Color {
    init?(hexString : String){
        var hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        hex = hex.replacingOccurrences(of: "#", with: "")
        guard let rgbHex = UInt64(hex, radix: 16) else {
            return nil
        }
        var r, g, b, a: Double
        // See if we have an alpha value
        let hexStringLength = hex.count
        switch hexStringLength {
        case 6:
            // Mask and bitshift to get the RGB values
            r = Double((rgbHex & 0xFF0000) >> 16) / 255.0
            g = Double((rgbHex & 0x00FF00) >> 8) / 255.0
            b = Double(rgbHex & 0x0000FF) / 255.0
            a = 1.0
        case 8:
            r = Double((rgbHex & 0xFF000000) >> 24) / 255.0
            g = Double((rgbHex & 0x00FF0000) >> 16) / 255.0
            b = Double((rgbHex & 0x0000FF00) >> 8) / 255.0
            a = Double(rgbHex & 0x000000FF) / 255.0
        default:
            return nil
        }
        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
