//
//  LastRollView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/15/22.
//

import SwiftUI

struct LastRollView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Text("place holder for last event")
        
//        VStack (alignment: .leading) {
//            Text("\(viewModel.lastEvent.who ?? "")\(viewModel.lastEvent.who == nil ? "" : " - ")\(viewModel.lastEvent.abilaty.name)")
//                .bold()
//                .font(.title)
//
//            HStack {
//                Text(viewModel.lastEvent.isSubRoll ? Constance.diceStringPlus(roll: viewModel.lastEvent.roll.subRoll!) : Constance.diceStringPlus(roll: viewModel.lastEvent.roll))
//                    .bold()
//                    .font(.title)
//
//                if viewModel.lastEvent.circumstance == .advantage {
//                    Image(systemName: "arrow.up.forward.square.fill")
//                        .font(.title)
//                        .foregroundColor(.green)
//                } else if viewModel.lastEvent.circumstance == .disadvantage {
//                    Image(systemName: "arrow.down.forward.square.fill")
//                        .font(.title)
//                        .foregroundColor(.red)
//                } else if viewModel.lastEvent.circumstance == .crit {
//                    Image(systemName: "star.square.fill")
//                        .font(.title)
//                        .foregroundColor(.yellow)
//                }
//
//                Spacer()
//
//                if viewModel.lastEvent.roll.subRoll != nil && !viewModel.lastEvent.isSubRoll {
//                    Button {
//                        viewModel.addToEvent(event: viewModel.lastEvent?.hitRoll())
//                    } label: {
//                        Text("\(viewModel.lastEvent.total)")
//                            .foregroundColor(.primary)
//                            .bold()
//                            .font(.title)
//                            .padding(.horizontal)
//                            .background(.green)
//                            .clipShape(Capsule())
//                    }
//                } else {
//                    Text("\(viewModel.lastEvent.total)")
//                        .bold()
//                        .font(.title)
//                }
//            }
//
//            Text("[\(viewModel.lastEvent.rollResult.faces.map{String($0)}.joined(separator: ","))]")
//
//        }
//        .padding()
    }
}

struct LastRollView_Previews: PreviewProvider {
    static var previews: some View {
        LastRollView()
            .environmentObject(ViewModel())
    }
}
