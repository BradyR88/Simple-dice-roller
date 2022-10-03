//
//  SettingsView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 10/3/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Form {
            Section {
                Toggle("Advantage Reset", isOn: $viewModel.settings.resetAdvantage)
            }
            
            Section {
                Button(role: .destructive) {
                    viewModel.deleteAllEvents()
                } label: {
                    Text("Deleat all Events")
                }

            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
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
