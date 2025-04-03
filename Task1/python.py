num = int(input("Enter the N number: "))

if num < 1 or num > 26:
    print("The N number must be from 1 to 26!")
else:
    for i in range(num):
        for j in range(i + 1):
            print(chr(num - j - 1 + ord('A')), end=' ')
        print()
