//
//  EditAbilitySection.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/26/22.
//

import SwiftUI

struct EditAbilitySection: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var showingInput: InputState = .nothing
    @FocusState private var discriptionFocus: Bool
    @FocusState private var nameFocus: Bool

    enum InputState {
        case nothing, roll, subroll
    }
    
    var body: some View {
        VStack {
            List{
                Section {
                    TextField("Ability Name", text: $viewModel.indicatedAbility.name)
                        .focused($nameFocus)
                    
                    Toggle("Primary Roll", isOn: $viewModel.indicatedAbility.hasRoll)
                    
                    if viewModel.indicatedAbility.hasRoll {
                        Button {
                            // edit this
                            discriptionFocus = false
                            showingInput = .roll
                        } label: {
                            Text(viewModel.indicatedAbility.roll?.stringName ?? "error")
                        }
                    }
                    
                    Toggle("On Hit Roll", isOn: $viewModel.indicatedAbility.hasOnHit)
                    if viewModel.indicatedAbility.hasOnHit {
                        Button {
                            // edit this
                            discriptionFocus = false
                            showingInput = .subroll
                        } label: {
                            Text(viewModel.indicatedAbility.onHit?.stringName ?? "error")
                        }
                    }
                    
                    
                }
                
                Section("Discription") {
                    TextEditor(text: $viewModel.indicatedAbility.safeDiscription)
                        .focused($discriptionFocus)
                }
            }
            
            if showingInput == .roll && !discriptionFocus && !nameFocus {
                DiceCalculatorBoardView(roll: $viewModel.indicatedAbility.roll)
            } else if showingInput == .subroll && !discriptionFocus && !nameFocus {
                DiceCalculatorBoardView(roll: $viewModel.indicatedAbility.onHit)
            }
        }
    }
}

struct EditAbilitySection_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        viewModel.monsterIndex = 0
        viewModel.abilityIndex = 0
        
         return EditAbilitySection()
                .environmentObject(viewModel)
    }
}
