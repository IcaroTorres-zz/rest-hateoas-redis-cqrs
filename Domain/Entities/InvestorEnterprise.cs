namespace Domain.Entities
{
    public class InvestorEnterprise
    {
        public long InvestorId { get; set; }
        public long EnterpriseId { get; set; }

        public virtual Investor Investor { get; set; }
        public virtual Enterprise Enterprise { get; set; }
    }
}
