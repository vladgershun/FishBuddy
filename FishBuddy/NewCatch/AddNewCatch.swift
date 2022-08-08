//
//  GenerateNewCatch.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 8/8/22.
//

import Foundation


//  Check if there is a trip for the current day
func isCurrentTrip() -> Bool {
    return false
}

//  Check if there is a current location
func isCurrentLocation() -> Bool {
    return false
}

//  Generate new trip for current day
func newTrip() {
    
}

//  Generate new location
func newLocation() {
    
}

func addNewCatch() {
    
    //  If No trip or location at users current postion exist create one
    if !isCurrentTrip() && !isCurrentLocation() {
        newTrip()
        newLocation()
        //  Add new catch to current location and trip
    }
    
    //  If a trip for today exists but no location and users current position, create new location
    if isCurrentTrip() && !isCurrentLocation() {
        newLocation()
        //  Add new catch to current location and trip
    }
    
    //  If a trip for today exists and a location for where user is
    if isCurrentTrip() && isCurrentLocation() {
        //  Add new catch to current location and trip
    }
    
}
