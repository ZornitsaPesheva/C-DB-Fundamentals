using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BookShopSystem.Data
{
    public enum EditionType
    {
        Normal,
        Promo,
        Gold
    }

    public enum AgeRestriction
    {
        Minor,
        Teen,
        Adult
    }
    public class Book
    {
        private ICollection<Category>categories;
        public Book()
        {
            this.Categories = new HashSet<Category>();
            this.RelatedBooks = new HashSet<Book>();
        }
        public int Id { get; set; }

        [Required]
        [MinLength(1)]
        [MaxLength(50)]
        public string Title { get; set; }

        [MaxLength(1000)]
        public string Description { get; set; }

        [Required]
        public EditionType Edition { get; set; }

        [Required]
        public AgeRestriction AgeRestriction { get; set; }

        [Required]
        public decimal Price { get; set; }

        [Required]
        public int Copies { get; set; }

        public DateTime? ReleaseDate { get; set; }

        public virtual ICollection<Category> Categories
        {
            get
            {
                return this.categories;
            }
            set
            {
                this.categories= value;
            }
        }

        [Required]
        public virtual Author Author { get; set; }

        [ForeignKey("Author")]
        public int AuthorId { get; set; }
        public virtual ICollection<Book> RelatedBooks { get; set; }


    }
}
