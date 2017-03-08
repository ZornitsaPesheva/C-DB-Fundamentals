namespace EntityFrameworkRelations
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using Models;
    using Migrations;
    using System.Collections.Generic;


    public class StudentSystemContext : DbContext
    {
        // 2. Seed Some Data in the Database
        public class StudentsSystemlDBInitializer : CreateDatabaseIfNotExists<StudentSystemContext>
        {
            protected override void Seed(StudentSystemContext context)
            {

                Course course = 
                            new Course()
                            {
                                Name = "C#",
                                Description = "some sharp",
                                StartDate = DateTime.Today,
                                EndDate = new DateTime(2017, 2, 3),
                                Price = 2,
                                Homeworks = new List<Homework>()
                                {
                                    new Homework()
                                    {
                                        Content = "C# homework",
                                        Type = ContentType.Application,
                                        SubmissionDate = DateTime.Today,
                                        Student = new Student()
                                        {
                                            Name = "Pesho",
                                            RegDate = DateTime.Today,
                                            Phone = "08869899899"
                                        }
                                    },
                                    new Homework()
                                    {
                                        Content = "java homework",
                                        Type = ContentType.Pdf,
                                        SubmissionDate = DateTime.Today,
                                        Student = new Student()
                                        {
                                            Name = "Stancho",
                                            RegDate = DateTime.Today,
                                            Phone = "08869899899"
                                        }
                                    }
                                 },

                                Students = new List<Student>()
                                 {
                                    new Student()
                                    {
                                        Name = "Ivo",
                                        RegDate = DateTime.Today,
                                        Phone = "08869899899"
                                    } ,
                                     new Student()
                                    {
                                        Name = "Reni",
                                        RegDate = DateTime.Today,
                                        Phone = "08869899899"
                                    }
                                  },
                                Resources = new List<Resource>()
                                  {
                                    new Resource()
                                    {
                                        Name = "rsrc",
                                        Type = ResourceType.Document,
                                        Url = "usadl"
                                    },
                                    new Resource()
                                    {
                                         Name = "redasdas",
                                         Type = ResourceType.Document,
                                         Url = "fsafasf"
                                    }
                                 }
                            };
                context.Courses.Add(course);
                context.SaveChanges();
            }
        }
        public StudentSystemContext()
            : base("name=StudentSystemContext")
        {
            Database.SetInitializer<StudentSystemContext>(
                new MigrateDatabaseToLatestVersion<StudentSystemContext, Configuration>());
        }



        // Add a DbSet for each entity type that you want to include in your model. For more information 
        // on configuring and using a Code First model, see http://go.microsoft.com/fwlink/?LinkId=390109.

        public virtual DbSet<Student> Students { get; set; }
        public virtual DbSet<Course> Courses { get; set; }
        public virtual DbSet<Resource> Resourses { get; set; }
        public virtual DbSet<Homework> Homeworks { get; set; }
    }

    //public class MyEntity
    //{
    //    public int Id { get; set; }
    //    public string Name { get; set; }
    //}
}