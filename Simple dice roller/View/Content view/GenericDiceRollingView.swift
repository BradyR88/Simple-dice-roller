//
//  GenericDiceRollingView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import SwiftUI

struct GenericDiceRollingView: View {
    let text: String
    let onSubmit: (Roll)->Void
    
    @State private var amount = 1
    @State private var numberOfSides = 20
    @State private var toAdd = 0
    
    var body: some View {
        VStack {
            
            DiceCalculatorBoardView(amount: $amount, numberOfSides: $numberOfSides, toAdd: $toAdd)
            
            Button {
                onSubmit(Roll(amount, d: numberOfSides, toAdd: toAdd))
            } label: {
                Text(text)
                    .bold()
                    .font(.title)
                    .foregroundColor(.primary)
                    .frame(width: 305, height: 44)
                    .background(.green)
                    .clipShape(Capsule())
            }
        }
    }
}

struct GenericDiceRollingView_Previews: PreviewProvider {
    static var previews: some View {
        GenericDiceRollingView(text: "Test") { roll in
            let result = RollResult(roll: roll)
            print(result.total)
        }
    }
}
