using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace Domain.DTOs.Auth.Inputs
{
    public class SigninInput
    {
        [Required, JsonProperty("email")]
        public string Email { get; set; }

        [Required, JsonProperty("password")]
        public string Password { get; set; }
    }
}
