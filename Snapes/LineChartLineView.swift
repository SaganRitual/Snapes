import SwiftUI

struct LineChartLineView: View {
    @EnvironmentObject var histogram: Histogram

    let viewWidth: CGFloat
    let viewHeight: CGFloat

    func drawLine() -> Path {
        guard let yValues = histogram.getScalarDistribution(reset: true) else {
            return Path { _ in }
        }

        var isFirst = true
        var prevPoint: CGPoint?
        var path = Path()

        // obv, there are lots of ways of doing this. let's
        // please refrain from yak shaving in the comments
        for (x_, y_) in zip(0..., yValues) {
            let x = (CGFloat(x_) + 0.5) / 10 * viewWidth
            let y = y_ * viewHeight

            let currentPoint = CGPoint(x: x, y: y)

            if let prevPoint = prevPoint {
                let midPoint = (currentPoint + prevPoint) / 2

                if isFirst { path.addLine(to: currentPoint) }
                else       { path.addQuadCurve(to: midPoint, control: prevPoint) }

                print("curr", currentPoint, "from", midPoint, "ctrl", prevPoint)

                isFirst = false
            } else { path.move(to: currentPoint) }

            prevPoint = currentPoint
        }

        if let prevPoint = prevPoint { path.addLine(to: prevPoint) }

        return path
    }

    var body: some View {
        GeometryReader { gr in
            drawLine()
                .stroke(lineWidth: 1)
                .foregroundColor(self.histogram.hackyTrigger ? .white : .blue)
        }
    }
}

struct LineChartLineView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartLineView(viewWidth: ArkoniaLayout.xScale, viewHeight: ArkoniaLayout.yScale)
    }
}
