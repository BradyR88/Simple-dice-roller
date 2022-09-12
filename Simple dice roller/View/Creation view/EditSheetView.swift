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
    @FocusState private var nameFieldFocused: Bool
    
    @State private var editMode: EditMode = .roll {
        didSet{
            if viewModel.rollIndex == nil {
                editMode = .roll
            }
            if editMode == .name {
                nameFieldFocused = true
            }
        }
    }
    
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
                            ZStack {
                                EditRollView(roll: roll)
                                HStack {
                                    Spacer()
                                    if index == viewModel.rollIndex {
                                        Image(systemName: "pencil.circle")
                                            .foregroundColor(.green)
                                            .font(.title)
                                    }
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
                
                HStack {
                    ToggleButtonView(mode: $editMode, setTo: .name)
                    ToggleButtonView(mode: $editMode, setTo: .roll)
                    ToggleButtonView(mode: $editMode, setTo: .subRoll)
                }
                
                Divider()
                
                switch editMode {
                case .name:
                    TextField("roll name", text: $viewModel.indicatedRoll.name)
                        .padding()
                        .focused($nameFieldFocused)
                case .roll:
                    DiceCalculatorBoardView(roll: $viewModel.indicatedRoll)
                case .subRoll:
                    DiceCalculatorBoardView(roll: $viewModel.indicatedSubRoll)
                }
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
