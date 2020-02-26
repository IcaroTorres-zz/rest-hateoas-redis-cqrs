using AutoMapper;
using Dapper;
using Domain.DTOs.EnterpriseTypes.Inputs;
using Domain.DTOs.EnterpriseTypes.Outputs;
using Domain.Entities;
using Domain.Repositories.Query;
using Domain.Util;
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
            var sqlBuilder = new StringBuilder(GetRequiredSqlQuery()).Append($"WHERE {nameof(EnterpriseType.Id)} = @{nameof(EnterpriseType.Id)}");
            var sql = sqlBuilder.ToString();
            var enterpriseType = (await conn.QueryAsync<EnterpriseType>(sql, new { Id = id })).SingleOrDefault() ?? throw new ApiException(HttpStatusCode.NotFound, "Not Found");
            if (!enterpriseType.Active)
            {
                throw new ApiException(HttpStatusCode.Gone, "Gone! Resource item disabled");
            }

            return _mapper.Map<EnterpriseTypeOutput>(enterpriseType);
        }

        public async Task<IReadOnlyList<EnterpriseTypeOutput>> Query(EnterpriseTypeIndexFilterInput filter)
        {
            _connection.Open();
            using var conn = _connection;
            var sqlBuilder = new StringBuilder(GetRequiredSqlQuery())
                .Append($"WHERE ({nameof(EnterpriseType.Active)} = 1) ")
                .Append($"AND (@{nameof(filter.NameWith)} IS NULL OR {nameof(EnterpriseType.Name)} LIKE '%' + @{nameof(filter.NameWith)} + '%')");
            var enterpriseTypes = await conn.QueryAsync<EnterpriseType>(sqlBuilder.ToString(), filter);
            var output = _mapper.Map<IReadOnlyList<EnterpriseTypeOutput>>(enterpriseTypes);

            return output;
        }

        public Pagination<EnterpriseTypeOutput> Paginate(Pagination<EnterpriseTypeOutput> pagination)
        {
            //pagination.Items = _baseRepository.Paginate(new Pagination<Enterprise>
            //{
            //    Page = pagination.Page,
            //    PageLength = pagination.PageLength,
            //    Term = pagination.Term,
            //    Order = pagination.Order,
            //    Column = pagination.Column,
            //    TotalInPage = pagination.TotalInPage,
            //    Total = pagination.Total,
            //    Items = new List<Enterprise>(),
            //    Length = pagination.Length
            //}).Items
            //.AsQueryable()
            //.ProjectTo<EnterpriseOutput>(_mapper.ConfigurationProvider).ToList();

            return pagination;
        }

        private string GetRequiredSqlQuery()
        {
            return @$"SELECT * FROM {_schema}.{nameof(EnterpriseType)}s ";
        }
    }
}
