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
    
    /// Padding around annotations in screen points.
    @ScaledMetric(relativeTo: .body) private var mapPadding = 25.0
    
    var body: some View {
        GeometryReader { geo in
            Map(mapRect: $region, annotationItems: trip.locations) { visit in
                MapAnnotation(coordinate: visit.location.coordinate) {
                    Text(visit.catches.count, format: .number)
                        .padding()
                        .background(.blue, in: Circle())
                }
            }
            .onAppear {
                region = trip.boundingRegion
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
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .navigationTitle(Text(trip.arrivalDate, format: .dateTime.day().month()))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailView(trip: .day3)
    }
}
