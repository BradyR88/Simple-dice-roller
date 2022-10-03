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
            Toggle("Advantage Reset", isOn: $viewModel.settings.resetAdvantage)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
