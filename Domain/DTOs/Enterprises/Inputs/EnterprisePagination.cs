using Domain.DTOs.Enterprises.Outputs;
using Domain.Util;
using Microsoft.AspNetCore.Mvc;

namespace Domain.DTOs.Enterprises.Inputs
{
    public partial class EnterprisePagination : Pagination<EnterpriseOutput>
    {
        [FromQuery(Name = "id")] public long? Id { get; set; }
        [FromQuery(Name = "name")] public string Name { get; set; }
        [FromQuery(Name = "photo")] public string Photo { get; set; }
        [FromQuery(Name = "description")] public string Description { get; set; }
        [FromQuery(Name = "email")] public string Email { get; set; }
        [FromQuery(Name = "facebook")] public string Facebook { get; set; }
        [FromQuery(Name = "twitter")] public string Twitter { get; set; }
        [FromQuery(Name = "linkedin")] public string Linkedin { get; set; }
        [FromQuery(Name = "phone")] public string Phone { get; set; }
        [FromQuery(Name = "own_enterprise")] public bool? OwnEnterprise { get; set; }
        [FromQuery(Name = "city")] public string City { get; set; }
        [FromQuery(Name = "country")] public string Country { get; set; }
        [FromQuery(Name = "value")] public decimal? Value { get; set; }
        [FromQuery(Name = "share_price")] public decimal? SharePrice { get; set; }
        [FromQuery(Name = "type_id")] public int? EnterpriseTypeId { get; set; }
    }
}
