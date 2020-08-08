//
//  ContentView.swift
//  Snapes
//
//  Created by Rob Bishop on 8/1/20.
//

import SwiftUI

extension ArkoniaLayout {
    static let hudHeight: CGFloat = 100
    static let frameWidth: CGFloat = 185
}

struct ContentView: View {
    @State var textUnitSize = CGSize.zero

    var body: some View {
        VStack {
            LineChartHeaderView(
                chartTitle: "Foobar",
                legend1Descriptor: LineChartLegendDescriptor(
                    title: "Current",
                    titleEdge: .leading,
                    legendoidDescriptors: [
                        (.red, "Min"), (.green, "Max")
                    ]
                ),
                legend2Descriptor: LineChartLegendDescriptor(
                    title: "All-time",
                    titleEdge: .trailing,
                    legendoidDescriptors: [
                        (.blue, "Min"), (.orange, "Max")
                    ]
                )
            )
            .padding(.top)

            ChartDataBackdrop()
                .padding(5)
                .background(Color.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(
                width: ArkoniaLayout.frameWidth * 2,
                height: ArkoniaLayout.hudHeight * 2
            )
    }
}
