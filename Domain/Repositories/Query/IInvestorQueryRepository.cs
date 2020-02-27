using Domain.DTOs.Investors.Inputs;
using Domain.DTOs.Investors.Outputs;
using System.Threading.Tasks;

namespace Domain.Repositories.Query
{
    public interface IInvestorQueryRepository
    {
        Task<InvestorOutput> GetAsync(long id);
        Task<InvestorPagination> Query(InvestorPagination pagination);
    }
}
