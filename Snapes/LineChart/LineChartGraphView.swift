import SwiftUI

struct LineChartGraphView: View {
    let histogram = Histogram(10, .minusOneToOne)

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
        let L = Int.random(in: 1..<100)
        let M = Double.random(in: -1..<1)
        (0..<L).forEach { _ in
            self.histogram.track(sample: M)
        }

        self.histogram.hackyTrigger = !self.histogram.hackyTrigger
        scheduleUpdate()
    }

    var body: some View {
        VStack {
            LineChartHeaderView(
                chartTitle: "Neuron Counts",
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
            .padding(.top, 5 )

            ChartDataBackdrop()
                .environmentObject(histogram)
                .padding(5)
                .background(Color.gray)
        }
    }
}

struct LineChartGraphView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartGraphView().frame(maxWidth: 350)
    }
}
