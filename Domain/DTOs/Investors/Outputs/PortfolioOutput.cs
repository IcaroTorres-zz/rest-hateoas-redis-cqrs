using Domain.DTOs.Enterprises.Outputs;
using Newtonsoft.Json;
using System.Collections.Generic;

namespace Domain.DTOs.Investors.Outputs
{
    public partial class PortfolioOutput
    {
        [JsonProperty("count")]
        public long Count => Enterprises.Count;

        [JsonProperty("enterprises")]
        public IReadOnlyList<EnterpriseOutput> Enterprises { get; set; }
    }
}
