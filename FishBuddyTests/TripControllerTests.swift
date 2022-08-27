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
        
//        if var existingTrip = trips.last, Calendar.current.isDate(existingTrip.arrivalDate, inSameDayAs: clock()) {
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
    
    func testAddMultipleCatch() {
        let now = Date.now
        let tripController = TripController(clock: { now })
        
        let newCatch1 = CatchCreationRequest(species: .bass, length: Measurement(value: 10, unit: .inches), weight: Measurement(value: 10, unit: .pounds), waterTemperature: Measurement(value: 64, unit: .fahrenheit), bait: "First")
        tripController.addCatch(newCatch1)
        
        let newCatch2 = CatchCreationRequest(species: .salmon, length: Measurement(value: 13, unit: .inches), weight: Measurement(value: 11, unit: .pounds), waterTemperature: Measurement(value: 64, unit: .fahrenheit), bait: "Second")
        tripController.addCatch(newCatch2)
        
        XCTAssertEqual(tripController.trips.count, 1, "both are added to the same trip")
        guard let actualTrip = tripController.trips.first else { return }
        XCTAssertEqual(actualTrip.locations.count, 1, "both are added to the same location")
        guard let location = actualTrip.locations.first else { return }
        XCTAssertEqual(location.catches.count, 2)
        guard let first = location.catches.first, let second = location.catches.dropFirst().first else { return }
        
        XCTAssertEqual(first.bait, "First")
        XCTAssertEqual(second.bait, "Second")
    }

    func testAddSameTripNewLocation() {
        let now = Date.now
        let tripController = TripController(clock: { now })
        
        let newCatch1 = CatchCreationRequest(species: .bass, length: Measurement(value: 10, unit: .inches), weight: Measurement(value: 10, unit: .pounds), waterTemperature: Measurement(value: 64, unit: .fahrenheit), bait: "First", location: .klineline)
        tripController.addCatch(newCatch1)
        
        let newCatch2 = CatchCreationRequest(species: .salmon, length: Measurement(value: 13, unit: .inches), weight: Measurement(value: 11, unit: .pounds), waterTemperature: Measurement(value: 64, unit: .fahrenheit), bait: "Second", location: .columbiaRiver)
        tripController.addCatch(newCatch2)
        
        XCTAssertEqual(tripController.trips.count, 1, "both are added to the same trip")
        guard let actualTrip = tripController.trips.first else { return }
        XCTAssertEqual(actualTrip.locations.count, 2, "both are added to different locations")
        guard let first = actualTrip.locations.first, let second = actualTrip.locations.second else { return }
        
        XCTAssertEqual(first.location, .klineline)
        XCTAssertEqual(second.location, .columbiaRiver)
    }
    
    func testAddNewTrip() {
        var now = try! Date("2022-08-27T22:59:02Z", strategy: .iso8601)
        let tripController = TripController(clock: { now })
        
        let newCatch1 = CatchCreationRequest(species: .bass, length: Measurement(value: 10, unit: .inches), weight: Measurement(value: 10, unit: .pounds), waterTemperature: Measurement(value: 64, unit: .fahrenheit), bait: "First", location: .klineline)
        tripController.addCatch(newCatch1)
        
        // Simulate waiting a day.
        now = try! Date("2022-08-28T22:59:02Z", strategy: .iso8601)
        
        let newCatch2 = CatchCreationRequest(species: .salmon, length: Measurement(value: 13, unit: .inches), weight: Measurement(value: 11, unit: .pounds), waterTemperature: Measurement(value: 64, unit: .fahrenheit), bait: "Second", location: .columbiaRiver)
        tripController.addCatch(newCatch2)
        
        XCTAssertEqual(tripController.trips.count, 2, "2 trips in collection")
        guard let first = tripController.trips.first, let second = tripController.trips.second else { return }
        
        XCTAssertEqual(first.arrivalDate,  try! Date("2022-08-27T22:59:02Z", strategy: .iso8601))
        XCTAssertEqual(second.arrivalDate, try! Date("2022-08-28T22:59:02Z", strategy: .iso8601))
    }
    
    func testAdd2NewTrips() {
        var now = try! Date("2022-08-27T22:59:02Z", strategy: .iso8601)
        let tripController = TripController(clock: { now })
        
        let newCatch1 = CatchCreationRequest(species: .bass, length: Measurement(value: 10, unit: .inches), weight: Measurement(value: 10, unit: .pounds), waterTemperature: Measurement(value: 64, unit: .fahrenheit), bait: "First", location: .klineline)
        tripController.addCatch(newCatch1)
        
        // Simulate waiting a day.
        now = try! Date("2022-08-28T22:59:02Z", strategy: .iso8601)
        
        let newCatch2 = CatchCreationRequest(species: .salmon, length: Measurement(value: 13, unit: .inches), weight: Measurement(value: 11, unit: .pounds), waterTemperature: Measurement(value: 64, unit: .fahrenheit), bait: "Second", location: .columbiaRiver)
        tripController.addCatch(newCatch2)
        
        let newCatch3 = CatchCreationRequest(species: .salmon, length: Measurement(value: 13, unit: .inches), weight: Measurement(value: 11, unit: .pounds), waterTemperature: Measurement(value: 64, unit: .fahrenheit), bait: "Third", location: .columbiaRiver)
        tripController.addCatch(newCatch3)
        
        XCTAssertEqual(tripController.trips.count, 2, "2 trips in collection")
        guard let first = tripController.trips.first, let last = tripController.trips.last else { return }
        
        XCTAssertEqual(first.arrivalDate, try! Date("2022-08-27T22:59:02Z", strategy: .iso8601))
        XCTAssertEqual(first.totalFishCaught, 1)
        XCTAssertEqual(last.arrivalDate, try! Date("2022-08-28T22:59:02Z", strategy: .iso8601))
        XCTAssertEqual(last.totalFishCaught, 2)

    }
    
    //submit a catch
    //generate a trip
    //generate a location
    //map a catch to location
    //map a location to a trip
    //group locations

    
    
}

extension Collection {
    var second: Element? {
//        guard count >= 2 else { return nil }
//        return self[self.index(after: self.startIndex)]
        
//        var iterator = self.makeIterator()
//        _ = iterator.next()
//        return iterator.next()

        return dropFirst().first
    }
}
