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
    
    @State private var roll = Roll(name: "Custom", 1, d: 20, toAdd: 0, subRoll: nil)
    
    var body: some View {
        VStack {
            
            DiceCalculatorBoardView(roll: $roll)
            
            Button {
                onSubmit(roll)
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
