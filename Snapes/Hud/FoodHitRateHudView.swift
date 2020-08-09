import SwiftUI

struct FoodHitrateHudView: View {
    @EnvironmentObject var stats: PopulationStats

    enum Format { case max, highwater, average, llamas }

    func format(_ format: Format) -> String { "0" }

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.white.opacity(0.01))
                .border(Color.black)

            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text("Max Food Hitrate").font(ArkoniaLayout.labelFont)
                    Spacer()
                    Text(format(.max))
                }.padding(.leading).padding(.trailing)

                HStack(alignment: .bottom) {
                    Text("Average").font(ArkoniaLayout.labelFont).padding(.top, 5)
                    Spacer()
                    Text(format(.average))
                }.padding(.leading).padding(.trailing)

                HStack(alignment: .bottom) {
                    Text("Manna").font(ArkoniaLayout.labelFont).padding(.top, 5)
                    Spacer()
                    Text(
                        "\(String(format: "% 5d", 0))"
                        + "/\(String(format: "% 5d", 0))"
                    )
                }.padding(.leading).padding(.trailing)

                HStack(alignment: .bottom) {
                    Text("Llamas").font(ArkoniaLayout.labelFont).padding(.top, 5)
                    Spacer()
                    Text(format(.llamas))
                }.padding(.leading).padding(.trailing)
            }
            .font(ArkoniaLayout.meterFont)
            .foregroundColor(.green)
            .frame(width: ArkoniaLayout.AlmanacView.frameWidth)
        }
    }
}

struct FoodHitrateHudView_Previews: PreviewProvider {
    static var previews: some View {
        FoodHitrateHudView().environmentObject(PopulationStats())
    }
}
