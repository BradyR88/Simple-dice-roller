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
            Marquee {
                Text(event.longName)
                    .bold()
                    .font(.title)
            }
            .marqueeDuration(8)
            .marqueeWhenNotFit(true)
            .marqueeIdleAlignment(.center)
            // TODO: find better to limit the size of the underlying geometry reader so that it works on all screen size
            .frame(height: 40)
            
            if event.hasRollResult {
                ZStack {
                    HStack {
                        VStack {
                            Text(Constance.diceStringPlus(roll: event.rollResult!.roll))
                            Text("[\(event.rollResult!.faces.map{String($0)}.joined(separator: ","))]")
                        }
                        
                        Spacer()
                        
                        Text(String(event.rollResult!.result))
                            .bold()
                            .font(.title)
                            .foregroundColor(event.rollResult!.color)
                    }
                    
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
                }
            }
            
            if event.hasRollResult && event.hasDiscription { Divider() }
            
            if event.hasDiscription && !viewModel.descriptionReadMode {
                Text(event.abilaty.discription!)
                    .lineLimit(3)
                    .onTapGesture {
                        viewModel.tapOnDiscription()
                    }
            } else if event.hasDiscription && viewModel.descriptionReadMode {
                ScrollView {
                    Text(event.abilaty.discription!)
                }
                .onTapGesture {
                    viewModel.tapOnDiscription()
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

struct LastRollView_Previews: PreviewProvider {
    static var previews: some View {
        LastRollView(event: Event.exampleLong)
            .environmentObject(ViewModel())
    }
}
