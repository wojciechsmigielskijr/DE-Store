namespace De_Store.Service.AnalysisReporting.Models
{
    public class SaleProduct
    {
        public SaleProduct(string productType, int productSales)
        {
            ProductType = productType;
            ProductSales = productSales;
        }

        public string ProductType { get; set; }
        public int ProductSales { get; set; }
    }
}
