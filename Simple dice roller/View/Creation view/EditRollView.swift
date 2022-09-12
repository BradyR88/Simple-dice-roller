//
//  EditRollView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/9/22.
//

import SwiftUI

struct EditRollView: View {
    let roll: Roll
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(roll.name)
            HStack{
                Text(Constance.diceString(roll.amount, d: roll.numberOfSides, toAdd: roll.toAdd))
                Spacer()
                if roll.subRoll != nil {
                    Text("Hit:")
                        .font(.callout)
                    Text(Constance.diceString(roll.subRoll!.amount, d: roll.subRoll!.numberOfSides, toAdd: roll.subRoll!.toAdd))
                        .padding(.trailing, 65)
                }
            }
        }
        .foregroundColor(.primary)
    }
}

struct EditRollView_Previews: PreviewProvider {
    static var previews: some View {
        EditRollView(roll: Roll.exampleWithSubRoll)
    }
}
