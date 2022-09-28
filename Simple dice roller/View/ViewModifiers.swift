//
//  ViewModifiers.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 9/28/22.
//

import Foundation
import SwiftUI

struct SimpleKeyboardButton: ViewModifier {
    let text: String
    let action: ()->Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button(text) {
                        action()
                    }
                }
            }
    }
}
