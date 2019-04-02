//Rextester.Program.Main is the entry point for your code. Don't change it.
//Compiler version 4.0.30319.17929 for Microsoft (R) .NET Framework 4.5

/*
input    -> output

attitude -> 100
chicken  -> 53
ttttt    -> 100

*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace Rextester
{
    public class Program
    {
        public static void Main(string[] args)
        {
            int total_inputs = int.Parse(Console.ReadLine());
            
            for (int i = 0; i < total_inputs; i++) {
                string input = Console.ReadLine();
                int output = 0;
                input = input.ToLower();
                
                List<char> all_char = input.ToList();
                
                foreach (char letter in all_char) {
                    output += ((int)letter) - 96;
                }
                
                Console.WriteLine("Input:  " + input + "\nOutput: " + output.ToString() + "\n");
            }
        }
    }
}
