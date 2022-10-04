//
//  LongPressButton.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 10/4/22.
//

import SwiftUI

struct LongPressButton<Lable>: View where Lable: View {
    let action: () -> Void
    let longTapAction: () -> Void
    let label: () -> Lable
    
    var body: some View {
        Button {
            // ignore
        } label: {
            label()
        }
        .simultaneousGesture(LongPressGesture().onEnded { _ in
            longTapAction()
        })
        .simultaneousGesture(TapGesture().onEnded {
            action()
        })

    }
}
