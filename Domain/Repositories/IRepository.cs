using Domain.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace Domain.Repositories
{
    public interface IRepository<T> where T : class
    {
        T GetWithKeys(object[] keys, IEnumerable<string> navigations = null, IEnumerable<string> collections = null);
        IQueryable<T> GetAll(string included = "", bool readOnly = false);
        IQueryable<T> Query(Expression<Func<T, bool>> predicate = null, bool readOnly = false, string included = "");
        IQueryable<S> Query<S>(Expression<Func<S, bool>> predicate = null, bool readOnly = false, string included = "") where S : class, T;
        Pagination<T> Paginate(Pagination<T> pagination);

        T Insert(T entity);
        IEnumerable<T> InsertMany(IEnumerable<T> entities);
        T Remove(T entity);
        T Remove(params object[] keys);
        IEnumerable<T> RemoveMany(IEnumerable<T> entities);
        IEnumerable<T> RemoveMany(IEnumerable<object[]> keys);
    }
}