using Domain.Entities;
using Domain.Util;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace Domain.Repositories.Command
{
    public interface IEnterpriseTypeRepository
    {
        EnterpriseType Get(int id);
        EnterpriseType GetWithAllNavigations(int id);
        IEnumerable<EnterpriseType> GetAll();
        IEnumerable<EnterpriseType> GetAllWithAllNavigations();
        IEnumerable<EnterpriseType> Query(Expression<Func<EnterpriseType, bool>> predicate = null);
        IEnumerable<EnterpriseType> QueryWithAllNavigations(Expression<Func<EnterpriseType, bool>> predicate = null);
        Pagination<EnterpriseType> Paginate(Pagination<EnterpriseType> pagination);
        EnterpriseType Insert(EnterpriseType entity);
        IEnumerable<EnterpriseType> InsertMany(IEnumerable<EnterpriseType> entities);
        EnterpriseType Remove(EnterpriseType entity);
        EnterpriseType Remove(int id);
        IEnumerable<EnterpriseType> RemoveMany(IEnumerable<EnterpriseType> entities);
        IEnumerable<EnterpriseType> RemoveMany(IEnumerable<int> ids);
    }
}
