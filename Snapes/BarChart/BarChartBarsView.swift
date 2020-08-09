import SwiftUI

struct BarChartBarsView: View {
    @EnvironmentObject var histogram: Histogram
    @State private var startColor = Double.random(in: 0..<1)

    let viewWidth: CGFloat
    let viewHeight: CGFloat

    func getCutesyColor(_ ix: Int) -> Color {
        let hue = (startColor + (Double(ix) * 0.25 / 10)).truncatingRemainder(dividingBy: 1)
        return Color(hue: hue, saturation: 0.75, brightness: 0.75)
    }

    func getYValue(_ ss: Int) -> CGFloat {
        guard let yv = histogram.getScalarDistribution(reset: false)
        else { return -1 }
        return yv[ss]
    }

    func getHeight(_ bucketSS: Int) -> CGFloat {
        let yValue = getYValue(bucketSS)
        return max(0.05, yValue)
    }

    var body: some View {
        HStack {
            ForEach(0..<10) { bucketSS in
                Rectangle()
                    .frame(
                        width: viewWidth / 11,
                        height: getHeight(bucketSS) * viewHeight
                    )
                    .foregroundColor(getCutesyColor(bucketSS))
                    .offset(y: (1 - getHeight(bucketSS)) * viewHeight / 2)
            }
        }
    }
}

struct BarChartLineView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartBarsView(viewWidth: ArkoniaLayout.xScale, viewHeight: ArkoniaLayout.yScale)
    }
}
