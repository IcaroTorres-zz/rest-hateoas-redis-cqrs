using Domain.DTOs.EnterpriseTypes.Outputs;
using Newtonsoft.Json;

namespace Domain.DTOs.Enterprises.Outputs
{
    public partial class EnterpriseOutput
    {
        [JsonProperty("id")] public long Id { get; set; }
        [JsonProperty("name")] public string Name { get; set; }
        [JsonProperty("description")] public string Description { get; set; }
        [JsonProperty("value")] public decimal Value { get; set; }
        [JsonProperty("city")] public string City { get; set; }
        [JsonProperty("country")] public string Country { get; set; }
        [JsonProperty("type")] public EnterpriseTypeOutput EnterpriseType { get; set; }
        [JsonProperty("email")] public string Email { get; set; }
        [JsonProperty("photo")] public string Photo { get; set; }
        [JsonProperty("facebook")] public string Facebook { get; set; }
        [JsonProperty("twitter")] public string Twitter { get; set; }
        [JsonProperty("linkedin")] public string Linkedin { get; set; }
        [JsonProperty("phone")] public string Phone { get; set; }
        [JsonProperty("own_enterprise")] public bool OwnEnterprise { get; set; }
        [JsonProperty("shares")] public decimal Shares { get; set; }
        [JsonProperty("share_price")] public decimal SharePrice { get; set; }
        [JsonProperty("own_shares")] public long OwnShares { get; set; }
    }
}
