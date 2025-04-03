import Foundation

extension String: Error {}

print("Enter the string of numbers with ' ' separator: ", terminator: "")
if let input = readLine() {

    var separators: [Int] = [-1]

    for (i, char) in input.enumerated() {
        if char == " " {
            separators.append(i)
        }
    }

    separators.append(input.count)

    var numbers: [[Character]] = []
    
    for i in 0..<separators.count - 1 {
        var numberSegment: [Character] = []
        
        for k in (separators[i] + 1)..<separators[i + 1] {
            numberSegment.append(input[input.index(input.startIndex, offsetBy: k)])
        }
        
        numbers.append(numberSegment)
    }

    var answer: [Int] = []

    for (i, number) in numbers.enumerated() {
        var summ = 0
        var multi = 1
        
        for j in number {
            let num: Int? = Int(String(j))
            
            guard let n = num else {
                print("You should have entered the numbers!")
                throw "You should have entered the numbers!"
            }

            summ += n
            multi *= n
        }

        if summ < multi {
            answer.append(i)
        }
    }

    print(answer.map { String($0) }.joined(separator: " "))
    if !answer.isEmpty { print("") }
}
