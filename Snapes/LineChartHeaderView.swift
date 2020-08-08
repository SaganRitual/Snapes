//
//  LineChartHeaderView.swift
//  Shapes
//
//  Created by Rob Bishop on 7/30/20.
//

import SwiftUI

struct LineChartHeaderView: View {
    let legend1Descriptor: LineChartLegendDescriptor
    let legend2Descriptor: LineChartLegendDescriptor

    var body: some View {
        HStack {
            LineChartLegend(descriptor: legend1Descriptor)
                .padding(.leading)

            Spacer()

            LineChartLegend(descriptor: legend2Descriptor)
                .padding(.trailing)
        }
    }
}

struct LineChartHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartHeaderView(
            legend1Descriptor: LineChartLegendDescriptor(
                title: "Current",
                titleEdge: .leading,
                legendoidDescriptors: [
                    (Color.yellow, "Min"),
                    (Color.blue, "Max"),
                    (Color.green, "Med")
                ]
            ),
            legend2Descriptor: LineChartLegendDescriptor(
                title: "All-time",
                titleEdge: .trailing,
                legendoidDescriptors: [
                    (Color.orange, "Min"),
                    (Color.purple, "Max"),
                    (Color(NSColor.cyan), "Med")
                ]
            )
        )
    }
}
