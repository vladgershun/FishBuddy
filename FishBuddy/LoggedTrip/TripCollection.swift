//
//  TripCollection.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import Foundation

struct TripCollection {
    
    var trips: [Trip]
}

extension TripCollection {
    
    static let trips = TripCollection(trips: [Trip.day1, .day2, .day3])
    
}
