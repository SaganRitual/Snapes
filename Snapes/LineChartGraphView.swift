//
//  LineChartGraphVeiw.swift
//  Snapes
//
//  Created by Rob Bishop on 8/1/20.
//

import SwiftUI

struct LineChartGraphView: View {
    @State var textUnitSize = ArkoniaLayout.labelTextSize

    let scale: CGSize
    let xScale: CGFloat
    let yScale: CGFloat

    init(_ xScale: CGFloat, _ yScale: CGFloat) {
        self.xScale = xScale
        self.yScale = yScale
        self.scale = CGSize(width: xScale, height: yScale)
    }

    var body: some View {
        ZStack {
            // I think and hope this one is holding the size of
            // our overall graph view section fixed
            Rectangle()
                .frame(width: 1.1 * xScale, height: 1.1 * yScale)
                .foregroundColor(Color(white: 0.4))

            LineChartHLinesView()
                .frame(width: 1.0 * xScale, height: 1.0 * yScale)
                .foregroundColor(Color(white: 0.3))
                .offset(
                    x: textUnitSize.width * 0.8,
                    y: textUnitSize.height
                )

            LineChartVLinesView()
                .frame(width: 1.0 * xScale, height: 1.0 * yScale)
                .foregroundColor(Color(white: 0.3))
                .offset(
                    x: (textUnitSize.width * 4.8 / 6) + 0.1 * xScale,
                    y: textUnitSize.height
                )

            LineChartYLabelsView()
                .frame(width: 0.1 * xScale, height: 1.0 * yScale)
                .background(Color(white: 0.5))
                .offset(x: -0.5 * xScale, y: (-0.05 * yScale))

            LineChartXLabelsView()
                .frame(width: 1.0 * xScale, height: 0.1 * yScale)
                .background(Color(white: 0.5))
                .offset(x: 0.05 * xScale, y: 0.5 * yScale)
        }.background(Color(white: 0.5))
    }
}

struct LineChartGraphView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartGraphView(450, 300)
    }
}