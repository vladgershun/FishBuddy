//
//  AddCatchView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import SwiftUI

struct AddCatchView: View {
    
    @StateObject private var viewModel = AddCatchViewModel()
    @FocusState private var weightIsFocused: Bool
    @FocusState private var baitIsFocused: Bool

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Picker("Select Fish Species", selection: $viewModel.fish) {
                            ForEach(Fish.exampleFish) {
                                Text($0.species)
                            }
                        }

                        Picker("Select Length", selection: $viewModel.length) {
                            ForEach(0..<80) {
                                Text(" \($0) Inches" )
                            }
                        }
                        
                        Picker("Select Weight", selection: $viewModel.weight) {
                            ForEach(0..<100) {
                                Text(" \($0) lbs" )
                            }
                        }
                          
                        Picker("Select Water Temperature", selection: $viewModel.waterTemperature) {
                            ForEach(0..<80) {
                                Text(" \($0) °F" )
                            }
                        }
                        
                        TextField("Bait", text: $viewModel.bait)
                            .focused($baitIsFocused)

                        
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
                        baitIsFocused = false
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
        
        
    }
}
