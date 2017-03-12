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

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Book>()
                .HasMany(b => b.RelatedBooks)
                .WithMany()
                .Map(m =>
                {
                    m.MapLeftKey("RelatedBooks");
                    m.MapRightKey("Id");
                    m.ToTable("RelatedBooks");
                });
            base.OnModelCreating(modelBuilder);
        }
    }

   }