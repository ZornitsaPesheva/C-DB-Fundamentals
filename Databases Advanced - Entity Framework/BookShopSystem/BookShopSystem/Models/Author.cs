﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BookShopSystem.Data
{
    public class Author
    {
        private ICollection<Book> books;
        public Author()
        {
            this.books = new HashSet<Book>();
        }
        public int Id { get; set; }
        public string FirstName { get; set; }

        [Required]
        public string LastName{ get; set; }
        public virtual ICollection<Book> Books
        {
            get
            {
                return this.books;
            }
            set
            {
                this.books = value;
            }
        }
    }
}
