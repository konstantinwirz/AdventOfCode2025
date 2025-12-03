// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
struct aoc2025 {
    static func main() {
        let day1 = Day1Solution()
        do {
            try day1.solvePart1()
            try day1.solvePart2()
        } catch {
            print("Failed to solve day1.part1: \(error)")
        }
    }
}
