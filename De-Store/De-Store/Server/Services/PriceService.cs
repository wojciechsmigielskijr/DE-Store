using Microsoft.Extensions.Logging;
using Grpc.Core;
using De_Store.Shared.Protos;

namespace De_Store.Shared.Services
{
    public class PriceService : PriceManager.PriceManagerBase
    {
        private readonly ILogger<PriceService> _logger;
        public PriceService(ILogger<PriceService> logger)
        {
            _logger = logger;
        }

        public override Task<SetPriceReply> ChangePrice(SetPriceRequest request, ServerCallContext context)
        {
            return Task.FromResult(new SetPriceReply
            {
                Message = "Hello " + request.NewPrice
            });
        }
    }
}
