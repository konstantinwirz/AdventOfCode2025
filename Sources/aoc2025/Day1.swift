import Foundation

enum Direction: Int, CustomStringConvertible {
    case left
    case right

    var description: String {
        switch self {
        case .left: "L"
        case .right: "R"
        }
    }
}

struct Rotation: CustomStringConvertible {
    let direction: Direction
    let value: UInt

    var description: String {
        "\(direction)\(value)"
    }
}

extension StringProtocol {

    func parseRotations() throws -> [Rotation] {
        try self.split(separator: Character("\n")).map {
            try $0.parseRotation()
        }
    }

    func parseRotation() throws(AocError) -> Rotation {
        let trimmed = self.trimmingCharacters(in: CharacterSet.whitespaces)
        guard trimmed.count >= 2 else {
            throw AocError.badInput(input: String(self))
        }

        let direction: Direction =
            switch trimmed.first?.uppercased() {
            case "L": .left
            case "R": .right
            default: throw AocError.badInput(input: String(self))
            }

        let valueStartIndex = trimmed.index(trimmed.startIndex, offsetBy: 1)
        let valueStr = String(trimmed[valueStartIndex...])
        if let value = UInt(valueStr) {
            return Rotation(direction: direction, value: value)
        }

        throw AocError.badInput(input: String(self))
    }
}

class Day1: Day {

    func solvePart1(input: String) throws -> String {
        let rotations = try input.parseRotations()
        var pwd: UInt = 0
        var counter: Int = 50

        for rotation in rotations {
            switch rotation.direction {
            case .left:
                counter -= (Int(rotation.value) % 100)
                if counter < 0 {
                    counter += 100
                }
            case .right:
                counter = (counter + Int(rotation.value)) % 100
            }
            if counter == 0 {
                pwd += 1
            }
        }

        return String(pwd)
    }

    func solvePart2(input: String) throws -> String {
        let rotations = try input.parseRotations()
        var pwd: UInt = 0
        var dial: Int = 50

        for rotation in rotations {
            let initialDial: Int = dial
            let rotations: UInt = rotation.value / 100
            let rotationValue: UInt = rotation.value % 100
            pwd += rotations
            let sign: Int = (rotation.direction == .left) ? -1 : 1
            dial = dial + sign * Int(rotationValue)
            if dial < 0 {
                dial += 100
                if dial != 0 && initialDial != 0 {
                    pwd += 1
                }
            } else if dial >= 100 {
                dial -= 100

                if dial != 0 && initialDial != 0 {
                    pwd += 1
                }
            }

            if dial == 0 && initialDial != 0 {      
                pwd += 1
            }
        }

        return String(pwd)
    }
}
