//
//  TransportModeSelector.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/18/25.
//

import SwiftUI

struct TransportModeSelector: View {
    @Binding var selectedModesOfTransport : Set<TransportationModes>
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
        HStack {
                ForEach(TransportationModes.allCases) {
                    transportType in
                    Spacer()
                    determineButtonIcon(
                        transportationMode: transportType,
                        selectedModes: $selectedModesOfTransport
                        
                    )
                    Spacer()
                }
            }
        }.contentMargins(0, for: .scrollContent)
    }
}

#Preview {
    @Previewable @State var selectedModesOfTransport : Set<TransportationModes> = Set(
        TransportationModes.allCases
    )
    TransportModeSelector(selectedModesOfTransport : $selectedModesOfTransport)
}
