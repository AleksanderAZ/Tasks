import Cocoa

struct Digit {
    var value: Int
    
    static func + (left: Digit, right: Digit) -> Digit {
        return Digit(value: (left.value + right.value))
    }
    static func - (left: Digit, right: Digit) -> Digit {
        return Digit(value: (left.value - right.value))
    }
    static func / (left: Digit, right: Digit) -> Digit {
        return Digit(value: (left.value / right.value))
    }
    static func * (left: Digit, right: Digit) -> Digit {
        return Digit(value: (left.value * right.value))
    }
    static func == (left: Digit, right: Digit) -> Bool {
        return left.value == right.value
    }
    static func != (left: Digit, right: Digit) -> Bool {
        return left.value != right.value
    }
}

let c = Digit(value: 1)
let d = Digit(value: 2)

let sum = c + d
let substr = c - d
let divide = c / d
let multiply = c * d
let isEqual = c == d
let isNotEqual = c != d



