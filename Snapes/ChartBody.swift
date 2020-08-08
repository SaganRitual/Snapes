//
//  ChartBody.swift
//  Yak
//
//  Created by Rob Bishop on 8/7/20.
//

import SwiftUI

struct FitToWidth: ViewModifier {
    var fraction: CGFloat = 1.0
    func body(content: Content) -> some View {
        GeometryReader { g in
        content
            .font(.system(size: 1000))
            .minimumScaleFactor(0.005)
            .lineLimit(1)
            .frame(width: g.size.width * self.fraction)
        }
    }
}

struct ChartBody: View {
    let chartBodyTitleHeight: CGFloat = 10 * 0.5
    let chartBodyPadding: CGFloat = 10 / 0.75 // 1/10 body height * 0.75 to make it a little smaller
    let chartAnnoyingPaddingSize: CGFloat = -0.8 * 10    // Body height - padding height

    var body: some View {
        ChartDataBackdrop()
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing])
            .background(Color.gray)
    }
}

struct ChartBody_Previews: PreviewProvider {
    static var previews: some View {
        ChartBody().frame(width: 300)
    }
}
