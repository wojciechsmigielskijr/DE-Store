using Microsoft.Extensions.Logging;
using Grpc.Core;
using De_Store.Service.Products.Manager;
using De_Store.Service.Products.Models;
using De_Store.Service.Products.Protos;

namespace De_Store.Service.Products.Services
{
    public class ProductService : ProductManagementService.ProductManagementServiceBase
    {
        private readonly ILogger<ProductService> _logger;
        public ProductService(ILogger<ProductService> logger)
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
                    OfferID = p.OfferID
                };

                await response.WriteAsync(myReply);
            }

            return;
        }

        public override async Task GetOffers(GetOffersRequest request, IServerStreamWriter<GetOffersReply> response, ServerCallContext context)
        {
            ProductManager myModel = new();

            List<Offers> myOffers = myModel.GetOffers();

            foreach (Offers o in myOffers)
            {
                GetOffersReply myReply = new()
                {
                    OfferID = o.OfferID,
                    OfferName = o.OfferName,
                    OfferDescription = o.OfferDescription
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

            await myManager.UpdateOffer(request.ProductID, request.OfferID);

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
