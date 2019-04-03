//Rextester.Program.Main is the entry point for your code. Don't change it.
//Compiler version 4.0.30319.17929 for Microsoft (R) .NET Framework 4.5

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace Rextester
{
    public class Program
    {
        public static List<Palette> allPalettes = new List<Palette>();
        public static EmulatedScreen gameWorld = new EmulatedScreen(0,192,128);
        private static bool getThem = false;
        
        public static void Main(string[] args)
        {
            ///TODO: reminder that these are BBGGRR and not RRGGBB because gml can be *really* dumb
            allPalettes.Add(new Palette { Color0 = "20200e", Color1 = "7504e4", Color2 = "e4e048", Color3 = "f6fbd7" });
            allPalettes.Add(new Palette { Color0 = "bee8eb", Color1 = "7ac8b3", Color2 = "2a7a34", Color3 = "242e20" });
            allPalettes.Add(new Palette { Color0 = "fafafa", Color1 = "20bbe0", Color2 = "181884", Color3 = "000000" });
            allPalettes.Add(new Palette { Color0 = "3f0135", Color1 = "cd43b6", Color2 = "a25dff", Color3 = "ccdd99" });
            
            ///TODO: these are properly RRGGBB
            allPalettes.Add(new Palette { Color0 = "233142", Color1 = "455d7a", Color2 = "f95959", Color3 = "facf5a" });
            allPalettes.Add(new Palette { Color0 = "000000", Color1 = "545454", Color2 = "ABABAB", Color3 = "FFFFFF" });
            allPalettes.Add(new Palette { Color0 = "49260a", Color1 = "623b1c", Color2 = "caad8c", Color3 = "f6eddd" });
            allPalettes.Add(new Palette { Color0 = "fdf1db", Color1 = "a6cb12", Color2 = "e00543", Color3 = "84253e" });
            
            allPalettes.Add(new Palette { Color0 = "f3f0d1", Color1 = "e29c68", Color2 = "c85108", Color3 = "a20e0e" });
            allPalettes.Add(new Palette { Color0 = "000000", Color1 = "3e432e", Color2 = "616f39", Color3 = "a7d129" });
            allPalettes.Add(new Palette { Color0 = "ff1f5a", Color1 = "ffd615", Color2 = "f9ff21", Color3 = "1e2a78" });
            allPalettes.Add(new Palette { Color0 = "481380", Color1 = "742dd2", Color2 = "efb1ff", Color3 = "ffe2ff" });
            
            allPalettes.Add(new Palette { Color0 = "05004e", Color1 = "ff0000", Color2 = "fb7777", Color3 = "ffcccc" });
            allPalettes.Add(new Palette { Color0 = "f9f8eb", Color1 = "a7d7c5", Color2 = "74b49b", Color3 = "5c8d89" });
            allPalettes.Add(new Palette { Color0 = "fbf9fa", Color1 = "fd0054", Color2 = "a80038", Color3 = "2b2024" });
            allPalettes.Add(new Palette { Color0 = "612c83", Color1 = "509aaf", Color2 = "7dd8c7", Color3 = "f5ffc3" });
            
            allPalettes.Add(new Palette { Color0 = "a8026f", Color1 = "db2d43", Color2 = "e76838", Color3 = "fbd5af" });
            allPalettes.Add(new Palette { Color0 = "ffeed0", Color1 = "f79f24", Color2 = "f12d2d", Color3 = "7c064d" });
            allPalettes.Add(new Palette { Color0 = "070d59", Color1 = "1f3c88", Color2 = "5893d4", Color3 = "ceddef" });
            allPalettes.Add(new Palette { Color0 = "0b032d", Color1 = "843b62", Color2 = "f67e7d", Color3 = "ffb997" });
            
            for (int pal = 0; pal < allPalettes.Count; pal++) {
                string extra = "";
                if (pal.ToString().Length == 1) extra = "0";
                Console.Write("p" + extra + pal.ToString() + ": {");
                for (int i = 0; i < 4; i++) {
                    Console.Write("c" + i.ToString() + ": [" +allPalettes[pal].GetColor(i) + "] ");
                }
                
                Console.WriteLine("}");
                
                if ((pal + 1) % 4 == 0) Console.WriteLine();
            }
            
            Console.WriteLine();
            Console.WriteLine("palette dump completed");
            
            Console.WriteLine();
            Console.WriteLine();
            Console.WriteLine("emulated screen");
            Console.WriteLine("    palette: " + gameWorld.CurrentPalette.ToString());
            Console.WriteLine("    width: " + gameWorld.Width.ToString());
            Console.WriteLine("    height: " + gameWorld.Height.ToString());
            
            if (getThem) {
                Console.WriteLine();
                Console.WriteLine();

                Console.WriteLine("   ._.  ");
                Console.WriteLine("   |X|  ");
                Console.WriteLine("   |XX\\ ");
                Console.WriteLine("  /XXX| ");
                Console.WriteLine(" //\\XX\\");
                Console.WriteLine(" |\\/XXX\\");
                Console.WriteLine(" \\\\^XX^\\");
                Console.WriteLine("  | || |");
                Console.WriteLine("  v || v");
                Console.WriteLine("     v  ");

                Console.WriteLine();
                Console.WriteLine("got 'em");
            }
        }
    }
    
    public class Palette {
        ///TODO: replace string with appropriate color functions for SDL
        public string Color0 {get; set;}
        public string Color1 {get; set;}
        public string Color2 {get; set;}
        public string Color3 {get; set;}
        
        public string GetColor(int index) {
            switch (index) {
                case 0: {
                    return this.Color0;
                }
                case 1: {
                    return this.Color1;
                }
                case 2: {
                    return this.Color2;
                }
                case 3: {
                    return this.Color3;
                }
                default: {
                    return this.Color0;
                }
            }
        }
    }
    
    public class EmulatedScreen {
        public int CurrentPalette {get; set;}
        public int Width {get; set;}
        public int Height {get; set;}
        
        public EmulatedScreen(int palette, int w, int h) {
            this.CurrentPalette = palette;
            this.Width = w;
            this.Height = h;
        }
    }
    
    public class API {
        public int[] Shape {get; set;}
        
        public int[] Triangle(int x1,int y1,int x2,int y2,int x3,int y3) {
            return Shape = new [] {x1,y1,x2,y2,x3,y3};
        }
    }
}
