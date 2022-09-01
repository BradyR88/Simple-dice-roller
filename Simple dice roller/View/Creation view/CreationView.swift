//
//  CreationView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/31/22.
//

import SwiftUI

struct CreationView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            List {
                ForEach(viewModel.rollGroops) { rollGroop in
                    Text(rollGroop.name)
                }
            }
        }
    }
}

struct CreationView_Previews: PreviewProvider {
    static var previews: some View {
        CreationView()
    }
}
