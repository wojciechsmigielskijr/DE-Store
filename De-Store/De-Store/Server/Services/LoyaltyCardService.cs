using Microsoft.Extensions.Logging;
using Grpc.Core;
using De_Store.Shared.Protos;

namespace De_Store.Shared.Services
{
    public class LoyaltyService : LoyaltyManager.LoyaltyManagerBase
    {
        private readonly ILogger<LoyaltyService> _logger;
        public LoyaltyService(ILogger<LoyaltyService> logger)
        {
            _logger = logger;
        }

        public override Task<LoyatyPointsReply> CheckLoyatyPoints(LoyatyPointsRequest request, ServerCallContext context)
        {
            return Task.FromResult(new LoyatyPointsReply
            {
                Message = "Hello " + request.Name
            });
        }
    }
}
