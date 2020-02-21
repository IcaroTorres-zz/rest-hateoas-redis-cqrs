using Domain.Entities;
using Domain.Repositories;
using Domain.Repositories.Command;
using Domain.Util;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace Data.Repositories
{
    public class EnterpriseTypeRepository : IEnterpriseTypeRepository
    {
        private readonly IRepository<EnterpriseType> _baseRepository;

        public EnterpriseTypeRepository(IRepository<EnterpriseType> baseRepo)
        {
            _baseRepository = baseRepo;
        }

        public EnterpriseType Get(int id)
        {
            return _baseRepository.GetWithKeys(new[] { (object)id });
        }

        public EnterpriseType GetWithAllNavigations(int id)
        {
            return QueryWithAllNavigations().FirstOrDefault(i => i.Id == id);
        }

        public IEnumerable<EnterpriseType> GetAll()
        {
            return _baseRepository.GetAll();
        }

        public IEnumerable<EnterpriseType> GetAllWithAllNavigations()
        {
            return QueryWithAllNavigations();
        }

        public IEnumerable<EnterpriseType> Query(Expression<Func<EnterpriseType, bool>> predicate = null)
        {
            return _baseRepository.Query(predicate);
        }

        public IEnumerable<EnterpriseType> QueryWithAllNavigations(Expression<Func<EnterpriseType, bool>> predicate = null)
        {
            return _baseRepository.Query(predicate).Include(et => et.Enterprises);
        }
        public Pagination<EnterpriseType> Paginate(Pagination<EnterpriseType> pagination)
        {
            return _baseRepository.Paginate(pagination);
        }

        public EnterpriseType Insert(EnterpriseType enterprise)
        {
            return _baseRepository.Insert(enterprise);
        }

        public IEnumerable<EnterpriseType> InsertMany(IEnumerable<EnterpriseType> enterprises)
        {
            return _baseRepository.InsertMany(enterprises);
        }

        public EnterpriseType Remove(EnterpriseType enterprise)
        {
            return _baseRepository.Remove(enterprise);
        }

        public EnterpriseType Remove(int id)
        {
            return _baseRepository.Remove(id);
        }

        public IEnumerable<EnterpriseType> RemoveMany(IEnumerable<EnterpriseType> enterprises)
        {
            return _baseRepository.RemoveMany(enterprises);
        }

        public IEnumerable<EnterpriseType> RemoveMany(IEnumerable<int> ids)
        {
            var enterprises = GetAll().Join(ids, e => e.Id, id => id, (e, id) => e);

            return _baseRepository.RemoveMany(enterprises);
        }
    }
}
