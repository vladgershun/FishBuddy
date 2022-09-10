//
//  TripController.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 8/27/22.
//

import Foundation

final class TripController: ObservableObject {
    
    @Published private(set) var trips: [Trip]
    
    let clock: () -> Date
    
    init(clock: @escaping () -> Date) {
        self.trips = []
        self.clock = clock
    }
    @MainActor
    func addCatch(_ catchRequest: CatchCreationRequest) {
        
        if let tripIndex = trips.firstIndex(where: { Calendar.current.isDate($0.arrivalDate, inSameDayAs: clock()) }) {
            var existingTrip = trips[tripIndex]
            defer { trips[tripIndex] = existingTrip }
            if existingTrip.firstLocation.location == catchRequest.location {
                let `catch` = CaughtFish(id: UUID(), fish: catchRequest.species, length: catchRequest.length, weight: catchRequest.weight, bait: catchRequest.bait, timeCaught: clock())
                existingTrip.firstLocation.catches.append(`catch`)
            } else {
                let `catch` = CaughtFish(id: UUID(), fish: catchRequest.species, length: catchRequest.length, weight: catchRequest.weight, bait: catchRequest.bait, timeCaught: clock())
                let newVisit = LocationVisit(id: UUID(), arrivialTime: clock(), catches: [`catch`], location: catchRequest.location)
                existingTrip.locations.append(newVisit)
            }
            
        } else {
            let `catch` = CaughtFish(id: UUID(), fish: catchRequest.species, length: catchRequest.length, weight: catchRequest.weight, bait: catchRequest.bait, timeCaught: clock())
            let newVisit = LocationVisit(id: UUID(), arrivialTime: clock(), catches: [`catch`], location: catchRequest.location)
            let newTrip = Trip(id: UUID(), firstLocation: newVisit)
            trips.append(newTrip)
        }
    }
}

extension TripController: CatchSubmissionService {
    func submitCatch(_ request: CatchCreationRequest) async {
        await addCatch(request)
    }
}
