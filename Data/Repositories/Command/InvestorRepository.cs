using Domain.Entities;
using Domain.Repositories;
using Domain.Repositories.Command;
using Domain.Util;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace Data.Repositories.Command
{
    public class InvestorRepository : IInvestorRepository
    {
        private readonly IRepository<Investor> _baseRepository;

        public InvestorRepository(IRepository<Investor> baseRepo)
        {
            _baseRepository = baseRepo;
        }

        public Investor Get(long id)
        {
            return _baseRepository.GetWithKeys(new[] { (object)id });
        }

        public Investor GetWithAllNavigations(long id)
        {
            return QueryWithAllNavigations().FirstOrDefault(i => i.Id == id);
        }

        public IEnumerable<Investor> GetAll()
        {
            return _baseRepository.GetAll();
        }

        public IEnumerable<Investor> GetAllWithAllNavigations()
        {
            return QueryWithAllNavigations();
        }

        public IEnumerable<Investor> Query(Expression<Func<Investor, bool>> predicate = null)
        {
            return _baseRepository.Query(predicate);
        }

        public IEnumerable<Investor> QueryWithAllNavigations(Expression<Func<Investor, bool>> predicate = null)
        {
            return _baseRepository
                .Query(predicate)
                .Include(i => i.Enterprise)
                .Include(i => i.InvestorsEnterprises)
                .ThenInclude(ie => ie.Enterprise)
                .ThenInclude(e => e.EnterpriseType);
        }

        public Pagination<Investor> Paginate(Pagination<Investor> pagination)
        {
            return _baseRepository.Paginate(pagination);
        }

        public Investor Insert(Investor enterprise)
        {
            return _baseRepository.Insert(enterprise);
        }

        public IEnumerable<Investor> InsertMany(IEnumerable<Investor> enterprises)
        {
            return _baseRepository.InsertMany(enterprises);
        }

        public Investor Remove(Investor enterprise)
        {
            return _baseRepository.Remove(enterprise);
        }

        public Investor Remove(long id)
        {
            return _baseRepository.Remove(id);
        }

        public IEnumerable<Investor> RemoveMany(IEnumerable<Investor> enterprises)
        {
            return _baseRepository.RemoveMany(enterprises);
        }

        public IEnumerable<Investor> RemoveMany(IEnumerable<long> ids)
        {
            var enterprises = GetAll().Join(ids, e => e.Id, id => id, (e, id) => e);

            return _baseRepository.RemoveMany(enterprises);
        }
    }
}
