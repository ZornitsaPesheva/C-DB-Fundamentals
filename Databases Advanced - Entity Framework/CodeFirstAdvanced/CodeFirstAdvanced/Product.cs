using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CodeFirstAdvanced
{
    public class Product
    {
        public Product()
        {

        }
        public Product(string name, string distributor, 
            string description, decimal price)
        {
            this.Name = name;
            this.Distributor = distributor;
            this.Description = description;
            this.Price = price;
        }
        public int Id { get; set; }
        public string Name { get; set; }
        public string Distributor { get; set; }
        public string Description { get; set; }
        public double Weight { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
    }
}
