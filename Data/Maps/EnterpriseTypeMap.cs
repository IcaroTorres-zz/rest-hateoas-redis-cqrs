using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Data.Maps
{
    public class EnterpriseTypeMap : IEntityTypeConfiguration<EnterpriseType>
    {
        public void Configure(EntityTypeBuilder<EnterpriseType> builder)
        {
            builder.Property(x => x.Id).IsRequired();
            builder.HasKey(x => x.Id);
            builder.Property(x => x.Name).HasColumnType("varchar(50)").IsRequired();
            builder.Property(x => x.CreatedDate).ValueGeneratedOnAdd().HasDefaultValueSql("GETUTCDATE()").IsRequired();
            builder.Property(x => x.ModifiedDate).ValueGeneratedOnAddOrUpdate().HasDefaultValueSql("GETUTCDATE()").IsRequired();
        }
    }
}
