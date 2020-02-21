using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Data.Maps
{
    public class InvestorEnterpriseMap : IEntityTypeConfiguration<InvestorEnterprise>
    {
        public void Configure(EntityTypeBuilder<InvestorEnterprise> builder)
        {
            builder.HasKey(ie => new { ie.InvestorId, ie.EnterpriseId });

            builder
                .HasOne(a => a.Investor)
                .WithMany(b => b.InvestorsEnterprises)
                .HasForeignKey(c => c.InvestorId)
                .OnDelete(DeleteBehavior.Restrict);

            builder
                .HasOne(a => a.Enterprise)
                .WithMany(b => b.InvestorsEnterprises)
                .HasForeignKey(c => c.EnterpriseId)
                .OnDelete(DeleteBehavior.Restrict);
        }
    }
}
