using Microsoft.AspNetCore.Routing;
using System;

namespace API.Hateoas
{
    public interface IRequiredLink
    {
        Type ResourceType { get; }
        string Name { get; }
        RouteValueDictionary GetRouteValues(object input);
    }
}
