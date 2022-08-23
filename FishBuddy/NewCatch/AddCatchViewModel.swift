//
//  AddCatchViewModel.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 8/22/22.
//

import Foundation
import CoreLocation

enum LoadingState<Value> {
    case loading
    case loaded(Value)
    case failed(any Error)
}

protocol LocationService {
    func getCurrentLocation() async throws -> CLLocationCoordinate2D
}

protocol LocationGroupingService {
    func nearestSignificantLocation(coordinate: CLLocationCoordinate2D) -> Location
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
    var coordinate: CLLocationCoordinate2D
    var location: Location
}

class StubLocationService: LocationService {
    func getCurrentLocation() async throws -> CLLocationCoordinate2D {
        return Location.klineline.coordinate
    }
}

class DeniedLocationService: LocationService {
    func getCurrentLocation() async throws -> CLLocationCoordinate2D {
        try await Task.sleep(nanoseconds: 2000000000)
        throw CLError(.denied)
    }
}

class StubLocationGroupingService: LocationGroupingService {
    func nearestSignificantLocation(coordinate: CLLocationCoordinate2D) -> Location {
        Location(name: "Wahoo", coordinate: coordinate)
    }
}

class StubCatchSubmissionService: CatchSubmissionService {
    func submitCatch(_ request: CatchCreationRequest) async {
        print(request)
    }
}

class AddCatchViewModel: ObservableObject {
    
    init(catchSubmission: any CatchSubmissionService, locationService: any LocationService, locationGrouping: any LocationGroupingService) {
        self.catchSubmission = catchSubmission
        self.locationService = locationService
        self.locationGrouping = locationGrouping
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
    @Published var coordinate: LoadingState<CLLocationCoordinate2D> = .loading
    @Published var location: LoadingState<Location> = .loading
    
    let catchSubmission: any CatchSubmissionService
    let locationService: any LocationService
    let locationGrouping: any LocationGroupingService
    
    var isValid: Bool {
        if weight.value <= 0 { return false }
        if length.value <= 0 { return false }
        if case .loading = location {
            return false
        }
        return true
    }
    
    ///true if no error
    func submit() async -> Bool {
        guard let coordinate = try? await locationService.getCurrentLocation() else {
            return false
        }
        
        let location = locationGrouping.nearestSignificantLocation(coordinate: coordinate)
        
        await catchSubmission.submitCatch(CatchCreationRequest(species: fish, length: length, weight: weight, waterTemperature: waterTemperature, bait: bait, coordinate: coordinate, location: location))
        
        return true
    }
    
    
    func task() async {
        do {
            let coordinate = try await locationService.getCurrentLocation()
            let location = locationGrouping.nearestSignificantLocation(coordinate: coordinate)
            self.coordinate = .loaded(coordinate)
            self.location = .loaded(location)
        } catch {
            self.coordinate = .failed(error)
            self.location = .failed(error)
        }
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
