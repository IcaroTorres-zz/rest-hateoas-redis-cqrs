using Domain.DTOs.Investors.Inputs;
using Domain.DTOs.Investors.Outputs;
using Microsoft.AspNetCore.JsonPatch;

namespace Services.ApplicationServices
{
    public interface IInvestorFacade
    {
        InvestorOutput CreateInvestor(CreateInvestorInput input); // POST
        InvestorOutput OverwriteInvestor(long id, OverwriteInvestorInput input); // PUT{id}
        InvestorOutput UpdateInvestor(long id, JsonPatchDocument<UpdateInvestorInput> input); // PATCH{id}
        void DeleteInvestor(long id); // DELETE{id}
    }
}
