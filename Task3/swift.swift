import Foundation

func enterPositiveNumber() -> Int {
    var number: Int

    repeat {
        if let input = readLine(), let num = Int(input), num > 0 {
            return num
        } else {
            print("The number must be positive!")
        }

    } while true
}

func enterCorrectNumbers(count: Int) -> [Int] {
    var correctNumbers: [Int] = []

    for i in 0..<count {
        var summ = 0, multi = 1

        let number = enterPositiveNumber()

        var tempNumber = number

        while tempNumber > 0 {
            let digit = tempNumber % 10

            summ += digit
            multi *= digit

            tempNumber /= 10
        }

        if summ < multi {
            correctNumbers.append(i)
        }

    }

    return correctNumbers
}

print("Enter the positive number of numbers to be entered: ")
let count = enterPositiveNumber()
print("Enter numbers greater than zero: ")
let correctNumbers = enterCorrectNumbers(count: count)

print()

if !correctNumbers.isEmpty {
   print(correctNumbers.map { String($0) }.joined(separator: " "))
} else {
   print("There are no numbers that match the condition")
}
print()
