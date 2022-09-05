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
    @State var indexOfRollGroop = 0
    
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
                            indexOfRollGroop = index
                            isPresintingSheet = true
                        }
                        Button("Delete", role: .destructive) {}

                    } label: {
                        Image(systemName: "ellipsis")
                    }

                }
            }
        }
        .navigationTitle("Dice Bags")
        .sheet(isPresented: $isPresintingSheet) {
            EditSheetView(indexOfRollGroop: indexOfRollGroop)
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
