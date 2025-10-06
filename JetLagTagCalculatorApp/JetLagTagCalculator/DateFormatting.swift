//
//  DateFormatting.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/6/25.
//

import Foundation

let dateFormatter = ISO8601DateFormatter()
let timeFormatter = DateFormatter()

func extractTime(timeString: String) -> String {
    guard let date = dateFormatter.date(from: timeString) else {
        return "N/A"
    }
    timeFormatter.dateFormat = "h:mm a"
    timeFormatter.locale = Locale.current
    timeFormatter.timeZone = TimeZone.current
    let time = timeFormatter.string(from: date)
    return time
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
    if hours != 0{
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
