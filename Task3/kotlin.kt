fun enterPositiveNumber(): Int {
    var number: Int
    while (true) {
        number = readLine()!!.toInt()
        if (number < 1) {
            println("The number must be positive!")
        } else break
    }
    return number
}

fun enterCorrectNumbers(count: Int): List<Int> {
    val correctNumbers = mutableListOf<Int>()
    for (i in 0 until count) {
        var summ = 0
        var multi = 1
        val number = enterPositiveNumber()
        var temp = number
        while (temp > 0) {
            val digit = temp % 10
            summ += digit
            multi *= digit
            temp /= 10
        }
        if (summ < multi) correctNumbers.add(i)
    }
    return correctNumbers
}

fun main() {
    println("Enter the positive number of numbers to be entered: ")
    val count = enterPositiveNumber()
    println("Enter numbers greater than zero: ")
    val correctNumbers = enterCorrectNumbers(count)
    println()

    if (correctNumbers.isNotEmpty()) {
        println(correctNumbers.joinToString(" "))
    } else {
        println("There are no numbers that match the condition")
    }
}
