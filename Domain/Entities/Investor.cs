using Domain.ComplexTypes;
using System.Collections.Generic;
using System.Linq;

namespace Domain.Entities
{
    public class Investor : BaseEntity
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
        public string Photo { get; set; }
        public decimal Balance { get; set; }
        public bool? FirstAccess { get; protected set; } = true;
        public bool SuperAngel { get; set; }
        public decimal PortfolioValue { get; set; }

        public long? EnterpriseId { get; set; }
        public virtual Enterprise Enterprise { get; set; }

        public virtual ICollection<InvestorEnterprise> InvestorsEnterprises { get; set; } = new List<InvestorEnterprise>();
        public virtual List<Enterprise> Enterprises => InvestorsEnterprises.Select(ie => ie.Enterprise).ToList();


        public Investor UpdateLocation(Location location)
        {
            City = location.City;
            Country = location.Country;

            return this;
        }

        public Investor UpdateEmail(Email email)
        {
            Email = email.Address;

            return this;
        }

        public Investor UpdatePortfolioValue()
        {
            PortfolioValue = Enterprises.Sum(e => e.Value);

            return this;
        }

        public Investor UpdateAccessAfterLogin()
        {
            FirstAccess = false;

            return this;
        }
    }
}
