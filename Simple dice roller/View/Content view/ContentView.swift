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
            VStack (spacing: 0) {
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
                                    .background(viewModel.display == nil ? .red : .purple)
                                    .clipShape(Capsule())
                                    .padding(.leading, 8)
                            }
                            
                            ForEach(viewModel.rollGroops) { rollGroop in
                                // TODO: stop using a statement and rather have a sub group for just the ones that are showing
                                if rollGroop.isShowing {
                                    Button {
                                        viewModel.display = rollGroop
                                    } label: {
                                        Text(rollGroop.name)
                                            .font(.title3)
                                            .foregroundColor(.primary)
                                            .padding(6)
                                            .background((rollGroop == (viewModel.display ?? RollGroop(name: ""))) ? .red : .purple)
                                            .clipShape(Capsule())
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 5)
                    .background(.tertiary)
                    
                    
                    // MARK: Roll Display
                    if viewModel.display == nil {
                        GenericDiceRollingView(text: "Roll!") { roll in viewModel.rolldice(roll) }
                    } else {
                        // the user has selected a specific display to show (it is not nill)
                        SpecificDiceRollingView(display: viewModel.display!)
                    }
                }
            }
            .navigationTitle("Paper Dice")
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
