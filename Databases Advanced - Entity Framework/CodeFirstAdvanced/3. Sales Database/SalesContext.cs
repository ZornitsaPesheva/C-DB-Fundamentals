namespace _3.Sales_Database
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using Models;
    using Migrations;

    public class SalesContext : DbContext
    {
     public SalesContext()
            : base("name=SalesContext")
        {
            Database.SetInitializer<SalesContext>(
                new MigrateDatabaseToLatestVersion<SalesContext, Configuration>());
        }


        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<Sale> Sales { get; set; }
        public virtual DbSet<Customer> Customers { get; set; }
        public virtual DbSet<StoreLocation> Locations { get; set; }

    }

    //public class MyEntity
    //{
    //    public int Id { get; set; }
    //    public string Name { get; set; }
    //}
}