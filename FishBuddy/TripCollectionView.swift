//
//  TripCollectionView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import SwiftUI

struct TripCollectionView: View {
    @State var tripCollection = TripCollection.trips
    
    
    var body: some View {
        List(tripCollection.trips) { trip in
            NavigationLink {
                TripDetailView(trip: trip)
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(trip.arrivalDate, format: .dateTime.day().month())
                        Text(trip.locations.map(\.location.name), format: .list(type: .and))
                    }
                    
                    Spacer()
                    
                    Text(trip.totalFishCaught, format: .number)
                }
            }
        }
    }
}

struct TripCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        TripCollectionView()
    }
}
