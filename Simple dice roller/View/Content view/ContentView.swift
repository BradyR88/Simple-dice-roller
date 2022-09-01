//
//  ContentView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: past rolls
                List {
                    ForEach(viewModel.pastRolls) { roll in
                        RollReadoutView(rollResult: roll)
                    }
                }
                
                VStack {
                    // MARK: roll options
                    ScrollView(.horizontal, showsIndicators: false) {
                        //options for dice rolers
                        HStack {
                            Button {
                                // set the display to a
                                viewModel.display = nil
                            } label: {
                                Text("Standard")
                                    .font(.title3)
                                    .foregroundColor(.primary)
                                    .padding(6)
                                    .background(.purple)
                                    .clipShape(Capsule())
                                    .padding(.leading, 8)
                            }
                            
                            ForEach(viewModel.rollGroops) { rollGroop in
                                Button {
                                    viewModel.display = rollGroop
                                } label: {
                                    Text(rollGroop.name)
                                        .font(.title3)
                                        .foregroundColor(.primary)
                                        .padding(6)
                                        .background(.purple)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }
                    
                    Divider()
                        .padding(.horizontal, 5)
                    
                    // MARK: Roll Display
                    if viewModel.display == nil {
                        GenericDiceRollingView()
                    } else {
                        // the user has selected a specific display to show (it is not nill)
                        SpecificDiceRollingView(display: viewModel.display!)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink {
                        // setings
                    } label: {
                        Image(systemName: "gear")
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink {
                        CreationView()
                    } label: {
                        Image(systemName: "die.face.6")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        
        ContentView()
            .environmentObject(viewModel)
    }
}
