import SwiftUI

class Histogram: ObservableObject {
    class Bucket {
        var getUnitScale: (() -> Double)!

        func inject(_ getUnitScale: @escaping () -> Double) { self.getUnitScale = getUnitScale }

        func addSample(_ sample: Double) { cHits += 1; sumOfAllSamples += sample }

        private var cHits: Int = 0
        private var sumOfAllSamples: Double = 0

        var average: Double { Double(cHits) / sumOfAllSamples }
        var normalized: Double { average / getUnitScale() }
    }

    let cBuckets: Int
    let dBuckets: Double
    var inputRange: Range<Double>
    let inputRangeMode: InputRangeMode
    @Published var theBuckets: [Bucket]

    enum InputRangeMode { case minusOneToOne, zeroToOne, zeroToMax(Int) }

    init(_ cColumns: Int, _ inputRangeMode: InputRangeMode) {
        self.cBuckets = cColumns
        self.dBuckets = Double(cColumns)
        self.theBuckets = [Bucket](repeating: .init(), count: cColumns)
        self.inputRangeMode = inputRangeMode

        switch inputRangeMode {
        case .minusOneToOne:            self.inputRange = Double(-1)..<Double(1)
        case .zeroToOne:                self.inputRange = Double(0)..<Double(1)
        case let .zeroToMax(rangeTop):  self.inputRange = Double(0)..<Double(rangeTop)
        }

        self.theBuckets.forEach { $0.inject(getUnitScale) }
    }

    func getUnitScale() -> Double {
        theBuckets.max(by: { $0.average < $1.average })!.average / 1
    }

    func track(sample: Double) {
        addSample(xAxis: sample, yAxis: 1)
    }

    func track(cJumps: Int, against cGrazeSuccesses: Int) {
        addSample(xAxis: Double(cJumps), yAxis: Double(cGrazeSuccesses))
    }

    private func addSample(xAxis: Double, yAxis: Double) {
        let bucket = getBucketFor(xAxis)
        bucket.addSample(yAxis)
    }

    private func getBucketFor(_ value: Double) -> Bucket {
        assert(inputRange.contains(value))

        let ss: Int
        switch inputRangeMode {
        case .minusOneToOne:
            let shifted = value + 1             // Convert scale -1..<1 to 0..<2
            let rescaled = shifted / 2          // Convert scale 0..<2 to 0..<1

            let s = Int(rescaled * dBuckets)
            ss = s < cBuckets ? s : cBuckets - 1

        case .zeroToOne:
            let s = Int(value * dBuckets)
            ss = s < cBuckets ? s : cBuckets - 1

        case let .zeroToMax(value):
            let rescaled = Double(value) / Double(inputRange.upperBound)
            let s = Int(rescaled * dBuckets)
            ss = s < cBuckets ? s : cBuckets - 1
        }

        return theBuckets[ss]
    }
}
