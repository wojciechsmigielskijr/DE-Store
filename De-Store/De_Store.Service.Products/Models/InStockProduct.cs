namespace De_Store.Service.Products.Models
{
    public class InStockProduct
    {
        public InStockProduct(int productID, int amountOfStock)
        {
            ProductID = productID;
            AmountOfStock = amountOfStock;
        }
        public int AmountOfStock { get; set; }
        public int ProductID { get; set; }
    }
}
