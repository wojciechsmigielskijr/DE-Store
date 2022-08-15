namespace De_Store.Service.Inventory.Models
{
    public class LowStockItem
    {
        public LowStockItem(int warehouseID, string productType, string productDescription, string locationName, int? stock = null)
        {
            WarehouseID = warehouseID;
            ProductType = productType;
            ProductDescription = productDescription;
            LocationName = locationName;
            Stock = stock;
        }
        public int WarehouseID { get; set; }
        public string ProductType { get; set; }
        public string ProductDescription { get; set; }
        public string LocationName { get; set; }
        public int? Stock { get; set; }

    }
}
