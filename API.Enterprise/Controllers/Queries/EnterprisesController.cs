using API.Actionttributes;
using Domain.DTOs.Enterprises.Inputs;
using Domain.Repositories.Query;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace API.Controllers.Queries
{
    [ApiController, Route("api/v2/enterprises"), CacheResponse(30)]
    public class EnterprisesController : ControllerBase
    {
        private readonly IEnterpriseQueryRepository _queryRepository;

        public EnterprisesController(IEnterpriseQueryRepository queryRepository)
        {
            _queryRepository = queryRepository;
        }

        [HttpGet(Name = "get-enterprises")]
        public async Task<IActionResult> Get([FromQuery]EnterpriseIndexFilterInput input)
        {
            return Ok(await _queryRepository.Query(input));
        }

        [HttpGet("{id}", Name = "get-enterprise")]
        public async Task<IActionResult> Get(long id)
        {
            return Ok(await _queryRepository.Get(id));
        }
    }
}
