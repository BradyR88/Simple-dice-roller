//
//  RollButtonView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/12/22.
//

import SwiftUI

struct RollButtonView: View {
    @EnvironmentObject var viewModel: ViewModel
    let roll: Roll
    let forSubRoll: Bool
    @Binding var circumstance: Circumstance
    
    var amount: Int {
        if forSubRoll {
            return roll.subRoll?.amount ?? 0
        } else {
            return roll.amount
        }
    }
    var numberOfSides: Int {
        if forSubRoll {
            return roll.subRoll?.numberOfSides ?? 0
        } else {
            return roll.numberOfSides
        }
    }
    var toAdd: Int {
        if forSubRoll {
            return roll.subRoll?.toAdd ?? 0
        } else {
            return roll.toAdd
        }
    }
    
    var body: some View {
        Button {
            if forSubRoll {
                viewModel.subRoll(from: roll)
            } else {
                viewModel.rolldice(roll, with: circumstance)
            }
            circumstance = .neutral
        } label: {
            HStack {
                Text("\(forSubRoll ? "To Hit" : roll.name):")
                    .bold()
                    .font(.title3)
                    .foregroundColor(.primary)
                    .padding(6)
                
                Text(Constance.diceString(amount, d: numberOfSides, toAdd: toAdd))
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.trailing)
            }
            .background(forSubRoll ? .green : .orange)
            .clipShape(Capsule())
        }
    }
}

struct RollButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RollButtonView(roll: Roll.example, forSubRoll: false, circumstance: .constant(Circumstance.neutral))
    }
}
