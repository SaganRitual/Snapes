import SwiftUI

struct LineChartLineView: View {
    @EnvironmentObject var histogram: Histogram

    let viewWidth: CGFloat
    let viewHeight: CGFloat

    func drawLine() -> Path {
        var path = Path()

        guard let yValues = histogram.getScalarDistribution(reset: false) else {
            return path
        }

        let points: [CGPoint] = zip(Int(0)..., yValues).map {
            CGPoint(x: CGFloat($0), y: $1) *
            CGPoint(x: 1.175 / 10 * viewWidth, y: -viewHeight) +
            CGPoint(x: 0, y: viewHeight)
        }

        path.move(to: points[0])

        for (previousPoint, currentPoint) in zip(points.dropLast(), points.dropFirst()) {
            let midPoint = (previousPoint + currentPoint) / 2
            path.addQuadCurve(to: midPoint, control: previousPoint)
        }

        return path
    }

    var body: some View {
        GeometryReader { gr in
            drawLine()
                .stroke(lineWidth: 3)
                .foregroundColor(.white)
        }
    }
}

struct LineChartLineView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartLineView(viewWidth: ArkoniaLayout.xScale, viewHeight: ArkoniaLayout.yScale)
    }
}
