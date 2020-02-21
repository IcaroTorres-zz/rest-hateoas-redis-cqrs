using Domain.Unities;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.DependencyInjection;
using System;

namespace API.Actionttributes
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
    public class UnitOfWorkAttribute : Attribute, IActionFilter
    {
        public IUnitOfEnterprises UnitOfWork { get; private set; }

        public void OnActionExecuting(ActionExecutingContext context)
        {
            UnitOfWork = context.HttpContext.RequestServices.GetService<IUnitOfEnterprises>();

            UnitOfWork.Begin();
        }

        public void OnActionExecuted(ActionExecutedContext context)
        {
            UnitOfWork ??= context.HttpContext.RequestServices.GetService<IUnitOfEnterprises>();

            if (context.Exception == null)
            {
                UnitOfWork.Commit();
            }
            else
            {
                UnitOfWork.RollbackTransaction();
            }
        }
    }
}
