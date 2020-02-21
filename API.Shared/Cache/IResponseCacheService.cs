using Newtonsoft.Json;
using System;
using System.Threading.Tasks;

namespace API.Cache
{
    public interface IResponseCacheService
    {
        Task CacheResponseAsync(string cacheKey, object response, TimeSpan timeToLive, JsonSerializerSettings serializerSettings = null);
        Task<string> GetCacheResponseAsync(string cacheKey);
        Task<(string, Type)> GetCacheResponseWithTypeAsync(string cacheKey);
        Task<object> GetCacheObjectAsync(string cacheKey);
    }
}
