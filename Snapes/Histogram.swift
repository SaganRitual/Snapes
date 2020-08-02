import SwiftUI

class Histogram: ObservableObject {
    class Bucket: CustomDebugStringConvertible {
        var debugDescription: String { "Bucket hit \(self.cSamples) sum \(self.sumOfAllSamples) avg \(self.average) nrm \(self.normalized)" }
        var getUnitScale: (() -> Double)!

        func inject(_ getUnitScale: @escaping () -> Double) { self.getUnitScale = getUnitScale }

        func addSample(_ sample: Double) {
            cSamples += 1; sumOfAllSamples += sample
//            print("addSample(\(sample)) -> cSamples \(cSamples) sum \(sumOfAllSamples)")
        }

        private(set) var cSamples: Int = 0
        private(set) var sumOfAllSamples: Double = 0

        var average: Double { sumOfAllSamples == 0 ? 0 : Double(cSamples) / sumOfAllSamples }
        var normalized: Double {
            let us = getUnitScale()
            if us == 0 { return 0 }
            return average / us
        }
    }

    let cBuckets: Int
    let dBuckets: Double
    var inputRange: Range<Double>
    let inputRangeMode: InputRangeMode
    var theBuckets: [Bucket]
    @Published var hackyTrigger = false

    enum InputRangeMode { case minusOneToOne, zeroToOne, zeroToMax(Int) }

    init(_ cColumns: Int, _ inputRangeMode: InputRangeMode) {
        self.cBuckets = cColumns
        self.dBuckets = Double(cColumns)
        self.theBuckets = (0..<cColumns).map { _ in Bucket() }
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
        let bucketSS = getBucketFor(xAxis)
        theBuckets[bucketSS].addSample(yAxis)
    }

    private func getBucketFor(_ value: Double) -> Int {
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

//        print("bucket \(ss) ", terminator: "")
        return ss
    }
}
