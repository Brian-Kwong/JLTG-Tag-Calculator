//
//  JetLagIconButton.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/16/25.
//

import SwiftUI

struct JetLagIconButton<CustomIcon: Shape>: View {
    let icon: CustomIcon
    let transportMode : TransportationModes
    @Binding var selectedModesSet : Set<TransportationModes>
    @State var enabled: Bool = false
    var body: some View {
        icon.frame(width: 20, height: 20).padding(8).background {
            Circle()
                .fill(enabled ? Color.accent : Color.clear)
                .fill(.ultraThinMaterial)
        }.overlay(
            RoundedRectangle(cornerRadius: 90)
                .stroke(Color.gray, style: StrokeStyle(lineWidth: 2, dash: [1, enabled ? 1 : 3]) )
        ).onTapGesture {
            enabled.toggle()
            if enabled {
                selectedModesSet.insert(transportMode)
            } else {
                selectedModesSet.remove(transportMode)
            }
        }
    }
}

#Preview {
    @Previewable @State var transportSet: Set<TransportationModes> = Set(
        TransportationModes.allCases
    )
    JetLagIconButton( icon: HighSpeedTrain(),
                      transportMode: TransportationModes.HIGH_SPEED_RAIL,
                      selectedModesSet: $transportSet, enabled: true)
}
