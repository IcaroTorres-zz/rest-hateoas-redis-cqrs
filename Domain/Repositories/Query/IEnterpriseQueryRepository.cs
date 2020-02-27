using Domain.DTOs.Enterprises.Inputs;
using Domain.DTOs.Enterprises.Outputs;
using System.Threading.Tasks;

namespace Domain.Repositories.Query
{
    public interface IEnterpriseQueryRepository
    {
        Task<EnterpriseOutput> Get(long id);
        Task<EnterprisePagination> Query(EnterprisePagination pagination);
    }
}
