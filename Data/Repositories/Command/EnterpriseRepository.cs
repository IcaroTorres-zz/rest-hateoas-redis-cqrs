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
    public class EnterpriseRepository : IEnterpriseRepository
    {
        private readonly IRepository<Enterprise> _baseRepository;

        public EnterpriseRepository(IRepository<Enterprise> baseRepo)
        {
            _baseRepository = baseRepo;
        }

        public Enterprise Get(long id)
        {
            return _baseRepository.GetWithKeys(new[] { (object)id });
        }

        public Enterprise GetWithAllNavigations(long id)
        {
            return QueryWithAllNavigations().FirstOrDefault(i => i.Id == id);
        }

        public IEnumerable<Enterprise> GetAll()
        {
            return _baseRepository.GetAll();
        }

        public IEnumerable<Enterprise> GetAllWithAllNavigations()
        {
            return QueryWithAllNavigations();
        }

        public IEnumerable<Enterprise> Query(Expression<Func<Enterprise, bool>> predicate = null)
        {
            return _baseRepository.Query(predicate);
        }

        public IEnumerable<Enterprise> QueryWithAllNavigations(Expression<Func<Enterprise, bool>> predicate = null)
        {
            return _baseRepository
                .Query(predicate)
                .Include(e => e.EnterpriseType)
                .Include(e => e.InvestorsEnterprises)
                .ThenInclude(ie => ie.Investor);
        }

        public Pagination<Enterprise> Paginate(Pagination<Enterprise> pagination)
        {
            return _baseRepository.Paginate(pagination);
        }

        public Enterprise Insert(Enterprise enterprise)
        {
            return _baseRepository.Insert(enterprise);
        }

        public IEnumerable<Enterprise> InsertMany(IEnumerable<Enterprise> enterprises)
        {
            return _baseRepository.InsertMany(enterprises);
        }

        public Enterprise Remove(Enterprise enterprise)
        {
            return _baseRepository.Remove(enterprise);
        }

        public Enterprise Remove(long id)
        {
            return _baseRepository.Remove(id);
        }

        public IEnumerable<Enterprise> RemoveMany(IEnumerable<Enterprise> enterprises)
        {
            return _baseRepository.RemoveMany(enterprises);
        }

        public IEnumerable<Enterprise> RemoveMany(IEnumerable<long> ids)
        {
            var enterprises = GetAll().Join(ids, e => e.Id, id => id, (e, id) => e);

            return _baseRepository.RemoveMany(enterprises);
        }
    }
}
