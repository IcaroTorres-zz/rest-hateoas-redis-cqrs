using API.Cache;
using API.Hateoas;
using API.Middleware;
using AutoMapper;
using Data.Context;
using Data.MapperProfiles;
using Data.Repositories;
using Data.Repositories.Command;
using Data.Repositories.Query;
using Data.Unities;
using Domain.DTOs.Enterprises.Outputs;
using Domain.DTOs.EnterpriseTypes.Outputs;
using Domain.DTOs.Investors.Outputs;
using Domain.Entities;
using Domain.Repositories;
using Domain.Repositories.Command;
using Domain.Repositories.Query;
using Domain.Unities;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using Services.ApplicationServices;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace API.Query
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services
                // context acessor for getting things from request and response 
                .AddHttpContextAccessor()

                // data access layer services
                .AddDbContext<EnterpriseContext>(opts =>
                {
                    opts.UseSqlServer(Configuration.GetConnectionString(nameof(EnterpriseContext)));
                    opts.EnableSensitiveDataLogging(); //just for debugging mode
                })

                // sql connection for dapper
                .AddScoped<IDbConnection, SqlConnection>(provider => new SqlConnection(Configuration.GetConnectionString(nameof(EnterpriseContext))))

                // query only repos
                .AddScoped<IEnterpriseQueryRepository, EnterpriseQueryRepository>()
                .AddScoped<IEnterpriseTypeQueryRepository, EnterpriseTypeQueryRepository>()
                .AddScoped<IInvestorQueryRepository, InvestorQueryRepository>()

                // command + query operations base repos
                .AddScoped<IRepository<Enterprise>, Repository<Enterprise>>()
                .AddScoped<IRepository<EnterpriseType>, Repository<EnterpriseType>>()
                .AddScoped<IRepository<Investor>, Repository<Investor>>()

                // specific command + query repos
                .AddScoped<IEnterpriseRepository, EnterpriseRepository>()
                .AddScoped<IInvestorRepository, InvestorRepository>()
                .AddScoped<IEnterpriseTypeRepository, EnterpriseTypeRepository>()

                // unit of work
                .AddScoped<IUnitOfEnterprises, UnitOfEnterprises>()

                // application services
                .AddScoped<IEnterpriseFacade, EnterpriseService>()
                .AddScoped<IEnterpriseTypeFacade, EnterpriseTypeService>()
                .AddScoped<IInvestorFacade, InvestorService>()

                // automapper services and profiles
                .AddAutoMapper(typeof(DomainToOutputProfile))

                // Ativando o uso de cache via Redis
                .AddRedisResponseCacheService(Configuration)

                // only the basic .net core services without other resources added by default .AddMvc()
                .AddMvcCore()

                // adding json formatters to let our application parse the response output as json
                .AddJsonFormatters(jsonSerializerSettings =>
                {
                    jsonSerializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
                    jsonSerializerSettings.NullValueHandling = NullValueHandling.Include;
                })

                // custom hateoas resouces options for JsonHateoasFormatter
                .AddHateoasResources(options =>
                {
                    options.AddLink<List<EnterpriseOutput>>("create-enterprise");
                    options.AddLink<EnterpriseOutput>("get-enterprise", e => new { id = e.Id });
                    options.AddLink<EnterpriseOutput>("update-enterprise", e => new { id = e.Id });
                    options.AddLink<EnterpriseOutput>("delete-enterprise", e => new { id = e.Id });
                    options.AddLink<EnterpriseOutput>("get-enterprises");

                    options.AddLink<List<EnterpriseTypeOutput>>("create-enterprise-type");
                    options.AddLink<EnterpriseTypeOutput>("get-enterprise-type", e => new { id = e.Id });
                    options.AddLink<EnterpriseTypeOutput>("update-enterprise-type", e => new { id = e.Id });
                    options.AddLink<EnterpriseTypeOutput>("update-enterprise-type-properties", e => new { id = e.Id });
                    options.AddLink<EnterpriseTypeOutput>("disable-enterprise-type", e => new { id = e.Id });
                    options.AddLink<EnterpriseTypeOutput>("get-enterprise-types");

                    options.AddLink<List<InvestorOutput>>("create-investor");
                    options.AddLink<InvestorOutput>("get-investor", e => new { id = e.Id });
                    options.AddLink<InvestorOutput>("update-investor", e => new { id = e.Id });
                    options.AddLink<InvestorOutput>("update-investor-properties", e => new { id = e.Id });
                    options.AddLink<InvestorOutput>("disable-investor", e => new { id = e.Id });
                    options.AddLink<InvestorOutput>("get-investors");
                })
                .SetCompatibilityVersion(CompatibilityVersion.Version_2_2);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            app
                .UseMiddleware<ExceptionMiddleware>()
                .UseHttpsRedirection()
                .UseMvc();
        }
    }
}
