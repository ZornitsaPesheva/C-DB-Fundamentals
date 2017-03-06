namespace _3.Sales_Database.Migrations
{
    using Models;
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<_3.Sales_Database.SalesContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
            ContextKey = "_3.Sales_Database.SalesContext";
        }

        protected override void Seed(_3.Sales_Database.SalesContext context)
        {
            context.Products.AddOrUpdate(new Product()
            { Name = "Car", Description = "Vehicle" });
            context.Products.AddOrUpdate(new Product()
            { Name = "Motorcycle", Description = "Vehicle" });
            context.Products.AddOrUpdate(new Product()
            { Name = "Truck", Description = "Vehicle" });

            context.Customers.AddOrUpdate(new Customer()
            { FirstName = "Teo", LastName = "Todorov" });
            context.Customers.AddOrUpdate(new Customer()
            { FirstName = "Mitko", LastName = "Todorov" });
            context.Customers.AddOrUpdate(new Customer()
            { FirstName = "Alex", LastName = "Todorov" });
        }
    }
}
