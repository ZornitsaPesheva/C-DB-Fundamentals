using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Gringotts.Models
{
    public class WizardDeposits
    {
        private string firstName;
        private string lastName;
        private string notes;
        private int age;
        private string magicWandCreator;
        private int magicWandSize;
        private string depositGroup;

        public int Id { get; set; }
        public string FirstName
        {
            get
            {
                return this.firstName;
            }
            set
            {
                this.ValidateStringLength(value, 50);
                this.firstName = value;
            }
        }
        [Required]
        public string LastName
        {
            get
            {
                return this.lastName;
            }
            set
            {
                this.ValidateStringLength(value, 60);
                this.lastName = value;
            }
        }
        public string Notes
        {
            get
            {
                return this.notes;
            }
            set
            {
                this.ValidateStringLength(value, 1000);
                this.notes = value;
            }
        }
        public int Age
        {
            get
            {
                return this.age;
            }
            set
            {
                if (value < 0) throw new
                        ArgumentOutOfRangeException(
                    "Age cannot be negative");
                this.age = value;
            }
        }
        
        public string MagicWandCreator
        {
            get
            {
                return this.magicWandCreator;
            }
            set
            {
                this.ValidateStringLength(value, 100);
                this.magicWandCreator = value;
            }
        }
        public int MagicWandSize
        {
            get
            {
                return this.magicWandSize;
            }
            set
            {
                if (value < 1)
                {
                    throw new ArgumentOutOfRangeException(
                        "Wand size cannot be less than 1");
                    this.magicWandSize = value;
                }
            }
        }
        public string DepositGroup
        {
            get
            {
                return this.depositGroup;
            }
            set
            {
                this.ValidateStringLength(value, 20);
                this.depositGroup = value;
            }
        }
        public DateTime? DepositStartDate { get; set; }
        public decimal DepositAmount { get; set; }
        public decimal DepositInterest { get; set; }
        public double DepositCharge { get; set; }
        public DateTime? DepositExpirationDate { get; set; }
        public bool IsDepositExpired { get; set; }

        private void ValidateStringLength(string value, int max)
        {
            if (value.Length > max)
                throw new ArgumentOutOfRangeException
                    ($"Input value exceeds max length ({max})");
        }
    }
}
