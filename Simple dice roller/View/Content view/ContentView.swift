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
                Divider()
                
                // TODO: the last roll veiw that is alwase at the top
                if viewModel.lastEvent != nil {
                    LastRollView()
                }
                
                
                List {
                    ForEach(viewModel.pastEventsDropFirst) { event in
                        RollReadoutView(event: event)
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
                            
                            ForEach(viewModel.monsters) { monster in
                                // TODO: stop using a statement and rather have a sub group for just the ones that are showing
                                if monster.isShowing {
                                    Button {
                                        viewModel.display = monster
                                    } label: {
                                        Text(monster.name)
                                            .font(.title3)
                                            .foregroundColor(.primary)
                                            .padding(6)
                                            .background((monster == (viewModel.display ?? Monster(name: "", abilaty: [], isShowing: false))) ? .red : .purple)
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
                        GenericDiceRollingView(text: "Roll!") { roll in viewModel.addToEvent(roll.simpleCustumEvent()) }
                        
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
            .onAppear { viewModel.updateDisplay() }
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
