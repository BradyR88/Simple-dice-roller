//
//  RollReadoutView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import SwiftUI

struct RollReadoutView: View {
    let rollResult: RollResult
    
    @State var infoPainVisible = false
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("\(rollResult.roll.amount)d\(rollResult.roll.numberOfSides)\(rollResult.roll.toAdd > 0 ? " + \(rollResult.roll.toAdd)" : "")")
                    .bold()
                    .font(.title)
                
                Spacer()
                
                Text("\(rollResult.total)")
                    .bold()
                    .font(.title)
                Button {
                    infoPainVisible.toggle()
                } label: {
                    Image(systemName: "eye.fill")
                        .font(.title3)
                }
            }
            if infoPainVisible {
                Text("[\(rollResult.faces.map{String($0)}.joined(separator: ","))]")
            }
        }
        .onTapGesture { infoPainVisible.toggle() }
    }
}

struct RollReadoutView_Previews: PreviewProvider {
    static var previews: some View {
        RollReadoutView(rollResult: RollResult.example)
    }
}
