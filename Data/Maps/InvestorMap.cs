using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Data.Maps
{
    public class InvestorMap : IEntityTypeConfiguration<Investor>
    {
        public void Configure(EntityTypeBuilder<Investor> builder)
        {
            builder.Property(x => x.Id).IsRequired();
            builder.HasKey(x => x.Id);
            builder.Property(x => x.Name).HasColumnType("varchar(50)").IsRequired();
            builder.Property(x => x.Balance).IsRequired().HasColumnType("decimal(8,2)").HasDefaultValue(0);
            builder.Property(x => x.PortfolioValue).IsRequired().HasColumnType("decimal(8,2)").HasDefaultValue(0);
            builder.Property(x => x.FirstAccess).IsRequired().HasDefaultValue(true);
            builder.Property(x => x.SuperAngel).IsRequired().HasDefaultValue(false);
            builder.Property(x => x.Email).HasColumnType("varchar(100)").IsRequired();
            builder.Property(x => x.City).HasColumnType("varchar(50)").IsRequired(false);
            builder.Property(x => x.Country).HasColumnType("varchar(70)").IsRequired(false);
            builder.Property(x => x.CreatedDate).ValueGeneratedOnAdd().HasDefaultValueSql("GETUTCDATE()").IsRequired();
            builder.Property(x => x.ModifiedDate).ValueGeneratedOnAddOrUpdate().HasDefaultValueSql("GETUTCDATE()").IsRequired();

            builder.HasOne(u => u.Enterprise)
                   .WithOne(c => c.Owner)
                   .HasForeignKey<Investor>(c => c.EnterpriseId)
                   .IsRequired(false)
                   .OnDelete(DeleteBehavior.Restrict);

            builder.Ignore(x => x.Enterprises);
        }
    }
}
