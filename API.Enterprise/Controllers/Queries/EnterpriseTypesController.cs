using API.Actionttributes;
using Domain.DTOs.EnterpriseTypes.Inputs;
using Domain.Repositories.Query;
using Domain.Util;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace API.Controllers.Queries
{
    [ApiController, Route("api/v2/enterprise-types"), CacheResponse(30)]
    public class EnterpriseTypesController : ControllerBase
    {
        [HttpGet(Name = "get-enterprise-types")]
        public async Task<IActionResult> Get([FromQuery] EnterpriseTypePagination pagination,
                                             [FromServices] IEnterpriseTypeQueryRepository queryRepository)
        {
            var resultPagination = await queryRepository.Query(pagination);
            Response.AddHeadersFromPagination(resultPagination);
            return Ok(resultPagination.Items);
        }

        [HttpGet("{id}", Name = "get-enterprise-type")]
        public async Task<IActionResult> Get(int id, IEnterpriseTypeQueryRepository queryRepository)
        {
            return Ok(await queryRepository.Get(id));
        }
    }
}
