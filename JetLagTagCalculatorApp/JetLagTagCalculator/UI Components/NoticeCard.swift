//
//  NoticeCard.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/20/25.
//

import SwiftUI

struct NoticeCard: View {
    let notice: ResponseIncident
    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            Image(
                systemName: noticeIcons[notice.type]
                    ?? "exclamationmark.triangle.fill"
            )
            .font(.system(size: 40))
            .foregroundStyle(
                noticeColors[notice.type]?.gradient ?? Color.yellow.gradient
            )
            VStack(alignment: .center, spacing: 4) {
                Text(notice.summary ?? "Service Notice")
                    .font(.system(size: TextSizes.subtitle, weight: .bold)).lineLimit(2)
                if let validFrom = notice.validFrom,
                   let validUntil = notice.validUntil {
                    
                    Text(
                        "Effected: \(validFrom) to \(validUntil)"
                    )
                    .font(.system(size: TextSizes.caption))
                    .foregroundStyle(.secondary)
                }
                Text(notice.description ?? "No additional details provided.")
                    .font(.system(size: TextSizes.body))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
            }.frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center)
        }.padding(16).background(
            noticeColors[notice.type]?.opacity(0.1).gradient
                ?? Color.yellow.opacity(0.1).gradient
        ).cornerRadius(12).shadow(
            color: .black.opacity(0.15),
            radius: 2,
            x: 0,
            y: 4
        ).onTapGesture {
            if let urlString = notice.url,
               let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
}

#Preview {
    let exampleNotice = ResponseIncident(
        summary: "Amtrak Service Disruption",
        description:
            "Due to severe weather conditions, Amtrak services between New York and Washington D.C. are experiencing delays up to 2 hours. Passengers are advised to check for updates before traveling.",
        type: .weather,
        effect: .delays,
        validFrom: "2024-06-15T08:00:00Z",
        validUntil: "2024-06-15T20:00:00Z",
        url: "https://www.amtrak.com/service-alerts-and-notices"
    )
    NoticeCard(notice: exampleNotice)
}
