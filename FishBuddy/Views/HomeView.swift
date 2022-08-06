//
//  ContentView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import SwiftUI

struct HomeView: View {
    @State private var addTripShowing = false
    let universalSize = UIScreen.main.bounds
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    
                    Image("Logo")
                        .resizable()
                        .frame(width: 300, height: 300)
                    
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .strokeBorder(.white, lineWidth: 2)
                        .frame(width: geo.size.width * 0.75, height: geo.size.height * 0.1)
                        .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.green.opacity(0.6)))
                        .overlay(
                            HStack {
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
                    
                    NavigationLink(destination: TripCollectionView()) {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .strokeBorder(.white, lineWidth: 2)
                            .frame(width: geo.size.width * 0.75, height: geo.size.height * 0.1)
                            .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.purple.opacity(0.6)))
                            .overlay(
                                HStack {
                                    Image(systemName: "book.fill")
                                        .foregroundColor(.white)
                                    Text("Trip Logs")
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
                .background(.blue.opacity(0.7))
                .sheet(isPresented: $addTripShowing) {
                    AddCatchView()
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
