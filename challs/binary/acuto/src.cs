using System;
using System.Linq;
using System.Text;

namespace ReverseChallenge
{
    class Program
    {
        static void Main()
        {
            Console.Write("Enter flag: ");
            string input = Console.ReadLine();
            
            if (input == null || !input.StartsWith("CTF{") || input[^1] != '}')
            {
                Fail();
                return;
            }

            string inner = input[4..^1];  // Remove CTF{ and }
            
            if (inner.Length != 14)
            {
                Fail();
                return;
            }

            char[] arr = inner.ToCharArray();
            Array.Reverse(arr);
            string reversed = new string(arr);

            string partA = reversed[..9];  // First 9 chars
            string partB = reversed[9..];   // Remaining 5 chars
            string combined = partB + partA;

            byte[] data = Encoding.ASCII.GetBytes(combined);
            for (int i = 0; i < data.Length; i++)
            {
                data[i] ^= 0x55;  // XOR with key 0x55
            }

            string transformed = Convert.ToBase64String(data);
            
            if (transformed == "MCM5ZSY0LzklCmY8Cg==")
            {
                Console.WriteLine("Correct! Flag is valid.");
            }
            else
            {
                Fail();
            }
        }

        static void Fail()
        {
            Console.WriteLine("Invalid flag. Try harder!");
            Environment.Exit(0);
        }
    }
}