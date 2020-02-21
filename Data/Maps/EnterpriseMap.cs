using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;

namespace Data.Maps
{
    public class EnterpriseMap : IEntityTypeConfiguration<Enterprise>
    {
        public void Configure(EntityTypeBuilder<Enterprise> builder)
        {
            builder.Property(x => x.Id).IsRequired();
            builder.HasKey(x => x.Id);
            builder.Property(x => x.Name).HasColumnType("varchar(50)").IsRequired();
            builder.Property(x => x.Description).IsRequired(false);
            builder.Property(x => x.Value).IsRequired().HasColumnType("decimal(8,2)").HasDefaultValue(0);
            builder.Property(x => x.SharePrice).IsRequired().HasColumnType("decimal(8,2)").HasDefaultValue(0);
            builder.Property(x => x.Shares).IsRequired().HasColumnType("decimal(8,2)").HasDefaultValue(0);
            builder.Property(x => x.OwnShares).IsRequired().HasDefaultValue(0);
            builder.Property(x => x.OwnEnterprise).IsRequired().HasDefaultValue(0);
            builder.Property(x => x.Email).HasColumnType("varchar(100)").IsRequired(false);
            builder.Property(x => x.Facebook).HasColumnType("varchar(200)").IsRequired(false);
            builder.Property(x => x.Twitter).HasColumnType("varchar(100)").IsRequired(false);
            builder.Property(x => x.Linkedin).HasColumnType("varchar(200)").IsRequired(false);
            builder.Property(x => x.Phone).HasColumnType("varchar(14)").IsRequired(false);
            builder.Property(x => x.City).HasColumnType("varchar(50)").IsRequired(false);
            builder.Property(x => x.Country).HasColumnType("varchar(70)").IsRequired(false);
            builder.Property(x => x.CreatedDate).ValueGeneratedOnAdd().HasDefaultValueSql("GETUTCDATE()").IsRequired();
            builder.Property(x => x.ModifiedDate).ValueGeneratedOnAddOrUpdate().HasDefaultValueSql("GETUTCDATE()").IsRequired();

            builder.HasOne(u => u.EnterpriseType)
                   .WithMany(c => c.Enterprises)
                   .HasForeignKey(c => c.EnterpriseTypeId)
                   .IsRequired()
                   .OnDelete(DeleteBehavior.Restrict);

            builder.Ignore(x => x.Investors);
        }
    }
}
