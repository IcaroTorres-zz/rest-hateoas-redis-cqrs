using Domain.DTOs.Enterprises.Inputs;
using Domain.DTOs.Enterprises.Outputs;
using Domain.Util;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Domain.Repositories.Query
{
    public interface IEnterpriseQueryRepository
    {
        Task<EnterpriseOutput> Get(long id);
        Task<IReadOnlyList<EnterpriseOutput>> Query(EnterpriseIndexFilterInput filter);
        Pagination<EnterpriseOutput> Paginate(Pagination<EnterpriseOutput> pagination);
    }
}
