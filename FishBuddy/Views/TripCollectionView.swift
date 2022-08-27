//
//  TripCollectionView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import SwiftUI

struct TripCollectionView: View {
        
    var trips: [Trip]
    
    var body: some View {
        List(trips) { trip in
            NavigationLink {
                TripDetailView(trip: trip)
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(trip.arrivalDate, format: .dateTime.day().month())
                        Text(trip.locations.map { $0.location?.name ?? "Unknown Location" }, format: .list(type: .and))
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text(trip.totalFishCaught, format: .number)
                        Image(systemName: "fish.fill")
                    }
                    
                }
                
            }
            
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Trip Log")
        .navigationBarTitleDisplayMode(.inline)
    }
}

