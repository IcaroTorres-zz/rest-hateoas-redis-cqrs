using System;

namespace Domain.Entities
{
    public abstract class BaseEntity
    {
        public virtual bool Active { get; set; } = true;
        public virtual DateTime CreatedDate { get; set; } = DateTime.UtcNow;
        public virtual DateTime ModifiedDate { get; set; } = DateTime.UtcNow;
    }
}
