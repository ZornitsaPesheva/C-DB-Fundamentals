using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hospital.Models
{
    public class Visitation
    {
        public int Id { get; set; }

        [Required]
        public DateTime Date { get; set; }

        [StringLength(200)]
        public string Comment { get; set; }
    }
}
