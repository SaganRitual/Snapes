//
//  LineChartLineView.swift
//  Snapes
//
//  Created by Rob Bishop on 8/1/20.
//

import SwiftUI

struct LineChartLineView: View {
    @EnvironmentObject var histogram: Histogram
    @State var textUnitSize = ArkoniaLayout.labelTextSize

    let viewWidth: CGFloat
    let viewHeight: CGFloat

    func drawLine() -> Path {
        let points: [CGPoint] = (0..<10).map {
            CGSize(width: viewWidth, height: viewHeight).asPoint() *
            CGPoint(x: CGFloat($0), y: CGFloat(histogram.theBuckets[$0].normalized))
        }

        print("drawLine() \(points)")
        var isFirst = true
        var prevPoint: CGPoint?
        var path = Path()

        // obv, there are lots of ways of doing this. let's
        // please refrain from yak shaving in the comments
        for point in points {
            if let prevPoint = prevPoint {
                let midPoint = (point + prevPoint) / 2

                if isFirst { path.addLine(to: midPoint) }
                else       { path.addQuadCurve(to: midPoint, control: prevPoint) }

                isFirst = false
            } else { path.move(to: point) }

            prevPoint = point
        }

        if let prevPoint = prevPoint { path.addLine(to: prevPoint) }

        return path
    }

    var body: some View {
        GeometryReader { gr in
            drawLine()
                .stroke(lineWidth: 1)
                .foregroundColor(.white)
                .offset(x: gr.size.width / 10 / 2)
        }
    }
}

struct LineChartLineView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartLineView(viewWidth: ArkoniaLayout.xScale, viewHeight: ArkoniaLayout.yScale)
    }
}
