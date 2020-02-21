using Domain.Util;
using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Linq;
using System.Net;

namespace API.Actionttributes
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
    public class ValidateModelStateAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext actionContext)
        {
            var modelState = actionContext.ModelState;
            if (!modelState.IsValid)
            {
                throw new ApiException(HttpStatusCode.BadRequest, string.Join(" | ", modelState.Values.SelectMany(v => v.Errors)
                                                                                                      .Select(e => e.ErrorMessage)));
            }

            base.OnActionExecuting(actionContext);
        }
    }
}
