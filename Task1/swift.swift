import Foundation

print("Enter the N number: ", terminator: "")
if let input = readLine(), let num = Int(input) {
    
    if num < 1 || num > 26 {
        print("The N number must be from 1 to 26!")
    } else {
        for i in 0..<num {
            for j in 0...i {
                let char = Character(UnicodeScalar(num - j - 1 + Int(UnicodeScalar("A").value))!)
                print("\(char) ", terminator: "")
            }
            print("")
        }
    }
}
