//
//  RouteLogo.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

import SwiftUI

struct RouteLogo<CustomIcon: Shape>: View {
    var icon: CustomIcon
    var iconColor: Color = Color.teal
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "circle.fill")
                    .font(.system(size: TextSizes.subtitle))
                    .foregroundStyle(.gray.gradient)
                Rectangle()
                    .frame(height: 5)
                ZStack {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(iconColor.secondary)
                    icon
                        .frame(width: 20, height: 20)
                }
                Rectangle()
                    .frame(height: 5)
                Image(systemName: "circle.fill")
                    .font(.system(size: TextSizes.subtitle))
                    .foregroundStyle(.gray.gradient)
            }.padding(10)
        }
    }
}

#Preview {
    RouteLogo(
        icon: HighSpeedTrain(),
        iconColor: .mint
    )
    RouteLogo(
        icon: LowSpeedRail(),
        iconColor: .green
    )
    RouteLogo(
        icon: MetroTrain(),
        iconColor: .orange
    )
    RouteLogo(
        icon: BusIcon(),
        iconColor: .yellow
    )
    RouteLogo(
        icon: FerryIcon(),
        iconColor: .blue
    )
    RouteLogo(
        icon: WalkingIcon(),
        iconColor: .pink
    )
}
