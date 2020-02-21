using System.Collections.Generic;

namespace Domain.Repositories
{
    public interface ICommandRepository<T> where T : class
    {
        T Insert(T entity);
        IEnumerable<T> InsertMany(IEnumerable<T> entities);
        T Remove(T entity);
        T Remove(params object[] keys);
        IEnumerable<T> RemoveMany(IEnumerable<T> entities);
        IEnumerable<T> RemoveMany(IEnumerable<object[]> keys);
    }
}