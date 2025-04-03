fun main() {
    print("Enter the N number: ")
    val num = readLine()!!.toInt()

    if (num < 1 || num > 26) {
        println("The N number must be from 1 to 26!")
        return
    }

    for (i in 0 until num) {
        for (j in 0..i) {
            print("${(num - j - 1 + 'A'.toInt()).toChar()} ")
        }
        println()
    }
}
