using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace Domain.DTOs.Enterprises.Inputs
{
    public partial class CreateEnterpriseInput
    {
        [Required, JsonProperty("name")] public string Name { get; set; }
        [Required, JsonProperty("description")] public string Description { get; set; }
        [Required, JsonProperty("value")] public decimal Value { get; set; }
        [Required, JsonProperty("city")] public string City { get; set; }
        [Required, JsonProperty("country")] public string Country { get; set; }
        [Required, JsonProperty("type_id")] public int EnterpriseTypeId { get; set; }

        // optionals
        [JsonProperty("email")] public string Email { get; set; }
        [JsonProperty("facebook")] public string Facebook { get; set; }
        [JsonProperty("twitter")] public string Twitter { get; set; }
        [JsonProperty("linkedin")] public string Linkedin { get; set; }
        [JsonProperty("phone")] public string Phone { get; set; }
        [JsonProperty("photo")] public string Photo { get; set; }
        [JsonProperty("own_enterprise")] public bool? OwnEnterprise { get; set; }
        [JsonProperty("shares")] public decimal? Shares { get; set; }
        [JsonProperty("share_price")] public decimal? SharePrice { get; set; }
        [JsonProperty("own_shares")] public long? OwnShares { get; set; }
    }
}
