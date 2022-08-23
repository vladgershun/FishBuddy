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
    var visit: LocationVisit

    
    var body: some View {
        List {
            
            Image("Salmon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .aspectRatio(1.0, contentMode: .fill)
                .clipShape(RoundedRectangle.platter)
                .listRowSeparator(.hidden)
            
            ListPlatterFish(fish: fish, location: visit)
            
            VStack {
                MapPreview(location: visit.location)
                    .aspectRatio(16/11, contentMode: .fill)
                //                    .clipShape(CutoffPlatterShape())
                
                Text(visit.location.name)
                    .padding([.leading, .bottom], 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .listRowSeparator(.hidden)
            .background(Color(.secondarySystemBackground), in: RoundedRectangle.platter)
            .padding()
            
            
        }
        .listStyle(.plain)
        .navigationTitle(fish.fish.species)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct MapPreview: View {
    var location: Location
    
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 100,
            longitudinalMeters: 100
        )), annotationItems: [location]) { location in
            MapMarker(coordinate: location.coordinate, tint: .red)
        }
    }
}

//struct FishView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            FishView(fish: CaughtFish(id: UUID(),
//                                      fish: .greenSturgeon,
//                                      length: Measurement(value: 16, unit: .inches),
//                                      weight: Measurement(value: 5, unit: .pounds),
//                                      bait: "Worm",
//                                      timeCaught: .now),
//                     location: LocationVisit(id: UUID(), arrivialTime: .now, catches: [.chinook], location: Location(name: "Klineline", coordinate: CLLocationCoordinate2D(latitude: 123, longitude: 32)), waterTemperature: Measurement(value: 32, unit: .fahrenheit), waterClarity: .muddy), trip: Trip(id: UUID(), firstLocation: LocationVisit(id: UUID(), arrivialTime: .now, catches: [CaughtFish.chinook, CaughtFish.rainbowTrout], location: .klineline, waterTemperature: Measurement(value: 50, unit: .fahrenheit), waterClarity: .muddy)))
//        }
//    }
//}
