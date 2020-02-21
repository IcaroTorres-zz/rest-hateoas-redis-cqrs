using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;

namespace Data.Context
{
    public class EnterpriseContext : DbContext
    {
        public DbSet<Investor> Investors { get; set; }
        public DbSet<Enterprise> Enterprises { get; set; }
        public DbSet<EnterpriseType> EnterpriseTypes { get; set; }

        public EnterpriseContext(DbContextOptions<EnterpriseContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasDefaultSchema("dbo");
            modelBuilder.Ignore<BaseEntity>();
            modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());

            Seed(modelBuilder);
        }

        private void Seed(ModelBuilder modelBuilder)
        {
            using StreamReader stream = new StreamReader("..\\Data\\JsonData\\seed.json");

            var enterprises = JsonConvert.DeserializeObject<List<Enterprise>>(stream.ReadToEnd());
            var enterpriesTypes = enterprises.Select(e => e.EnterpriseType).Distinct(new EnterptiseTypeEqComparer()).ToArray();
            enterprises.ForEach(enterprise =>
            {
                enterprise.EnterpriseTypeId = enterprise.EnterpriseType.Id;
                enterprise.EnterpriseType = null;
            });

            modelBuilder.Entity<EnterpriseType>().HasData(enterpriesTypes);
            modelBuilder.Entity<Enterprise>().HasData(enterprises);
        }
        private class EnterptiseTypeEqComparer : IEqualityComparer<EnterpriseType>
        {
            public bool Equals(EnterpriseType x, EnterpriseType y)
            {
                return (x == null && y == null) || (x.Id == y.Id);
            }

            public int GetHashCode(EnterpriseType obj)
            {
                return obj.Id.GetHashCode();
            }
        }
    }
}
