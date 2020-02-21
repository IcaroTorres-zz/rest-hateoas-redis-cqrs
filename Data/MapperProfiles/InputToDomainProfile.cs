using AutoMapper;
using Domain.DTOs.Enterprises.Inputs;
using Domain.DTOs.Investors.Inputs;
using Domain.Entities;
using Microsoft.AspNetCore.JsonPatch;
using Microsoft.AspNetCore.JsonPatch.Operations;
using System.Collections.Generic;

namespace Data.MapperProfiles
{
    public class InputToDomainProfile : Profile
    {
        public InputToDomainProfile()
        {
            CreateMap<EnterpriseIndexFilterInput, Enterprise>();

            CreateMap<CreateEnterpriseInput, Enterprise>();

            CreateMap<UpdateEnterpriseInput, Enterprise>();

            CreateMap<InvestorIndexFilterInput, Investor>();

            CreateMap<CreateInvestorInput, Investor>().IgnoreAllPropertiesWithAnInaccessibleSetter();

            CreateMap<OverwriteInvestorInput, Investor>().IgnoreAllPropertiesWithAnInaccessibleSetter();

            CreateMap<JsonPatchDocument<UpdateInvestorInput>, JsonPatchDocument<Investor>>();
            CreateMap<Operation<OverwriteInvestorInput>, Operation<Investor>>();
            CreateMap<HashSet<UpdateInvestorEnterpriseInput>, ICollection<InvestorEnterprise>>().IgnoreAllPropertiesWithAnInaccessibleSetter();
        }
    }
}
