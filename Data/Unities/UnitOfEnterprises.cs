using Data.Context;
using Domain.Repositories.Command;
using Domain.Unities;

namespace Data.Unities
{
    public class UnitOfEnterprises : UnitOfWork, IUnitOfEnterprises
    {
        /// <summary>
        /// Construtor de Unidade de trabalho, injetada com os Contextos.
        /// </summary>
        /// <param name="context"/>
        public UnitOfEnterprises(
            EnterpriseContext context,
            IEnterpriseRepository enterprises,
            IInvestorRepository investors,
            IEnterpriseTypeRepository types) : base(context)
        {
            Enterprises = enterprises;
            Investors = investors;
            Types = types;
        }

        public IEnterpriseRepository Enterprises { get; }
        public IInvestorRepository Investors { get; }
        public IEnterpriseTypeRepository Types { get; }
    }
}
