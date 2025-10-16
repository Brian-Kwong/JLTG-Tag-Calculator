//
//  DeparturesParameters.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/15/25.
//

import SwiftUI

struct DeparturesParameters: View {
    @ObservedObject var departuresViewModel : DeparturesViewModel
    @State var didAppear = false
    var body: some View {
        VStack {
            Form {
                Text("Search Parameters Not Implemented Yet").frame(maxWidth: .infinity, alignment: .center)
                Section {
                    Button("Update Search Parameters"){
                        departuresViewModel.showDepartures = true
                    }.frame(maxWidth: .infinity, alignment: .center)
                }
            }.onAppear{
                Task {
                    if !didAppear {
                        departuresViewModel.showDepartures = true
                        didAppear = true
                    }
                }
            }
        }.navigationTitle("Departures Searh").navigationDestination(
            isPresented: $departuresViewModel.showDepartures
        ) {
            StationsPage(departuresViewModel: departuresViewModel)
        }
    }
}

#Preview {
    struct DepartureParameters: View {
        @StateObject var departuresViewModel = DeparturesViewModel(
            forPreview: true
        )
        var body: some View {
            DeparturesParameters(departuresViewModel: departuresViewModel)
        }
    }
    return DepartureParameters()
}

