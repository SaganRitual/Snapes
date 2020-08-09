import SwiftUI

struct BarChartGraphView: View {
    let histogram = Histogram(10, .zeroToOne)

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
        let M = Double.random(in: 0..<1)
        (0..<L).forEach { _ in
            self.histogram.track(sample: M)
        }

        self.histogram.hackyTrigger = !self.histogram.hackyTrigger
        scheduleUpdate()
    }

    var body: some View {
        VStack {
            BarChartHeaderView(chartTitle: "Neuron Counts")
                .padding(.top, 5 )

            BarChartDataBackdrop()
                .environmentObject(histogram)
                .padding(5)
                .background(Color.gray)
        }
    }
}

struct BarChartGraphView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartGraphView().frame(maxWidth: 350)
    }
}
