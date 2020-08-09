import SwiftUI

struct AlmanacHudView: View {
    let clockFormatter = DateComponentsFormatter()

    init() {
        clockFormatter.allowedUnits = [.hour, .minute, .second]
        clockFormatter.allowsFractionalUnits = true
        clockFormatter.unitsStyle = .positional
        clockFormatter.zeroFormattingBehavior = .pad
    }

    enum Property { case elapsedTimeRealSeconds }
    func readClock(_ property: Property) -> TimeInterval { 0 }

    enum NumberStringFormat { case year, day, temperature, foodValue }
    func format(_ format: NumberStringFormat) -> String {
        switch format {
        case .year:
            return String(format: "%02d", Int(0))

        case .day:
            return String(format: "%02d", Int(0))

        case .temperature: return String(format: "%0.2f", 0)
        case .foodValue: return String(format: "%0.2f", 0)
        }
    }

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.white.opacity(0.01))
                .border(Color.black)

            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text("Elapsed").font(ArkoniaLayout.labelFont)
                    Spacer()
                    Text(clockFormatter.string(from: 0)!)
                }.padding(.leading).padding(.trailing)

                HStack(alignment: .bottom) {
                    Text("Year:Day").font(ArkoniaLayout.labelFont).padding(.top, 5)
                    Spacer()
                    Text("\(format(.year)):\(format(.day))")
                }.padding(.leading).padding(.trailing)

                HStack(alignment: .bottom) {
                    Text("Temperature").font(ArkoniaLayout.labelFont).padding(.top, 5)
                    Spacer()
                    Text("\(format(.temperature))")
                }.padding(.leading).padding(.trailing)

                HStack(alignment: .bottom) {
                    Text("Food value").font(ArkoniaLayout.labelFont).padding(.top, 5)
                    Spacer()
                    Text("\(format(.foodValue))")
                }.padding(.leading).padding(.trailing)

            }
            .font(ArkoniaLayout.meterFont)
            .foregroundColor(.green)
        }
    }
}

struct AlmanacView_Previews: PreviewProvider {
    static var previews: some View {
        AlmanacHudView()
    }
}
