namespace De_Store.Service.Inventory.Models
{
    public class InventoryItem
    {
        public InventoryItem(int productID, string productType, string productDescription, double productCost, int? stock = null)
        {
            ProductID = productID;
            ProductType = productType;
            ProductDescription = productDescription;
            ProductCost = productCost;
            Stock = stock;
        }
        public int ProductID { get; set; }
        public string ProductType { get; set; }
        public string ProductDescription { get; set; }
        public double ProductCost { get; set; }
        public int? Stock { get; set; }

    }
}
