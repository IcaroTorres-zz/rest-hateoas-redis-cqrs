using Data.Context;
using Domain.Repositories;
using Domain.Util;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace Data.Repositories
{
    public class QueryableRepository<T> : IQueryableRepository<T> where T : class
    {
        private EnterpriseContext Context { get; set; }
        protected virtual DbSet<T> EntitiesSet { get; set; }
        public QueryableRepository(EnterpriseContext context)
        {
            Context = context;
            EntitiesSet = Context.Set<T>();
        }

        public T LoadNavigation(T e, Expression<Func<T, object>> expression)
        {
            Context.Entry(e).Reference(expression).Load();
            return e;
        }

        public T LoadCollection(T e, string collectionPropName)
        {
            Context.Entry(e).Collection(collectionPropName).Load();

            return e;
        }

        public virtual T GetWithKeys(params object[] keys)
        {
            return GetWithKeys(keys, null, null);
        }

        public virtual T GetWithKeys(object[] keys, IEnumerable<string> navications = null, IEnumerable<string> collections = null)
        {
            var entity = EntitiesSet.Find(keys);

            if (entity != null)
            {
                (navications ?? new string[] { }).Aggregate(entity, (e, navegation) =>
                {
                    Context.Entry(e).Reference(navegation).Load();
                    return e;
                });

                (collections ?? new string[] { }).Aggregate(entity, (e, collection) =>
                {
                    Context.Entry(e).Collection(collection).Load();
                    return e;
                });

            }
            return entity;
        }

        public virtual IQueryable<T> GetAll(string included = "", bool readOnly = false)
        {
            return Query(e => true, readOnly, included);
        }

        public virtual IQueryable<T> Query(Expression<Func<T, bool>> predicate = null, bool readOnly = false, string included = "")
        {
            return Query<T>(predicate, readOnly, included);
        }

        public virtual IQueryable<S> Query<S>(Expression<Func<S, bool>> predicate = null, bool readOnly = false, string included = "") where S : class, T
        {
            var query = included
                .Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                .Aggregate(EntitiesSet.OfType<S>(), (set, navigation) => set.Include(navigation))
                .Where(predicate ?? (e => true));

            return readOnly ? query.AsNoTracking() : query;
        }

        public virtual Pagination<T> Paginate(Pagination<T> pagination)
        {
            var query = GetAll(readOnly: true);

            pagination.Length = query.Count();

            pagination.Items = query
                .Skip((pagination.Page - 1) * pagination.PageLength)
                .Take(pagination.PageLength)
                .ToList();

            return pagination;
        }
    }
}
