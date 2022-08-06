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
        List {
            VStack {
                Grid {
                    GridRow {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .strokeBorder(.white, lineWidth: 2)
                            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.green.opacity(0.9)))
                            .aspectRatio(contentMode: .fit)
                            .overlay(alignment: .topLeading) {
                                VStack(alignment: .leading) {
                                    Text("Arrival Time")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .padding([.top, .leading])
                                    Text(locations.arrivialTime, format: .dateTime)
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .padding([.leading])
                                    Text("Fish Caught")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .padding([.top, .leading])
                                    Text(locations.catches.count, format: .number)
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .padding([.leading])
                                }
                            }
                        
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .strokeBorder(.white, lineWidth: 2)
                            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.green.opacity(0.9)))
                            .aspectRatio(contentMode: .fit)
                            .overlay(alignment: .topLeading) {
                                VStack(alignment: .leading) {
                                    Text("Water Temperature")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .padding([.top, .leading])
                                    Text("location.name")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .padding([.leading])
                                    Text("Water Clarity")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .padding([.top, .leading])
                                    Text(locations.waterClarity.rawValue)
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .padding([.leading])
                                }
                            }
                    }
                    
                    
                    
                }
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(.white, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.gray.opacity(0.9)))
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        Text("Weather Info")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding([.leading])
                    }
                
                
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            
            
            
            
            //                RoundedRectangle(cornerRadius: 20, style: .continuous)
            //                    .strokeBorder(.white, lineWidth: 2)
            //
            //                    .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.gray.opacity(0.9)))
            //                    .aspectRatio(contentMode: .fit)
            
            Section {
                ForEach(locations.catches) { fish in
                    NavigationLink(fish.fish.species) {
                        FishView(fish: fish, location: locations)
                    }
                }
                .listRowBackground(Color.red)

            } header: {
                Text("Latest Transactions")
                    .bold()
                    .edgesIgnoringSafeArea(.leading)
                    
            }
            
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .listRowInsets(EdgeInsets())

//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue.opacity(0.7))
        .navigationTitle(locations.location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(locations: LocationVisit(id: UUID(), arrivialTime: .now, catches: [CaughtFish.chinook, CaughtFish.rainbowTrout], location: .klineline, waterTemperature: Measurement(value: 50, unit: .fahrenheit), waterClarity: .muddy))    }
}
