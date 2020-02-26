using Newtonsoft.Json;

namespace Domain.DTOs.Investors.Outputs
{
    public partial class InvestorOutput
    {
        [JsonProperty("id")] public long Id { get; set; }
        [JsonProperty("name")] public string Name { get; set; }
        [JsonProperty("email")] public string Email { get; set; }
        [JsonProperty("city")] public string City { get; set; }
        [JsonProperty("country")] public string Country { get; set; }
        [JsonProperty("portfolio_value")] public decimal PortfolioValue { get; set; }
        [JsonProperty("first_access")] public bool? FirstAccess { get; set; }
        [JsonProperty("super_angel")] public bool SuperAngel { get; set; }
        [JsonProperty("balance")] public decimal Balance { get; set; }
        [JsonProperty("photo")] public string Photo { get; set; }
        [JsonProperty("portfolio")] public PortfolioOutput Portfolio { get; set; }
    }
}
