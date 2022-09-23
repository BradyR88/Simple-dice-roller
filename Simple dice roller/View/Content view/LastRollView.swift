//
//  LastRollView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/15/22.
//

import SwiftUI

struct LastRollView: View {
    @EnvironmentObject var viewModel: ViewModel
    let event: Event
    
    var body: some View {
        VStack {
            Text(event.longName)
                .bold()
                .font(.title)
            
            if event.hasRollResult {
                HStack {
                    VStack {
                        Text(Constance.diceStringPlus(roll: event.rollResult!.roll))
                        Text("[\(event.rollResult!.faces.map{String($0)}.joined(separator: ","))]")
                    }
                    Spacer()
                    
                    if event.showHitButton {
                        Button {
                            viewModel.addToEvent(event.hitRoll())
                        } label: {
                            Text("Damage")
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                                .background(.green)
                                .clipShape(Capsule())
                        }

                    }
                    
                    Spacer()
                    Text(String(event.rollResult!.result))
                        .bold()
                        .font(.title)
                        .foregroundColor(event.rollResult!.color)
                }
            }
            
            if event.hasRollResult && event.hasDiscription { Divider() }
            
            if event.hasDiscription {
                Text(event.abilaty.discription!)
            }
        }
        .padding(.horizontal)
    }
}

struct LastRollView_Previews: PreviewProvider {
    static var previews: some View {
        LastRollView(event: Event.example)
            .environmentObject(ViewModel())
    }
}