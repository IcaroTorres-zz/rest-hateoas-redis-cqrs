using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace Domain.Util
{
    public static class ValidationExtensions
    {
        public static bool ValidateEmail(this string email)
        {
            new EmailAddressAttribute().Validate(email, "EmailAddres");

            return Regex.IsMatch(email,
                                 @"\A(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)\Z",
                                 RegexOptions.IgnoreCase);
        }
    }
}
