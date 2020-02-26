using AutoMapper;
using Dapper;
using Domain.DTOs.Investors.Inputs;
using Domain.DTOs.Investors.Outputs;
using Domain.Entities;
using Domain.Repositories.Query;
using Domain.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace Data.Repositories.Query
{
    public class InvestorQueryRepository : IInvestorQueryRepository
    {
        private readonly IMapper _mapper;
        private readonly string _schema;
        private readonly IDbConnection _connection;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="connection"></param>
        /// <param name="mapper"></param>
        public InvestorQueryRepository(IDbConnection connection, IMapper mapper)
        {
            _connection = connection;
            _mapper = mapper;
            _schema = "[dbo]";
        }

        /// <summary>
        /// Get an active Investor by Id with Its active enterprises for theirs active enterprise types associated
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public async Task<InvestorOutput> GetAsync(long id)
        {
            _connection.Open();
            using var conn = _connection;
            var sqlBuilder = new StringBuilder(GenerateBaseSqlQuery())
                .Append($"AND ([I].{nameof(Investor.Id)} = @{nameof(Investor.Id)})");
            var investor = (await conn.QueryAsync(sqlBuilder.ToString(), GetLambdaFunction(), new { Id = id }))
                .SingleOrDefault() ?? throw new ApiException(HttpStatusCode.NotFound, "Not Found");
            if (!investor.Active)
            {
                throw new ApiException(HttpStatusCode.Gone, "Gone! Resource item disabled");
            }

            return _mapper.Map<InvestorOutput>(investor);
        }

        /// <summary>
        /// Query active Investors with Its active enterprises for theirs active enterprise types associated
        /// </summary>
        /// <param name="filter"></param>
        /// <returns></returns>
        public async Task<IReadOnlyList<InvestorOutput>> Query(InvestorIndexFilterInput filter)
        {
            _connection.Open();
            using var conn = _connection;
            var sqlBuilder = new StringBuilder(GenerateBaseSqlQuery())
                .Append($"AND [I].{nameof(Investor.Active)} = 1 ")
                .Append($"AND (@{ nameof(filter.Name)} IS NULL OR [I].{nameof(Investor.Name)} = @{nameof(filter.Name)}) ")
                .Append($"AND (@{nameof(filter.Id)} IS NULL OR [I].{nameof(Investor.Id)} = @{nameof(filter.Id)}) ")
                .Append($"AND (@{nameof(filter.PortfolioValue)} IS NULL OR [I].{nameof(Investor.PortfolioValue)} = @{nameof(filter.PortfolioValue)}) ")
                .Append($"AND (@{nameof(filter.Balance)} IS NULL OR [I].{nameof(Investor.Balance)} = @{nameof(filter.Balance)}) ")
                .Append($"AND (@{nameof(filter.EnterpriseId)} IS NULL OR [I].{nameof(Investor.EnterpriseId)} = @{nameof(filter.EnterpriseId)}) ")
                .Append($"AND (@{nameof(filter.Email)} IS NULL OR [I].{nameof(Investor.Email)} = @{nameof(filter.Email)}) ")
                .Append($"AND (@{nameof(filter.City)} IS NULL OR [I].{nameof(Investor.City)} = @{nameof(filter.City)}) ")
                .Append($"AND (@{nameof(filter.Country)} IS NULL OR [I].{nameof(Investor.Country)} = @{nameof(filter.Country)}) ")
                .Append($"AND (@{nameof(filter.SuperAngel)} IS NULL OR [I].{nameof(Investor.SuperAngel)} = @{nameof(filter.SuperAngel)}) ")
                .Append($"AND (@{nameof(filter.FirstAccess)} IS NULL OR [I].{nameof(Investor.FirstAccess)} = @{nameof(filter.FirstAccess)}) ");
            var investors = await conn.QueryAsync(sqlBuilder.ToString(), GetLambdaFunction(), filter);
            return _mapper.Map<IReadOnlyList<InvestorOutput>>(investors);
        }

        private string GenerateBaseSqlQuery()
        {
            return @$"SELECT [I].*, [E].Id, [E].Name, [E].EnterpriseTypeId, [E].Active, [E].Value, [T].*, [IE].* 
                FROM {_schema}.{nameof(Investor)}s [I]
                JOIN {_schema}.{nameof(InvestorEnterprise)} [IE] ON [IE].InvestorId = [I].Id
                JOIN {_schema}.{nameof(Enterprise)}s [E] ON [IE].EnterpriseId = [E].Id
                JOIN {_schema}.{nameof(EnterpriseType)}s [T] ON [E].EnterpriseTypeId = [T].Id
                WHERE ([E].{nameof(Enterprise.Active)} = 1 AND [T].{nameof(EnterpriseType.Active)} = 1) ";
        }

        private Func<Investor, List<InvestorEnterprise>, List<Enterprise>, List<EnterpriseType>, Investor> GetLambdaFunction()
        {
            return (investor, investorEnterprises, enterprises, types) =>
            {
                enterprises.ForEach(e => e.EnterpriseType = types.First(t => t.Id == e.EnterpriseTypeId));
                investorEnterprises.ForEach(ie =>
                {
                    ie.Investor = investor;
                    ie.Enterprise = enterprises.First(e => e.Id == ie.EnterpriseId);
                });
                investor.InvestorsEnterprises = investorEnterprises;
                investor.Enterprise = enterprises.FirstOrDefault(e => e.Id == investor.EnterpriseId);
                return investor;
            };
        }

        /// <summary>
        /// Paginates
        /// </summary>
        /// <param name="pagination"></param>
        /// <returns></returns>
        public Pagination<InvestorOutput> Paginate(Pagination<InvestorOutput> pagination)
        {
            //pagination.Items = _baseRepository.Paginate(new Pagination<Investor>
            //{
            //    Page = pagination.Page,
            //    PageLength = pagination.PageLength,
            //    Term = pagination.Term,
            //    Order = pagination.Order,
            //    Column = pagination.Column,
            //    TotalInPage = pagination.TotalInPage,
            //    Total = pagination.Total,
            //    Items = new List<Investor>(),
            //    Length = pagination.Length
            //}).Items
            //.AsQueryable()
            //.ProjectTo<InvestorOutput>(_mapper.ConfigurationProvider).ToList();

            return pagination;
        }
    }
}
