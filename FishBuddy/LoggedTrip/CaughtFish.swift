//
//  CaughtFish.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//
//  Model of a caught fish

import Foundation

struct CaughtFish: Identifiable {
    
    let id: UUID
    var fish: Fish
    /// Length in inches
    var length: Measurement<UnitLength>
    let timeCaught: Date
    
    //add image later

}

extension CaughtFish {
    
    static let chinook = CaughtFish(id: UUID(),
                                    fish: .salmon,
                                    length: Measurement(value: 36, unit: .inches),
                                    timeCaught: .now)
    
    static let bass = CaughtFish(id: UUID(),
                                  fish: .bass,
                                  length: Measurement(value: 16, unit: .inches),
                                  timeCaught: .now)
    
    static let rainbowTrout = CaughtFish(id: UUID(),
                                         fish: .trout,
                                         length: Measurement(value: 12, unit: .inches),
                                         timeCaught: .now)
    
}
