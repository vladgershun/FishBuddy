//
//  Fish.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//
//  Model of a fish

import Foundation

struct Fish: Identifiable {
    
    let id: UUID
    let species: String
}

extension Fish {
    
    static let salmon = Fish(id: UUID(), species: "Salmon")
    static let trout = Fish(id: UUID(), species: "Trout")
    static let bass = Fish(id: UUID(), species: "Bass")
}
