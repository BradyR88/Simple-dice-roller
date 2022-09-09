//
//  DiceCalculatorBoardView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/7/22.
//

import SwiftUI

struct DiceCalculatorBoardView: View {
    @Binding var amount: Int{
        didSet {
            if amount < 1 { amount = 1 }
        }
    }
    @Binding var numberOfSides: Int
    @Binding var toAdd: Int{
        didSet {
            if toAdd < 0 { toAdd = 0 }
        }
    }
    
    var body: some View {
        VStack {
            Text(Constance.diceString(amount, d: numberOfSides, toAdd: toAdd))
                .font(.title)
                .bold()
            
            HStack {
                NumberToggleView {
                    // addition
                    amount += 1
                } subtraction: {
                    amount -= 1
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
                    toAdd += 1
                } subtraction: {
                    toAdd -= 1
                }
            }
            .padding(.bottom)
        }
    }
    
    func dicePicker(sides: Int) -> some View {
        var view: some View {
            Button {
                withAnimation {
                    numberOfSides = sides
                }
            } label: {
                Text("\(sides)")
                    .bold()
                    .font(.title)
                    .foregroundColor(.primary)
                    .frame(width: 65, height: 48)
                    .background(numberOfSides == sides ? .red : .red.opacity(0.75))
                    .background(.black)
                    .clipShape(Capsule())
            }
        }
        return view
    }
}
struct DiceCalculatorBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DiceCalculatorBoardView(amount: .constant(1), numberOfSides: .constant(20), toAdd: .constant(0))
    }
}
