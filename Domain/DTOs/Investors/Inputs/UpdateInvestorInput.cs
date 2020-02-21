using Domain.Util;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Linq;

namespace Domain.DTOs.Investors.Inputs
{
    public partial class UpdateInvestorInput
    {
        [JsonProperty("id")] public long Id { get; set; }
        [JsonProperty("investor_name")] public string Name { get; set; }
        [JsonProperty("investor_email")] public string Email { get; set; }
        [JsonProperty("location")] public string City { get; set; }
        [JsonProperty("location")] public string Country { get; set; }
        [JsonProperty("super_angel")] public bool SuperAngel { get; set; }
        [JsonProperty("photo")] public string Photo { get; set; }
        [JsonProperty("balance")] public decimal? Balance { get; set; }
        [JsonProperty("enterprise_id")] public long? EnterpriseId { get; set; }
        [JsonProperty("enterprise_ids")] public virtual HashSet<long> EnterpriseIds { get; set; }

        public virtual List<UpdateInvestorEnterpriseInput> InvestorsEnterprises
        {
            get
            {
                return EnterpriseIds?.Select(eId => new UpdateInvestorEnterpriseInput { EnterpriseId = eId, InvestorId = Id }).ToList();
            }
        }
    }

    public class UpdateInvestorEnterpriseInput
    {
        [JsonProperty("investor_id")] public long InvestorId { get; set; }
        [JsonProperty("enterprise_id")] public long EnterpriseId { get; set; }
    }
}
