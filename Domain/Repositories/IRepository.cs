namespace Domain.Repositories
{
    public interface IRepository<T> : ICommandRepository<T>, IQueryableRepository<T> where T : class
    {
    }
}