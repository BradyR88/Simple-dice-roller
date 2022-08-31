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
                Button {
                    switch circumstance {
                    case .advantage:
                        viewModel.rollWithAdvantage(roll)
                        circumstance = .neutral
                    case .disadvantage:
                        viewModel.rollWithDisadvantage(roll)
                        circumstance = .neutral
                    case .neutral:
                        viewModel.rolldice(roll)
                    }                    
                } label: {
                    HStack {
                        Text(Constance.diceString(roll.amount, d: roll.numberOfSides, toAdd: roll.toAdd))
                            .bold()
                            .font(.title)
                            .foregroundColor(.primary)
                            .padding(6)
                            .background(.orange)
                            .clipShape(Capsule())
                            .padding(.leading)
                        
                        Spacer()
                    }
                }
            }
            
            Picker("select advantage state", selection: $circumstance) {
                ForEach(Circumstance.allCases, id: \.self) { value in
                    Text(value.rawValue).tag(value)
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

