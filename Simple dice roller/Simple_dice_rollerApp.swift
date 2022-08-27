//
//  Simple_dice_rollerApp.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import SwiftUI

@main
struct Simple_dice_rollerApp: App {
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
