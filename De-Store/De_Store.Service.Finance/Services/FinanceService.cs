using De_Store.Service.Finance;
using Grpc.Core;

namespace De_Store.Service.Finance.Services
{
    public class FinanceService : Greeter.GreeterBase
    {
        private readonly ILogger<FinanceService> _logger;
        public FinanceService(ILogger<FinanceService> logger)
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