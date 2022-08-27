//
//  RollReadoutView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import SwiftUI

struct RollReadoutView: View {
    let roll: Roll
    
    var body: some View {
        HStack {
            Text("\(roll.diceRolled)d\(roll.sides)\(roll.plus > 0 ? " + \(roll.plus)" : "")")
            
            Spacer()
            
            Text("\(roll.total)")
        }
    }
}

struct RollReadoutView_Previews: PreviewProvider {
    static var previews: some View {
        RollReadoutView(roll: Roll.example)
    }
}
