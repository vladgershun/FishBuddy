//
//  TripCollectionView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import SwiftUI

struct TripCollectionView: View {
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .red
    }
    
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
//                            .listRowBackground(.red) why no work?
                    }
                    
                    Spacer()
                    
                    Text(trip.totalFishCaught, format: .number)
                }
                
            }
            
        }
        //        .scrollContentBackground(.hidden) iOS 16
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue.opacity(0.7))
    }
}

