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
                Text(rollGroop.name)
                    .swipeActions(edge: .leading) {
                        Button {
                            viewModel.rollGroopIndex = index
                            isPresintingSheet = true
                        } label: {
                            Label("Edit", image: "pencil")
                        }
                        .tint(.indigo)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            viewModel.deleteRollGroop(at: index)
                        } label: {
                            Label("delete", image: "pencil")
                        }
                        .tint(.red)
                    }
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
