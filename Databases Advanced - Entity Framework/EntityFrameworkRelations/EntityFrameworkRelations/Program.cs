using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntityFrameworkRelations
{
    class Program
    {
        static void Main(string[] args)
        {
            StudentSystemContext context = new StudentSystemContext();
            context.Database.Initialize(true);
        }
    }
}
