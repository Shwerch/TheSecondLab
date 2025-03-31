using System;

class Program
{
    static void Main()
    {
        int num = 0;
        num = int.Parse(Console.ReadLine());
        
        for (int i = 1; i <= num; i++)
        {
            for (int j = 1; j <= i; j++)
            {
                Console.Write((char)(num - j + 'A') + " ");
            }
            Console.WriteLine();
        }
    }
}
