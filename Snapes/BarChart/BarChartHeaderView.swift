import SwiftUI

struct BarChartHeaderView: View {
    let chartTitle: String

    var body: some View {
        Text(chartTitle)
            .font(.caption)
            .foregroundColor(.white)
    }
}

struct BarChartHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartHeaderView(chartTitle: "Neuron Counts")
            .frame(maxWidth: .infinity)
    }
}
