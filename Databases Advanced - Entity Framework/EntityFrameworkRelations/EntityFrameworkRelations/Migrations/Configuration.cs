namespace EntityFrameworkRelations.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;
    using Models;
    using System.Collections.Generic;

    internal sealed class Configuration : DbMigrationsConfiguration<EntityFrameworkRelations.StudentSystemContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(EntityFrameworkRelations.StudentSystemContext context)
        {
            context.Courses.AddOrUpdate(course => course.Name,
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
                                          //  Birthday = new 
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
                            });
        }
    }
}
