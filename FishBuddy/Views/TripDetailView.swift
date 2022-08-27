//
//  TripDetailView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import SwiftUI
import MapKit

struct TripDetailView: View {
    var trip: Trip
    
    @State private var region = MKMapRect.world
    @State private var hasRealLocations = true
    
    /// Padding around annotations in screen points.
    @ScaledMetric(relativeTo: .body) private var mapPadding = 30.0
    
    var body: some View {
        GeometryReader { geo in
            List {
                VStack {
                    
                    ZStack {
                        if hasRealLocations {
                            Map(mapRect: $region, annotationItems: trip.locations.filter { visit in visit.location != nil }) { visit in
                                MapAnnotation(coordinate: visit.location!.coordinate) {
                                    Text(visit.catches.count, format: .number)
                                        .padding()
                                        .background(.blue, in: Circle())
                                }
                            }
                        }
                    }
                    .border(.white, width: 2)
                    .onAppear {
                        guard let boundingRegion = trip.boundingRegion else {
                            hasRealLocations = false
                            return
                        }
                        hasRealLocations = true
                        region = boundingRegion
                        func scaleScreenWidth(_ screenValue: CGFloat) -> Double {
                            region.width / geo.size.width * screenValue
                        }
                        func scaleScreenHeight(_ screenValue: CGFloat) -> Double {
                            region.height / geo.size.height * screenValue
                        }
                        region = region.insetBy(
                            dx: -scaleScreenWidth(mapPadding),
                            dy: -scaleScreenHeight(mapPadding)
                        )
                    }
                    .padding()
                    //                        .frame(maxHeight: geo.size.height * 0.5)
                    .frame(width: 380, height: 320)
                    
                    
                    
                    Section {
                        ForEach(trip.locations.filter { visit in visit.location != nil }) { location in
                            NavigationLink {
                                LocationView(location: location, trip: trip)
                            } label: {
                                Text(location.location!.name)
                            }
                        }
                    } header: {
                        Text("Locations")
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
            .navigationTitle(Text(trip.arrivalDate, format: .dateTime.day().month()))
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailView(trip: .day3)
    }
}
