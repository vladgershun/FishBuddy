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
    func submitCatch(_ request: CatchCreationRequest) async
}

///Non optional properties from UI
struct CatchCreationRequest {
    var species: Fish
    var length: Measurement<UnitLength>
    var weight: Measurement<UnitMass>
    var waterTemperature: Measurement<UnitTemperature>
    var bait: String
}

class StubCatchSubmissionService: CatchSubmissionService {
    func submitCatch(_ request: CatchCreationRequest) async {
        print(request)
    }
}

class AddCatchViewModel: ObservableObject {
    
    init(catchSubmission: CatchSubmissionService) {
        self.catchSubmission = catchSubmission
    }
    
    //no coordinates
    //no weather
    //image storage failure (no disk space)
    //validation error
    
    //replace these with strucutres
    @Published var fish: Fish = .salmon
    @Published var length: Measurement<UnitLength> = Measurement(value: 12, unit: .inches)
    @Published var weight: Measurement<UnitMass> = Measurement(value: 32, unit: .pounds)
    @Published var waterTemperature: Measurement<UnitTemperature> = Measurement(value: 50, unit: .fahrenheit)
    @Published var timeCaught = Date.now
    @Published var bait = ""
    
    let catchSubmission: any CatchSubmissionService
    
    var isValid: Bool {
        if weight.value <= 0 { return false }
        if length.value <= 0 { return false}
        return true
    }
    
    ///true if no error
    func submit() async -> Bool {
        await catchSubmission.submitCatch(CatchCreationRequest(species: fish, length: length, weight: weight, waterTemperature: waterTemperature, bait: bait))
        return true
    }
    
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
