//
//  NoticesBanner.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/20/25.
//

import SwiftUI

struct NoticesBanner: View {
    let notices: [ResponseIncident]
    @State var showNoticesPage: Bool = false
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
            Text(
                "\(notices.count) Notices Currently Active on Selected Route"
            )
            .font(.system(size: TextSizes.caption))
            .foregroundColor(.primary)
            Button(action: {
                showNoticesPage = true
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(.yellow)
            }
        }.padding(12).background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.yellow.opacity(0.2))
        ).overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.yellow.opacity(0.5), lineWidth: 1)
        ).shadow(color: .yellow.opacity(0.25), radius: 2, x: 0, y: 4)
            .navigationDestination( isPresented: $showNoticesPage) {
                NoticesPage(notices: notices)
            }
    }
}

#Preview {
    NoticesBanner(notices: [])
}
