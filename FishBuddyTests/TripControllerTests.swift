//
//  TripControllerTests.swift
//  FishBuddyTests
//
//  Created by Vlad Gershun on 7/31/22.
//

import XCTest
@testable import FishBuddy


//  func addCatch()
//  published list of trips

final class TripController {
    
    private(set) var trips: [Trip]
    
    let clock: () -> Date
    
    init(clock: @escaping () -> Date) {
        self.trips = []
        self.clock = clock
    }
    
    func addCatch(_ catchRequest: CatchCreationRequest) {
        let `catch` = CaughtFish(id: UUID(), fish: catchRequest.species, length: catchRequest.length, weight: catchRequest.weight, bait: catchRequest.bait, timeCaught: clock())
        trips.append(Trip(id: UUID(), firstLocation: LocationVisit(id: UUID(), arrivialTime: clock(), catches: [`catch`], location: catchRequest.location)))
    }
    
}

final class TripControllerTests: XCTestCase {
    
    func testTripsStartsEmpty() {
        let tripController = TripController(clock: Date.init)
        XCTAssertEqual(tripController.trips, [])
    }
    
    func testAddCatch() {
        let now = Date.now
        let tripController = TripController(clock: { now })
        let newCatch = CatchCreationRequest(species: .bass, length: Measurement(value: 10, unit: .inches), weight: Measurement(value: 10, unit: .pounds), waterTemperature: Measurement(value: 64, unit: .fahrenheit), bait: "Worm")
        tripController.addCatch(newCatch)
        
        XCTAssertEqual(tripController.trips.count, 1)
        guard let actualTrip = tripController.trips.first else { return }
        XCTAssertEqual(actualTrip.locations.count, 1)
        guard let location = actualTrip.locations.first else { return }
        XCTAssertEqual(location.catches.count, 1)
        guard let fish = location.catches.first else { return }
        XCTAssertEqual(fish.fish, newCatch.species)
        XCTAssertEqual(fish.length, newCatch.length)
        XCTAssertEqual(fish.weight, newCatch.weight)
        XCTAssertEqual(fish.bait, newCatch.bait)
        XCTAssertEqual(fish.timeCaught, now)
    }

    
    //submit a catch
    //generate a trip
    //generate a location
    //map a catch to location
    //map a location to a trip
    //group locations

    
    
}
