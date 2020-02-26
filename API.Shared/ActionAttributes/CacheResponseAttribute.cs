using API.Cache;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace API.Actionttributes
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
    public class CacheResponseAttribute : Attribute, IAsyncActionFilter
    {
        private readonly int _timeToLiveSeconds;

        public CacheResponseAttribute(int timeToLiveSeconds)
        {
            _timeToLiveSeconds = timeToLiveSeconds;
        }

        public async Task OnActionExecutionAsync(ActionExecutingContext context, ActionExecutionDelegate next)
        {
            var cacheSettings = context.HttpContext.RequestServices.GetRequiredService<RedisCacheSettings>();
            if (!cacheSettings.Enabled)
            {
                await next();
                return;
            }

            var cacheService = context.HttpContext.RequestServices.GetRequiredService<IResponseCacheService>();
            var cacheKey = GenerateCacheKeyFromRequest(context.HttpContext.Request);
            var cachedResponse = await cacheService.GetCacheObjectAsync(cacheKey);

            if (cachedResponse != null)
            {
                context.Result = new OkObjectResult(cachedResponse);
                return;
            }

            var executedContext = await next();
            if (executedContext.Result is OkObjectResult okObjectResult)
            {
                await cacheService.CacheResponseAsync(cacheKey, okObjectResult.Value, timeToLive: TimeSpan.FromSeconds(_timeToLiveSeconds));
            }
        }

        private static string GenerateCacheKeyFromRequest(HttpRequest request)
        {
            return request.Query
                .OrderBy(q => q.Key)
                .Aggregate(
                    new StringBuilder(),
                    (orderedQueryBuilder, currentQueryStringPair) =>
                    {
                        var previousFullValue = orderedQueryBuilder.Append(orderedQueryBuilder.Length > 0 ? "&" : "").ToString();
                        orderedQueryBuilder.Clear().Append($"{previousFullValue}{currentQueryStringPair.Key}={currentQueryStringPair.Value}");
                        return orderedQueryBuilder;
                    }, orderedQueryBuilder => orderedQueryBuilder.Insert(0, $"{request.Path}{(orderedQueryBuilder.Length > 0 ? "?" : "")}"))
                .ToString();
        }
    }
}
