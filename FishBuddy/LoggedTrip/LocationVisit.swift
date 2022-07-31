//
//  LocationVisit.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//
//  Model of what a visited location looks like

import Foundation

struct LocationVisit: Identifiable {
    
    enum WaterClarity {
        case clear, muddy
    }
    
    let id: UUID
    let arrivialTime: Date
    var catches: [CaughtFish]
    let location: Location
    //add weather with WeatherKit
    
    ///Temperature of the water at location
    var waterTemperature: Measurement<UnitTemperature>
    var waterClarity: WaterClarity
    
}

extension LocationVisit {
    
    static let klineline = LocationVisit(id: UUID(), arrivialTime: .now, catches: [CaughtFish.chinook, CaughtFish.rainbowTrout], location: .klineline, waterTemperature: Measurement(value: 50, unit: .fahrenheit), waterClarity: .muddy)
    
    static let columbiaRiver = LocationVisit(id: UUID(), arrivialTime: .now, catches: [CaughtFish.chinook, CaughtFish.bass], location: .columbiaRiver, waterTemperature: Measurement(value: 39, unit: .fahrenheit), waterClarity: .clear)
    
    
}
