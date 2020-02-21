using Domain.Repositories.Command;

namespace Domain.Unities
{
    public interface IUnitOfEnterprises : IUnitOfWork
    {
        public IEnterpriseRepository Enterprises { get; }
        public IInvestorRepository Investors { get; }
        public IEnterpriseTypeRepository Types { get; }
    }
}
