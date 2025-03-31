fun main() {
    println("Enter the string of numbers with ' ' separator: ")
    val input = readLine() ?: ""

    val separators = mutableListOf(-1)
    for (i in input.indices) {
        if (input[i] == ' ') {
            separators.add(i)
        }
    }
    separators.add(input.length)

    val numbers = mutableListOf<MutableList<Char>>()
    for (i in 0 until separators.size - 1) {
        val numberList = mutableListOf<Char>()
        for (k in (separators[i] + 1) until separators[i + 1]) {
            numberList.add(input[k])
        }
        numbers.add(numberList)
    }

    val answer = mutableListOf<Int>()
    for (i in numbers.indices) {
        var summ = 0
        var multi = 1
        for (j in numbers[i]) {
            val num = j - '0'
            if (num < 0 || num > 9) {
                println("You should have entered the numbers!")
                return
            }
            summ += num
            multi *= num
        }
        if (summ < multi) {
            answer.add(i)
        }
    }

    for (i in answer) {
        print("$i ")
    }
    println()
}
