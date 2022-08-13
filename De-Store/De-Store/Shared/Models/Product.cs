namespace De_Store.Shared.Models
{
    public class Product
    {
        public Product(int productID, string productType, string productDescription, double productCost, bool availableToBuy, int? stock = null)
        {
            ProductID = productID;
            ProductType = productType;
            ProductDescription = productDescription;
            ProductCost = productCost;
            AvailableToBuy = availableToBuy;
            Stock = stock;
        }
        public int ProductID { get; set; }
        public string ProductType { get; set; }
        public string ProductDescription { get; set; }
        public double ProductCost { get; set; }
        public bool AvailableToBuy { get; set; }
        public int? Stock { get; set; }
    }
}
