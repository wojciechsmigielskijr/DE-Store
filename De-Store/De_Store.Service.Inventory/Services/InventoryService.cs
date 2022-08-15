using De_Store.Service.Inventory.Manager;
using De_Store.Service.Inventory.Models;
using De_Store.Service.Inventory.Protos;
using Grpc.Core;

namespace De_Store.Service.Inventory.Services
{
    public class InventoryService : InventoryManagementService.InventoryManagementServiceBase
    {
        private readonly ILogger<InventoryService> _logger;
        public InventoryService(ILogger<InventoryService> logger)
        {
            _logger = logger;
        }

        public override async Task GetLocations(GetLocationsRequest request, IServerStreamWriter<GetLocationsResponse> response, ServerCallContext context)
        {
            InventoryManager myInventoryManager = new();

            List<Location> myLocations = myInventoryManager.GetLocations();

            foreach (Location l in myLocations)
            {
                GetLocationsResponse myResponse = new()
                {
                    LocationID = l.ID,
                    LocationName = l.LocationName   
                };

                await response.WriteAsync(myResponse);
            }

            return;
        }

        public override async Task GetInventory(GetInventoryRequest request, IServerStreamWriter<GetInventoryResponse> response, ServerCallContext context)
        {
            InventoryManager myInventoryManager = new();

            List<InventoryItem> myInventoryItems = myInventoryManager.GetInventory(request.LocationID);

            foreach (InventoryItem i in myInventoryItems)
            {
                GetInventoryResponse myResponse = new()
                {
                    ProductID = i.ProductID,
                    ProductType = i.ProductType,
                    ProductDescription = i.ProductDescription,
                    ProductCost = i.ProductCost,
                    ProductStock = i.Stock
                };

                await response.WriteAsync(myResponse);
            }

            return;
        }

        public override async Task GetLowStock(GetLowStockRequest request, IServerStreamWriter<GetLowStockResponse> response, ServerCallContext context)
        {
            InventoryManager myInventoryManager = new();

            List<LowStockItem> myLowStockItems = myInventoryManager.GetLowStock();

            foreach (LowStockItem i in myLowStockItems)
            {
                GetLowStockResponse myResponse = new()
                {
                    WarehouseID = i.WarehouseID,
                    ProductType = i.ProductType,
                    ProductDescription = i.ProductDescription,
                    Location = i.LocationName,
                    ProductStock = i.Stock
                };

                await response.WriteAsync(myResponse);
            }

            return;
        }
    }
}