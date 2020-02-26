using Newtonsoft.Json;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Domain.DTOs.Investors.Inputs
{
    public partial class CreateInvestorInput
    {
        [Required, JsonProperty("name")] public string Name { get; set; }
        [Required, JsonProperty("email")] public string Email { get; set; }
        [Required, JsonProperty("city")] public string City { get; set; }
        [Required, JsonProperty("country")] public string Country { get; set; }
        [Required, JsonProperty("super_angel")] public bool SuperAngel { get; set; }

        // optionals
        [JsonProperty("enterprise_id")] public long? EnterpriseId { get; set; }
        [JsonProperty("photo")] public string Photo { get; set; }
        [JsonProperty("balance")] public decimal? Balance { get; set; }
        [JsonProperty("portfolio")] public HashSet<long> Portfolio { get; set; } = new HashSet<long>();
    }
}
