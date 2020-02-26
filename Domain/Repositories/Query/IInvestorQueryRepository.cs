using Domain.DTOs.Investors.Inputs;
using Domain.DTOs.Investors.Outputs;
using Domain.Util;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Domain.Repositories.Query
{
    public interface IInvestorQueryRepository
    {
        Task<InvestorOutput> GetAsync(long id);
        Task<IReadOnlyList<InvestorOutput>> Query(InvestorIndexFilterInput filter);
        Pagination<InvestorOutput> Paginate(Pagination<InvestorOutput> pagination);
    }
}
