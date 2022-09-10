//
//  LocationService.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 9/10/22.
//

import Foundation
import CoreLocation

protocol LocationService {
    func getCurrentLocation() async throws -> CLLocationCoordinate2D
}

class StubLocationService: LocationService {
    func getCurrentLocation() async throws -> CLLocationCoordinate2D {
        return Location.klineline.coordinate
    }
}

class CoreLocationService: LocationService {
    
    let locationManger: CLLocationManager
    let delegate: Delegate
    
    init() {
        self.locationManger = CLLocationManager()
        self.delegate = Delegate()
        locationManger.delegate = delegate
    }
    
    func getCurrentLocation() async throws -> CLLocationCoordinate2D {
        locationManger.requestWhenInUseAuthorization()
        let _: Void = try await withCheckedThrowingContinuation { continuation in
            delegate.authorizationContinuation = continuation
        }
//        try await locationManger.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "catch")
        locationManger.requestLocation()
        let locations = try await withCheckedThrowingContinuation { continuation in
            delegate.locationContinuation = continuation
        }
        return locations.first!.coordinate
    }
    
    
}

extension CoreLocationService {
    final class Delegate: NSObject, CLLocationManagerDelegate {
        fileprivate var authorizationContinuation: CheckedContinuation<Void, Error>?
        fileprivate var locationContinuation: CheckedContinuation<[CLLocation], Error>?

        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            print("DidChangeAuthorization", manager.authorizationStatus)
            if let continuation = authorizationContinuation {
                continuation.resume()
                authorizationContinuation = nil
            }
        }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            print("didUpdateLocation", locations)
            if let continuation = locationContinuation {
                continuation.resume(returning: locations)
                locationContinuation = nil
            }
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("didFailWithError", error)
            if let continuation = locationContinuation {
                continuation.resume(throwing: error)
                locationContinuation = nil
            } else if let continuation = authorizationContinuation {
                continuation.resume(throwing: error)
                authorizationContinuation = nil
            }
        }
    }
}

//dont allow error is not appearing
