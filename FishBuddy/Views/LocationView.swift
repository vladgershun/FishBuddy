//
//  LocationView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import SwiftUI

struct LocationView: View {
    var location: LocationVisit
    var trip: Trip
    
    var body: some View {
        List {
            VStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .strokeBorder(.white, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous).foregroundColor(.gray.opacity(0.9)))
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        Text("Weather Info")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding([.leading])
                    }
                
                ListPlatterLocation(trip: trip, location: location)
                    .padding([.top, .bottom], 10)
                
                Section {
                    ForEach(location.catches) { fish in
                        NavigationLink(fish.fish.species) {
                            FishView(fish: fish, location: location, trip: trip)
                        }
                    }
//                    .listRowBackground(Color.red)
                    
                } header: {
                    Text("Catches")
                        .bold()
                        .edgesIgnoringSafeArea(.leading)
                    
                }
                
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            
            
            
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .listRowInsets(EdgeInsets())
        .navigationTitle(location.location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}



struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(location: LocationVisit(id: UUID(), arrivialTime: .now, catches: [CaughtFish.chinook, CaughtFish.rainbowTrout], location: .klineline, waterTemperature: Measurement(value: 50, unit: .fahrenheit), waterClarity: .muddy), trip: Trip(id: UUID(), firstLocation: LocationVisit(id: UUID(), arrivialTime: .now, catches: [CaughtFish.chinook, CaughtFish.rainbowTrout], location: .klineline, waterTemperature: Measurement(value: 50, unit: .fahrenheit), waterClarity: .muddy)))      }
}
