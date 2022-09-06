//
//  EditSheetView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/2/22.
//

import SwiftUI

struct EditSheetView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $viewModel.indicatedRollGroop.name)
                }
                
                Section("Rolls") {
                    ForEach(Array(viewModel.indicatedRollGroop.rolls.enumerated()), id: \.offset) { index, roll in
                        Button {
                            viewModel.rollIndex = index
                        } label: {
                            HStack {
                                Text(roll.name)
                                
                                Spacer()
                                
                                if index == viewModel.rollIndex {
                                    Image(systemName: "pencil.circle")
                                        .foregroundColor(.green)
                                }
                            }
                            .foregroundColor(.primary)
                        }
                    }
                }
            }
            
            Spacer()
            
            GenericDiceRollingView(text: "Submit") { roll in viewModel.indicatedRoll = roll }
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
