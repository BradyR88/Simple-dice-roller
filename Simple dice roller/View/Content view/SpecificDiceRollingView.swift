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
                        Button {
                            viewModel.addToEvent(abilaty.genarateEvent(who: display.name, circumstance: viewModel.circumstance))
                        } label: {
                            Text(abilaty.longName)
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(.green)
                                .clipShape(Capsule())
                        }
                        
                        Spacer()
                        
                        if abilaty.hasOnHit {
                            LongPressButton {
                                viewModel.addToEvent(abilaty.genarateEvent(who: display.name, circumstance: .neutral, damageRoll: true))
                            } longTapAction: {
                                viewModel.addToEvent(abilaty.genarateEvent(who: display.name, circumstance: .crit, damageRoll: true))
                            } label: {
                                Text(abilaty.onHit!.stringName)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .background(.blue)
                                    .clipShape(Capsule())
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
            .environmentObject(ViewModel())
    }
}

