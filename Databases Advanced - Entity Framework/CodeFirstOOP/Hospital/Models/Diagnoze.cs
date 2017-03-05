using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hospital.Models
{
    public class Diagnose
    {
        public Diagnose()
        {
            this.Patients = new List<Patient>();
        }
        public int Id { get; set; }

        [StringLength(60)]
        [Required]
        public string Name { get; set; }

        [StringLength(200)]
        public string Comment { get; set; }

        public virtual List<Patient> Patients { get; set; }

    }
}
