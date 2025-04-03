input_str = input("Enter the string of numbers with ' ' separator: ")

separators = [-1]
for i in range(len(input_str)):
    if input_str[i] == ' ':
        separators.append(i)
separators.append(len(input_str))

numbers = []
for i in range(len(separators) - 1):
    numbers.append([])
    for k in range(separators[i] + 1, separators[i + 1]):
        numbers[i].append(input_str[k])

answer = []
for i in range(len(numbers)):
    summ, multi = 0, 1
    for j in numbers[i]:
        if j < '0' or j > '9':
            print("You should have entered the numbers!")
            exit()
        num = int(j)
        summ += num
        multi *= num
    if summ < multi:
        answer.append(i)

print(" ".join(map(str, answer)))
if answer:
    print()
