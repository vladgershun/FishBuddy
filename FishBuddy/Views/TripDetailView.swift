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
    @ScaledMetric(relativeTo: .body) private var mapPadding = 30.0
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Map(mapRect: $region, annotationItems: trip.locations) { visit in
                    MapAnnotation(coordinate: visit.location.coordinate) {
                        Text(visit.catches.count, format: .number)
                            .padding()
                            .background(.blue, in: Circle())
                    }
                }
                .border(.white, width: 2)
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
                .padding()
                .frame(maxHeight: geo.size.height * 0.5)
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .strokeBorder(.white, lineWidth: 2)
                    .frame(maxWidth: geo.size.width, maxHeight: geo.size.height * 0.06)
                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.green.opacity(0.9)))
                    .padding()
                    .overlay {
                        HStack {
                            Text("Total Fish Caught: ")
                                .font(.title2)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text(trip.totalFishCaught, format: .number)
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .padding(30)
                    }
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .strokeBorder(.white, lineWidth: 2)
                    .frame(maxWidth: geo.size.width)
                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.green.opacity(0.9)))
                    .padding()
                    .overlay {
                        List(trip.locations) { location in
                            NavigationLink {
                                LocationView(locations: location)
                            } label: {
                                Text(location.location.name)
                                
                            }
                        }
                        .padding()
                    }
                
//                RoundedRectangle(cornerRadius: 15, style: .continuous)
//                    .strokeBorder(.white, lineWidth: 2)
//                    .padding()
//                    .frame(maxHeight: geo.size.height * 0.1)
//                    .overlay(
//                        HStack {
//                            Text("Total Fish Caught: ")
//                                .font(.title2)
//                                .foregroundColor(.white)
//
//                            Spacer()
//
//                            Text(trip.totalFishCaught, format: .number)
//                                .font(.title2)
//                                .foregroundColor(.white)
//                        }
//                            .padding(30)
//                    )
                
//                List(trip.locations) { location in
//                    NavigationLink {
//                        LocationView(locations: location)
//                    } label: {
//                        Text(location.location.name)
//
//                    }
//                }
                
                
                
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue.opacity(0.7))
            
            
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
