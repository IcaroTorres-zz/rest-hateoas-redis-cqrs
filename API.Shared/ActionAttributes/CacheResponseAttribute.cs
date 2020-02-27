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
            var cacheKeyBuilder = new StringBuilder(request.Path);

            if (request.Query.Any())
            {
                cacheKeyBuilder = request.Query
                    .OrderBy(q => q.Key)
                    .Aggregate(
                        cacheKeyBuilder,
                        (orderedQueryBuilder, currentQueryStringPair) =>
                        {
                            var previousFullValue = orderedQueryBuilder.Append(orderedQueryBuilder.ToString() == request.Path.ToString() ? "?" : "&").ToString();
                            orderedQueryBuilder.Clear().Append($"{previousFullValue}{currentQueryStringPair.Key}={currentQueryStringPair.Value}");
                            return orderedQueryBuilder;
                        });
            }

            cacheKeyBuilder = request.Headers
                .Where(header => !string.IsNullOrWhiteSpace(header.Value))
                .Aggregate(cacheKeyBuilder, (headerBuilder, header) => headerBuilder.Append($"|{header.Key}={header.Value}"));

            return cacheKeyBuilder.ToString();
        }
    }
}
