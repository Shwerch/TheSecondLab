using System;

class Program
{
    static void Main()
    {
        Console.Write("Enter the N number: ");
        int num = Convert.ToInt32(Console.ReadLine());

        if (num < 1 || num > 26)
        {
            Console.WriteLine("The N number must be from 1 to 26!");
            return;
        }

        for (int i = 0; i < num; i++)
        {
            for (int j = 0; j < i + 1; j++)
                Console.Write((char)(num - j - 1 + 'A') + " ");
            Console.WriteLine();
        }
    }
}
