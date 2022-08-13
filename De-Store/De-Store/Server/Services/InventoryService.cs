using Microsoft.Extensions.Logging;
using Grpc.Core;
using De_Store.Server.Models;
using De_Store.Shared.Protos;
using De_Store.Shared.Models;

namespace De_Store.Shared.Services
{
    public class InventoryService : InventoryManager.InventoryManagerBase
    {
        private readonly ILogger<InventoryService> _logger;
        public InventoryService(ILogger<InventoryService> logger)
        {
            _logger = logger;
        }

        public override async Task CheckStock(CheckStockRequest request, IServerStreamWriter<CheckStockReply> response, ServerCallContext context)
        {
            ProductManager myModel = new();

            List<InStockProduct> myProducts = myModel.GetProductStock();

            foreach (InStockProduct p in myProducts)
            {
                CheckStockReply myReply = new()
                {
                    ProductItemID = p.ProductID,
                    StockAmount = p.AmountOfStock
                };

                await response.WriteAsync(myReply);
            }
        }

        public override async Task GetProducts(GetProductsRequest request, IServerStreamWriter<GetProductsReply> response, ServerCallContext context)
        {
            ProductManager myModel = new();

            List<Product> myProducts = myModel.GetProducts();

            foreach (Product p in myProducts)
            {
                GetProductsReply myReply = new()
                {
                    ProductID = p.ProductID,
                    ProductType = p.ProductType,
                    ProductDescription = p.ProductDescription,
                    ProductCost = p.ProductCost,
                    AvailableToBuy = p.AvailableToBuy,
                    ProductStock = p.Stock
                };

                await response.WriteAsync(myReply);
            }

            return;
        }

        public override async Task<UpdatePriceReply> UpdatePrice(UpdatePriceRequest request, ServerCallContext context)
        {
            ProductManager myManager = new();

            await myManager.UpdatePrice(request.ProductID, request.ProductCost);

            return new UpdatePriceReply();
        }

        public override async Task<UpdateOfferReply> UpdateOffer(UpdateOfferRequest request, ServerCallContext context)
        {
            ProductManager myManager = new();

            await myManager.UpdateOffer(request.ProductID, request.OfferType);

            return new UpdateOfferReply();
        }

        public override async Task<UpdateAvailableReply> UpdateAvailable(UpdateAvailableRequest request, ServerCallContext context)
        {
            ProductManager myManager = new();

            await myManager.UpdateAvailable(request.ProductID, request.AvailableToBuy);

            return new UpdateAvailableReply();
        }
    }
}
