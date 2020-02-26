using Domain.DTOs.EnterpriseTypes.Inputs;
using Domain.DTOs.EnterpriseTypes.Outputs;
using Microsoft.AspNetCore.JsonPatch;

namespace Services.ApplicationServices
{
    public interface IEnterpriseTypeFacade
    {
        EnterpriseTypeOutput CreateEnterpriseType(string input); // POST
        EnterpriseTypeOutput OverwriteEnterpriseType(int id, OverwriteEnterpriseTypeInput input); // PUT{id}
        EnterpriseTypeOutput UpdateEnterpriseType(int id, JsonPatchDocument<UpdateEnterpriseTypeInput> input); // PATCH{id}
        void DeleteEnterpriseType(int id); // DELETE{id}
    }
}
