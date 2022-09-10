//
//  ToggleButtonView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/9/22.
//

import SwiftUI

struct ToggleButtonView: View {
    @Binding var mode: EditMode
    let setTo: EditMode
    
    
    var body: some View {
        Button {
            mode = setTo
        } label: {
            Text(setTo.rawValue)
                .bold()
                .foregroundColor(.primary)
                .padding(.horizontal, 30)
                .padding(.vertical, 12)
                .background(.blue)
                .clipShape(Capsule())
                .padding(4)
                .background(setTo == mode ? .black : .blue)
                .clipShape(Capsule())
        }
    }
}

struct ToggleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleButtonView(mode: .constant(EditMode.roll), setTo: .roll)
    }
}

enum EditMode: String {
    case name = "Name", roll  = "Roll", subRoll = "Sub Roll"
}
