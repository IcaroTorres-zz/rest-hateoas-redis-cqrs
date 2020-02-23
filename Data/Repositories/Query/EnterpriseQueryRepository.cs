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

        public EnterpriseOutput Get(long id)
        {
            _connection.Open();
            using var conn = _connection;
            var sqlBuilder = new StringBuilder(GetRequiredSqlQuery()).Append($"AND [E].{nameof(Enterprise.Id)} = @{nameof(Enterprise.Id)}");
            var sql = sqlBuilder.ToString();
            var enterprise = conn.Query(sql, GetLambdaFunction(), new { Id = id })
                .SingleOrDefault() ?? throw new ApiException(HttpStatusCode.NotFound, "Not Found");

            return _mapper.Map<EnterpriseOutput>(enterprise);
        }

        public IReadOnlyList<EnterpriseOutput> Query(EnterpriseIndexFilterInput filter)
        {
            _connection.Open();
            using var conn = _connection;
            var sqlBuilder = new StringBuilder(GetRequiredSqlQuery())
                .Append($"AND (@{nameof(filter.Name)} IS NULL OR [E].{nameof(Enterprise.Name)} = @{nameof(filter.Name)})")
                .Append($"AND (@{nameof(filter.EnterpriseTypeId)} IS NULL OR [E].{nameof(Enterprise.EnterpriseTypeId)} = @{nameof(filter.EnterpriseTypeId)})")
                .Append($"AND (@{nameof(filter.Phone)} IS NULL OR [E].{nameof(Enterprise.Phone)} = @{nameof(filter.Phone)})")
                .Append($"AND (@{nameof(filter.Twitter)} IS NULL OR [E].{nameof(Enterprise.Twitter)} = @{nameof(filter.Twitter)})")
                .Append($"AND (@{nameof(filter.Facebook)} IS NULL OR [E].{nameof(Enterprise.Facebook)} = @{nameof(filter.Facebook)})")
                .Append($"AND (@{nameof(filter.Linkedin)} IS NULL OR [E].{nameof(Enterprise.Linkedin)} = @{nameof(filter.Linkedin)})")
                .Append($"AND (@{nameof(filter.Email)} IS NULL OR [E].{nameof(Enterprise.Email)} = @{nameof(filter.Email)})")
                .Append($"AND (@{nameof(filter.City)} IS NULL OR [E].{nameof(Enterprise.City)} = @{nameof(filter.City)})")
                .Append($"AND (@{nameof(filter.Country)} IS NULL OR [E].{nameof(Enterprise.Country)} = @{nameof(filter.Country)})")
                .Append($"AND (@{nameof(filter.Value)} IS NULL OR [E].{nameof(Enterprise.Value)} = @{nameof(filter.Value)})")
                .Append($"AND (@{nameof(filter.Id)} IS NULL OR [E].{nameof(Enterprise.Id)} = @{nameof(filter.Id)})")
                .Append($"AND (@{nameof(filter.OwnEnterprise)} IS NULL OR [E].{nameof(Enterprise.OwnEnterprise)} = @{nameof(filter.OwnEnterprise)})");
            var sql = sqlBuilder.ToString();
            var enterprises = conn.Query(sql, GetLambdaFunction(), filter).ToList();
            var output = _mapper.Map<List<EnterpriseOutput>>(enterprises);

            return output;
        }

        public Pagination<EnterpriseOutput> Paginate(Pagination<EnterpriseOutput> pagination)
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
            return @$"SELECT [E].*, [T].* 
                FROM {_schema}.{nameof(Enterprise)}s [E]
                JOIN {_schema}.{nameof(EnterpriseType)}s [T] ON [E].{nameof(Enterprise.EnterpriseTypeId)} = [T].{nameof(EnterpriseType.Id)}
                WHERE ([E].{nameof(Enterprise.Active)} = 1 AND [T].{nameof(EnterpriseType.Active)} = 1)";
        }
        private Func<Enterprise, EnterpriseType, Enterprise> GetLambdaFunction()
        {
            return (enterprise, type) => { enterprise.EnterpriseType = type; return enterprise; };
        }
    }
}
