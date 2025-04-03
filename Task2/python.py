input_str = input("Enter the string of numbers with ',' separator: ")

separators = [-1]
for i in range(len(input_str)):
    if input_str[i] == ',':
        separators.append(i)
separators.append(len(input_str))

count = 0
for i in range(len(separators) - 1):
    count += (separators[i + 1] - separators[i] - 1) % 2
    for j in range(separators[i] + 1, separators[i + 1]):
        if input_str[j] < '0' or input_str[j] > '9':
            print("You should have entered the numbers!")
            exit()
print(count)
