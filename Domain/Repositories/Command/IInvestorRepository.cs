using Domain.Entities;
using Domain.Util;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace Domain.Repositories.Command
{
    public interface IInvestorRepository
    {
        Investor Get(long id);
        Investor GetWithAllNavigations(long id);
        IEnumerable<Investor> GetAll();
        IEnumerable<Investor> GetAllWithAllNavigations();
        IEnumerable<Investor> Query(Expression<Func<Investor, bool>> predicate = null);
        IEnumerable<Investor> QueryWithAllNavigations(Expression<Func<Investor, bool>> predicate = null);
        Pagination<Investor> Paginate(Pagination<Investor> pagination);
        Investor Insert(Investor entity);
        IEnumerable<Investor> InsertMany(IEnumerable<Investor> entities);
    }
}
