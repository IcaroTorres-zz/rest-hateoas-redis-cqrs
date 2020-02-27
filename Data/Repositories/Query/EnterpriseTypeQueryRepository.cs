using AutoMapper;
using Dapper;
using Domain.DTOs.EnterpriseTypes.Inputs;
using Domain.DTOs.EnterpriseTypes.Outputs;
using Domain.Entities;
using Domain.Repositories.Query;
using Domain.Util;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace Data.Repositories.Query
{
    public class EnterpriseTypeQueryRepository : IEnterpriseTypeQueryRepository
    {
        private readonly IMapper _mapper;
        private readonly string _schema;
        private readonly IDbConnection _connection;

        public EnterpriseTypeQueryRepository(IDbConnection connection, IMapper mapper)
        {
            _connection = connection;
            _mapper = mapper;
            _schema = "[dbo]";
        }

        public async Task<EnterpriseTypeOutput> Get(int id)
        {
            _connection.Open();
            using var conn = _connection;

            var sqlGetQuery = new StringBuilder(GetRequiredSqlQuery())
                .AppendLine(string.Format("WHERE {0} = @{1}", nameof(EnterpriseType.Id), nameof(EnterpriseType.Id))).ToString();

            var enterpriseType = (await conn.QueryAsync<EnterpriseType>(sqlGetQuery, new { Id = id }))
                .SingleOrDefault() ?? throw new ApiException(HttpStatusCode.NotFound, "Not Found");

            if (!enterpriseType.Active)
            {
                throw new ApiException(HttpStatusCode.Gone, "Gone! Resource item disabled");
            }

            return _mapper.Map<EnterpriseTypeOutput>(enterpriseType);
        }

        // template query "SELECT * FROM {0} ORDER BY {1] OFFSET {2} ROWS FETCH NEXT {3} ROWS ONLY;";
        public async Task<EnterpriseTypePagination> Query(EnterpriseTypePagination pagination)
        {
            _connection.Open();
            using var conn = _connection;
            var sqlPaginationQuery = new StringBuilder(GetRequiredSqlQuery())
                .AppendLine(string.Format("WHERE ({0} = 1) ", nameof(EnterpriseType.Active)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR {1} LIKE '%' + @{2} + '%') ", nameof(pagination.Name), nameof(EnterpriseType.Name), nameof(pagination.Name)))
                .AppendLine(string.Format("ORDER BY {0} {1} ", pagination.GenerateOrderBy(), pagination.Order))
                .AppendLine(string.Format("OFFSET @{0} ROWS FETCH NEXT @{1} ROWS ONLY;", nameof(pagination.Skip), nameof(pagination.PageLength))).ToString();

            var enterpriseTypes = await conn.QueryAsync<EnterpriseType>(sqlPaginationQuery, pagination);
            pagination. Items = _mapper.Map<IReadOnlyList<EnterpriseTypeOutput>>(enterpriseTypes);

            var sqlCountQuery = GetCountSqlQuery(pagination);
            var totalItems = (await conn.QueryAsync<int>(sqlCountQuery, pagination)).SingleOrDefault();
            pagination.TotalItems = totalItems;

            return pagination;
        }

        private string GetRequiredSqlQuery()
        {
            return string.Format("SELECT * FROM {0}.{1}s ", _schema, nameof(EnterpriseType));
        }

        private string GetCountSqlQuery(EnterpriseTypePagination pagination)
        {
            var sqlBuilder = new StringBuilder(string.Format("SELECT COUNT(*) as count_items FROM {0}.{1}s ", _schema, nameof(EnterpriseType)))
                .AppendLine(string.Format("WHERE ({0} = 1) ", nameof(EnterpriseType.Active)))
                .AppendLine(string.Format("AND (@{0} IS NULL OR {1} LIKE '%' + @{2} + '%') ", nameof(pagination.Name), nameof(EnterpriseType.Name), nameof(pagination.Name)));

            return sqlBuilder.ToString();
        }
    }
}
