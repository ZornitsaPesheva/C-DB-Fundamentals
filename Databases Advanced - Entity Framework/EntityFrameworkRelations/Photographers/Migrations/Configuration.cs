namespace Photographers.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;
    using Models;

    internal sealed class Configuration : DbMigrationsConfiguration<Photographers.PhotographersContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(Photographers.PhotographersContext context)
        {
            Photographer teo = new Photographer
            {
                Username = "Teo",
                Password = "sdfasdgdfg",
                Email = "teo@softuni.bg",
                BirthDate = DateTime.Now,
                RegisterDate = DateTime.Now.AddDays(-20)  
            };
            context.Photographers
                .AddOrUpdate(p => p.Username, teo);
            context.SaveChanges();

            Picture demoPicture = new Picture()
            {
                Title = "Demo",
                Caption = "Demo",
                FileSystemPath = "/public/imags/demo.png"
            };

            context.Pictures.Add(demoPicture);

            Album vitosha = new Album()
            {
                Name = "Vitosha",
                BackgroundColor = "Blue",
                IsPublic = true,
                OwnerId = teo.Id
            };

            context.Albums.AddOrUpdate(a => a.Name, vitosha);
            context.SaveChanges();

            vitosha.pictures.Add(demoPicture);
            context.SaveChanges();
        }
    }
}
