//
//  CreationView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/31/22.
//

import SwiftUI

struct CreationView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var isPresintingSheet = false
    
    var body: some View {
        List {
            ForEach(Array(viewModel.rollGroops.enumerated()), id: \.offset) { index, rollGroop in
                HStack {
                    Text(rollGroop.name)
                    
                    Spacer()
                    
                    Menu {
                        // options for the roll groop
                        Button("Toggle Status") { viewModel.togalIsShowing(for: index) }
                        Button("Edit") {
                            viewModel.rollGroopIndex = index
                            isPresintingSheet = true
                        }

                    } label: {
                        Image(systemName: "ellipsis")
                    }

                }
            }
            .onDelete { offsets in
                viewModel.deleteRollGroop(at: offsets)
            }
        }
        .navigationTitle("Dice Bags")
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    viewModel.addNewRollGroop()
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
        .sheet(isPresented: $isPresintingSheet) {
            EditSheetView()
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
