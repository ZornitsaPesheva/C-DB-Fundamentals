using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntityFrameworkRelations.Models
{
    public class Course
    {
        public Course()
        {
            this.Students = new HashSet<Student>();
            this.Resourses = new HashSet<Resource>();
            this.Homeworks = new HashSet<Homework>();
        }
        public int Id { get; set; }

        [Required]
        [MaxLength(265)]
        public string Name { get; set; }
        public string Description { get; set; }

        [Required]
        public DateTime StartDate { get; set; }

        [Required]
        public DateTime EndDate { get; set; }

        [Required]
        public decimal Price { get; set; }

        public virtual ICollection<Student> Students { get; set; }
        public virtual ICollection<Resource> Resourses { get; set; }
        public virtual ICollection<Homework> Homeworks { get; set; }
    }
}
