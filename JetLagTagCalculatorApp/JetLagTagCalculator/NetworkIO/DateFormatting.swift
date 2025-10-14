//
//  DateFormatting.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/6/25.
//

import Foundation

let dateFormatter = Date.ISO8601FormatStyle(includingFractionalSeconds: true)
let timeFormatter = DateFormatter()

func extractTime(timeString: String) -> String {
    do {
        let date = try dateFormatter.parse(timeString)
        timeFormatter.dateFormat = "h:mm a"
        
        let TZRegex = #/(.*?)(\+|-)(\d{2}):(\d{2})$/#
        let timeZone = timeString.firstMatch(of: TZRegex)
        timeFormatter.timeZone = TimeZone(secondsFromGMT: ((timeZone?.output.2 == "+" ? 1 : -1) * ((Int(timeZone?.output.3 ?? "0") ?? 0) * 3600 + (Int(timeZone?.output.4 ?? "0") ?? 0) * 60)))
        let time = timeFormatter.string(from: date)
        return time
    } catch {
        return "N/A"
    }
}

func convertSecondsToTimeFormat(seconds: Int) -> String {
    // Converts the number of seconds to XH XM XS format
    if seconds < 0 {
        return "N/A"
    }
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let secs = seconds % 60
    var timeString = ""
    if hours != 0 {
        timeString += "\(hours)H "
    }
    if minutes != 0 {
        timeString += "\(minutes)M "
    }
    if secs != 0 {
        timeString += "\(secs)S"
    }
    return timeString.trimmingCharacters(in: .whitespaces)
}

func convertToISO8601DateString(date: Date) -> String {
    return dateFormatter.format(date)
}
