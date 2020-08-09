import SwiftUI

struct LineChartLegendDescriptor {
    let title: String
    let titleEdge: Edge
    let legendoidDescriptors: [(Color, String)]
}

struct LineChartLegend: View {
    let descriptor: LineChartLegendDescriptor

    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                if descriptor.titleEdge == .leading {
                    Text(descriptor.title)
                        .font(.footnote)
                        .padding(.trailing)
                }

                VStack {
                    ForEach(0..<descriptor.legendoidDescriptors.count) { ss in
                        LineChartLegendoid(
                            color: self.descriptor.legendoidDescriptors[ss].0,
                            label: self.descriptor.legendoidDescriptors[ss].1,
                            titleEdge: descriptor.titleEdge
                        )
                    }.padding([.leading, .trailing], 5)
                }

                if descriptor.titleEdge == .trailing {
                    Text(descriptor.title)
                        .font(.footnote)
                        .padding([.leading, .trailing])
                }
            }
        }
    }
}

struct LineChartLegend_Previews: PreviewProvider {
    static let dataSelectors = ChartLegendSelect(3)

    static var previews: some View {
        LineChartLegend(
            descriptor: LineChartLegendDescriptor(
                title: "Current",
                titleEdge: .trailing,
                legendoidDescriptors: [
                    (Color.green, "Avg"),
                    (Color(NSColor.cyan), "Med"),
                    (Color.blue, "Max")
                ]
            )
        )
    }
}
