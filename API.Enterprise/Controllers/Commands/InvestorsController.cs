using API.Actionttributes;
using Domain.DTOs.Investors.Inputs;
using Services.ApplicationServices;
using Microsoft.AspNetCore.JsonPatch;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers.Commands
{
    [ApiController, Route("api/v2/investors"), ValidateModelState, UnitOfWork]
    public class InvestorsController : ControllerBase
    {
        private readonly IInvestorFacade _service;

        public InvestorsController(IInvestorFacade service)
        {
            _service = service;
        }

        [HttpPost(Name = "create-investor")]
        public IActionResult Post([FromBody] CreateInvestorInput input)
        {
            var investor = _service.CreateInvestor(input);
            return Created($"{Request.Path.ToUriComponent()}/{investor.Id}", investor);
        }

        [HttpPut("{id}", Name = "update-investor")]
        public IActionResult Put(long id, [FromBody] OverwriteInvestorInput input)
        {
            return Ok(_service.OverwriteInvestor(id, input));
        }

        [HttpPatch("{id}", Name = "update-investor-properties")]
        public IActionResult Patch(long id, [FromBody] JsonPatchDocument<UpdateInvestorInput> input)
        {
            return Ok(_service.UpdateInvestor(id, input));
        }

        [HttpDelete("{id}", Name = "delete-investor")]
        public IActionResult Delete(long id)
        {
            _service.DeleteInvestor(id);

            return NoContent();
        }
    }
}
