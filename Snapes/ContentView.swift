import SwiftUI

extension ArkoniaLayout {
    static let hudHeight: CGFloat = 100
    static let frameWidth: CGFloat = 185
}

struct ContentView: View {
    @State var textUnitSize = CGSize.zero

    var body: some View {
        LineChartGraphView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(
                width: ArkoniaLayout.frameWidth * 2,
                height: ArkoniaLayout.hudHeight * 2
            )
    }
}
