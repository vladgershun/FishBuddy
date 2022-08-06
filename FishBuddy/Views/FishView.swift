//
//  FishView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 8/1/22.
//

import SwiftUI
import MapKit

struct FishView: View {
    var fish: CaughtFish
    var location: Location
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .strokeBorder(.white, lineWidth: 2)
                .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.gray.opacity(0.9)))
                .aspectRatio(contentMode: .fit)
                .overlay {
                    Text("Image Goes Here")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding([.leading])
                }
            
            Grid {
                GridRow {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(.white, lineWidth: 2)
                        .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.blue.opacity(0.7)))
                        .aspectRatio(contentMode: .fit)
                        .overlay(alignment: .topLeading) {
                            VStack(alignment: .leading) {
                                Text("Species")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding([.top, .leading])
                                Text(fish.fish.species)
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding([.leading])
                                Text("Bait")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding([.top, .leading])
                                Text(fish.bait)
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding([.leading])
                            }
                        }
                    
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(.white, lineWidth: 2)
                        .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.blue.opacity(0.7)))
                        .aspectRatio(contentMode: .fit)
                        .overlay(alignment: .topLeading) {
                            VStack(alignment: .leading) {
                                Text("Location")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding([.top, .leading])
                                Text(location.name)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding([.leading])
                                Text("Time Caught")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding([.top, .leading])
                                Text(fish.timeCaught, format: .dateTime.hour().minute())
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding([.leading])
                            }
                        }
                }
                
                GridRow {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(.white, lineWidth: 2)
                        .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.blue.opacity(0.7)))
                        .aspectRatio(contentMode: .fit)
                        .overlay(alignment: .topLeading) {
                            VStack(alignment: .leading) {
                                Text("Weight")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding([.top, .leading])
                                Text(fish.weight, format: .measurement(width: .abbreviated))
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding([.leading])
                                Text("Length")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding([.top, .leading])
                                Text(fish.length, format: .measurement(width: .abbreviated))
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding([.leading])
                            }
                        }
                    
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(.white, lineWidth: 2)
                        .background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.blue.opacity(0.7)))
                        .aspectRatio(contentMode: .fit)
                        .overlay(alignment: .topLeading) {
                            VStack(alignment: .leading) {
                                Text("Location")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding([.top, .leading])
                                Text(location.name)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding([.leading])
                                Text("Time Caught")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding([.top, .leading])
                                Text(fish.timeCaught, format: .dateTime.hour().minute())
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding([.leading])
                            }
                        }
                }
                
            }
        }
        //            .background(.blue.opacity(0.7))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //            .background(.blue.opacity(0.7))
        //            .navigationTitle(fish.fish.species)
        //            .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct FishView_Previews: PreviewProvider {
    static var previews: some View {
        FishView(fish: CaughtFish(id: UUID(),
                                  fish: .bass,
                                  length: Measurement(value: 16, unit: .inches),
                                  weight: Measurement(value: 5, unit: .pounds),
                                  bait: "Worm",
                                  timeCaught: .now),
                 location: Location(name: "Columbia River", coordinate: CLLocationCoordinate2D(latitude: 12, longitude: -123)))
    }
}
