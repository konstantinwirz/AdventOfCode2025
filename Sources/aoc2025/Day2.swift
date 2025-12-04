import Foundation

class Day2: Day {

    func solvePart1(input: String) throws -> String {
        let ranges = try parseRanges(from: input)
        var cache: [Int: Bool] = [:]
        func checkID(_ id: Int) {
            if cache[id] != nil {
                return  // already cached
            }

            let idStr = String(id)
            guard idStr.count % 2 == 0 else {
                cache[id] = false
                return
            }

            let midIndex = idStr.index(idStr.startIndex, offsetBy: idStr.count / 2)
            let isInvalid = idStr[..<midIndex] == idStr[midIndex...]
            cache[id] = isInvalid
        }

        ranges.forEach { range in
            (range.start...range.end).forEach { checkID($0) }
        }

        let invalidIdsSum = cache.filter { _, value in value == true }
            .map { key, _ in key }
            .reduce(0, { $0 + $1 })

        return String(invalidIdsSum)
    }

    func solvePart2(input: String) throws -> String {
        let ranges = try parseRanges(from: input)
        var cache: [Int: Bool] = [:]
        func checkID(_ id: Int) {
            if cache[id] != nil {
                return  // already cached
            }
            let idStr = String(id)
            for i in 0..<(idStr.count / 2) {
                let endIndex = idStr.index(idStr.startIndex, offsetBy: i + 1)
                let numberUnderTest = idStr[idStr.startIndex..<endIndex]
                cache[id] =
                    (String(
                        repeating: String(numberUnderTest),
                        count: idStr.count / numberUnderTest.count) == idStr)
                if cache[id] == true {
                    return
                }
            }
        }

        ranges.forEach { range in
            (range.start...range.end).forEach { checkID($0) }
        }

        let invalidIdsSum = cache.filter { _, value in value == true }
            .map { key, _ in key }
            .reduce(0, { $0 + $1 })

        return String(invalidIdsSum)
    }

    private func parseRanges(from input: String) throws -> [(start: Int, end: Int)] {
        try input.split(separator: Character(",")).map { range in
            let parts = range.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).split(
                separator: "-")
            guard parts.count == 2 else {
                throw AocError.badInput(input: String(range))
            }

            guard let start = Int(parts[0]) else {
                throw AocError.badInput(input: String(parts[0]))
            }

            guard let end = Int(parts[1]) else {
                throw AocError.badInput(input: String(parts[1]))
            }

            return (start, end)
        }
    }

}
