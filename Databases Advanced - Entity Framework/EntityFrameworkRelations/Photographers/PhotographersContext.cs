namespace Photographers
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using Models;
    using Migrations;

    public class PhotographersContext : DbContext
    {
               public PhotographersContext()
            : base("name=PhotographersContext")
        {
            Database.SetInitializer(new MigrateDatabaseToLatestVersion<PhotographersContext, Configuration>());
        }

         public virtual DbSet<Photographer> Photographers { get; set; }
         public virtual DbSet<Album> Albums { get; set; }
         public virtual DbSet<Picture> Pictures { get; set; }

    }

    //public class MyEntity
    //{
    //    public int Id { get; set; }
    //    public string Name { get; set; }
    //}
}