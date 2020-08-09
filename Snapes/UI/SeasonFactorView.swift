import SwiftUI

extension CGFloat {
    static let piOverTwo = CGFloat.pi / 2
    static let threePiOverTwo = 3 * CGFloat.pi / 2
}

struct SeasonFactorView: View {
    @EnvironmentObject var seasonalFactors: SeasonalFactors

    let qDay = Arkonia.diurnalCyclePeriodSeconds / 4
    let qYear = Arkonia.diurnalCyclePeriodSeconds * Arkonia.annualCyclePeriodDiurnalPeriods  / 4

    var diurnalArrowFrameHeight: CGFloat {
        let c = ArkoniaLayout.SeasonFactorView.diurnalArrowFrameHeightScale *
        ArkoniaLayout.SeasonFactorView.naturalArrowHeightInAssetCatalog
        return c
    }

    var seasonalArrowFrameHeight: CGFloat {
        let c = (ArkoniaLayout.SeasonFactorView.seasonalArrowFrameHeightScale *
                ArkoniaLayout.SeasonFactorView.naturalArrowHeightInAssetCatalog)
        return c
    }

    func scaleDiurnalCurveToSeasonalArrowPosition() -> CGFloat {
        let scaleToSeasonalArrowFrameRange: CGFloat =
            (seasonalArrowFrameHeight - diurnalArrowFrameHeight) / 2

        return scaleAnnualCurveToAnnualTrackPosition() +
            (-1 * scaleToSeasonalArrowFrameRange * seasonalFactors.diurnalCurve * 0.9)
    }

    func scaleAnnualCurveToAnnualTrackPosition() -> CGFloat {
        let scaleToTrackFrameRange: CGFloat =
            (ArkoniaLayout.SeasonFactorView.annualTrackFrameHeight - seasonalArrowFrameHeight) / 2

        return -1 * scaleToTrackFrameRange * seasonalFactors.annualCurve
    }

    var sunIsAscending: Bool {
        let p = seasonalFactors.diurnalCurve
        return (0..<CGFloat.piOverTwo).contains(p) || (-CGFloat.piOverTwo..<0).contains(p)
    }

    var seasonIsAscending: Bool {
        let p = seasonalFactors.annualCurve - seasonalFactors.seasonalCurve
        return (0..<CGFloat.piOverTwo).contains(p) || (-CGFloat.piOverTwo..<0).contains(p)
    }

    var body: some View {
        ZStack {
            Rectangle()
                .frame(
                    width: ArkoniaLayout.SeasonFactorView.bgFrameWidth,
                    height: ArkoniaLayout.SeasonFactorView.bgFrameHeight
                )
                .foregroundColor(Color(NSColor.darkGray))

            Rectangle()
                .frame(
                    width: ArkoniaLayout.SeasonFactorView.annualTrackFrameWidth,
                    height: ArkoniaLayout.SeasonFactorView.annualTrackFrameHeight
                )
                .cornerRadius(5)
                .foregroundColor(Color(NSColor(calibratedWhite: 0.1, alpha: 1)))

            // Time of year
            Image("sundial")
                .blendMode(.hardLight)
                .colorMultiply(.yellow)
                .opacity(0.0)
                .scaleEffect(CGSize(width: 1.5, height: (seasonIsAscending ? 1 : -1) * ArkoniaLayout.SeasonFactorView.seasonalArrowFrameHeightScale))
                .offset(y: scaleAnnualCurveToAnnualTrackPosition())
                .animation(.easeInOut)

            // Temperature marker
            Rectangle()
                .frame(width: ArkoniaLayout.SeasonFactorView.bgFrameWidth, height: 7)
                .foregroundColor(Color.black)
                .offset(y: scaleDiurnalCurveToSeasonalArrowPosition())
                .animation(.easeInOut)

            // Time of day
            Image("sundial")
                .blendMode(.normal)
                .colorMultiply(.gray)
                .colorMultiply(.green)
                .scaleEffect(CGSize(width: 0.5, height: (sunIsAscending ? 1 : -1) * ArkoniaLayout.SeasonFactorView.diurnalArrowFrameHeightScale))
                .offset(y: scaleDiurnalCurveToSeasonalArrowPosition())
                .animation(.easeInOut)
        }
    }
}

struct SeasonFactorView_Previews: PreviewProvider {
    static var previews: some View {
        return SeasonFactorView().environmentObject(SeasonalFactors())
    }
}
