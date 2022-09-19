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
    let display: RollGroop
    
    
    var body: some View {
        VStack (alignment: .leading) {
            ForEach(display.rolls) { roll in
                HStack {
                    RollButtonView(roll: roll, forSubRoll: false, circumstance: $circumstance)
                        .padding(.leading)
                    
                    Spacer()
                    
                    
                    if roll.subRoll != nil {
                        RollButtonView(roll: roll, forSubRoll: true, circumstance: $circumstance)
                    }
                    
                }
            }
            
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
        SpecificDiceRollingView(display: RollGroop.example)
    }
}

