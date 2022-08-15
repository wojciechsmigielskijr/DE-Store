using De_Store.Service.Inventory.Database;
using De_Store.Service.Inventory.Models;
using System.Data.SqlClient;

namespace De_Store.Service.Inventory.Manager
{
    public class InventoryManager
    {
        public List<InventoryItem> GetInventory(int locationID)
        {
            DatabaseManager myDBManager = new();

            string commandText = "SELECT P.ID, P.ProductType, P.ProductDescription, P.ProductCost, W.Stock FROM [De-Store].[dbo].[Warehouse] W LEFT JOIN [De-Store].[dbo].[Products] P ON W.ProductID = P.ID WHERE W.LocationID = " + locationID;

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<InventoryItem> myInventoryItem = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[0].ToString(), out int myID) && int.TryParse(myReader[4].ToString(), out int myStock) && double.TryParse(myReader[3].ToString(), out double myCost))
                {
                    myInventoryItem.Add(new InventoryItem(myID, myReader[1].ToString(), myReader[2].ToString(), myCost, myStock));
                };
            }
            myReader.Close();

            myDBManager.CleanUp();

            return myInventoryItem;
        }

        public List<Location> GetLocations()
        {
            DatabaseManager myDBManager = new();

            string commandText = "SELECT * FROM [De-Store].[dbo].[Locations]";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<Location> myLocations = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[0].ToString(), out int myLocationID))
                {
                    myLocations.Add(new Location(myLocationID, myReader[1].ToString()));
                };
            }

            myReader.Close();

            myDBManager.CleanUp();

            return myLocations;
        }

        public List<LowStockItem> GetLowStock()
        {
            DatabaseManager myDBManager = new();

            string commandText = @"SELECT W.ID, P.ProductType, P.ProductDescription, W.Stock, L.Location
                                    FROM[De-Store].[dbo].[Warehouse] W LEFT JOIN[De-Store].[dbo].[Products] P
                                    ON W.ProductID = P.ID
                                    INNER JOIN[De-Store].dbo.Locations L ON L.ID = W.LocationID
                                    WHERE W.Stock <= 5";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<LowStockItem> myLowStockItems = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[0].ToString(), out int myID) && int.TryParse(myReader[3].ToString(), out int myStock))
                {
                    myLowStockItems.Add(new LowStockItem(myID, myReader[1].ToString(), myReader[2].ToString(), myReader[4].ToString(), myStock));
                };
            }
            myReader.Close();

            myDBManager.CleanUp();

            return myLowStockItems;
        }


    }
}
