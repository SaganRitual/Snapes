//
//  ChartDataBackdrop.swift
//  Yak
//
//  Created by Rob Bishop on 8/7/20.
//

import SwiftUI

struct LChartDataBackdrop: View {
    enum AxisShape { case linear, log }
    enum GridLinesDirection { case vertical, horizontal }

    let foregroundColor = Color.gray
    let horizontalLines = true
    let verticalLines = true
    let xAxisShape = AxisShape.linear
    let yAxisShape = AxisShape.linear

    func drawGridLines(
        _ gProxy: GeometryProxy, _ direction: GridLinesDirection
    ) -> some View {
        let (rectWidth, rectHeight) = direction == .vertical ?
            (gProxy.size.width, 0) : (0, gProxy.size.height)

        return ForEach(0..<(10 + 1)) { ss in
            Path { path in
                if direction == .vertical {
                    path.move(
                        to: CGPoint(x: CGFloat(ss) * rectWidth / 10, y: 0)
                    )

                    path.addLine(
                        to: CGPoint(x: CGFloat(ss) * rectWidth / 10, y: gProxy.size.height)
                    )
                } else {
                    path.move(
                        to: CGPoint(x: 0, y: CGFloat(ss) * rectHeight / 10)
                    )

                    path.addLine(
                        to: CGPoint(x: gProxy.size.width, y: CGFloat(ss) * rectHeight / 10)
                    )
                }

                path.closeSubpath()
            }
            .stroke(lineWidth: 1).foregroundColor((.black))
        }
    }

    var body: some View {
        ZStack {
            GeometryReader { gr in
                Rectangle()
                    .foregroundColor(foregroundColor)

                drawGridLines(gr, .horizontal)
                drawGridLines(gr, .vertical)
            }
        }
    }
}

struct LChartDataBackdrop_Previews: PreviewProvider {
    static var previews: some View {
        LChartDataBackdrop().frame(width: 500, height: 200)
    }
}
