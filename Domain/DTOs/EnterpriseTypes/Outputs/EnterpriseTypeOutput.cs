using Newtonsoft.Json;

namespace Domain.DTOs.EnterpriseTypes.Outputs
{
    public partial class EnterpriseTypeOutput
    {
        [JsonProperty("id")]
        public int Id { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }
    }
}
