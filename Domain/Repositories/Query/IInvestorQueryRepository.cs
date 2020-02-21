using Domain.DTOs.Investors.Inputs;
using Domain.DTOs.Investors.Outputs;
using Domain.Util;
using System.Collections.Generic;

namespace Domain.Repositories.Query
{
    public interface IInvestorQueryRepository
    {
        InvestorOutput Get(long id);
        IReadOnlyList<InvestorOutput> Query(InvestorIndexFilterInput filter);
        Pagination<InvestorOutput> Paginate(Pagination<InvestorOutput> pagination);
    }
}
