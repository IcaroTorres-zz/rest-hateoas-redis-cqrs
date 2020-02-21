using Microsoft.Extensions.Caching.Distributed;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.Threading.Tasks;

namespace API.Cache
{
    public class ResponseCacheService : IResponseCacheService
    {
        private readonly IDistributedCache _distributedCache;
        public ResponseCacheService(IDistributedCache distributedCache)
        {
            _distributedCache = distributedCache;
        }

        public async Task CacheResponseAsync(string cacheKey, object response, TimeSpan timeToLive, JsonSerializerSettings serializerSettings = null)
        {
            if (response == null)
            {
                return;
            }

            serializerSettings ??= new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver(),
                NullValueHandling = NullValueHandling.Ignore,
                ReferenceLoopHandling = ReferenceLoopHandling.Ignore
            };
            var serializedResponse = JsonConvert.SerializeObject(response, serializerSettings);
            var serializedType = JsonConvert.SerializeObject(response.GetType(), serializerSettings);

            var distributedCacheEntryOptions = new DistributedCacheEntryOptions { AbsoluteExpirationRelativeToNow = timeToLive };
            await _distributedCache.SetStringAsync(cacheKey, serializedResponse, distributedCacheEntryOptions);
            await _distributedCache.SetStringAsync(GetTypeCacheKey(cacheKey), serializedType, distributedCacheEntryOptions);
        }

        public async Task<string> GetCacheResponseAsync(string cacheKey)
        {
            var cachedResponse = await _distributedCache.GetStringAsync(cacheKey);
            return string.IsNullOrEmpty(cachedResponse) ? null : cachedResponse;
        }

        public async Task<(string, Type)> GetCacheResponseWithTypeAsync(string cacheKey)
        {
            var cachedResponse = await GetCacheResponseAsync(cacheKey);
            if (string.IsNullOrEmpty(cachedResponse))
            {
                return (null, null);
            }
            var cachedType = JsonConvert.DeserializeObject<Type>(await _distributedCache.GetStringAsync(GetTypeCacheKey(cacheKey)));

            return (cachedResponse, cachedType);
        }

        public async Task<object> GetCacheObjectAsync(string cacheKey)
        {
            var (cachedResponse, cachedType) = await GetCacheResponseWithTypeAsync(cacheKey);
            return string.IsNullOrEmpty(cachedResponse) || cachedType == null ? null : JsonConvert.DeserializeObject(cachedResponse, cachedType);
        }

        private string GetTypeCacheKey(string cacheKey)
        {
            return $"{cacheKey}::typed";
        }
    }
}