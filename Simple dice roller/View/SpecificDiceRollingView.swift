//
//  SpecificDiceRollingView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/30/22.
//

import SwiftUI

struct SpecificDiceRollingView: View {
    let display: RollGroop
    
    var body: some View {
        VStack (alignment: .leading) {
            ForEach(display.rolls) { roll in
                Text("\(roll.amount)d\(roll.numberOfSides)\(roll.toAdd > 0 ? " + \(roll.toAdd)" : "")")
                    .bold()
                    .font(.title)
            }
        }
    }
}

struct SpecificDiceRollingView_Previews: PreviewProvider {
    static var previews: some View {
        SpecificDiceRollingView(display: RollGroop.example)
    }
}
