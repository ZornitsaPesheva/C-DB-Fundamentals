using BookShopSystem.Data;
using BookShopSystem.Migrations;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BookShopSystem
{
    class Program
    {
        static void Main(string[] args)
        {
            var context = new BookShopContext();
            var migrationStrategy = new MigrateDatabaseToLatestVersion<BookShopContext, Configuration>();
            Database.SetInitializer(migrationStrategy);
            context.Database.Initialize(true);
        }
    }
}
