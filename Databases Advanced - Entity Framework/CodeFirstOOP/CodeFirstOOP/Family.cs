

namespace CodeFirstOOP
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    class Family
    {
        private List<Person> members;

        public Family()
        {
            members = new List<Person>();
        }

        public void AddMember(Person member)
        {
            members.Add(member);
        }

        public List<Person> Members
        {
            get
            {
                return members;
            }
        }

        public Person GetOldestPerson()
        {
            return this.members
                .OrderByDescending(m => m.Age)
                .FirstOrDefault();
        }
    }
}
