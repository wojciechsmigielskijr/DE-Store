using De_Store.Service.AnalysisReporting.Database;
using De_Store.Service.AnalysisReporting.Models;
using System.Data.SqlClient;

namespace De_Store.Service.AnalysisReporting.Managers
{
    public class AnalysisReportingManager
    {
        public List<SaleLocation> GetSalesByLocation()
        {
            DatabaseManager myDBManager = new();

            string commandText = "SELECT * FROM [De-Store].[dbo].[SalesByLocation]";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<SaleLocation> mySaleLocations = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[0].ToString(), out int mySales))
                {
                    mySaleLocations.Add(new SaleLocation(myReader[1].ToString(), mySales));
                };
            }

            myReader.Close();

            myDBManager.CleanUp();

            return mySaleLocations;
        }

        public List<SaleMonth> GetSalesByMonth()
        {
            DatabaseManager myDBManager = new();

            string commandText = "SELECT * FROM [De-Store].[dbo].[SalesByMonth]";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<SaleMonth> mySaleMonth = new();

            while (myReader.Read())
            {
                if (double.TryParse(myReader[0].ToString(), out double myTotalSaleRevenue))
                {
                    mySaleMonth.Add(new SaleMonth(myReader[1].ToString(), myTotalSaleRevenue));
                };
            }

            myReader.Close();

            myDBManager.CleanUp();

            mySaleMonth.OrderBy(s => s.YearMonth);

            foreach(SaleMonth s in mySaleMonth)
            {
               s.YearMonth = s.YearMonth.Replace(" ", "");
            }

            return mySaleMonth;
        }

        public List<SaleProduct> GetSalesByProduct()
        {
            DatabaseManager myDBManager = new();

            string commandText = "SELECT * FROM [De-Store].[dbo].[SalesByProduct]";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<SaleProduct> mySaleProducts = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[1].ToString(), out int myProductsSold))
                {
                    mySaleProducts.Add(new SaleProduct(myReader[0].ToString(), myProductsSold));
                };
            }

            myReader.Close();

            myDBManager.CleanUp();

            mySaleProducts.OrderBy(i => i.ProductSales);

            return mySaleProducts;
        }
    }
}
