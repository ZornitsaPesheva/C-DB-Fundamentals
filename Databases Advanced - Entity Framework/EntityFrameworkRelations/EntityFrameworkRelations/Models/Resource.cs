using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntityFrameworkRelations.Models
{
    public enum ResourceType
    {
        Video, Presentation, Document, Other
    }

    public class Resource
    {
        public int Id { get; set; }

        [Required]
        [MaxLength(265)]
        public string Name { get; set; }

        [Required]
        public ResourceType Type { get; set; }

        [Required]
        public string URL { get; set; }

        public virtual Course Course { get; set; }
    }
}
