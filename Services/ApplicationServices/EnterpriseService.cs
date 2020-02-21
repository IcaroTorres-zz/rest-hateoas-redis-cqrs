using AutoMapper;
using Domain.DTOs.Enterprises.Inputs;
using Domain.DTOs.Enterprises.Outputs;
using Domain.Entities;
using Domain.Repositories.Command;
using Domain.Unities;
using Domain.Util;
using System.Net;

namespace Services.ApplicationServices
{
    public class EnterpriseService : IEnterpriseFacade
    {
        private readonly IUnitOfEnterprises _uow;
        private readonly IEnterpriseRepository _enterprises;
        private readonly IEnterpriseTypeRepository _types;
        private readonly IMapper _mapper;

        public EnterpriseService(IUnitOfEnterprises uow, IMapper mapper)
        {
            _uow = uow;
            _enterprises = uow.Enterprises;
            _types = uow.Types;
            _mapper = mapper;
        }

        private Enterprise GetEnterpriseWithType(long id)
        {
            return _enterprises.GetWithAllNavigations(id) ?? throw new ApiException(HttpStatusCode.NotFound, "Not Found");
        }

        private Enterprise LoadEnterpriseType(Enterprise enterprise, int typeId)
        {
            enterprise.EnterpriseType = _types.Get(enterprise.EnterpriseTypeId)
                ?? throw new ApiException(HttpStatusCode.Conflict, $"Invalid Id {typeId} for EnterpriseType");

            return enterprise;
        }

        // POST
        public EnterpriseOutput CreateEnterprise(CreateEnterpriseInput input)
        {
            var enterprise = _mapper.Map<Enterprise>(input);
            enterprise = LoadEnterpriseType(enterprise, input.EnterpriseTypeId);
            enterprise = _enterprises.Insert(enterprise);
            _uow.Save(); // saving for Id generation purpose

            return _mapper.Map<EnterpriseOutput>(enterprise);
        }

        // PUT{id}
        public EnterpriseOutput UpdateEnterprise(long id, UpdateEnterpriseInput input)
        {
            if (id == input.Id)
            {
                var enterprise = _mapper.Map(input, GetEnterpriseWithType(id));
                enterprise = LoadEnterpriseType(enterprise, input.EnterpriseTypeId);
                return _mapper.Map<EnterpriseOutput>(enterprise);
            }
            throw new ApiException(HttpStatusCode.Conflict, $"conflict between id [{id}] and input id [{input.Id}]");
        }

        // DELETE{id}
        public void DeleteEnterprise(long id)
        {
            _enterprises.Remove(GetEnterpriseWithType(id));
        }
    }
}
