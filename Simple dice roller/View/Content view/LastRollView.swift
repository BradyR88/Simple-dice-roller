//
//  LastRollView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/15/22.
//

import SwiftUI

struct LastRollView: View {
    @EnvironmentObject var viewModel: ViewModel
    let rollResult: RollResult
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(rollResult.roll.from ?? "")\(rollResult.roll.from == nil ? "" : " - ")\(rollResult.roll.name)")
                .bold()
                .font(.title)
            
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
                
                if rollResult.roll.subRoll != nil && !rollResult.isSubRoll {
                    Button {
                        viewModel.rollHit(from: rollResult)
                    } label: {
                        Text("\(rollResult.total)")
                            .foregroundColor(.primary)
                            .bold()
                            .font(.title)
                            .padding(.horizontal)
                            .background(.green)
                            .clipShape(Capsule())
                    }
                } else {
                    Text("\(rollResult.total)")
                        .bold()
                        .font(.title)
                }
            }
            
            Text("[\(rollResult.faces.map{String($0)}.joined(separator: ","))]")
            
        }
        .padding()
    }
}

struct LastRollView_Previews: PreviewProvider {
    static var previews: some View {
        LastRollView(rollResult: .example)
    }
}
