using System;

namespace Domain.Unities
{
    public interface IUnitOfWork : IDisposable
    {
        /// <summary>
        /// start a transaction with the context
        /// </summary>
        IUnitOfWork Begin();

        /// <summary>
        /// Save state of changesin the context.
        /// </summary>
        void Save();

        /// <summary>
        ///  Rollback all states saved under the transaction.
        /// </summary>
        void RollbackStates();

        /// <summary>
        /// Confirm all changes under transaction.
        /// </summary>
        void Commit();

        /// <summary>
        ///  Rollback all changes under the transaction.
        /// </summary>
        void RollbackTransaction();
    }
}
