//
//  Trip.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//
//  Model for what a trip will consist of

import Foundation
import MapKit

struct Trip: Identifiable, Hashable {
    
    let id: UUID
    /// Non-empty list of locations
    var locations: [LocationVisit]
    
    var firstLocation: LocationVisit {
        locations.first!
    }
    
    init(id: UUID, firstLocation: LocationVisit) {
        self.id = id
        self.locations = [firstLocation]
    }
    
    var arrivalDate: Date {
        firstLocation.arrivialTime
    }
    
    var totalFishCaught: Int {
        locations.lazy.map(\.catches.count).reduce(0, +)
    }
    
    var boundingRegion: MKMapRect? {
        MKMapRect(containing: locations.lazy.compactMap { $0.location?.coordinate }.map { coordinate in
            MKMapPoint(coordinate)
        })
    }
}

extension MKMapRect {
    init?(containing points: some Collection<MKMapPoint>) {
        guard !points.isEmpty else { return nil }
        var result = MKMapRect(origin: points.first!, size: MKMapSize())
        for point in points.dropFirst() {
            result = result.union(MKMapRect(origin: point, size: MKMapSize()))
        }
        self = result
    }
}

extension Trip {
    static let day1 = Trip(id: UUID(), firstLocation: .klineline)
    static let day2 = Trip(id: UUID(), firstLocation: .columbiaRiver)
    static let day3: Trip = {
        var trip = Trip(id: UUID(), firstLocation: .klineline)
        trip.locations.append(.columbiaRiver)
        return trip
    }()
}
