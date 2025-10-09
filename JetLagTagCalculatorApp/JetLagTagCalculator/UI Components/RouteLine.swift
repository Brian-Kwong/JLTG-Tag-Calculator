//
//  RouteLogo.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

import SwiftUI

struct RouteLine<CustomIcon: Shape>: View {
    var icon: CustomIcon
    var iconColor: Color = Color.teal
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "circle.fill")
                    .font(.system(size: TextSizes.subtitle))
                    .foregroundStyle(.gray.gradient)
                Rectangle()
                    .frame(height: 4)
                ZStack {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(iconColor.secondary)
                    icon
                        .frame(width: 20, height: 20)
                }
                Rectangle()
                    .frame(height: 4)
                Image(systemName: "circle.fill")
                    .font(.system(size: TextSizes.subtitle))
                    .foregroundStyle(.gray.gradient)
            }.padding(12)
        }
    }
}

#Preview {
    RouteLine(
        icon: HighSpeedTrain(),
        iconColor: .mint
    )
    RouteLine(
        icon: LowSpeedRail(),
        iconColor: .green
    )
    RouteLine(
        icon: MetroTrain(),
        iconColor: .orange
    )
    RouteLine(
        icon: BusIcon(),
        iconColor: .yellow
    )
    RouteLine(
        icon: FerryIcon(),
        iconColor: .blue
    )
    RouteLine(
        icon: WalkingIcon(),
        iconColor: .pink
    )
}
