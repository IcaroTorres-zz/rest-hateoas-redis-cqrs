using Domain.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace Domain.Repositories
{
    public interface IQueryableRepository<T> where T : class
    {
        T LoadNavigation(T e, Expression<Func<T, object>> expression);
        T LoadCollection(T e, string collectionPropName);
        T GetWithKeys(object[] keys, IEnumerable<string> navigations = null, IEnumerable<string> collections = null);
        IQueryable<T> GetAll(string included = "", bool readOnly = false);
        IQueryable<T> Query(Expression<Func<T, bool>> predicate = null, bool readOnly = false, string included = "");
        IQueryable<S> Query<S>(Expression<Func<S, bool>> predicate = null, bool readOnly = false, string included = "") where S : class, T;
        Pagination<T> Paginate(Pagination<T> pagination);
    }
}