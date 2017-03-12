namespace BookShopSystem.Data
{
    using Migrations;
    using System;
    using System.Data.Entity;
    using System.Linq;


    public class BookShopContext : DbContext
    {
      public BookShopContext()
            : base("name=BookShopContext")
        {
            //Database.SetInitializer<BookShopContext>(
            //   new MigrateDatabaseToLatestVersion<BookShopContext, Configuration>());
        }

        public virtual DbSet<Book> Books { get; set; }
        public virtual DbSet<Author> Authors { get; set; }
        public virtual DbSet<Category> Categories { get; set; }
    }

   }