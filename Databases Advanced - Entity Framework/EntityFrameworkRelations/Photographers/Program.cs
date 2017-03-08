using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Photographers
{
    class Program
    {
        static void Main(string[] args)
        {
            PhotographersContext context =
                new PhotographersContext();
            Console.WriteLine(context.Photographers.Count());
        }
    }
}
