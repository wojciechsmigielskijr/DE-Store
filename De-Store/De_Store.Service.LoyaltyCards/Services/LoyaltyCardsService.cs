using De_Store.Service.LoyaltyCards;
using Grpc.Core;

namespace De_Store.Service.LoyaltyCards.Services
{
    public class LoyaltyCardsService : Greeter.GreeterBase
    {
        private readonly ILogger<LoyaltyCardsService> _logger;
        public LoyaltyCardsService(ILogger<LoyaltyCardsService> logger)
        {
            _logger = logger;
        }

        public override Task<HelloReply> SayHello(HelloRequest request, ServerCallContext context)
        {
            return Task.FromResult(new HelloReply
            {
                Message = "Hello " + request.Name
            });
        }
    }
}