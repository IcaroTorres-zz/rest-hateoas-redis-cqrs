using AutoMapper;
using AutoMapper.QueryableExtensions;
using Domain.DTOs.Enterprises.Inputs;
using Domain.DTOs.Enterprises.Outputs;
using Domain.Entities;
using Domain.Repositories;
using Domain.Repositories.Query;
using Domain.Util;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Net;

namespace Data.Repositories.Query
{
    public class EnterpriseQueryRepository : IEnterpriseQueryRepository
    {
        private readonly IQueryableRepository<Enterprise> _baseRepository;
        private readonly IMapper _mapper;

        public EnterpriseQueryRepository(IQueryableRepository<Enterprise> baseRepo, IMapper mapper)
        {
            _baseRepository = baseRepo;
            _mapper = mapper;
        }

        public EnterpriseOutput Get(long id)
        {
            return GetQueryable(e => e.Active && e.Id == id)
                .ProjectTo<EnterpriseOutput>(_mapper.ConfigurationProvider)
                .FirstOrDefault() ?? throw new ApiException(HttpStatusCode.NotFound, "Not Found");
        }

        public IReadOnlyList<EnterpriseOutput> Query(EnterpriseIndexFilterInput filter)
        {
            var filterObject = _mapper.Map<Enterprise>(filter);

            // required filters
            return GetQueryable(e => e.Active
                && (filterObject.Name == e.Name || filter.Name == null)
                && (filterObject.EnterpriseTypeId == e.EnterpriseTypeId || filter.EnterpriseTypeId == null)
                && (filterObject.Phone == e.Phone || string.IsNullOrWhiteSpace(filter.Phone))
                && (filterObject.Twitter == e.Twitter || string.IsNullOrWhiteSpace(filter.Twitter))
                && (filterObject.Facebook == e.Facebook || string.IsNullOrWhiteSpace(filter.Facebook))
                && (filterObject.Linkedin == e.Linkedin || string.IsNullOrWhiteSpace(filter.Linkedin))
                && (filterObject.Email == e.Email || string.IsNullOrWhiteSpace(filter.Email))
                && (filterObject.City == e.City || string.IsNullOrWhiteSpace(filter.City))
                && (filterObject.Country == e.Country || string.IsNullOrWhiteSpace(filter.Country))
                && (filterObject.Value == e.Value || filter.Value == null)
                && (filterObject.Id == e.Id || filter.Id == null)
                && (filterObject.OwnEnterprise == e.OwnEnterprise || filter.OwnEnterprise == null))
                .ProjectTo<EnterpriseOutput>(_mapper.ConfigurationProvider).ToList();
        }

        public Pagination<EnterpriseOutput> Paginate(Pagination<EnterpriseOutput> pagination)
        {
            pagination.Items = _baseRepository.Paginate(new Pagination<Enterprise>
            {
                Page = pagination.Page,
                PageLength = pagination.PageLength,
                Term = pagination.Term,
                Order = pagination.Order,
                Column = pagination.Column,
                TotalInPage = pagination.TotalInPage,
                Total = pagination.Total,
                Items = new List<Enterprise>(),
                Length = pagination.Length
            }).Items
            .AsQueryable()
            .ProjectTo<EnterpriseOutput>(_mapper.ConfigurationProvider).ToList();

            return pagination;
        }

        private IQueryable<Enterprise> GetQueryable(Expression<Func<Enterprise, bool>> predicate)
        {
            return _baseRepository
                .Query(predicate, readOnly: true)
                .Include(e => e.EnterpriseType)
                .Include(e => e.Owner)
                .Include(e => e.InvestorsEnterprises);
        }
    }
}
