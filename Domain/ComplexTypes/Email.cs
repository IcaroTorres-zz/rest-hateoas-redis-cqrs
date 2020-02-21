using Domain.Util;

namespace Domain.ComplexTypes
{
    public class Email
    {
        public Email(string address)
        {
            if(string.IsNullOrWhiteSpace(address) || address.ValidateEmail())
            {
                Address = address;
            }
        }

        public string Address { get; set; }
    }
}
