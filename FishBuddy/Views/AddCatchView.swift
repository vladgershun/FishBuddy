//
//  AddCatchView.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 7/31/22.
//

import SwiftUI

struct AddCatchView: View {
    
    @StateObject private var viewModel = AddCatchViewModel(catchSubmission: StubCatchSubmissionService(), locationService: DeniedLocationService(), locationGrouping: StubLocationGroupingService())
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
                                Text(" \($0) Inches" ).tag(Measurement(value: Double($0), unit: UnitLength.inches))
                            }
                        }
                        
                        Picker("Select Weight", selection: $viewModel.weight) {
                            ForEach(0..<100) {
                                Text(" \($0) lbs" ).tag(Measurement(value: Double($0), unit: UnitMass.pounds))
                            }
                        }
                          
                        Picker("Select Water Temperature", selection: $viewModel.waterTemperature) {
                            ForEach(0..<80) {
                                Text(" \($0) °F" ).tag(Measurement(value: Double($0), unit: UnitTemperature.fahrenheit))
                            }
                        }
                        
                        TextField("Bait", text: $viewModel.bait)
                            .focused($baitIsFocused)

                        
                        Text("Add Image")
                        
                        switch viewModel.location {
                        case .loaded(let location):
                            VStack {
                                MapPreview(location: location)
                                    .aspectRatio(16/11, contentMode: .fill)
                                //                    .clipShape(CutoffPlatterShape())
                                
                                Text(location.name)
                                    .padding([.leading, .bottom], 10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .listRowSeparator(.hidden)
                            .background(Color(.secondarySystemBackground), in: RoundedRectangle.platter)
                            .padding()
                            
                        case .loading:
                            ProgressView()
                            
                        case .failed(_):
                            Text("No Map")
                        }                        
                    }
                    
                    Section {
                        HStack {
                            Spacer()
                            
                            Button("Add Catch") {
                                Task {
                                    if await viewModel.submit() {
                                        dismiss()
                                    }
                                    //Errors
                                }
                                
                            }.disabled(!viewModel.isValid)
                            
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
        .task {
            await viewModel.task()
        }
        
        
    }
}
