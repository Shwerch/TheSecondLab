using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        Console.Write("Enter the string of numbers with ',' separator: ");
        string input = Console.ReadLine();

        List<int> separators = new List<int> { -1 };
        for (int i = 0; i < input.Length; i++)
        {
            if (input[i] == ',')
            {
                separators.Add(i);
            }
        }
        separators.Add(input.Length);

        int count = 0;
        for (int i = 0; i < separators.Count - 1; i++)
        {
            count += (separators[i + 1] - separators[i] - 1) % 2;
        }
        
        Console.WriteLine(count);
    }
}
