using AutoMapper;
using Domain.DTOs.Auth.Outputs;
using Domain.DTOs.Enterprises.Outputs;
using Domain.DTOs.Investors.Outputs;
using Domain.Entities;
using System.Collections.Generic;

namespace Data.MapperProfiles
{
    public class DomainToOutputProfile : Profile
    {
        public DomainToOutputProfile()
        {
            CreateMap<EnterpriseType, EnterpriseTypeOutput>();

            CreateMap<Enterprise, EnterpriseOutput>();
            CreateMap<IReadOnlyList<Enterprise>, IReadOnlyList<EnterpriseOutput>>();
            CreateMap<IReadOnlyList<Enterprise>, PortfolioOutput>();

            CreateMap<Investor, InvestorOutput>().IgnoreAllPropertiesWithAnInaccessibleSetter();
            CreateMap<Investor, SuccessSigninOutput>().IgnoreAllPropertiesWithAnInaccessibleSetter();
        }
    }
}
