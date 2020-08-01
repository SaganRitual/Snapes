//
//  ContentView.swift
//  Snapes
//
//  Created by Rob Bishop on 8/1/20.
//

import SwiftUI

struct ContentView: View {
    @State var textUnitSize = CGSize.zero

    let scale: CGSize
    let xScale = CGFloat(450)
    let yScale = CGFloat(300)

    init() { scale = CGSize(width: xScale, height: yScale) }

    var body: some View {
        VStack {
            LineChartHeaderView(
                title: "Ages",
                legend1Descriptor: LineChartLegendDescriptor(
                    title: "Current",
                    legendoidDescriptors: [
                        (.red, "Red"), (.green, "Green")
                    ]
                ),
                legend2Descriptor: LineChartLegendDescriptor(
                        title: "All-time",
                        legendoidDescriptors: [
                            (.blue, "Blue"), (.orange, "Orange")
                        ]
                )
            )

            LineChartGraphView(450, 300)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
