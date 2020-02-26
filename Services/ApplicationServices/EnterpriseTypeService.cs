using AutoMapper;
using Domain.DTOs.EnterpriseTypes.Inputs;
using Domain.DTOs.EnterpriseTypes.Outputs;
using Domain.Entities;
using Domain.Repositories.Command;
using Domain.Unities;
using Domain.Util;
using Microsoft.AspNetCore.JsonPatch;
using System.Net;

namespace Services.ApplicationServices
{
    public class EnterpriseTypeService : IEnterpriseTypeFacade
    {
        private readonly IUnitOfEnterprises _uow;
        private readonly IEnterpriseTypeRepository _types;
        private readonly IMapper _mapper;

        public EnterpriseTypeService(IUnitOfEnterprises uow, IMapper mapper)
        {
            _uow = uow;
            _types = uow.Types;
            _mapper = mapper;
        }

        // POST
        public EnterpriseTypeOutput CreateEnterpriseType(string name)
        {
            var enterpriseType = _types.Insert(new EnterpriseType(name));
            _uow.Save(); // saving for Id generation purpose

            return _mapper.Map<EnterpriseTypeOutput>(enterpriseType);
        }

        // PUT{id}
        public EnterpriseTypeOutput OverwriteEnterpriseType(int id, OverwriteEnterpriseTypeInput input)
        {
            if (id == input.Id)
            {
                var enterpriseType = _mapper.Map(input, _types.Get(id));
                return _mapper.Map<EnterpriseTypeOutput>(enterpriseType);
            }
            throw new ApiException(HttpStatusCode.Conflict, $"conflict between id [{id}] and input id [{input.Id}]");
        }

        // PATCH{id}
        public EnterpriseTypeOutput UpdateEnterpriseType(int id, JsonPatchDocument<UpdateEnterpriseTypeInput> input)
        {
            var enterpriseType = _types.Get(id);

            var delta = _mapper.Map<JsonPatchDocument<UpdateEnterpriseTypeInput>, JsonPatchDocument<EnterpriseType>>(input);

            delta.ApplyTo(enterpriseType);

            return _mapper.Map<EnterpriseTypeOutput>(enterpriseType);
        }

        // DELETE{id}
        public void DeleteEnterpriseType(int id)
        {
            var enterpriseType = _types.Get(id);

            enterpriseType.Active = false;
        }
    }
}
