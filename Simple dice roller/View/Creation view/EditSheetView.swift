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
            if viewModel.abilityIndex == nil {
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
                    TextField("Name", text: $viewModel.indicatedMonster.name)
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
                
                Section("Abilatys") {
                    ForEach(Array(viewModel.indicatedMonster.abilaty.enumerated()), id: \.offset) { index, abilaty in
                        Button {
                            isTextFieldFocused = false
                            viewModel.tapOnRoll(at: index)
                        } label: {
                            ZStack {
                                EditRollView(ability: abilaty)
                                HStack {
                                    Spacer()
                                    if index == viewModel.abilityIndex {
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
                    TextField("roll name", text: $viewModel.indicatedAbility.name)
                        .padding()
                        .focused($nameFieldFocused)
                case .roll:
                    DiceCalculatorBoardView(roll: $viewModel.indicatedAbility.roll)
                case .subRoll:
                    DiceCalculatorBoardView(roll: $viewModel.indicatedAbility.onHit)
                }
            }
        }
        .onDisappear { viewModel.resetAllIndexes() }
    }
}

struct EditSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        viewModel.monsterIndex = 0
        viewModel.abilityIndex = 0
        
        return EditSheetView().environmentObject(viewModel)
    }
}
