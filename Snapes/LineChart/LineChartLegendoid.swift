import SwiftUI

struct LineChartLegendoid: View {
    @State private var isActive = true

    let color: Color
    let label: String
    let titleEdge: Edge

    var body: some View {
        HStack {
            if titleEdge == .trailing {
                Text(label)
                    .font(.footnote)
                    .foregroundColor(isActive ? .white : .gray)
                    .frame(minWidth: 40)
            }

            Button(action: {
                self.isActive.toggle()
            }) {
                Rectangle()
                    .foregroundColor(isActive ? color : .gray)
                    .frame(width: 15, height: 15)
            }
            .buttonStyle(PlainButtonStyle())

            if titleEdge == .leading {
                Text(label)
                    .font(.footnote)
                    .foregroundColor(isActive ? .white : .gray)
                    .frame(minWidth: 40)
            }
        }
    }
}

struct ChartLegendoid_Previews: PreviewProvider {
    static var previews: some View {
        LineChartLegendoid(
            color: Color.blue,
            label: "Min",
            titleEdge: .trailing
        )
    }
}
