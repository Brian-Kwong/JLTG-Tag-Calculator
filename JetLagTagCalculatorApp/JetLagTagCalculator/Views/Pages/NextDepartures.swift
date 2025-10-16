//
//  NextDepartures.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/15/25.
//

import SwiftUI

struct NextDepartures: View {
    @State var departuresViewModel : DeparturesViewModel = DeparturesViewModel(forPreview: true)
    var body: some View {
        NavigationSplitView {
            DeparturesParameters(departuresViewModel: departuresViewModel)
        } detail: {
            NavigationStack {
                if departuresViewModel.showDepartures {
                    StationsPage(departuresViewModel: departuresViewModel)
                } else {
                    Text("Please modify the departure search parameters to see departures.")
                        .font(.system(size: TextSizes.body))
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    NextDepartures()
}
