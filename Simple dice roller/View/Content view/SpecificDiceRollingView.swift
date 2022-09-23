//
//  SpecificDiceRollingView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/30/22.
//

import SwiftUI

struct SpecificDiceRollingView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var circumstance: Circumstance = .neutral
    let display: Monster
    
    
    var body: some View {
        VStack (alignment: .leading) {
            ForEach(display.abilaty) { abilaty in
                // TODO: new abilaty read out
                Text(abilaty.longName)
                    .padding(.horizontal)
                    .padding(.vertical, 3)
                    .background(.green)
                    .clipShape(Capsule())
                    .onTapGesture {
                        viewModel.addToEvent(abilaty.genarateEvent(who: display.name, circumstance: circumstance))
                    }
            }
            .padding()
            
            Picker("select advantage state", selection: $circumstance) {
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

