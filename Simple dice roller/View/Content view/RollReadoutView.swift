//
//  RollReadoutView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import SwiftUI

struct RollReadoutView: View {
    let event: Event
    
    @State var infoPainVisible = false
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(event.longNameInRollReadout)
                Spacer()
                if event.hasRollResult {
                    Text(String(event.rollResult!.result))
                    CircumstanceEmblem(circumstance: event.rollResult!.circumstance)
                }
            }
            
            if infoPainVisible {
                if event.hasRollResult {
                    Text("\(Constance.diceStringPlus(roll: event.rollResult!.roll))  [\(event.rollResult!.faces.map{String($0)}.joined(separator: ","))]")
                }
                if event.hasDiscription {
                    Text(event.abilaty.discription!)
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture { infoPainVisible.toggle() }
    }
}

struct RollReadoutView_Previews: PreviewProvider {
    static var previews: some View {
        RollReadoutView(event: .example)
    }
}
