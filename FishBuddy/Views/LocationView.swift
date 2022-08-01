//
//  LocationView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import SwiftUI

struct LocationView: View {
    var locations: LocationVisit
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .strokeBorder(.white, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.purple.opacity(0.6)))
                    .frame(maxHeight: geo.size.height * 0.1)
                    .padding([.leading, .trailing], 30)
                    .overlay(
                        HStack {
                            Text("Arrival Time:")
                                .font(.title2)
                                .foregroundColor(.white)
                            Text(locations.arrivialTime, format: .dateTime)
                                .font(.title2)
                                .foregroundColor(.white)
                            
                        }
                    )
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .strokeBorder(.white, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.purple.opacity(0.6)))
                    .frame(maxHeight: geo.size.height * 0.1)
                    .padding([.leading, .trailing], 30)
                    .overlay(
                        HStack {
                            
                            Text("Fish Caught:")
                                .font(.title2)
                                .foregroundColor(.white)
                            Text(locations.catches.count, format: .number)
                                .font(.title2)
                                .foregroundColor(.white)
                            
                        }
                    )
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .strokeBorder(.white, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.purple.opacity(0.6)))
                    .frame(maxHeight: geo.size.height * 0.1)
                    .padding([.leading, .trailing], 30)
                    .overlay(
                        HStack {
                            Text("Weather Info")
                                .font(.title2)
                                .foregroundColor(.white)
                            
                        }
                    )
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .strokeBorder(.white, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.purple.opacity(0.6)))
                    .frame(maxHeight: geo.size.height * 0.1)
                    .padding([.leading, .trailing], 30)
                    .overlay(
                        HStack {
                            Text("Water Temperature:")
                                .font(.title2)
                                .foregroundColor(.white)
                            //                Text(locations.waterTemperature, format: .number)
                        }
                    )
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .strokeBorder(.white, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.purple.opacity(0.6)))
                    .frame(maxHeight: geo.size.height * 0.1)
                    .padding([.leading, .trailing], 30)
                    .overlay(
                        HStack {
                            Text("Water Clarity:")
                                .font(.title2)
                                .foregroundColor(.white)
                            //                Text(locations.waterClarity, format: .number)
                        }
                    )
                
                
                
                
                
                
                List(locations.catches) { fish in
                    NavigationLink(fish.fish.species) {
                        FishView(fish: fish)
                    }
                }
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue.opacity(0.7))
            .navigationTitle(locations.location.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}
