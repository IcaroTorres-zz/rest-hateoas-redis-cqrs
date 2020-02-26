using API.Actionttributes;
using Domain.DTOs.EnterpriseTypes.Inputs;
using Domain.Repositories.Query;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace API.Controllers.Queries
{
    [ApiController, Route("api/v2/enterprise-types"), CacheResponse(30)]
    public class EnterpriseTypesController : ControllerBase
    {
        private readonly IEnterpriseTypeQueryRepository _queryRepository;

        public EnterpriseTypesController(IEnterpriseTypeQueryRepository queryRepository)
        {
            _queryRepository = queryRepository;
        }

        [HttpGet(Name = "get-enterprise-types")]
        public async Task<IActionResult> Get([FromQuery] EnterpriseTypeIndexFilterInput input)
        {
            return Ok(await _queryRepository.Query(input));
        }

        [HttpGet("{id}", Name = "get-enterprise-type")]
        public async Task<IActionResult> Get(int id)
        {
            return Ok(await _queryRepository.Get(id));
        }
    }
}
