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
                Toggle("Show reference in past rolls", isOn: $viewModel.settings.onlySaveRolls)
            }
            
            Section {
                NavigationLink("Open Gaming License", destination: OGLView())
            }
            
            Section {
                Button(role: .destructive) {
                    isConfirming = true
                } label: {
                    Text("Delete All Events")
                }
            }
//            Section {
//                Button {
//                    let data = try! Data(contentsOf: Constance.savePathRollGroops)
//                    print(String(data: data, encoding: String.Encoding.utf8)!)
//                } label: {
//                    Text("Print JSON")
//                }
//
//            }
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
