using API.Actionttributes;
using Domain.DTOs.Investors.Inputs;
using Domain.Repositories.Query;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace API.Controllers.Queries
{
    [ApiController, Route("api/v2/investors"), CacheResponse(30)]
    public class InvestorsController : ControllerBase
    {
        [HttpGet(Name = "get-investors")]
        public async Task<IActionResult> Get([FromQuery]InvestorIndexFilterInput input, [FromServices] IInvestorQueryRepository queryRepository)
        {
            return Ok(await queryRepository.Query(input));
        }

        [HttpGet("{id}", Name = "get-investor")]
        public async Task<IActionResult> Get(long id, [FromServices] IInvestorQueryRepository queryRepository)
        {
            return Ok(await queryRepository.GetAsync(id));
        }
    }
}
