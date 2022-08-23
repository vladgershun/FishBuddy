//
//  AddCatchViewModel.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 8/22/22.
//

import Foundation

protocol LocationService {
    
}

protocol LocationGroupingService {
    
}

protocol CatchSubmissionService {
    
}

class AddCatchViewModel: ObservableObject {
    //replace these with strucutres
    @Published var fish: Fish = .salmon
    @Published var length: Measurement<UnitLength> = Measurement(value: 12, unit: .inches)
    @Published var weight: Measurement<UnitMass> = Measurement(value: 32, unit: .pounds)
    @Published var waterTemperature: Measurement<UnitTemperature> = Measurement(value: 50, unit: .fahrenheit)
    @Published var timeCaught = Date.now
    @Published var bait = ""
    
    
}



//protocol WeatherService {
//
//}

//protocol SpeciesService {
//
    //}
    //
    //protocol BaitService {
    //
    //}
