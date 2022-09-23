//
//  NumberToggleView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import SwiftUI

struct NumberToggleView: View {
    let addition: ()->Void
    let subtraction: ()->Void
    
    var body: some View {
        VStack {
            Button {
                addition()
            } label: {
                Image(systemName: "plus.square.fill")
                    .resizable()
                    .frame(width: 75, height: 75)
            }
            
            Button {
                subtraction()
            } label: {
                Image(systemName: "minus.square.fill")
                    .resizable()
                    .frame(width: 75, height: 75)
            }
        }
    }
}

struct NumberToggleView_Previews: PreviewProvider {
    static var previews: some View {
        NumberToggleView {
            // nothing
        } subtraction: {
            // nothing
        }

    }
}
