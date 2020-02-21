using Domain.Entities;
using Domain.Util;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace Domain.Repositories.Command
{
    public interface IEnterpriseRepository
    {
        Enterprise Get(long id);
        Enterprise GetWithAllNavigations(long id);
        IEnumerable<Enterprise> GetAll();
        IEnumerable<Enterprise> GetAllWithAllNavigations();
        IEnumerable<Enterprise> Query(Expression<Func<Enterprise, bool>> predicate = null);
        IEnumerable<Enterprise> QueryWithAllNavigations(Expression<Func<Enterprise, bool>> predicate = null);
        Pagination<Enterprise> Paginate(Pagination<Enterprise> pagination);
        Enterprise Insert(Enterprise entity);
        IEnumerable<Enterprise> InsertMany(IEnumerable<Enterprise> entities);
        Enterprise Remove(Enterprise entity);
        Enterprise Remove(long id);
        IEnumerable<Enterprise> RemoveMany(IEnumerable<Enterprise> entities);
        IEnumerable<Enterprise> RemoveMany(IEnumerable<long> ids);
    }
}
