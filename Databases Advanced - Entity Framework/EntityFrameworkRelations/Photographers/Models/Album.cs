// 6. Albums
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Photographers.Models
{
    public class Album
    {
        public Album()
        {
            this.pictures = new List<Picture>();
        }
        public int Id { get; set; }
        public string Name { get; set; }
        public string BackgroundColor { get; set; }
        public bool IsPublic { get; set; }
        public virtual List<Picture> pictures { get; set; }
        public virtual Photographer Owner { get; set; }
        public int OwnerId { get; set; }
    }
}
