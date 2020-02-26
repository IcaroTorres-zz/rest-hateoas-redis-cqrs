using API.Actionttributes;
using Domain.DTOs.EnterpriseTypes.Inputs;
using Microsoft.AspNetCore.JsonPatch;
using Microsoft.AspNetCore.Mvc;
using Services.ApplicationServices;

namespace API.Controllers.Commands
{
    [ApiController, Route("api/v2/enterprise-types"), ValidateModelState, UnitOfWork]
    public class EnterpriseTypesController : ControllerBase
    {
        private readonly IEnterpriseTypeFacade _service;

        public EnterpriseTypesController(IEnterpriseTypeFacade service)
        {
            _service = service;
        }

        [HttpPost(Name = "create-enterprise-type")]
        public IActionResult Post([FromBody] string input)
        {
            var enterpriseType = _service.CreateEnterpriseType(input);
            return Created($"{Request.Path.ToUriComponent()}/{enterpriseType.Id}", enterpriseType);
        }

        [HttpPut("{id}", Name = "update-enterprise-type")]
        public IActionResult Put(int id, [FromBody] OverwriteEnterpriseTypeInput input)
        {
            return Ok(_service.OverwriteEnterpriseType(id, input));
        }

        [HttpPatch("{id}", Name = "update-enterprise-type-properties")]
        public IActionResult Patch(int id, [FromBody] JsonPatchDocument<UpdateEnterpriseTypeInput> input)
        {
            return Ok(_service.UpdateEnterpriseType(id, input));
        }

        [HttpDelete("{id}", Name = "disable-enterprise-type")]
        public IActionResult Delete(int id)
        {
            _service.DeleteEnterpriseType(id);

            return NoContent();
        }
    }
}
