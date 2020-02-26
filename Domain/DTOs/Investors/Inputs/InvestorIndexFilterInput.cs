using Microsoft.AspNetCore.Mvc;

namespace Domain.DTOs.Investors.Inputs
{
    public partial class InvestorIndexFilterInput
    {
        [FromQuery(Name = "id")] public long? Id { get; set; }
        [FromQuery(Name = "name")] public string Name { get; set; }
        [FromQuery(Name = "photo")] public string Photo { get; set; }
        [FromQuery(Name = "email")] public string Email { get; set; }
        [FromQuery(Name = "city")] public string City { get; set; }
        [FromQuery(Name = "country")] public string Country { get; set; }
        [FromQuery(Name = "enterprise_id")] public long? EnterpriseId { get; set; }
        [FromQuery(Name = "balance")] public decimal? Balance { get; set; }
        [FromQuery(Name = "portfolio_value")] public decimal? PortfolioValue { get; set; }
        [FromQuery(Name = "super_angel")] public bool? SuperAngel { get; set; }
        [FromQuery(Name = "first_access")] public bool? FirstAccess { get; set; }
    }
}
