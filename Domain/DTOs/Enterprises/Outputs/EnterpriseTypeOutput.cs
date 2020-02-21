using Newtonsoft.Json;

namespace Domain.DTOs.Enterprises.Outputs
{
    public partial class EnterpriseTypeOutput
    {
        [JsonProperty("id")]
        public int Id { get; set; }

        [JsonProperty("enterprise_type_name")]
        public string Name { get; set; }
    }
}
