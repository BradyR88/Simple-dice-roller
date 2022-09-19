//
//  RollReadoutView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import SwiftUI

struct RollReadoutView: View {
    let rollResult: RollResult
    
    @State var infoPainVisible = false
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(rollResult.isSubRoll ? Constance.diceStringPlus(roll: rollResult.roll.subRoll!) : Constance.diceStringPlus(roll: rollResult.roll))
                    .bold()
                    .font(.title)
                
                if rollResult.circumstance == .advantage {
                    Image(systemName: "arrow.up.forward.square.fill")
                        .font(.title)
                        .foregroundColor(.green)
                } else if rollResult.circumstance == .disadvantage {
                    Image(systemName: "arrow.down.forward.square.fill")
                        .font(.title)
                        .foregroundColor(.red)
                } else if rollResult.circumstance == .crit {
                    Image(systemName: "star.square.fill")
                        .font(.title)
                        .foregroundColor(.yellow)
                }
                
                Spacer()
                
                Text("\(rollResult.total)")
                    .bold()
                    .font(.title)
                Button {
                    infoPainVisible.toggle()
                } label: {
                    Image(systemName: "eye.fill")
                        .font(.title3)
                }
            }
            if infoPainVisible {
                Text("[\(rollResult.faces.map{String($0)}.joined(separator: ","))]")
            }
        }
        .onTapGesture { infoPainVisible.toggle() }
    }
}

struct RollReadoutView_Previews: PreviewProvider {
    static var previews: some View {
        RollReadoutView(rollResult: RollResult.example)
    }
}
