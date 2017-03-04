﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CodeFirstOOP
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Choose an option: ");
            Console.WriteLine("------------------");
            Console.WriteLine("1. Define a class Person");
            Console.WriteLine(" (Create and Print Gosho, Pesho and Stamat)");
            Console.WriteLine("2. Create Person Constructors");
            Console.WriteLine("3. Oldest Family Member");
            Console.WriteLine("4. Students");
            Console.WriteLine("5. Planck Constant");
            Console.WriteLine();
            Console.Write("Your choise is: ");
            int option = 0;

            try
            {
                option = int.Parse(Console.ReadLine());
            }
            catch
            {
                Console.WriteLine("You need to enter a number.");
            }

            switch (option)
            {
                case 1: CreatePersons(); break;
                case 2: CreateConstructors(); break;
                case 3: OldestFamilyMember(); break;
                case 4: Students(); break;
                case 5: PlanckConstant(); break;
                default: break;
            }
            
        }

        private static void PlanckConstant()
        {
            Console.WriteLine(Calculation.Result());
        }

        private static void Students()
        {
            Console.WriteLine("Enter the student names one by row:");
            Console.WriteLine("For end type 'end'");
            string input = Console.ReadLine();
            while (input != "end")
            {
                Student st = new Student(input);
                input = Console.ReadLine();
            }
            Console.WriteLine(Student.count);
        }

        private static void OldestFamilyMember()
        {
            Family f = new Family();
            Console.Write("Number of persons: ");
            int count = int.Parse(Console.ReadLine());
            Console.WriteLine("Enter the input (Example: Gosho 23): ");
            for (int i = 1; i <= count; i++)
            {
                string[] inputArgs =
                Console.ReadLine().Split(new char[] { ' ' },
                StringSplitOptions.RemoveEmptyEntries);
                Person p = new Person(inputArgs[0], 
                    int.Parse(inputArgs[1]));
                f.AddMember(p);
            }
            Console.WriteLine($"{f.GetOldestPerson().Name} " +
                $"{f.GetOldestPerson().Age}");
        }

        private static void CreateConstructors()
        {
            Console.Write("Input: ");
            string[] inputArgs =
                Console.ReadLine().Split(new char[] { ',' },
                StringSplitOptions.RemoveEmptyEntries);

            if (inputArgs.Length == 0)
            {
                Person p = new Person();
                Console.WriteLine($"{p.Name} {p.Age}");

            }
            else if (inputArgs.Length == 1)
            {
                string argument = inputArgs[0];
                int age = -1;
                if (int.TryParse(argument, out age))
                {
                    Person p = new Person(age);
                    Console.WriteLine($"{p.Name} {p.Age}");
                }
                else
                {
                    Person p = new Person(argument);
                    Console.WriteLine($"{p.Name} {p.Age}");
                }
            }
            else if (inputArgs.Length == 2)
            {
                string name = inputArgs[0];
                int age = int.Parse(inputArgs[1]);
                Person p = new Person(name, age);
                Console.WriteLine($"{p.Name} {p.Age}");
            }

        }

        private static void CreatePersons()
        {
            Person pesho = new Person()
            {
                name = "Pesho",
                age = 20
            };

            Person gosho = new Person("Gosho", 18);

            Person stamat = new Person()
            {
                name = "Stamat",
                age = 43
            };

            Console.WriteLine($"{pesho.name} {pesho.age}");
            Console.WriteLine($"{gosho.Name} {gosho.Age}");
            Console.WriteLine($"{stamat.name} {stamat.age}");
        }
    }
}