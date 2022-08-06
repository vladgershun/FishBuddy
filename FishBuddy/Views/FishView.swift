//
//  FishView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 8/1/22.
//

import SwiftUI
import MapKit

struct FishView: View {
    var fish: CaughtFish
    var location: LocationVisit
    
    var body: some View {
        List {
            Section {
                
            } header: {
                Image("Salmon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .aspectRatio(1.0, contentMode: .fill)
            }
            
            HStack {
                Text("Foo")
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.secondary, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                Text("Foo")
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.secondary, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            }.listRowSeparator(.hidden)
            
            LabeledContent("Bait", value: fish.bait)
            LabeledContent("Location", value: location.location.name)
            LabeledContent("Time Caught", value: location.arrivialTime, format: .dateTime.hour().minute())
            LabeledContent("Weight", value: fish.weight, format: .measurement(width: .abbreviated))
            LabeledContent("Length", value: fish.length, format: .measurement(width: .abbreviated))
            LabeledContent("Water Temp", value: location.waterTemperature, format: .measurement(width: .abbreviated))
            LabeledContent("Water Clarity", value: location.waterClarity.rawValue)
        }
        .listStyle(.plain)
        .navigationTitle(fish.fish.species)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct FishView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FishView(fish: CaughtFish(id: UUID(),
                                      fish: .greenSturgeon,
                                      length: Measurement(value: 16, unit: .inches),
                                      weight: Measurement(value: 5, unit: .pounds),
                                      bait: "Worm",
                                      timeCaught: .now),
                     location: LocationVisit(id: UUID(), arrivialTime: .now, catches: [.chinook], location: Location(name: "Klineline", coordinate: CLLocationCoordinate2D(latitude: 123, longitude: 32)), waterTemperature: Measurement(value: 32, unit: .fahrenheit), waterClarity: .muddy))
        }
    }
}
