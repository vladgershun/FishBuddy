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
    var trip: Trip
    
    var body: some View {
        List {
            
            Image("Salmon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .aspectRatio(1.0, contentMode: .fill)
                .clipShape(RoundedRectangle.platter)
                .listRowSeparator(.hidden)
            
            ListPlatter(fish: fish, location: location)
            
//            ListPlatter {
//                Group {
//                    LabeledContent("Bait", value: fish.bait)
//                    Divider()
//                    LabeledContent("Time Caught", value: location.arrivialTime, format: .dateTime.hour().minute())
//                    Divider()
//                    LabeledContent("Weight", value: fish.weight, format: .measurement(width: .abbreviated))
//                    Divider()
//                    LabeledContent("Length", value: fish.length, format: .measurement(width: .abbreviated))
//                    Divider()
//                }
//
//
//                LabeledContent("Water Temp", value: location.waterTemperature, format: .measurement(width: .abbreviated))
//
//                Divider()
//                LabeledContent("Water Clarity", value: location.waterClarity.rawValue)
//
//            }
            
            VStack {
                MapPreview(center: location.location.coordinate, trip: trip)
                    .aspectRatio(16/11, contentMode: .fill)
                //                    .clipShape(CutoffPlatterShape())
                
                Text(location.location.name)
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
    var center: CLLocationCoordinate2D
    
    var trip: Trip
    
    var body: some View {
        
        
        //        Map(coordinateRegion: .constant(MKCoordinateRegion(
        //            center: center,
        //            latitudinalMeters: 100,
        //            longitudinalMeters: 100
        //        )))
        
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: center,
            latitudinalMeters: 100,
            longitudinalMeters: 100
        )), annotationItems: trip.locations) { visit in
            MapMarker(coordinate: visit.location.coordinate, tint: .red)
        }
        
        
        
        
        //        Color.red
        
        //            .onAppear {
        //                self.region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        //            }
        //            .onChange(of: center) { newValue in
        //                self.region = MKCoordinateRegion(center: newValue, latitudinalMeters: 100, longitudinalMeters: 100)
        //            }
        
        //            .task(id: center) {
        //                self.region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        //            }
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
//                     location: LocationVisit(id: UUID(), arrivialTime: .now, catches: [.chinook], location: Location(name: "Klineline", coordinate: CLLocationCoordinate2D(latitude: 123, longitude: 32)), waterTemperature: Measurement(value: 32, unit: .fahrenheit), waterClarity: .muddy))
//        }
//    }
//}
