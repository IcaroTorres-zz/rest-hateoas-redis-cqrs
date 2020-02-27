using AutoMapper;
using Dapper;
using Domain.DTOs.Enterprises.Inputs;
using Domain.DTOs.Enterprises.Outputs;
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
    public class EnterpriseQueryRepository : IEnterpriseQueryRepository
    {
        private readonly IMapper _mapper;
        private readonly string _schema;
        private readonly IDbConnection _connection;

        public EnterpriseQueryRepository(IDbConnection connection, IMapper mapper)
        {
            _connection = connection;
            _mapper = mapper;
            _schema = "[dbo]";
        }

        public async Task<EnterpriseOutput> Get(long id)
        {
            _connection.Open();
            using var conn = _connection;

            var sqlGetQuery = new StringBuilder(GetRequiredSqlQuery())
                .AppendLine(string.Format("AND [E].{0} = @{1}", nameof(Enterprise.Id), nameof(Enterprise.Id))).ToString();

            var enterprise = (await conn.QueryAsync(sqlGetQuery, GetLambdaFunction(), new { Id = id }))
                .SingleOrDefault() ?? throw new ApiException(HttpStatusCode.NotFound, "Not Found");

            return _mapper.Map<EnterpriseOutput>(enterprise);
        }

        public async Task<EnterprisePagination> Query(EnterprisePagination pagination)
        {
            _connection.Open();
            using var conn = _connection;
            var sqlBuilder = new StringBuilder(GetRequiredSqlQuery())
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Name), nameof(Enterprise.Name), nameof(pagination.Name)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.EnterpriseTypeId), nameof(Enterprise.EnterpriseTypeId), nameof(pagination.EnterpriseTypeId)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Phone), nameof(Enterprise.Phone), nameof(pagination.Phone)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Twitter), nameof(Enterprise.Twitter), nameof(pagination.Twitter)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Facebook), nameof(Enterprise.Facebook), nameof(pagination.Facebook)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Linkedin), nameof(Enterprise.Linkedin), nameof(pagination.Linkedin)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Id), nameof(Enterprise.Id), nameof(pagination.Id)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Email), nameof(Enterprise.Email), nameof(pagination.Email)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.OwnEnterprise), nameof(Enterprise.OwnEnterprise), nameof(pagination.OwnEnterprise)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.City), nameof(Enterprise.City), nameof(pagination.City)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Country), nameof(Enterprise.Country), nameof(pagination.Country)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Value), nameof(Enterprise.Value), nameof(pagination.Value)))
                .AppendLine(string.Format("ORDER BY {0} {1} ", pagination.GenerateOrderBy(), pagination.Order))
                .AppendLine(string.Format("OFFSET @{0} ROWS FETCH NEXT @{1} ROWS ONLY;", nameof(pagination.Skip), nameof(pagination.PageLength))).ToString();

            var enterprises = await conn.QueryAsync(sqlBuilder.ToString(), GetLambdaFunction(), pagination);
            pagination.Items = _mapper.Map<IReadOnlyList<EnterpriseOutput>>(enterprises);

            var sqlCountQuery = GetCountSqlQuery(pagination);
            var TotalItems = (await conn.QueryAsync<int>(sqlCountQuery, pagination)).SingleOrDefault();
            pagination.TotalItems = TotalItems;

            return pagination;
        }

        private string GetRequiredSqlQuery()
        {
            return new StringBuilder(string.Format("SELECT [E].*, [T].* FROM {0}.{1}s [E] JOIN {0}.{1}s [T] ", _schema, nameof(Enterprise), _schema, nameof(EnterpriseType)))
                .AppendLine(string.Format("ON [E].{0} = [T].{1}", nameof(Enterprise.EnterpriseTypeId), nameof(EnterpriseType.Id)))
                .AppendLine(string.Format("WHERE ([E].{0} = 1 AND [T].{1} = 1)", nameof(Enterprise.Active), nameof(EnterpriseType.Active))).ToString();
        }
        private Func<Enterprise, EnterpriseType, Enterprise> GetLambdaFunction()
        {
            return (enterprise, type) => { enterprise.EnterpriseType = type; return enterprise; };
        }

        private string GetCountSqlQuery(EnterprisePagination pagination)
        {
            var sqlBuilder = new StringBuilder(string.Format("SELECT COUNT([E].*) FROM {0}.{1}s [E] ", _schema, nameof(Enterprise)))
                .AppendLine(string.Format("JOIN {0}.{1}s [T] ON [E].{2} = [T].{3} ", _schema, nameof(EnterpriseType), nameof(Enterprise.EnterpriseTypeId), nameof(EnterpriseType.Id)))
                .AppendLine(string.Format("WHERE ([E].{0} = 1 AND [T].{1} = 1) ", nameof(Enterprise.Active), nameof(EnterpriseType.Active)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Name), nameof(Enterprise.Name), nameof(pagination.Name)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.EnterpriseTypeId), nameof(Enterprise.EnterpriseTypeId), nameof(pagination.EnterpriseTypeId)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Phone), nameof(Enterprise.Phone), nameof(pagination.Phone)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Twitter), nameof(Enterprise.Twitter), nameof(pagination.Twitter)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Facebook), nameof(Enterprise.Facebook), nameof(pagination.Facebook)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Linkedin), nameof(Enterprise.Linkedin), nameof(pagination.Linkedin)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Id), nameof(Enterprise.Id), nameof(pagination.Id)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Email), nameof(Enterprise.Email), nameof(pagination.Email)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.OwnEnterprise), nameof(Enterprise.OwnEnterprise), nameof(pagination.OwnEnterprise)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.City), nameof(Enterprise.City), nameof(pagination.City)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Country), nameof(Enterprise.Country), nameof(pagination.Country)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR [E].{1} = @{2}) ", nameof(pagination.Value), nameof(Enterprise.Value), nameof(pagination.Value)));

            return sqlBuilder.ToString();
        }
    }
}
