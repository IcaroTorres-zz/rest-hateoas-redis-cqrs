using Domain.Enums;
using System.Collections.Generic;

namespace Domain.Util
{
    public class Pagination<T> where T : class
    {
        public int Page { get; set; } = 1;
        public int PageLength { get; set; } = 10;
        public string Term { get; set; } = "";
        public Orderby Order { get; set; } = Orderby.ascending; //"ascending";
        public string Column { get; set; } = "Id";
        public decimal TotalInPage { get; set; } = 0m;
        public decimal Total { get; set; } = 0m;
        public IReadOnlyList<T> Items { get; set; } = new List<T>();

        public long Length { get; set; }
        public long Start => Items.Count == 0 ? 0 : (PageLength * (Page - 1)) + 1;
        public long End => Items.Count == 0 ? 0 : Start + (Items.Count - 1);
        public long Pages => Length == 0 ? 1 : (Length + PageLength - 1) / PageLength;
        public string TotalInPageAsCurrency => TotalInPage.AsBRL();
        public string TotalEmMoeda => Total.AsBRL();
    }
}
