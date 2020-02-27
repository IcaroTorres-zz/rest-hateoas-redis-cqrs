using Domain.DTOs.EnterpriseTypes.Outputs;
using Domain.Util;
using Microsoft.AspNetCore.Mvc;

namespace Domain.DTOs.EnterpriseTypes.Inputs
{
    public class EnterpriseTypePagination : Pagination<EnterpriseTypeOutput>
    {
        [FromQuery(Name = "id")] public string Id { get; set; }
        [FromQuery(Name = "name_with")] public string Name { get; set; }
    }
}
