using AutoMapper;
using Domain.DTOs.Enterprises.Inputs;
using Domain.DTOs.EnterpriseTypes.Inputs;
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
            CreateMap<EnterprisePagination, Enterprise>();
            CreateMap<CreateEnterpriseInput, Enterprise>();
            CreateMap<UpdateEnterpriseInput, Enterprise>();

            CreateMap<UpdateEnterpriseTypeInput, EnterpriseType>();
            CreateMap<OverwriteEnterpriseTypeInput, EnterpriseType>();

            CreateMap<InvestorPagination, Investor>();
            CreateMap<CreateInvestorInput, Investor>().IgnoreAllPropertiesWithAnInaccessibleSetter();
            CreateMap<OverwriteInvestorInput, Investor>().IgnoreAllPropertiesWithAnInaccessibleSetter();
            CreateMap<JsonPatchDocument<UpdateInvestorInput>, JsonPatchDocument<Investor>>();
            CreateMap<Operation<UpdateInvestorInput>, Operation<Investor>>();
            CreateMap<HashSet<UpdateInvestorEnterpriseInput>, ICollection<InvestorEnterprise>>().IgnoreAllPropertiesWithAnInaccessibleSetter();

            CreateMap<JsonPatchDocument<UpdateEnterpriseTypeInput>, JsonPatchDocument<EnterpriseType>>();
            CreateMap<Operation<UpdateEnterpriseTypeInput>, Operation<EnterpriseType>>();
        }
    }
}
