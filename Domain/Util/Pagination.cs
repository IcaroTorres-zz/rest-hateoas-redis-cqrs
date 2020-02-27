using Domain.Enums;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;

namespace Domain.Util
{
    public class Pagination<T> where T : class
    {
        [Description("Pagination-ResponsePage"), FromHeader(Name = "Pagination-RequestPage")]
        public int Page { get; set; } = 1;

        [Description("Pagination-PageLength"), FromHeader(Name = "Pagination-PageLength")]
        public int PageLength { get; set; } = int.MaxValue;

        public long Skip => (PageLength * (Page - 1));

        [Description("Pagination-Order"), FromHeader(Name = "Pagination-Order")]
        public Orderby Order { get; set; } = Orderby.ASC;

        [Description("Pagination-OrderBy"), FromHeader(Name = "Pagination-OrderBy")]
        public string OrderBy { get; set; } = "Id";

        public IReadOnlyList<T> Items { get; set; } = new List<T>();

        [Description("Pagination-TotalItems")]
        public long TotalItems { get; set; } = 0;

        [Description("Pagination-TotalPages")]
        public long Pages => TotalItems == 0 ? 1 : (TotalItems + PageLength - 1) / PageLength;

        public string GenerateOrderBy()
        {
            return GetType()
                .GetProperties()
                .Where(propInfo => propInfo.GetCustomAttributes(typeof(FromQueryAttribute), true).Any())
                .Select(propInfo => propInfo.Name)
                .First(name => name == OrderBy);
        }
    }

    public static class PaginationExtension
    {
        public static HttpResponse AddHeadersFromPagination<T>(this HttpResponse response, Pagination<T> pagination) where T : class
        {
            var headers = pagination
                .GetType()
                .GetProperties()
                .Select(propInfo => (propInfo.GetCustomAttributes(typeof(DescriptionAttribute), true).SingleOrDefault() is DescriptionAttribute att)
                    ? new { Key = att.Description, Value = propInfo.GetValue(pagination).ToString() }
                    : null)
                .Where(header => header != null)
                .ToList();

            headers.ForEach(header => response.Headers.Add(header.Key, header.Value));

            return response;
        }
    }
}
