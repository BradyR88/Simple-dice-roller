//
//  GenericDiceRollingView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import SwiftUI

struct GenericDiceRollingView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State var numberOfDice: Int = 1 {
        didSet {
            if numberOfDice < 1 { numberOfDice = 1 }
        }
    }
    @State var numberOfSides: Int = 20
    @State var toAdd: Int = 0 {
        didSet {
            if toAdd < 0 { toAdd = 0 }
        }
    }
    
    var body: some View {
        VStack {
            Text("\(numberOfDice)d\(numberOfSides)\(toAdd > 0 ? " + \(toAdd)" : "")")
                .font(.title)
                .bold()
            
            HStack {
                NumberToggleView {
                    // addition
                    numberOfDice += 1
                } subtraction: {
                    numberOfDice -= 1
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
            
            Button {
                viewModel.rolldice(Roll(numberOfDice, d: numberOfSides, toAdd: toAdd))
            } label: {
                Text("Roll!")
                    .bold()
                    .font(.title)
                    .foregroundColor(.primary)
                    .frame(width: 305, height: 44)
                    .background(.green)
                    .clipShape(Capsule())
            }
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

struct GenericDiceRollingView_Previews: PreviewProvider {
    static var previews: some View {
        GenericDiceRollingView()
    }
}
