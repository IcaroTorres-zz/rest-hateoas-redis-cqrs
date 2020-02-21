using API.Actionttributes;
using Domain.DTOs.Investors.Inputs;
using Domain.Repositories.Query;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers.Queries
{
    [ApiController, Route("api/v2/investors"), CacheResponse(300)]
    public class InvestorsController : ControllerBase
    {
        [HttpGet(Name = "get-investors")]
        public IActionResult Get([FromQuery]InvestorIndexFilterInput input, [FromServices] IInvestorQueryRepository queryRepository)
        {
            return Ok(queryRepository.Query(input));
        }

        [HttpGet("{id}", Name = "get-investor")]
        public IActionResult Get(long id, [FromServices] IInvestorQueryRepository queryRepository)
        {
            return Ok(queryRepository.Get(id));
        }
    }
}
