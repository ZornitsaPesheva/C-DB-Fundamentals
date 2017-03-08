// 1. Code First Student System
namespace EntityFrameworkRelations.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
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
        public string Url { get; set; }

        public virtual Course Course { get; set; }
    }
}
