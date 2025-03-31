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
            {
                separators.Add(i);
            }
        }
        separators.Add(input.Length);

        List<List<char>> numbers = new List<List<char>>();
        for (int i = 0; i < separators.Count - 1; i++)
        {
            int j = i + 1;
            numbers.Add(new List<char>());
            for (int k = separators[i] + 1; k < separators[j]; k++)
            {
                numbers[i].Add(input[k]);
            }
        }

        for (int i = 0; i < numbers.Count; i++)
        {
            int sum = 0, product = 1;
            foreach (char j in numbers[i])
            {
                int num = j - '0';
                sum += num;
                product *= num;
            }
            if (sum < product)
            {
                Console.Write(i + " ");
            }
        }
        Console.WriteLine();
    }
}
