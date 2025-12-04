import Foundation
import ArgumentParser

public protocol Day {
    func solvePart1(input: String) throws -> String
    func solvePart2(input: String) throws -> String
}

public enum AocError: Error {
    case badInput(input: String)
    case notYetImplemented
}

@main
struct AoC2025: ParsableCommand {

    @Option(name: .shortAndLong, help: "Day to solve (1-12)") 
    var day: Int = 1

    
    
    func validate() throws {
        guard day >= 1 && day <= 12 else {
            throw ValidationError("Day must be between 1 and 12")
        }
    }

    mutating func run() throws{
        let days: [Day] = [Day1(), Day2()]
        guard day <= days.count else {
            throw AocError.notYetImplemented
        }

        let selectedDay = days[day - 1]

        // read input file
        let input = try String(contentsOfFile: "Input/day\(day).txt", encoding: .utf8)

        let result1 = try selectedDay.solvePart1(input: input)
        print("[Day \(day) | Part 1] Result = \(result1)")
        
        let result2 = try selectedDay.solvePart2(input: input)
        print("[Day \(day) | Part 2] Result = \(result2)")
    }

}
