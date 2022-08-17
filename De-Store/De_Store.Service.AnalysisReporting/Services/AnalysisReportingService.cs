using De_Store.Service.AnalysisReporting.Protos;
using De_Store.Service.AnalysisReporting.Managers;
using De_Store.Service.AnalysisReporting.Models;
using Grpc.Core;

namespace De_Store.Service.AnalysisReporting.Services
{
    public class AnalysisReportingService : AnalysisReporter.AnalysisReporterBase
    {
        private readonly ILogger<AnalysisReportingService> _logger;
        public AnalysisReportingService(ILogger<AnalysisReportingService> logger)
        {
            _logger = logger;
        }

        public override async Task GetSaleDataByProduct(SaleDataByProductRequest request, IServerStreamWriter<SaleDataByProductReply> response, ServerCallContext context)
        {
            AnalysisReportingManager myModel = new();

            List<SaleProduct> myProductSales = myModel.GetSalesByProduct();

            foreach (SaleProduct p in myProductSales)
            {
                SaleDataByProductReply myReply = new()
                {
                    ProductType = p.ProductType,
                    ProductSales = p.ProductSales,
                };

                await response.WriteAsync(myReply);
            }

            return;
        }

        public override async Task RevenueByMonth(RevenueByMonthRequest request, IServerStreamWriter<RevenueByMonthReply> response, ServerCallContext context)
        {
            AnalysisReportingManager myModel = new();

            List<SaleMonth> myMonthSales = myModel.GetSalesByMonth();

            foreach (SaleMonth s in myMonthSales)
            {
                RevenueByMonthReply myReply = new()
                {
                    TotalSale = s.SaleCost,
                    MonthYear = s.YearMonth,
                };

                await response.WriteAsync(myReply);
            }

            return;
        }

        public override async Task GetSalesByLocation(SalesByLocationRequest request, IServerStreamWriter<SalesByLocationReply> response, ServerCallContext context)
        {
            AnalysisReportingManager myModel = new();

            List<SaleLocation> myLocationSales = myModel.GetSalesByLocation();

            foreach (SaleLocation l in myLocationSales)
            {
                SalesByLocationReply myReply = new()
                {
                    LocationSold = l.LocationName,
                    TotalsSales = l.SaleAmount,
                };

                await response.WriteAsync(myReply);
            }

            return;
        }
    }
}