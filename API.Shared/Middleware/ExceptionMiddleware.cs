using Domain.Util;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using System;
using System.Net;
using System.Threading.Tasks;

namespace API.Middleware
{
    /// <summary>
    /// Classe global para tratamento de erros
    /// </summary>
    public class ExceptionMiddleware
    {
        private readonly RequestDelegate RequestDelegate;
        //private readonly ILogger Logger;

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="requestDelegate"></param>
        /// <param name="logger"></param>
        public ExceptionMiddleware(RequestDelegate requestDelegate)//, ILoggerFactory logger)
        {
            RequestDelegate = requestDelegate;
            //Logger = logger.CreateLogger("Global Errors");
        }

        /// <summary>
        /// Global try-catch
        /// </summary>
        /// <param name="httpContext"></param>
        /// <returns></returns>
        public async Task InvokeAsync(HttpContext httpContext)
        {
            try
            {
                await RequestDelegate(httpContext);
            }
            catch (ApiException ex)
            {
                //if (!string.IsNullOrWhiteSpace(ex.LogInfo))
                //{
                //    Logger.LogWarning(ex.LogInfo);
                //}

                await HandleExceptionAsync(httpContext, ex);
            }
            catch (Exception ex)
            {
                //Logger.LogError(ex.Message);
                await HandleExceptionAsync(httpContext, ex);
            }
        }

        private static Task HandleExceptionAsync(HttpContext context, Exception exception)
        {
            context.Response.ContentType = "application/json";
            context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;

            return context.Response.WriteAsync(JsonConvert.SerializeObject(new
            {
                status = $"{(int)HttpStatusCode.InternalServerError}",
                error = $"Ocorreu um erro inesperado, por favor entre em contato com o administrador do sistema. {exception.Message}"
            }));
        }

        private Task HandleExceptionAsync(HttpContext context, ApiException exception)
        {
            context.Response.ContentType = "application/json";
            context.Response.StatusCode = (int)exception.StatusCode;

            return context.Response.WriteAsync(JsonConvert.SerializeObject(new
            {
                status = $"{(int)exception.StatusCode}",
                error = exception.Message
            }));
        }
    }
}
