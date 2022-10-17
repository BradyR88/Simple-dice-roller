//
//  DiceCalculatorBoardView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/7/22.
//

import SwiftUI

struct DiceCalculatorBoardView: View {
    @Binding var roll: Roll?
    
    var body: some View {
        if roll != nil {
            VStack {
                Text(Constance.diceString(roll!.numberOfDice, d: roll!.numberOfSides, toAdd: roll!.toAdd))
                    .font(.title)
                    .bold()
                
                HStack {
                    NumberToggleView {
                        // addition
                        roll!.numberOfDice += 1
                    } subtraction: {
                        roll!.numberOfDice -= 1
                    }
                    
                    VStack {
                        dicePicker(sides: 20)
                        dicePicker(sides: 6)
                        dicePicker(sides: 10)
                    }
                    
                    VStack {
                        dicePicker(sides: 4)
                        dicePicker(sides: 8)
                        dicePicker(sides: 12)
                    }
                    
                    NumberToggleView {
                        // addition
                        roll!.toAdd += 1
                    } subtraction: {
                        roll!.toAdd -= 1
                    }
                }
                .padding(.bottom)
            }
            .dynamicTypeSize(.xSmall ... .accessibility2)
            
        } else {
            EmptyView()
        }
    }
    
    func dicePicker(sides: Int) -> some View {
        var view: some View {
            Button {
                withAnimation {
                    roll!.numberOfSides = sides
                }
            } label: {
                Text("\(sides)")
                    .bold()
                    .font(.title)
                    .foregroundColor(.primary)
                    .frame(width: 65, height: 48)
                    .background(roll!.numberOfSides == sides ? .red : .red.opacity(0.75))
                    .background(.black)
                    .clipShape(Capsule())
            }
        }
        return view
    }
}
struct DiceCalculatorBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DiceCalculatorBoardView(roll: .constant(Roll.example20))
    }
}
