using API.Actionttributes;
using Domain.DTOs.Enterprises.Inputs;
using Services.ApplicationServices;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers.Commands
{
    [ApiController, Route("api/v2/enterprises"), ValidateModelState, UnitOfWork]
    public class EnterprisesController : ControllerBase
    {
        private readonly IEnterpriseFacade _service;

        public EnterprisesController(IEnterpriseFacade service)
        {
            _service = service;
        }

        [HttpPost(Name = "create-enterprise")]
        public IActionResult Post([FromBody] CreateEnterpriseInput input)
        {
            var enterprise = _service.CreateEnterprise(input);
            return Created($"{Request.Path.ToUriComponent()}/{enterprise.Id}", enterprise);
        }

        [HttpPut("{id}", Name = "update-enterprise")]
        public IActionResult Put(long id, [FromBody] UpdateEnterpriseInput input)
        {
            return Ok(_service.UpdateEnterprise(id, input));
        }

        [HttpDelete("{id}", Name = "delete-enterprise")]
        public IActionResult Delete(long id)
        {
            _service.DeleteEnterprise(id);

            return NoContent();
        }
    }
}
