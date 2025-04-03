using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        Console.Write("Enter the string of numbers with ' ' separator: ");
        string input = Console.ReadLine();

        List<int> separators = new List<int> { -1 };
        for (int i = 0; i < input.Length; i++)
        {
            if (input[i] == ' ')
                separators.Add(i);
        }
        separators.Add(input.Length);

        List<List<char>> numbers = new List<List<char>>();
        for (int i = 0; i < separators.Count - 1; i++)
        {
            numbers.Add(new List<char>());
            for (int k = separators[i] + 1; k < separators[i + 1]; k++)
                numbers[i].Add(input[k]);
        }

        List<int> answer = new List<int>();
        for (int i = 0; i < numbers.Count; i++)
        {
            int summ = 0, multi = 1;
            foreach (char j in numbers[i])
            {
                int num = j - '0';
                if (num < 0 || num > 9)
                {
                    Console.WriteLine("You should have entered the numbers!");
                    return;
                }
                summ += num;
                multi *= num;
            }
            if (summ < multi)
                answer.Add(i);
        }

        foreach (int i in answer)
            Console.Write(i + " ");
        
        if (answer.Count > 0)
            Console.WriteLine();
    }
}
