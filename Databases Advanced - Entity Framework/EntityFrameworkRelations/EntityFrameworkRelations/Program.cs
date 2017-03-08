using EntityFrameworkRelations.Models;
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
            // 3. Worknig with the Database
            Console.WriteLine("3. Worknig with the Database:");
            Console.WriteLine("3.0. Add some data.");
            Console.WriteLine("3.1. All students ad their homeworks.");
            Console.WriteLine("3.2. All cources and resources.");
            Console.WriteLine("3.3. All cources with more than 5 resources");
            var option = int.Parse(Console.ReadLine());
            switch (option)
            {
                case 0: AddData(context); break;
                case 1: ListStudentsandHomeworks(context); break;
                case 2: AllCoursesWithREsources(context); break;
                case 3: CourcesWithMoreThan5Resources(context); break;
                default:
                    break;
            }

            

        }

        private static void CourcesWithMoreThan5Resources(StudentSystemContext context)
        {
            var courses = context.Courses
                            .Where(c => c.Resources.Count() > 5)
                            .OrderByDescending(c => c.Resources.Count)
                            .ThenByDescending(c => c.StartDate)
                            .ToList();

            foreach (var c in courses)
            {
                Console.WriteLine($"{c.Name}: " +
                    $"{c.Resources.Count} resources");
            }
        }

        private static void AddData(StudentSystemContext context)
        {
            Course course = new Course()
            {
                Name = "Course with 7 resources",
                Description = "Introductio to programming 2",
                StartDate = new DateTime(2016, 6, 6),
                EndDate = new DateTime(2016, 8, 8),
                Price = 0,
                Homeworks = new List<Homework>()
                {
                   new Homework()
                   {
                       Content = "1st homework6",
                       Type = ContentType.Application,
                       SubmissionDate = DateTime.Today,
                       Student = new Student()
                       {
                           Name = "Gosho6",
                           RegDate = DateTime.Today,
                           Phone = "08869899899"
                        }
                     },
                     new Homework()
                     {
                         Content = "1st homework6",
                         Type = ContentType.Pdf,
                         SubmissionDate = DateTime.Today,
                         Student = new Student()
                         {
                             Name = "Koko6",
                             RegDate = DateTime.Today,
                             Phone = "08869899899"
                          }
                       }
                   },//homeworks
                Students = new List<Student>()
                {
                   new Student()
                   {
                       Name = "Ani6",
                       RegDate = DateTime.Today,
                       Phone = "08869899899"
                    },
                    new Student()
                    {
                        Name = "Mimi6",
                        RegDate = DateTime.Today,
                        Phone = "08869899899"
                    }
                }, //students
                Resources = new List<Resource>()
                {
                    new Resource()
                    {
                        Name = "resource 1",
                        Type = ResourceType.Document,
                        Url = "http://softuni.bg"
                     },
                     new Resource()
                     {
                         Name = "resource 2",
                         Type = ResourceType.Document,
                         Url = "http://softuni.bg"
                     },
                     new Resource()
                     {
                         Name = "resource 3",
                         Type = ResourceType.Document,
                         Url = "http://softuni.bg"
                     },
                     new Resource()
                     {
                         Name = "resource 4",
                         Type = ResourceType.Document,
                         Url = "http://softuni.bg"
                     },
                     new Resource()
                     {
                         Name = "resource 5",
                         Type = ResourceType.Document,
                         Url = "http://softuni.bg"
                     },
                     new Resource()
                     {
                         Name = "resource 6",
                         Type = ResourceType.Document,
                         Url = "http://softuni.bg"
                     },
                     new Resource()
                     {
                         Name = "resource 7",
                         Type = ResourceType.Document,
                         Url = "http://softuni.bg"
                     }
                 }
            };

            context.Courses.Add(course);
            context.SaveChanges();
        }


        private static void AllCoursesWithREsources(StudentSystemContext context)
        {
            var courses = context.Courses
                .OrderBy(c => c.StartDate)
                .ToList();
            foreach (var c in courses)
            {
                Console.WriteLine($"{c.Name} - " +
                    $"{c.Description}");
                foreach (var r in c.Resources)
                {
                    Console.WriteLine($"{r.Id}. " +
                        $"{r.Name} - {r.Type}: " +
                        $"{r.Url}");
                }
                Console.WriteLine();
            }
        }

        private static void ListStudentsandHomeworks(StudentSystemContext context)
        {
            var students = context.Students.ToList();
            foreach (var s in students)
            {
                Console.WriteLine($"{s.Name}: ");
                foreach (var h in s.Homeworks)
                {
                    Console.WriteLine($"{h.Content} " +
                        $"- {h.Type}");

                }
                Console.WriteLine();
            }
        }
    }
}
