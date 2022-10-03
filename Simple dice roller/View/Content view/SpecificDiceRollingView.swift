//
//  SpecificDiceRollingView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/30/22.
//

import SwiftUI

struct SpecificDiceRollingView: View {
    @EnvironmentObject var viewModel: ViewModel
    let display: Monster
    
    
    var body: some View {
        VStack (alignment: .leading) {
            ScrollView {
                ForEach(display.abilaty) { abilaty in
                    // TODO: add longTap funcshanalaty
                    HStack {
                        Text(abilaty.longName)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(.green)
                            .clipShape(Capsule())
                            .onTapGesture {
                                viewModel.addToEvent(abilaty.genarateEvent(who: display.name, circumstance: viewModel.circumstance))
                            }
                        
                        Spacer()
                        
                        if abilaty.hasOnHit {
                            Text(abilaty.onHit!.stringName)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(.blue)
                                .clipShape(Capsule())
                                .onTapGesture {
                                    viewModel.addToEvent(abilaty.genarateEvent(who: display.name, circumstance: .neutral, damageRoll: true))
                                }
                                .onLongPressGesture {
                                    viewModel.addToEvent(abilaty.genarateEvent(who: display.name, circumstance: .crit, damageRoll: true))
                                }
                        }
                    }
                    
                }
                .padding(.horizontal)
            }
            
            Picker("select advantage state", selection: $viewModel.circumstance) {
                ForEach(Circumstance.allCases, id: \.self) { value in
                    if value != .crit {
                        Text(value.rawValue).tag(value)
                    }
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

        }
    }
}

struct SpecificDiceRollingView_Previews: PreviewProvider {
    static var previews: some View {
        SpecificDiceRollingView(display: Monster.example)
    }
}

