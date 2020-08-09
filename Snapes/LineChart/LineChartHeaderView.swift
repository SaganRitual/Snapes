//
//  LineChartHeaderView.swift
//  Shapes
//
//  Created by Rob Bishop on 7/30/20.
//

import SwiftUI

struct LineChartHeaderView: View {
    let chartTitle: String
    let legend1Descriptor: LineChartLegendDescriptor
    let legend2Descriptor: LineChartLegendDescriptor

    var body: some View {
        VStack {
            Text(chartTitle)
                .font(.caption)
                .foregroundColor(.white)

            HStack {
                LineChartLegend(descriptor: legend1Descriptor)
                    .frame(maxWidth: .infinity)

                Spacer()

                LineChartLegend(descriptor: legend2Descriptor)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct LineChartHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartHeaderView(
            chartTitle: "Neuron Counts",
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
        .frame(maxWidth: .infinity)
    }
}
