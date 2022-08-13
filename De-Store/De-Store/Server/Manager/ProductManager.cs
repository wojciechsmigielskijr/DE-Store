using De_Store.Server.Database;
using De_Store.Shared.Models;
using System.Data.SqlClient;

namespace De_Store.Server.Models
{
    public class ProductManager
    {
        public List<InStockProduct> GetProductStock()
        {
            DatabaseManager myDBManager = new();

            string commandText = "SELECT Stock, ProductID FROM De-Store.Inventory";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<InStockProduct> myCurrentStockPerItem = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[0].ToString(), out int myAmount) && int.TryParse(myReader[1].ToString(), out int myProductTypeID))
                {
                    myCurrentStockPerItem.Add(new InStockProduct(myProductTypeID, myAmount));
                };
            }

            myReader.Close();

            myDBManager.CleanUp();

            return myCurrentStockPerItem;
        }

        public List<Product> GetProducts()
        {
            DatabaseManager myDBManager = new();

            string commandText = "SELECT ID, ProductType, ProductDescription, ProductCost, AvailableToBuy, W.Stock FROM [De-Store].[dbo].[Products] P FULL JOIN [De-Store].[dbo].[Warehouse] W ON P.ID = W.ProductID";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<Product> myCurrentStockPerItem = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[0].ToString(), out int myID) && double.TryParse(myReader[3].ToString(), out double myCost) && int.TryParse(myReader[5].ToString(), out int myStock))
                {
                    myCurrentStockPerItem.Add(new Product(myID, productType: myReader[1].ToString(), productDescription: myReader[2].ToString(), myCost, (bool)myReader[4], myStock));
                };
            }

            myReader.Close();

            myDBManager.CleanUp();

            return myCurrentStockPerItem;
        }

        public async Task UpdatePrice(int productID, double productPrice)
        {
            DatabaseManager myDBManager = new();

            string commandText = "UPDATE [De-Store].[dbo].[Products] SET ProductCost = " + productPrice + " WHERE ID = " + productID;

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            await cmd.ExecuteNonQueryAsync();

            myDBManager.CleanUp();

            return;
        }

        public async Task UpdateOffer(int productID, string offer)
        {
            DatabaseManager myDBManager = new();

            int offerID = GetOfferID(offer);

            string commandText = "UPDATE [De-Store].[dbo].[Products] SET OfferID = " + offerID + " WHERE ID = " + productID;

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            await cmd.ExecuteNonQueryAsync();

            myDBManager.CleanUp();

            return;
        }

        public async Task UpdateAvailable(int productID, bool available)
        {
            DatabaseManager myDBManager = new();

            int myValue = available ? 1 : 0;

            string commandText = "UPDATE [De-Store].[dbo].[Products] SET AvailableToBuy = " + myValue + " WHERE ID = " + productID;

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            await cmd.ExecuteNonQueryAsync();

            myDBManager.CleanUp();

            return;
        }

        private static int GetOfferID(string offer)
        {
            return offer switch
            {
                "ThreeForTwo" => 1,
                "BuyOneGetOneFree" => 2,
                "FreeDelivery" => 3,
                "None" => 4,
                _ => 0,
            };
        }
    }
}
