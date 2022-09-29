//
//  EditSheetView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/2/22.
//

import SwiftUI

struct EditSheetView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State  private var showingSheat = false
    @FocusState private var nameFocus: Bool
    
    var body: some View {
        List {
            Section("Name") {
                TextField("Name", text: $viewModel.indicatedMonster.name)
                    .focused($nameFocus)
            }
            
            Section {
                Toggle("On Roll Screan", isOn: $viewModel.indicatedMonster.isShowing)
            }
            
            Section("Abilatys") {
                ForEach(Array(viewModel.indicatedMonster.abilaty.enumerated()), id: \.offset) { index, abilaty in
                    Button {
                        viewModel.tapOnRoll(at: index)
                        showingSheat.toggle()
                        nameFocus = false
                    } label: {
                        HStack {
                            Text(abilaty.longName)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .onDelete { offsets in
                    viewModel.deleteRoll(at: offsets)
                }
            }
        }
        .onDisappear { viewModel.resetAllIndexes() }
        .sheet(isPresented: $showingSheat) {
            EditAbilitySection()
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    viewModel.addNewRoll()
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()

                Button("Done") {
                    nameFocus = false
                }
            }
        }
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
