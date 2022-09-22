//
//  RollButtonView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/12/22.
//

import SwiftUI

//TODO: this will be replased with a eveint options view
// what is bottom of the screen when a user selects a monster i.e. club smoke cloud etc. clicking on then will post them to the event log

//struct RollButtonView: View {
//    @EnvironmentObject var viewModel: ViewModel
//    let roll: Roll
//    let forSubRoll: Bool
//    @Binding var circumstance: Circumstance
//
//    var amount: Int {
//        if forSubRoll {
//            return roll.subRoll?.amount ?? 0
//        } else {
//            return roll.amount
//        }
//    }
//    var numberOfSides: Int {
//        if forSubRoll {
//            return roll.subRoll?.numberOfSides ?? 0
//        } else {
//            return roll.numberOfSides
//        }
//    }
//    var toAdd: Int {
//        if forSubRoll {
//            return roll.subRoll?.toAdd ?? 0
//        } else {
//            return roll.toAdd
//        }
//    }
//
//    var body: some View {
//
//
//
//        Button {
//            // this button is handled below by the simultaneous gesture and high priority gesture
//        } label: {
//            HStack {
//                Text("\(forSubRoll ? "To Hit" : roll.name):")
//                    .bold()
//                    .font(.title3)
//                    .foregroundColor(.primary)
//                    .padding(6)
//
//                Text(Constance.diceString(amount, d: numberOfSides, toAdd: toAdd))
//                    .font(.body)
//                    .foregroundColor(.primary)
//                    .padding(.trailing)
//            }
//            .background(forSubRoll ? .green : .orange)
//            .clipShape(Capsule())
//        }
//        .simultaneousGesture(
//            LongPressGesture()
//                .onEnded { _ in
//                    // action for long press
//                    if forSubRoll {
//                        viewModel.subRoll(from: roll, isCrit: true)
//                    } else {
//                        viewModel.rolldice(roll, with: circumstance)
//                    }
//                    circumstance = .neutral
//                }
//        )
//        .highPriorityGesture(TapGesture()
//            .onEnded { _ in
//                // action for a short press
//                if forSubRoll {
//                    viewModel.subRoll(from: roll)
//                } else {
//                    viewModel.rolldice(roll, with: circumstance)
//                }
//                circumstance = .neutral
//            })
//    }
//}
//
//struct RollButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        RollButtonView(roll: Roll.example, forSubRoll: false, circumstance: .constant(Circumstance.neutral))
//    }
//}
