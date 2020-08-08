//
//  ContentView.swift
//  Snapes
//
//  Created by Rob Bishop on 8/8/20.
//

import SwiftUI

struct DontentView: View {
    var body: some View {
        VStack(alignment: .trailing) {
            Text("Hello, world!")
                .background(Color.red)
                .offset(x: 100, y: 100)
        }
    }
}

struct DontentView_Previews: PreviewProvider {
    static var previews: some View {
        DontentView()
    }
}
