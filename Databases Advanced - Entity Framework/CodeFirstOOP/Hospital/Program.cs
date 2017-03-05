using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Hospital;
using Hospital.Models;

namespace Hospital
{
    class Program
    {
        static void Main(string[] args)
        {
            var context = new HospitalContext();

            using (context)
            {
                context.Database.Initialize(true);

                Diagnose d = new Diagnose()
                {
                    Name = "flu",
                    Comment = "pravi se na bolen"
                };

                Patient p = new Patient()
                {
                    FirstName = "Petar",
                    LastName = "Petrov",
                    Address = "Sofia",
                    BirthDate = new DateTime(1989, 10, 9),
                    Email = "petar@sdf.bg",
                    HasInsurance = true
                };
                context.Patients.Add(p);
                p.Diagnoses.Add(d);
                context.SaveChanges();
    
            }
        }
    }
}
