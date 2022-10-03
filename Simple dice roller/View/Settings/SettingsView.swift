//
//  SettingsView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 10/3/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Toggle("Advantage Reset", isOn: <#T##Binding<Bool>#>)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
