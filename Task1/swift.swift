import Foundation

func main() {
    print("Enter the N number: ")
    let num = Int(readLine()!)!
    
    for i in 1...num {
        for j in 1...i {
            let char = Character(UnicodeScalar(num - j + Int("A".utf8.first!))!)
            print(char, terminator: " ")
        }
        print()
    }
}

main()