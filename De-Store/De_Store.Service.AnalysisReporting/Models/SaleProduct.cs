namespace De_Store.Service.AnalysisReporting.Models
{
    public class SaleLocation
    {
        public SaleLocation(string locationName, int saleAmount)
        {
            LocationName = locationName;
            SaleAmount = saleAmount;
        }

        public string LocationName { get; set; }
        public int SaleAmount { get; set; }
    }
}
