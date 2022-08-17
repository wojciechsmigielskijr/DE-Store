namespace De_Store.Service.AnalysisReporting.Models
{
    public class SaleMonth
    {
        public SaleMonth(string yearMonth, double saleCost)
        {
            YearMonth = yearMonth;
            SaleCost = saleCost;
        }

        public string YearMonth { get; set; }
        public double SaleCost { get; set; }
    }
}
