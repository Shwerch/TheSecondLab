
num = int(input("Enter the N number: "))

for i in range(1, num + 1):
    line = ''
    for j in range(1, i + 1):
        line += chr(num - j + ord('A')) + " "
    print(line.strip())