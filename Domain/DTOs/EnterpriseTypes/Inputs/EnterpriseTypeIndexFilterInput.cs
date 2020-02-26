using Microsoft.AspNetCore.Mvc;

namespace Domain.DTOs.EnterpriseTypes.Inputs
{
    public partial class EnterpriseTypeIndexFilterInput
    {
        [FromQuery(Name = "name_with")] public string NameWith { get; set; }
    }
}
