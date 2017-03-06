using _3.Sales_Database.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _3.Sales_Database
{
    class Program
    {
        static void Main(string[] args)
        {
            SalesContext context = new SalesContext();

            Product p = new Product();
            p.Name = "Product";
            p.Description = "Description";
            context.Products.Add(p);

            Console.WriteLine(context.Products.First().Name);
            context.SaveChanges();

            //Product car = new Product();
            //car.Name = "Car";
            //car.Price = 2000m;
            //car.Quantity = 10;

            //Product truck = new Product();
            //car.Name = "Truck";
            //car.Price = 2000m;
            //car.Quantity = 8;

            //Product motorcycle = new Product();
            //car.Name = "Motorcycle";
            //car.Price = 2000m;
            //car.Quantity = 8;

            //Customer pesho = new Customer();
            //pesho.Name = "Pesho";
            //pesho.CreditCardNumber = "sdsdfwetrer46d";

            //Customer mitko = new Customer();
            //mitko.Name = "Mitko";
            //mitko.CreditCardNumber = "sdsdfwetrer46d";

            //Customer georgi = new Customer();
            //georgi.Name = "Georgi";
            //georgi.CreditCardNumber = "dfggrftyh6678";

            //StoreLocation sofia = new StoreLocation();
            //sofia.LocationName = "Gr. Sofia";

            //StoreLocation plovdiv = new StoreLocation();
            //plovdiv.LocationName = "Gr. Plovdiv";

            //Sale carSale = new Sale();
            //carSale.Product = car;
            //carSale.Customer = mitko;
            //carSale.StoreLocation = sofia;
            //carSale.Date = DateTime.Now;

            //Sale motorcycleSale = new Sale();
            //motorcycleSale.Product = motorcycle;
            //motorcycleSale.Customer = georgi;
            //motorcycleSale.StoreLocation = sofia;
            //motorcycleSale.Date = DateTime.Now;

            //Sale truckSale = new Sale();
            //truckSale.Product = truck;
            //truckSale.Customer = pesho;
            //truckSale.StoreLocation = plovdiv;
            //truckSale.Date = DateTime.Now;

        
            //context.Sales.Add(carSale);
            //context.Sales.Add(motorcycleSale);
            //context.Sales.Add(truckSale);

            //context.SaveChanges();

        }
    }
}
