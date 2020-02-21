using AutoMapper;
using AutoMapper.QueryableExtensions;
using Domain.DTOs.Investors.Inputs;
using Domain.DTOs.Investors.Outputs;
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
    public class InvestorQueryRepository : IInvestorQueryRepository
    {
        private readonly IQueryableRepository<Investor> _baseRepository;
        private readonly IMapper _mapper;

        public InvestorQueryRepository(IQueryableRepository<Investor> baseRepo, IMapper mapper)
        {
            _baseRepository = baseRepo;
            _mapper = mapper;
        }

        public InvestorOutput Get(long id)
        {
            return GetQueryable(e => e.Active && e.Id == id)
                .ProjectTo<InvestorOutput>(_mapper.ConfigurationProvider)
                .FirstOrDefault() ?? throw new ApiException(HttpStatusCode.NotFound, "Not Found");
        }

        public IReadOnlyList<InvestorOutput> Query(InvestorIndexFilterInput input)
        {
            var filterObject = _mapper.Map<Investor>(input);

            return GetQueryable(e => e.Active
                && (filterObject.Name == e.Name || string.IsNullOrWhiteSpace(input.Name))
                && (filterObject.Id == e.Id || input.Id == null)
                && (filterObject.PortfolioValue == e.PortfolioValue || input.PortfolioValue == null)
                && (filterObject.Balance == e.Balance || input.Balance == null)
                && (filterObject.EnterpriseId == e.EnterpriseId || input.EnterpriseId == null)
                && (filterObject.Email == e.Email || string.IsNullOrWhiteSpace(input.Email))
                && (filterObject.City == e.City || string.IsNullOrWhiteSpace(input.City))
                && (filterObject.Country == e.Country || string.IsNullOrWhiteSpace(input.Country))
                && (filterObject.SuperAngel == e.SuperAngel || input.SuperAngel == null)
                && (filterObject.FirstAccess == e.FirstAccess || input.FirstAccess == null))
                .ProjectTo<InvestorOutput>(_mapper.ConfigurationProvider).ToList();
        }

        private IQueryable<Investor> GetQueryable(Expression<Func<Investor, bool>> predicate)
        {
            return _baseRepository
                .Query(predicate, readOnly: true)
                .Include(i => i.Enterprise)
                .Include(i => i.InvestorsEnterprises)
                .ThenInclude(ie => ie.Enterprise)
                .ThenInclude(e => e.EnterpriseType);
        }


        public Pagination<InvestorOutput> Paginate(Pagination<InvestorOutput> pagination)
        {
            pagination.Items = _baseRepository.Paginate(new Pagination<Investor>
            {
                Page = pagination.Page,
                PageLength = pagination.PageLength,
                Term = pagination.Term,
                Order = pagination.Order,
                Column = pagination.Column,
                TotalInPage = pagination.TotalInPage,
                Total = pagination.Total,
                Items = new List<Investor>(),
                Length = pagination.Length
            }).Items
            .AsQueryable()
            .ProjectTo<InvestorOutput>(_mapper.ConfigurationProvider).ToList();

            return pagination;
        }
    }
}
