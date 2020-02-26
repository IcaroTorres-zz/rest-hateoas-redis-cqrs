using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace Domain.DTOs.EnterpriseTypes.Inputs
{
    public partial class UpdateEnterpriseTypeInput
    {
        [JsonProperty("name"), Required] public string Name { get; set; }
        [JsonProperty("active"), Required] public bool Active { get; set; }
    }
}
