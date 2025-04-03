import Foundation

print("Enter the string of numbers with ',' separator: ", terminator: "")
if let input = readLine() {
    
    var separators: [Int] = [-1]
    
    for (i, char) in input.enumerated() {
        if char == "," {
            separators.append(i)
        }
    }
    
    separators.append(input.count)

    var count = 0
    var error = false
    
    for i in 0..<separators.count - 1 {
        count += (separators[i + 1] - separators[i] - 1) % 2
        
        for j in (separators[i] + 1)..<separators[i + 1] {
            if let char = input[input.index(input.startIndex, offsetBy: j)].asciiValue {
                if char < Character("0").asciiValue! || char > Character("9").asciiValue! {
                    print("You should have entered the numbers!")
                    error = true
                }
            }
        }
    }
    
    if !error {
        print(count)
    }
}
