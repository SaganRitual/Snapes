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

struct BontentView: View {
    @State var textUnitSize = CGSize.zero

    var body: some View {
        GeometryReader { gr in
            VStack {
                LineChartHeaderView(
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
                .frame(minHeight: gr.size.height / 3)
                ChartBody()
            }
        }
    }
}

struct BontentView_Previews: PreviewProvider {
    static var previews: some View {
        BontentView()
            .frame(
                width: ArkoniaLayout.frameWidth * 2,
                height: ArkoniaLayout.hudHeight * 2
            )
    }
}
