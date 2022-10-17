//
//  OGLView.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 10/17/22.
//

import SwiftUI

struct OGLView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Some content in this application has been created by Wizards of the Coast and is being accessed through the Open Gaming License (OGL). All content in Die Master that has been derived from the OGL can be identified by the 🐉 emoji by its name. All content associated with the 🐉 emoji is subject to Wizards of the Coast copyright as seen below.")
                .padding()
            Link("Copy of the OGL", destination: URL(string: "https://media.wizards.com/2016/downloads/DND/SRD-OGL_V5.1.pdf")!)
                .padding(.horizontal)
            
            Spacer()
            
            Group {
                Text("Open Game License v 1.0a Copyright 2000, Wizards of the Coast, LLC.")
                Text("System Reference Document 5.1 Copyright 2016, Wizards of the Coast, Inc.; Authors Mike Mearls, Jeremy Crawford, Chris Perkins, Rodney Thompson, Peter Lee, James Wyatt, Robert J. Schwalb, Bruce R. Cordell, Chris Sims, and Steve Townshend, based on original material by E. Gary Gygax and Dave Arneson.")
            }
            .padding(.horizontal)
            .font(.callout)
            
        }
        
    }
}

struct OGLView_Previews: PreviewProvider {
    static var previews: some View {
        OGLView()
    }
}
