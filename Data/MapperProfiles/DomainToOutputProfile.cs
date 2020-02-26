using AutoMapper;
using Domain.DTOs.Auth.Outputs;
using Domain.DTOs.Enterprises.Outputs;
using Domain.DTOs.EnterpriseTypes.Outputs;
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

            CreateMap<List<Enterprise>, PortfolioOutput>();
            CreateMap<Enterprise, EnterpriseOutput>();

            CreateMap<Investor, InvestorOutput>().IgnoreAllPropertiesWithAnInaccessibleSetter();
            CreateMap<Investor, SuccessSigninOutput>().IgnoreAllPropertiesWithAnInaccessibleSetter();
        }
    }
}
