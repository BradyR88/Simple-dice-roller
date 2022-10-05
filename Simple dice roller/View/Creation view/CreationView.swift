//
//  CreationView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/31/22.
//

import SwiftUI

struct CreationView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        List {
            ForEach(Array(viewModel.monsters.enumerated()), id: \.offset) { index, monster in
                NavigationLink {
                    EditSheetView()
                        .onAppear {
                            viewModel.monsterIndex = index
                        }
                } label: {
                    HStack {
                        Text(monster.name)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        if monster.isShowing {
                            Image(systemName: "checkmark.square.fill")
                        }
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        viewModel.togalIsShowing(for: index)
                    } label: {
                        Label("Display", systemImage: "checkmark.square.fill")
                    }
                    .tint(.indigo)
                    
                    Button {
                        viewModel.duplicateMonster(at: index)
                    } label: {
                        Label("Duplicate", systemImage: "arrow.right.doc.on.clipboard")
                    }
                    .tint(.cyan)
                }
                .swipeActions(edge: .trailing) {
                    Button {
                        viewModel.deleteMonster(at: index)
                    } label: {
                        Label("Delete", systemImage: "trash.circle")
                    }
                    .tint(.red)
                }
            }
            .onDelete { indexSet in
                viewModel.deleteMonster(at: indexSet.first!)
            }
        }
        .navigationTitle("Dice Bags")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                EditButton()
                
                Button {
                    viewModel.addNewRollGroop()
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
    }
}

struct CreationView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        NavigationView {
            CreationView()
                .environmentObject(viewModel)
        }
    }
}
