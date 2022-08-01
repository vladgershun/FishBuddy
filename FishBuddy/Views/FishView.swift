//
//  FishView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 8/1/22.
//

import SwiftUI

struct FishView: View {
    var fish: CaughtFish
    
    var body: some View {
        VStack {
            Text("Location Caught")
            Text(fish.fish.species)
            Text(fish.timeCaught, format: .dateTime)
            Text(fish.length, format: .measurement(width: .abbreviated))
            Text(fish.weight, format: .measurement(width: .abbreviated))
            Text(fish.bait)
            Text("Image")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue.opacity(0.7))
        .navigationTitle(fish.fish.species)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

