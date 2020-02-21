using Domain.DTOs.Enterprises.Inputs;
using Domain.DTOs.Enterprises.Outputs;
using Domain.Util;
using System.Collections.Generic;

namespace Domain.Repositories.Query
{
    public interface IEnterpriseQueryRepository
    {
        EnterpriseOutput Get(long id);
        IReadOnlyList<EnterpriseOutput> Query(EnterpriseIndexFilterInput filter);
        Pagination<EnterpriseOutput> Paginate(Pagination<EnterpriseOutput> pagination);
    }
}
