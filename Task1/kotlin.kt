import java.util.Scanner

fun main() {
    print("Enter the N number: ")
    val scanner = Scanner(System.`in`)
    val num = scanner.nextInt()
    scanner.close()
    for (i in 1..num) {
        for (j in 1..i) {
            print((num - j + 'A'.code).toChar() + " ")
        }
        println()
    }
}