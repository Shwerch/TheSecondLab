import java.util.Scanner

fun main() {
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