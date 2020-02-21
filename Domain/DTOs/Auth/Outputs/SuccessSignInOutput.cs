using Domain.DTOs.Enterprises.Outputs;
using Domain.DTOs.Investors.Outputs;
using Newtonsoft.Json;

namespace Domain.DTOs.Auth.Outputs
{
    public partial class SuccessSigninOutput
    {
        [JsonProperty("investor")]
        public InvestorOutput Investor { get; set; }

        [JsonProperty("enterprise")]
        public EnterpriseOutput Enterprise { get; set; }

        [JsonProperty("success")]
        public bool Success => true;
    }
}
