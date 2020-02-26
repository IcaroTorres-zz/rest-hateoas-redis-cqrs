using Domain.DTOs.EnterpriseTypes.Inputs;
using Domain.DTOs.EnterpriseTypes.Outputs;
using Domain.Util;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Domain.Repositories.Query
{
    public interface IEnterpriseTypeQueryRepository
    {
        Task<EnterpriseTypeOutput> Get(int id);
        Task<IReadOnlyList<EnterpriseTypeOutput>> Query(EnterpriseTypeIndexFilterInput filter);
        Pagination<EnterpriseTypeOutput> Paginate(Pagination<EnterpriseTypeOutput> pagination);
    }
}
