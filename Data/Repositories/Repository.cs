using Data.Context;
using Domain.Repositories;
using System.Collections.Generic;

namespace Data.Repositories
{
    public class Repository<T> : QueryableRepository<T>, IRepository<T> where T : class
    {
        public Repository(EnterpriseContext context) : base(context) { }

        public virtual T Insert(T entity)
        {
            return EntitiesSet.Add(entity).Entity;
        }

        public virtual IEnumerable<T> InsertMany(IEnumerable<T> entities)
        {
            EntitiesSet.AddRange(entities);

            return entities;
        }

        public virtual T Remove(T entity)
        {
            return EntitiesSet.Remove(entity).Entity;
        }

        public virtual T Remove(params object[] keys)
        {
            return EntitiesSet.Remove(EntitiesSet.Find(keys)).Entity;
        }

        public virtual IEnumerable<T> RemoveMany(IEnumerable<T> entities)
        {
            EntitiesSet.RemoveRange(entities);

            return entities;
        }

        public virtual IEnumerable<T> RemoveMany(IEnumerable<object[]> keysList)
        {
            foreach (var keys in keysList)
            {
                yield return Remove(keys);
            }
        }
    }
}
