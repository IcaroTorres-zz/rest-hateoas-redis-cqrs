using System.Globalization;

namespace Domain.Util
{
    public static class CurrencyExtension
    {
        public static string AsSpecificCurrency(this decimal value, CultureInfo culture)
        {
            return value.ToString("C", culture);
        }

        public static string AsBRL(this decimal value)
        {
            return AsSpecificCurrency(value, new CultureInfo("pt-BR"));
        }

        public static string AsUnsignedSpecificCurrency(this decimal value, CultureInfo culture)
        {
            return value.ToString(culture);
        }

        public static string AsUnsignedBRL(this decimal value)
        {
            return value.ToString(new CultureInfo("pt-BR"));
        }
    }
}
