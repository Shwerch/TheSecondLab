using System;
using System.Collections.Generic;

class Program
{
    static int EnterPositiveNumber()
    {
        int number = 0;
        while (true)
        {
            if (int.TryParse(Console.ReadLine(), out number) && number > 0)
                break;
            Console.WriteLine("The number must be positive!");
        }
        return number;
    }

    static List<int> EnterCorrectNumbers(int count)
    {
        List<int> correctNumbers = new List<int>();
        for (int i = 0; i < count; i++)
        {
            int summ = 0, multi = 1;
            int number;
            do
            {
                number = EnterPositiveNumber();
                int temp = number;
                while (temp > 0)
                {
                    int digit = temp % 10;
                    summ += digit;
                    multi *= digit;
                    temp /= 10;
                }
            } while (number <= 0);
            if (summ < multi)
                correctNumbers.Add(i);
        }
        return correctNumbers;
    }

    static void Main()
    {
        Console.Write("Enter the positive number of numbers to be entered: ");
        int number = EnterPositiveNumber();
        Console.Write("Enter numbers greater than zero: ");
        List<int> correctNumbers = EnterCorrectNumbers(number);
        Console.WriteLine();

        if (correctNumbers.Count > 0)
            Console.WriteLine(string.Join(" ", correctNumbers));
        else
            Console.WriteLine("There are no numbers that match the condition");
    }
}
