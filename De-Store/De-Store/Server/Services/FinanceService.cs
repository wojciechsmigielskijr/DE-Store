using Microsoft.Extensions.Logging;
using Grpc.Core;
using De_Store.Shared.Protos;

namespace De_Store.Shared.Services
{
    public class FinanceService : FinanceManager.FinanceManagerBase
    {
        private readonly ILogger<FinanceService> _logger;
        public FinanceService(ILogger<FinanceService> logger)
        {
            _logger = logger;
        }

        public override Task<EnablingReply> OfferEnabling(EnablingRequest request, ServerCallContext context)
        {
            return Task.FromResult(new EnablingReply
            {
                Message = "Hello " + request.Name
            });
        }
    }
}
