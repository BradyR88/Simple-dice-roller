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
    @Environment(\.dismiss) var dismiss

    enum InputState {
        case nothing, roll, subroll
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    Section {
                        TextField("Ability Name", text: $viewModel.indicatedAbility.name)
                            .focused($nameFocus)
                        
                        Toggle("Initial Roll", isOn: $viewModel.indicatedAbility.hasRoll.animation())
                            .onChange(of: viewModel.indicatedAbility.hasRoll) { newValue in
                                if newValue {
                                    edit(.roll)
                                }
                            }
                        if viewModel.indicatedAbility.hasRoll {
                            Button {
                                edit(.roll)
                            } label: {
                                Text(viewModel.indicatedAbility.roll?.stringName ?? "error")
                            }
                        }
                        
                        Toggle("Damage Roll", isOn: $viewModel.indicatedAbility.hasOnHit.animation())
                            .onChange(of: viewModel.indicatedAbility.hasOnHit) { newValue in
                                if newValue {
                                    edit(.subroll)
                                }
                            }
                        if viewModel.indicatedAbility.hasOnHit {
                            Button {
                                edit(.subroll)
                            } label: {
                                Text(viewModel.indicatedAbility.onHit?.stringName ?? "error")
                            }
                        }
                    }
                    
                    Section("Discription") {
                        // all the things visible to the user here is the TextEditor everything else is a hack to get it to take up the right amount of space on the screen
                        ZStack(alignment: .topLeading) {
                            Text(viewModel.indicatedAbility.safeDiscription)
                                .padding(.leading, 4)
                                .foregroundColor(.white)
                            TextEditor(text: $viewModel.indicatedAbility.safeDiscription)
                                .focused($discriptionFocus)
                            
                        }
                        
                    }
                }
                
                if showingInput == .roll && !discriptionFocus && !nameFocus {
                    DiceCalculatorBoardView(roll: $viewModel.indicatedAbility.roll)
                } else if showingInput == .subroll && !discriptionFocus && !nameFocus {
                    DiceCalculatorBoardView(roll: $viewModel.indicatedAbility.onHit)
                }
            }
            //.navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .onDisappear {
                viewModel.abilityIndex = nil
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        nameFocus = false
                        discriptionFocus = false
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func edit(_ input: InputState) {
        discriptionFocus = false
        nameFocus = false
        showingInput = input
    }
}

struct EditAbilitySection_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        viewModel.monsterIndex = 0
        viewModel.abilityIndex = 0
        
        return Text("test")
            .sheet(isPresented: .constant(true)) {
                EditAbilitySection()
                        .environmentObject(viewModel)
            }
        
    }
}
