//
//  Location.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//
//  Model of what a location is

import Foundation
import MapKit

struct Location: Hashable, Identifiable {
    var id: String {
        return name
    }
    let name: String
    let coordinate: CLLocationCoordinate2D
}

// TODO: Don't do this because we don't own Hashable or CLLocationCoordinate2D
extension CLLocationCoordinate2D: Hashable {
    public func hash(into hasher: inout Hasher) {
        latitude.hash(into: &hasher)
        longitude.hash(into: &hasher)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.latitude == rhs.latitude
        && lhs.longitude == rhs.longitude
    }
}

extension Location {
    
    static let klineline = Location(name: "Klineline", coordinate: CLLocationCoordinate2D(latitude: 45.706426, longitude: -122.658824))
    static let columbiaRiver = Location(name: "Columbia River", coordinate: CLLocationCoordinate2D(latitude: 46.246922, longitude: -124.09344))
    
}
