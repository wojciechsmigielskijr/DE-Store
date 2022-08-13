using Microsoft.Extensions.Logging;
using Grpc.Core;
using De_Store.Shared.Protos;

namespace De_Store.Shared.Services
{
    public class AnalysisReportingService : AnalysisReporter.AnalysisReporterBase
    {
        private readonly ILogger<AnalysisReportingService> _logger;
        public AnalysisReportingService(ILogger<AnalysisReportingService> logger) => _logger = logger;

        public override Task<PurchaseDoneReply> LogPurchase(PurchaseDoneRequest request, ServerCallContext context)
        {
            return Task.FromResult(new PurchaseDoneReply
            {
                Message = "Hello " + request.Name
            });
        }
    }
}
