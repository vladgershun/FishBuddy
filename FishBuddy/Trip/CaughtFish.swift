//
//  CaughtFish.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import Foundation

struct CaughtFish: Identifiable {
    
    let id: UUID
    var species: String
    /// Length in inches
    var length: Measurement<UnitLength>
    let timeCaught: Date
    
    //add image later

}

extension CaughtFish {
    
    static let chinook = CaughtFish(id: UUID(), species: "Chinook", length: Measurement(value: 36, unit: .inches), timeCaught: .now)
    static let cohoe = CaughtFish(id: UUID(), species: "Cohoe", length: Measurement(value: 36, unit: .inches), timeCaught: .now)
    static let rainbowTrout = CaughtFish(id: UUID(), species: "Rainbow Trout", length: Measurement(value: 12, unit: .inches), timeCaught: .now)
    
}
