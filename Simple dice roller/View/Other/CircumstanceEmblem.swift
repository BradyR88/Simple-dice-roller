//
//  CircumstanceEmblem.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 10/4/22.
//

import SwiftUI

struct CircumstanceEmblem: View {
    let circumstance: Circumstance
    
    var body: some View {
        var systemName: String = ""
        var color: Color = .primary

        switch circumstance {
        case .advantage:
            systemName = "arrow.up.right.square.fill"
            color = .green
        case .neutral:
            systemName = ""
        case .disadvantage:
            systemName = "arrow.down.right.square.fill"
            color = .red
        case .crit:
            systemName = "star.square.fill"
            color = .yellow
        }

        if systemName != "" {
            return AnyView(Image(systemName: systemName).foregroundColor(color))
        } else {
            return AnyView(EmptyView())
        }
        
    }
}

struct CircumstanceEmblem_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            CircumstanceEmblem(circumstance: .crit)
            CircumstanceEmblem(circumstance: .advantage)
            CircumstanceEmblem(circumstance: .disadvantage)
        }
        
    }
}
