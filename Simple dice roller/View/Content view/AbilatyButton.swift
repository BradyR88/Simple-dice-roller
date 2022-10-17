//
//  AbilatyButton.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 10/17/22.
//

import SwiftUI

struct AbilatyButton: View {
    @EnvironmentObject var viewModel: ViewModel
    let display: Monster
    let abilaty: Ability
    
    @Environment(\.dynamicTypeSize) var typeSize
    
    var body: some View {
        ZStack {
            if abilaty.hasOnHit {
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.secondary)
            }
            HStack {
                Button {
                    viewModel.addToEvent(abilaty.genarateEvent(who: display.name, circumstance: viewModel.circumstance))
                } label: {
                    if typeSize >= .xxLarge && abilaty.hasRoll {
                        // big neads to be on two line
                        VStack(alignment: .leading) {
                            Text(abilaty.name)
                            Text(abilaty.roll!.stringName)
                        }
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .clipShape(Capsule())
                    } else {
                        // normal on one line
                        Text(abilaty.longName)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                    
                }
                .background(.background)
                
                Spacer()
                
                if abilaty.hasOnHit {
                    LongPressButton {
                        viewModel.addToEvent(abilaty.genarateEvent(who: display.name, circumstance: .neutral, damageRoll: true))
                    } longTapAction: {
                        viewModel.addToEvent(abilaty.genarateEvent(who: display.name, circumstance: .crit, damageRoll: true))
                    } label: {
                        Text(abilaty.onHit!.stringName)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(.green)
                            .clipShape(Capsule())
                    }
                    .background(.background)
                }
            }
        }
    }
}

struct AbilatyButton_Previews: PreviewProvider {
    static var previews: some View {
        AbilatyButton(display: Monster.example, abilaty: Ability.example)
            .environmentObject(ViewModel())
    }
}
