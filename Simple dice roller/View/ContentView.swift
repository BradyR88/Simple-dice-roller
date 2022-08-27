//
//  ContentView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            //MARK: past rolls
            List {
                ForEach(viewModel.pastRolls) { roll in
                    RollReadoutView(roll: roll)
                }
            }
            
            // MARK: roll options
            GenericDiceRollingView()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        
        ContentView()
            .environmentObject(viewModel)
    }
}
