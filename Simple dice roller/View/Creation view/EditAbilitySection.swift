//
//  EditAbilitySection.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/26/22.
//

import SwiftUI

struct EditAbilitySection: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var safeDiscription = ""
    
    var body: some View {
        List{
            Section {
                TextField("Ability Name", text: $viewModel.indicatedAbility.name)
                
                Toggle("Primary Roll", isOn: $viewModel.indicatedAbility.hasRoll)
                
                if viewModel.indicatedAbility.hasRoll {
                    Button {
                        // edit this
                    } label: {
                        Text(viewModel.indicatedAbility.roll?.stringName ?? "error")
                    }
                }
                
                Toggle("On Hit Roll", isOn: $viewModel.indicatedAbility.hasOnHit)
                if viewModel.indicatedAbility.hasOnHit {
                    Button {
                        // edit this
                    } label: {
                        Text(viewModel.indicatedAbility.onHit?.stringName ?? "error")
                    }
                }
                
                
            }
            
            Section("Discription") {
                TextEditor(text: $safeDiscription)
            }
        }
        .onAppear{
            safeDiscription = viewModel.indicatedAbility.discription ?? ""
        }
        .onDisappear {
            if safeDiscription.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                viewModel.indicatedAbility.discription = nil
            } else {
                viewModel.indicatedAbility.discription = safeDiscription
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
