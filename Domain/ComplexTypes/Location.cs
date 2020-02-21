using System;

namespace Domain.ComplexTypes
{
    public class Location
    {
        public Location(string city, string country)
        {
            if (string.IsNullOrWhiteSpace(city))
            {
                throw new ArgumentNullException(nameof(city));
            }

            if (string.IsNullOrWhiteSpace(country))
            {
                throw new ArgumentNullException(nameof(country));
            }

            City = city;
            Country = country;
        }

        public string City { get; set; }
        public string Country { get; set; }
    }
}
