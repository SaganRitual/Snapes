import SwiftUI

enum ArkoniaLayout {
    static let labelFontSize = CGFloat(10)
    static let meterFontSize = CGFloat(8)

    static let labelFont = Font.system(
        size: labelFontSize,
        design: Font.Design.monospaced
    ).lowercaseSmallCaps()

    static let meterFont = Font.system(
        size: meterFontSize,
        design: Font.Design.monospaced
    )

    static let xScale = CGFloat(300)
    static let yScale = CGFloat(200)

    static let bodyRatio: CGFloat = 0.9
    static let labelsRatio: CGFloat = 0.1

    // Based on size of labelFont
    static let labelTextSize = CGSize(width: 2 * labelFontSize, height: 1 * labelFontSize)

    static func getLabelText(_ labelNumber: Int) -> String {
        String(format: "% 3d", labelNumber)
    }
}
