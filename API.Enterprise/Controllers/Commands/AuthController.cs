using Domain.DTOs.Auth.Inputs;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers.Commands
{
    [Route("api/v2/[controller]"), Produces("application/json"), ApiController]
    public class AuthController : ControllerBase
    {
        [HttpPost("sign_in")]
        public IActionResult SignIn([FromBody] SigninInput input)
        {
            // TODO implement Authorization Service Facade

            // enable Oath2 authentication

            // integrate service and oath2 to the controller and login repository structure

            return Ok();
        }
    }
}
