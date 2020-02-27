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
                .AppendLine($"AND ([I].{nameof(Investor.Id)} = @{nameof(Investor.Id)})");
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
        /// <param name="pagination"></param>
        /// <returns></returns>
        public async Task<InvestorPagination> Query(InvestorPagination pagination)
        {
            _connection.Open();
            using var conn = _connection;
            var sqlBuilder = new StringBuilder(GenerateBaseSqlQuery())
                .AppendLine(string.Format("AND [I].{0} = 1 ", nameof(Investor.Active)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Name), nameof(Investor.Name), nameof(pagination.Name)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Id), nameof(Investor.Id), nameof(pagination.Id)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.PortfolioValue), nameof(Investor.PortfolioValue), nameof(pagination.PortfolioValue)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Balance), nameof(Investor.Balance), nameof(pagination.Balance)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.EnterpriseId), nameof(Investor.EnterpriseId), nameof(pagination.EnterpriseId)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Email), nameof(Investor.Email), nameof(pagination.Email)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.City), nameof(Investor.City), nameof(pagination.City)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Country), nameof(Investor.Country), nameof(pagination.Country)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.FirstAccess), nameof(Investor.FirstAccess), nameof(pagination.FirstAccess)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.SuperAngel), nameof(Investor.SuperAngel), nameof(pagination.SuperAngel)))
                .AppendLine(string.Format("ORDER BY {0} {1} ", pagination.GenerateOrderBy(), pagination.Order))
                .AppendLine(string.Format("OFFSET @{0} ROWS FETCH NEXT @{1} ROWS ONLY;", nameof(pagination.Skip), nameof(pagination.PageLength))).ToString();

            var investors = await conn.QueryAsync(sqlBuilder.ToString(), GetLambdaFunction(), pagination);
            pagination.Items = _mapper.Map<IReadOnlyList<InvestorOutput>>(investors);

            var sqlCountQuery = GetCountSqlQuery(pagination);
            var TotalItems = (await conn.QueryAsync<int>(sqlCountQuery, pagination)).SingleOrDefault();
            pagination.TotalItems = TotalItems;

            return pagination;
        }

        private string GenerateBaseSqlQuery()
        {
            return new StringBuilder(string.Format("SELECT [I].*, [E].{0}, [E].{1}, [E].{2}, [E].{3}, [E].{4}, [T].*, [IE].* ", 
                nameof(Enterprise.Id), nameof(Enterprise.Name), nameof(Enterprise.EnterpriseTypeId), nameof(Enterprise.Active), nameof(Enterprise.Value)))
                .AppendLine(string.Format("FROM {0}.{1}s [I]", _schema, nameof(Investor)))
                .AppendLine(string.Format("JOIN {0}.{1} [IE] ON [IE].{2} = [I].{3}", _schema, nameof(InvestorEnterprise), nameof(InvestorEnterprise.InvestorId), nameof(Investor.Id)))
                .AppendLine(string.Format("JOIN {0}.{1}s [E] ON [IE].{2} = [E].{3}", _schema, nameof(Enterprise), nameof(InvestorEnterprise.EnterpriseId), nameof(Enterprise.Id)))
                .AppendLine(string.Format("JOIN {0}.{1}s [T] ON [E].{2} = [T].{3})", _schema, nameof(EnterpriseType), nameof(Enterprise.EnterpriseTypeId), nameof(EnterpriseType.Id)))
                .AppendLine(string.Format("WHERE ([E].{0} = 1 AND [T].{1} = 1) ", nameof(Enterprise.Active), nameof(EnterpriseType.Active))).ToString();
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

        private string GetCountSqlQuery(InvestorPagination pagination)
        {
            var sqlBuilder = new StringBuilder(string.Format("SELECT COUNT([I].*) FROM {0}.{1}s [I] ", _schema, nameof(InvestorEnterprise)))
                .AppendLine(string.Format("JOIN {0}.{1} [IE] ON [IE].InvestorId = [I].Id ", _schema, nameof(InvestorEnterprise)))
                .AppendLine(string.Format("JOIN {0}.{1}s [E] ON [IE].EnterpriseId = [E].Id ", _schema, nameof(Enterprise)))
                .AppendLine(string.Format("JOIN {0}.{1}s [T] ON [E].EnterpriseTypeId = [T].Id ", _schema, nameof(EnterpriseType)))
                .AppendLine(string.Format("WHERE ([E].{0} = 1 AND [T].{1} = 1) AND [I].{2} = 1 ", nameof(Enterprise.Active), nameof(EnterpriseType.Active), nameof(Investor.Active)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Name), nameof(Investor.Name), nameof(pagination.Name)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Id), nameof(Investor.Id), nameof(pagination.Id)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.PortfolioValue), nameof(Investor.PortfolioValue), nameof(pagination.PortfolioValue)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Balance), nameof(Investor.Balance), nameof(pagination.Balance)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.EnterpriseId), nameof(Investor.EnterpriseId), nameof(pagination.EnterpriseId)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Email), nameof(Investor.Email), nameof(pagination.Email)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.City), nameof(Investor.City), nameof(pagination.City)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Country), nameof(Investor.Country), nameof(pagination.Country)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.FirstAccess), nameof(Investor.FirstAccess), nameof(pagination.FirstAccess)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.SuperAngel), nameof(Investor.SuperAngel), nameof(pagination.SuperAngel)));

            return sqlBuilder.ToString();
        }
    }
}
