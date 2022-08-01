//
//  AddCatchView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import SwiftUI

struct AddCatchView: View {
    
    //replace these with strucutres
    @State private var fish: Fish = .salmon
    @State private var length: Measurement<UnitLength> = Measurement(value: 12, unit: .inches)
    @State private var weight: Measurement<UnitMass> = Measurement(value: 32, unit: .pounds)
    @State private var waterTemperature: Measurement<UnitTemperature> = Measurement(value: 50, unit: .fahrenheit)
    @State private var timeCaught = Date.now
    @FocusState private var weightIsFocused: Bool
    
    //Remove for iOS 16
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Picker("Select Fish Species", selection: $fish) {
                            ForEach(Fish.exampleFish) {
                                Text($0.species)
                            }
                        }
                        
                        Picker("Select Length", selection: $length) {
                            ForEach(0..<80) {
                                Text(" \($0) Inches" )
                            }
                        }
                        
                        Picker("Select Weight", selection: $weight) {
                            ForEach(0..<100) {
                                Text(" \($0) lbs" )
                            }
                        }
                          
                        Picker("Select Water Temperature", selection: $waterTemperature) {
                            ForEach(0..<80) {
                                Text(" \($0) °F" )
                            }
                        }
                        
                        Text("Add Image")
                    }
                    
                    Section {
                        HStack {
                            Spacer()
                            Button("Add Catch") { dismiss() }
                            Spacer()
                        }
                        
                    }
                    
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        weightIsFocused = false
                    }
                }
            }
//            .scrollContentBackground(.hidden) fix when iOS 16
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue.opacity(0.7))
        }
        
        
    }
}
