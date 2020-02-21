using Domain.ComplexTypes;
using System.Collections.Generic;
using System.Linq;

namespace Domain.Entities
{
    public class Enterprise : BaseEntity
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public decimal Value { get; set; }
        public string Country { get; set; }
        public string City { get; set; }
        public string Linkedin { get; set; }
        public string Twitter { get; set; }
        public string Facebook { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Photo { get; set; }
        public decimal Shares { get; set; }
        public decimal SharePrice { get; set; }
        public long OwnShares { get; set; }
        public bool OwnEnterprise { get; set; }

        public int EnterpriseTypeId { get; set; }
        public virtual EnterpriseType EnterpriseType { get; set; } = null;
        public virtual Investor Owner { get; set; } = null;

        public virtual ICollection<InvestorEnterprise> InvestorsEnterprises { get; set; } = new List<InvestorEnterprise>();
        public virtual List<Investor> Investors => InvestorsEnterprises?.Select(ie => ie.Investor).ToList() ?? new List<Investor>();

        public Enterprise UpdateEmail(Email email)
        {
            Email = email.Address;

            return this;
        }
    }
}
