def enter_positive_number():
    while True:
        number = int(input())
        if number < 1:
            print("The number must be positive!")
        else:
            return number

def enter_correct_numbers(count):
    correct_numbers = []
    for i in range(count):
        summ, multi = 0, 1
        number = enter_positive_number()

        while number > 0:
            digit = number % 10
            summ += digit
            multi *= digit
            number //= 10

        if summ < multi:
            correct_numbers.append(i)

    return correct_numbers

def main():
    print("Enter the positive number of numbers to be entered: ")
    count = enter_positive_number()
    print("Enter numbers greater than zero: ")
    correct_numbers = enter_correct_numbers(count)

    print()

    if correct_numbers:
        print(' '.join(map(str, correct_numbers)))
    else:
        print("There are no numbers that match the condition")

if __name__ == "__main__":
    main()
