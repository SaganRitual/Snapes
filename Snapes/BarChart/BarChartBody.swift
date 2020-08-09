import SwiftUI

struct BarChartBody: View {
    let chartBodyTitleHeight: CGFloat = 10 * 0.5
    let chartBodyPadding: CGFloat = 10 / 0.75 // 1/10 body height * 0.75 to make it a little smaller
    let chartAnnoyingPaddingSize: CGFloat = -0.8 * 10    // Body height - padding height

    var body: some View {
        BarChartDataBackdrop()
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing])
            .background(Color.gray)
    }
}

struct BarChartBody_Previews: PreviewProvider {
    static var previews: some View {
        BarChartBody().frame(width: 300)
    }
}
