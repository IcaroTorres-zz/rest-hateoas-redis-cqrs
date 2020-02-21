using Domain.DTOs.Enterprises.Inputs;
using Domain.DTOs.Enterprises.Outputs;

namespace Services.ApplicationServices
{
    public interface IEnterpriseFacade
    {
        EnterpriseOutput CreateEnterprise(CreateEnterpriseInput input); // POST
        EnterpriseOutput UpdateEnterprise(long id, UpdateEnterpriseInput input); // PUT{id}
        void DeleteEnterprise(long id); // DELETE{id}
    }
}
