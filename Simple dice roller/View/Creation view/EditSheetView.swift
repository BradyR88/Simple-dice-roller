//
//  EditSheetView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/2/22.
//

import SwiftUI

struct EditSheetView: View {
    @EnvironmentObject var viewModel: ViewModel
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack {
            List {
                Section("Name") {
                    TextField("Name", text: $viewModel.indicatedRollGroop.name)
                        .focused($isTextFieldFocused)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    isTextFieldFocused = false
                                }
                            }
                        }
                }
                
                Section("Rolls") {
                    ForEach(Array(viewModel.indicatedRollGroop.rolls.enumerated()), id: \.offset) { index, roll in
                        Button {
                            isTextFieldFocused = false
                            viewModel.tapOnRoll(at: index)
                        } label: {
                            HStack {
                                Text(Constance.diceString(roll.amount , d: roll.numberOfSides, toAdd: roll.toAdd))
                                    .foregroundColor(index == viewModel.rollIndex ? .green : .primary)
                                    .font(index == viewModel.rollIndex ? .title3 : .body)
                                
                                Spacer()
                                
                                if index == viewModel.rollIndex {
                                    Image(systemName: "pencil.circle")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                    .onDelete { offsets in
                        viewModel.deleteRoll(at: offsets)
                    }
                }
            }
            
            if !isTextFieldFocused {
                //Spacer()
                
                Button {
                    viewModel.addNewRoll()
                } label: {
                    Text("Add new roll")
                        .foregroundColor(.primary)
                        .bold()
                        .padding()
                        .background(.green)
                        .clipShape(Capsule())
                }
                
                Divider()
                
                DiceCalculatorBoardView(amount: $viewModel.indicatedRoll.amount, numberOfSides: $viewModel.indicatedRoll.numberOfSides, toAdd: $viewModel.indicatedRoll.toAdd)
            }
        }
        .onDisappear { viewModel.resetAllIndexes() }
    }
}

struct EditSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        viewModel.rollIndex = 0
        viewModel.rollGroopIndex = 0
        
        return EditSheetView().environmentObject(viewModel)
    }
}
