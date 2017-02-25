using System;
using System.Collections.Generic;
using System.Globalization;
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
            Console.WriteLine("6. Adding a New Address and Updating Employee");
            Console.WriteLine("7. Find employees in period");
            Console.WriteLine("8. Addresses by town name");
            Console.WriteLine("9. Employee with id 147");
            Console.WriteLine("10. Departments with more than 5 employees");
            Console.WriteLine();
            Console.Write("Enter your choise: ");
            int input = int.Parse(Console.ReadLine());

            switch (input)
            {
                case 3: EmployeeFullInfo(context); break;
                case 4: EmployeeWithSalaryOver50000(context); break;
                case 5: EmployeesFromSeattle(context); break;
                case 6: AddingNewAddress(context); break;
                case 7: FindEmployeesInPeriod(context); break;
                case 8: AddressByTownName(context); break;
                case 9: EmployeeWithId147(context); break;
                case 10: DepartmentsWithMoreThan5Employees(context); break;
                default: break;
            }

            
        }

        private static void DepartmentsWithMoreThan5Employees(SoftuniContext context)
        {
            List<Department> deps = context.Departments
                .Where(d => d.Employees.Count > 5)
                .OrderBy(d => d.Employees.Count)
                .ToList();

            foreach (Department d in deps)
            {
                Console.WriteLine($"{d.Name} " +
                $"{d.Manager.FirstName}");

                foreach (Employee e in d.Employees)
                {
                    Console.WriteLine($"{e.FirstName} " +
                        $"{e.LastName} {e.JobTitle}");
                }
            }
        }

        private static void EmployeeWithId147(SoftuniContext context)
        {
            Employee emp = context.Employees
                .Where(e => e.EmployeeID == 147)
                .FirstOrDefault();

            Console.WriteLine($"{emp.FirstName} " +
                $"{emp.LastName} {emp.JobTitle}");

            List<Project> projects = new List<Project>();
            foreach (Project p in emp.Projects)
            {
                projects.Add(p);
            }
            var projs = projects.OrderBy(p => p.Name);

            foreach (Project p in projs)
            {
                Console.WriteLine(p.Name);
            }
        }

        private static void AddressByTownName(SoftuniContext context)
        {
            List<Address> addresses = context.Addresses
                            .OrderByDescending(a => a.Employees.Count)
                            .ThenBy(a => a.Town.Name)
                            .Take(10)
                            .ToList();

            foreach (Address a in addresses)
            {
                Console.WriteLine($"{a.AddressText}, " +
                    $"{a.Town.Name} - " +
                    $"{a.Employees.Count} employees");
            }
        }

        private static void FindEmployeesInPeriod(SoftuniContext context)
        {
            List<Employee> employees = context.Employees
                            .Where(e => e.Projects.Count(p => p.StartDate.Year >= 2001 && p.StartDate.Year <= 2003) > 0)
                            .Take(30).ToList();

            foreach (Employee e in employees)
            {
                Console.WriteLine($"{e.FirstName} {e.LastName} " +
                    $"{e.Manager.FirstName}");
                foreach (Project p in e.Projects)
                {
                    Console.WriteLine($"--{p.Name} " +
                        $"{p.StartDate} " +
                        $"{p.EndDate}");

                }
            }
        }

        private static void AddingNewAddress(SoftuniContext context)
        {
            Address addr = new Address()
            {
                AddressText = "Vitoshka 15",
                TownID = 4
            };

            Employee employee = null;
            employee = context.Employees
                .Where(e => e.LastName == "Nakov")
                .FirstOrDefault();

            employee.Address = addr;

            context.SaveChanges();

            List<string> employeesAddr = context.Employees
                .OrderByDescending(e => e.AddressID)
                .Take(10)
                .Select(e => e.Address.AddressText)
                .ToList();

            foreach (string ea in employeesAddr)
            {
                Console.WriteLine(ea);
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
