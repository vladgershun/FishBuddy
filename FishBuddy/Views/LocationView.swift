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
        VStack {
            HStack {
                Text("Arrival Time:")
                    .font(.title2)
                    .foregroundColor(.white)
                Text(locations.arrivialTime, format: .dateTime)
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            HStack {
                Text("Fish Caught:")
                    .font(.title2)
                    .foregroundColor(.white)
                Text(locations.catches.count, format: .number)
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            Text("Weather Info")
                .font(.title2)
                .foregroundColor(.white)
            
            HStack {
                Text("Water Temperature:")
                    .font(.title2)
                    .foregroundColor(.white)
//                Text(locations.waterTemperature, format: .number)
            }
            
            HStack {
                Text("Water Clarity:")
                    .font(.title2)
                    .foregroundColor(.white)
//                Text(locations.waterClarity, format: .number)
            }
            
            List(locations.catches) { fish in
                Text(fish.fish.species)
            }
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue.opacity(0.7))
        .navigationTitle(locations.location.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
