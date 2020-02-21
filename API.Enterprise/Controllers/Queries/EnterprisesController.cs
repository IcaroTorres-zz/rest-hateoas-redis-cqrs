using API.Actionttributes;
using Domain.DTOs.Enterprises.Inputs;
using Domain.Repositories.Query;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers.Queries
{
    [ApiController, Route("api/v2/enterprises"), CacheResponse(300)]
    public class EnterprisesController : ControllerBase
    {
        private readonly IEnterpriseQueryRepository _queryRepository;

        public EnterprisesController(IEnterpriseQueryRepository queryRepository)
        {
            _queryRepository = queryRepository;
        }

        [HttpGet(Name = "get-enterprises")]
        public IActionResult Get([FromQuery]EnterpriseIndexFilterInput input)
        {
            return Ok(_queryRepository.Query(input));
        }

        [HttpGet("{id}", Name = "get-enterprise")]
        public IActionResult Get(long id)
        {
            return Ok(_queryRepository.Get(id));
        }
    }
}
