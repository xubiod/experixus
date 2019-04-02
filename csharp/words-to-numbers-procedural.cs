//Rextester.Program.Main is the entry point for your code. Don't change it.
//Compiler version 4.0.30319.17929 for Microsoft (R) .NET Framework 4.5

/*

This generates random strings and then "numberizes" them.

*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Net;
using System.Threading.Tasks;

namespace Rextester
{
    public class Program
    {
        static Random _r = new Random();
        //static int mode = 0;
        
        public static void Main(string[] args)
        {
            for (int iter = 0; iter < 5000; iter++) {
                    string test = "";
                    for (int letter = 0; letter < _r.Next(4, 16); letter++) {
                        test += (char)(_r.Next(97, 123));
                    }

                    Console.WriteLine(test + "\nScore: " + WordToNumber(test).ToString() + " Length: " + test.Length.ToString() + "\n"); 
                }
        }
        
        public static int WordToNumber(string input)
        {
            int output = 0;
            input = input.ToLower();
            
            List<char> all_char = input.ToList();
            
            foreach (char letter in all_char) {
               output += ((int)letter) - 96;
            }
            
            return output;
        }
    }
}
