//
//  ContentView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import SwiftUI

struct HomeView: View {
    @State private var addTripShowing = false
    @StateObject private var tripController = TripController(clock: { Date.now })
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                VStack {
                    
                    Spacer()
                    
                    Text("Fishdex")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .strokeBorder(.white, lineWidth: 2)
                        .frame(width: geo.size.width * 0.75, height: geo.size.height * 0.1)
                        .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.green.opacity(0.6)))
                        .overlay(
                            HStack{
                                Image(systemName: "fish.fill")
                                    .foregroundColor(.white)
                                Text("Add Catch")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        )
                        .onTapGesture {
                            addTripShowing = true
                        }
                    
                    NavigationLink(destination: TripCollectionView(trips: tripController.trips)) {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .strokeBorder(.white, lineWidth: 2)
                            .frame(width: geo.size.width * 0.75, height: geo.size.height * 0.1)
                            .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.purple.opacity(0.6)))
                            .overlay(
                                HStack {
                                    Image(systemName: "book.fill")
                                        .foregroundColor(.white)
                                    Text("Trips")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }
                                
                            )
                    }
                    
                    NavigationLink(destination: StatisticsView()) {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .strokeBorder(.white, lineWidth: 2)
                            .frame(width: geo.size.width * 0.75, height: geo.size.height * 0.1)
                            .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.orange.opacity(0.6)))
                            .overlay(
                                HStack {
                                    Image(systemName: "trophy.fill")
                                        .foregroundColor(.white)
                                    Text("Statistics")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }
                                
                            )
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .sheet(isPresented: $addTripShowing) {
                    AddCatchView(catchSubmissionService: tripController)
                }
            }
            
            
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
