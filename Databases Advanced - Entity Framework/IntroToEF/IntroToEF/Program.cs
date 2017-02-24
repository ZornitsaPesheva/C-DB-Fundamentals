using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IntroToEF
{
    class Program
    {
        static void Main(string[] args)
        {
            SoftuniContext context = new SoftuniContext();

            Console.WriteLine("Select an option:");
            Console.WriteLine("3. Employees full information");
            Console.WriteLine("4. Employees with Salary Over 50 000");
            Console.WriteLine("5. Employees from Seattle");
            Console.WriteLine();
            Console.Write("Enter your choise: ");
            int input = int.Parse(Console.ReadLine());

            switch (input)
            {
                case 3: EmployeeFullInfo(context); break;
                case 4: EmployeeWithSalaryOver50000(context); break;
                case 5: EmployeesFromSeattle(context); break;
                default: break;
            }
        }

        private static void EmployeesFromSeattle(SoftuniContext context)
        {
            List<Employee> emloyees = context.Employees
                .Where(e => e.Department.Name == "Research and Development")
                .OrderBy(e => e.Salary)
                .ThenByDescending(e => e.FirstName)
                .ToList();


            foreach (Employee e in emloyees)
            {
                Console.WriteLine($"{e.FirstName} " +
                    $"{e.LastName} from {e.Department.Name}" +
                    $" - ${e.Salary:f2}");
            }
        }

        private static void EmployeeWithSalaryOver50000(SoftuniContext context)
        {
            List<String> emloyeeNames = context.Employees
                            .Where(e => e.Salary > 50000)
                            .Select(e => e.FirstName).ToList();

            foreach (string name in emloyeeNames)
            {
                Console.WriteLine(name);
            }
        }

        private static void EmployeeFullInfo(SoftuniContext context)
        {
            List<Employee> emloyees = context.Employees.ToList();

            foreach (Employee e in emloyees)
            {
                Console.WriteLine($"{e.FirstName} {e.LastName} {e.MiddleName} {e.JobTitle} {e.Salary:f4}");
            }
        }
    }
}
