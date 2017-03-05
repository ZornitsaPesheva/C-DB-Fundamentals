namespace CreateUser
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using CreateUser;

    public class UsersContext : DbContext
    {
        // Your context has been configured to use a 'UsersContext' connection string from your application's 
        // configuration file (App.config or Web.config). By default, this connection string targets the 
        // 'CreateUser.UsersContext' database on your LocalDb instance. 
        // 
        // If you wish to target a different database and/or database provider, modify the 'UsersContext' 
        // connection string in the application configuration file.
        public UsersContext()
            : base("name=UsersContext")
        {
        }

         public virtual DbSet<Users> Users { get; set; }
    }

    //public class MyEntity
    //{
    //    public int Id { get; set; }
    //    public string Name { get; set; }
    //}
}