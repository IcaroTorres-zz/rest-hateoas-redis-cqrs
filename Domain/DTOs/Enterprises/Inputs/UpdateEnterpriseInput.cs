using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace Domain.DTOs.Enterprises.Inputs
{
    public partial class UpdateEnterpriseInput
    {
        [JsonProperty("id"), Required] public long Id { get; set; }
        [JsonProperty("name"), Required] public string Name { get; set; }
        [JsonProperty("description"), Required] public string Description { get; set; }
        [JsonProperty("value"), Required] public decimal Value { get; set; }
        [JsonProperty("city"), Required] public string City { get; set; }
        [JsonProperty("country"), Required] public string Country { get; set; }
        [JsonProperty("type_id"), Required] public int EnterpriseTypeId { get; set; }

        // optionals
        [JsonProperty("email")] public string Email { get; set; }
        [JsonProperty("facebook")] public string Facebook { get; set; }
        [JsonProperty("twitter")] public string Twitter { get; set; }
        [JsonProperty("linkedin")] public string Linkedin { get; set; }
        [JsonProperty("phone")] public string Phone { get; set; }
        [JsonProperty("photo")] public string Photo { get; set; }
        [JsonProperty("own_enterprise")] public bool? OwnEnterprise { get; set; }
        [JsonProperty("shares")] public decimal Shares { get; set; }
        [JsonProperty("share_price")] public decimal? SharePrice { get; set; }
        [JsonProperty("own_shares")] public long? OwnShares { get; set; }
    }
}
