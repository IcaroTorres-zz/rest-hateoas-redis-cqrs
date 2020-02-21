using AutoMapper;
using Domain.DTOs.Investors.Inputs;
using Domain.DTOs.Investors.Outputs;
using Domain.Entities;
using Domain.Repositories.Command;
using Domain.Unities;
using Domain.Util;
using Microsoft.AspNetCore.JsonPatch;
using System.Collections.Generic;
using System.Linq;
using System.Net;

namespace Services.ApplicationServices
{
    public class InvestorService : IInvestorFacade
    {
        private readonly IUnitOfEnterprises _uow;
        private readonly IInvestorRepository _investors;
        private readonly IEnterpriseRepository _enterprises;
        private readonly IMapper _mapper;

        public InvestorService(IUnitOfEnterprises uow, IMapper mapper)
        {
            _uow = uow;
            _investors = uow.Investors;
            _enterprises = uow.Enterprises;
            _mapper = mapper;
        }

        private Investor LoadEnterpriseCollection(Investor investor, HashSet<long> portfolio)
        {
            _enterprises.GetAllWithAllNavigations().Join(
                portfolio,
                enterprise => enterprise.Id,
                enterpriseId => enterpriseId,
                (enterprise, _) =>
                {
                    investor.InvestorsEnterprises.Add(new InvestorEnterprise
                    {
                        Investor = investor,
                        Enterprise = enterprise
                    });

                    return enterprise;
                });

            return investor.UpdatePortfolioValue();
        }

        private Investor GetInvestor(long id)
        {
            return _investors.GetWithAllNavigations(id) ?? throw new ApiException(HttpStatusCode.NotFound, "Not Found");
        }

        // POST
        public InvestorOutput CreateInvestor(CreateInvestorInput input)
        {
            var investor = _mapper.Map<Investor>(input);
            investor = LoadEnterpriseCollection(investor, input.Portfolio);
            investor = _investors.Insert(investor);
            _uow.Save(); // saving for Id generation purpose

            return _mapper.Map<InvestorOutput>(investor);
        }

        // PUT{id}
        public InvestorOutput OverwriteInvestor(long id, OverwriteInvestorInput input)
        {
            if (id == input.Id)
            {
                var investor = _mapper.Map(input, GetInvestor(id));
                investor = LoadEnterpriseCollection(investor, input.Portfolio);
                return _mapper.Map<InvestorOutput>(investor);
            }
            throw new ApiException(HttpStatusCode.Conflict, $"conflict between id [{id}] and input id [{input.Id}]");
        }

        // PATCH{id}
        public InvestorOutput UpdateInvestor(long id, JsonPatchDocument<UpdateInvestorInput> input)
        {
            var investor = GetInvestor(id);

            var delta = _mapper.Map<JsonPatchDocument<UpdateInvestorInput>, JsonPatchDocument<Investor>>(input);

            delta.ApplyTo(investor);

            return _mapper.Map<InvestorOutput>(investor);
        }

        // DELETE{id}
        public void DeleteInvestor(long id)
        {
            var investor = GetInvestor(id);

            investor.Active = false;
        }
    }
}
