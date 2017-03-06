namespace CodeFirstAdvanced
{
    using System;
    using System.Data.Entity;
    using System.Linq;

    public class ProductContext : DbContext
    {
        // Your context has been configured to use a 'ProductContext' connection string from your application's 
        // configuration file (App.config or Web.config). By default, this connection string targets the 
        // 'CodeFirstAdvanced.ProductContext' database on your LocalDb instance. 
        // 
        // If you wish to target a different database and/or database provider, modify the 'ProductContext' 
        // connection string in the application configuration file.
        public ProductContext()
            : base("name=ProductContext")
        {
        }


         public virtual DbSet<Product> Products { get; set; }
    }

    //public class MyEntity
    //{
    //    public int Id { get; set; }
    //    public string Name { get; set; }
    //}
}