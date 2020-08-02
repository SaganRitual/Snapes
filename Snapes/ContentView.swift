//
//  ContentView.swift
//  Snapes
//
//  Created by Rob Bishop on 8/1/20.
//

import SwiftUI

struct ContentView: View {
    @State var textUnitSize = CGSize.zero

    var body: some View {
        VStack {
            LineChartHeaderView(
                title: "Ages",
                legend1Descriptor: LineChartLegendDescriptor(
                    title: "Current",
                    legendoidDescriptors: [
                        (.red, "Min"), (.green, "Max")
                    ]
                ),
                legend2Descriptor: LineChartLegendDescriptor(
                        title: "All-time",
                        legendoidDescriptors: [
                            (.blue, "Min"), (.orange, "Max")
                        ]
                )
            )

            LineChartGraphView().environmentObject(LineChartGraphView.histogram)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
