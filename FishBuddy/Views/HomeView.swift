//
//  ContentView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import SwiftUI

struct HomeView: View {
    @State private var addTripShowing = false
    
    var body: some View {
        NavigationView {
            VStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .strokeBorder(Color.white,lineWidth: 2)
                    .frame(width: 300, height: 80)
                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.green.opacity(0.6)))
                    .overlay(
                        Text("Add Trip")
                            .foregroundColor(.white)
                    )
                    .onTapGesture {
                        addTripShowing = true
                    }
                
                NavigationLink(destination: TripCollectionView()) {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .strokeBorder(Color.white,lineWidth: 2)
                        .frame(width: 300, height: 80)
                        .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.purple.opacity(0.6)))
                        .overlay(
                            Text("Trip Log")
                                .foregroundColor(.white)
                        )
                }
                
                NavigationLink(destination: TripCollectionView()) {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .strokeBorder(Color.white,lineWidth: 2)
                        .frame(width: 300, height: 80)
                        .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.orange.opacity(0.6)))
                        .overlay(
                            Text("Statistics")
                                .foregroundColor(.white)
                        )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue.opacity(0.7))
            .sheet(isPresented: $addTripShowing) {
                AddTripView()
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
