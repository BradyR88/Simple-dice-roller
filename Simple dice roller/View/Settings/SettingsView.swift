//
//  SettingsView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 10/3/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var isConfirming = false
    
    var body: some View {
        Form {
            Section {
                Toggle("Advantage Reset", isOn: $viewModel.settings.resetAdvantage)
            }
            
            Section {
                Button(role: .destructive) {
                    isConfirming = true
                } label: {
                    Text("Deleat all Events")
                }

            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog("Deleat Events?", isPresented: $isConfirming) {
            Button("Delete", role: .destructive) {
                viewModel.deleteAllEvents()
            }

        } message: {
            Text("This will permanent remove all past events are you trying to do this?")
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
        .environmentObject(ViewModel())
    }
}