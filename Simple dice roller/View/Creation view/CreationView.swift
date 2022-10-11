//
//  CreationView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/31/22.
//

import SwiftUI

struct CreationView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            NavigationLink("new monster view", isActive: $isActive) { EditSheetView() }.hidden()
            
            List {
                ForEach(viewModel.sortedMonsters) { monster in
                    NavigationLink {
                        EditSheetView()
                            .onAppear {
                                viewModel.setMonsterIndex(to: monster)
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
                            viewModel.togalIsShowing(for: monster)
                        } label: {
                            Label("Display", systemImage: "checkmark.square.fill")
                        }
                        .tint(.indigo)
                        
                        Button {
                            viewModel.duplicateMonster(monster)
                            isActive = true
                        } label: {
                            Label("Duplicate", systemImage: "arrow.right.doc.on.clipboard")
                        }
                        .tint(.cyan)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            viewModel.deleteMonster(monster)
                        } label: {
                            Label("Delete", systemImage: "trash.circle")
                        }
                        .tint(.red)
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteMonster(at: indexSet)
                }
            }
            .searchable(text: $viewModel.sortMonsterText)
            .navigationTitle("Dice Bags")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                    
                    Button {
                        viewModel.addNewRollGroop()
                        isActive = true
                    } label: {
                        Image(systemName: "plus")
                    }

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
