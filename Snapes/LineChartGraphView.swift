import SwiftUI

struct LineChartGraphView: View {
    @State var textUnitSize = ArkoniaLayout.labelTextSize

    static let histogram = Histogram(10, .minusOneToOne)

    let scale: CGSize
    var timer: Timer!
    let xScale: CGFloat
    let yScale: CGFloat

    init() {
        self.xScale = ArkoniaLayout.xScale
        self.yScale = ArkoniaLayout.yScale
        self.scale = CGSize(width: xScale, height: yScale)

        scheduleUpdate()
    }

    func scheduleUpdate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: updateHistogram)
    }

    func updateHistogram() {
        for _ in 0..<10 {
            LineChartGraphView.histogram.track(sample: Double.random(in: -1..<1))
        }

//        print("update", LineChartGraphView.histogram.theBuckets)

        LineChartGraphView.histogram.hackyTrigger = !LineChartGraphView.histogram.hackyTrigger
        scheduleUpdate()
    }

    var body: some View {
        ZStack {
            // I think and hope this one is holding the size of
            // our overall graph view section fixed
            Rectangle()
                .frame(width: 1.1 * xScale, height: 1.1 * yScale)
                .foregroundColor(Color(white: 0.4))

            LineChartLineView(viewWidth: xScale, viewHeight: yScale)
                .environmentObject(LineChartGraphView.histogram)
                .frame(width: xScale, height: yScale)

            LineChartHLinesView()
                .frame(width: 1.0 * xScale, height: 1.0 * yScale)
                .foregroundColor(Color(white: 0.3))
                .offset(
                    x: textUnitSize.width * 0.8,
                    y: textUnitSize.height * 1
                )

            LineChartVLinesView()
                .frame(width: 1.0 * xScale, height: 1.1 * yScale)
                .foregroundColor(Color(white: 0.3))
                .offset(
                    x: (-0.8 * textUnitSize.width) + 0.1 * xScale,
                    y: -2 * textUnitSize.height
                )

            LineChartYLabelsView()
                .frame(width: 0.1 * xScale, height: 1.0 * yScale)
                .background(Color(white: 0.4))
                .offset(x: -0.5 * xScale, y: (-0.05 * yScale))

            LineChartXLabelsView()
                .frame(width: 1.0 * xScale, height: 0.1 * yScale)
                .background(Color(white: 0.4))
                .offset(x: 0.05 * xScale, y: 0.5 * yScale)
        }
    }
}

struct LineChartGraphView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartGraphView()
    }
}
