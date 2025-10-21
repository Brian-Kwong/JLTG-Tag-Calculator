//
//  Notices.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/20/25.
//

import SwiftUI

struct NoticesPage: View {
    let notices: [ResponseIncident]
    var body: some View {
        List(notices) { notice in
            NoticeCard(notice: notice)
                .listRowSeparator(.hidden)
        }.listStyle(.plain).navigationTitle("Active Notices")
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
    let exampleNotice2 = ResponseIncident(
        summary: "Metro Maintenance Work",
        description:
            "Scheduled maintenance work on the Blue Line will result in reduced service and longer wait times from June 16 to June 20. Shuttle buses will be provided between affected stations.",
        type: .maintenance,
        effect: .reducedService,
        validFrom: "2024-06-16T00:00:00Z",
        validUntil: "2024-06-20T23:59:00Z",
        url: "https://www.metrotransit.org/alerts"
    )
    NoticesPage(notices: [exampleNotice, exampleNotice2])
}
