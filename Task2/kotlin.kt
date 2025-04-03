fun main() {
    print("Enter the string of numbers with ',' separator: ")
    val input = readLine()!!

    val separators = mutableListOf(-1)
    for (i in input.indices) {
        if (input[i] == ',') {
            separators.add(i)
        }
    }
    separators.add(input.length)

    var count = 0
    for (i in 0 until separators.size - 1) {
        count += (separators[i + 1] - separators[i] - 1) % 2
        for (j in (separators[i] + 1)..(separators[i + 1] - 1)) {
            if (input[j] < '0' || input[j] > '9') {
                println("You should have entered the numbers!")
                return
            }
        }
    }
    println(count)
}
