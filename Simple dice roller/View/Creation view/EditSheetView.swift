//
//  EditSheetView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/2/22.
//

import SwiftUI

struct EditSheetView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var rollIndex:Int? = nil
    
    let indexOfRollGroop: Int
    
    
    var body: some View {
        VStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $viewModel.rollGroops[indexOfRollGroop].name)
                }
                
                Section("Rolls") {
                    ForEach(Array(viewModel.rollGroops[indexOfRollGroop].rolls.enumerated()), id: \.offset) { index, roll in
                        Button {
                            rollIndex = index
                        } label: {
                            HStack {
                                Text(roll.name)
                                
                                Spacer()
                                
                                if index == rollIndex {
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
            
            GenericDiceRollingView(text: "Submit") { roll in
                // what to do wiht the new roll
                guard let rollIndex = rollIndex else { return }

                viewModel.rollGroops[indexOfRollGroop].rolls[rollIndex] = roll
            }
        }
    }
}

struct EditSheetView_Previews: PreviewProvider {
    static var previews: some View {
        EditSheetView(indexOfRollGroop: 0)
            .environmentObject(ViewModel())
    }
}
