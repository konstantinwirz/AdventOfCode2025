import Foundation

final class Day3: Day {
    func solvePart1(input: String) throws -> String {
        let _ = """
            987654321111111
            811111111111119
            234234234234278
            818181911112111
            """

        func findMaxJoltage<S: StringProtocol>(in bank: S, posRange: (from: UInt, to: UInt)) throws -> (
            joltage: UInt8, pos: UInt
        ) {
            var pos: UInt = 0
            var joltage: UInt8 = 0
            for (i, c) in bank.enumerated() where i >= posRange.from && i < posRange.to {
                guard let digit = c.wholeNumberValue else {
                    throw AocError.badInput(input: String(bank))
                }
                if digit > joltage {
                    pos = UInt(i)
                    joltage = UInt8(digit)
                }

                if joltage == 9 {
                    break
                }
            }

            return (joltage, pos)
        }

        let totalJoltage = try input.split(separator: "\n").map { bank in
            let (firstJoltage, pos) = try findMaxJoltage(in: bank, posRange: (from: 0, to: UInt(bank.count - 1)))
            let (secondJoltage, _) = try findMaxJoltage(in: bank, posRange: (from: pos + 1, to: UInt(bank.count)))
            //print("first = \(firstJoltage); second = \(secondJoltage)")
            return UInt(firstJoltage * 10 + secondJoltage)
        }.reduce(0, +)

        return "\(totalJoltage)"
    }

    func solvePart2(input: String) throws -> String {
        "2"
    }
}
