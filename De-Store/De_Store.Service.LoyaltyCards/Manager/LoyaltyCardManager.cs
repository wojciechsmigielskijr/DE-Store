using De_Store.Service.LoyaltyCards.Database;
using De_Store.Service.LoyaltyCards.Models;
using System.Data.SqlClient;

namespace De_Store.Service.LoyaltyCards.Manager
{
    public class LoyaltyCardManager
    {
        public List<LoyaltyCard> GetLoyaltyCards()
        {
            DatabaseManager myDBManager = new();

            string commandText = "SELECT * FROM [De-Store].[dbo].[LoyaltyCards]";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<LoyaltyCard> myCards = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[0].ToString(), out int myID))
                {
                    myCards.Add(new LoyaltyCard(myID, myReader[1].ToString()));
                };
            }

            myReader.Close();

            myDBManager.CleanUp();

            return myCards;
        }

        public List<LoyaltyCardOffer> GetLoyaltyCardOffers()
        {


            return null;
        }


        public List<Customer> GetCustomers()
        {
            DatabaseManager myDBManager = new();

            string commandText = "SELECT [CustomerID], [Name], [Address], [Active], [LoyatyCardTypeID], [Points], [Revoked], [LoyaltyCardID] FROM [De-Store].[dbo].[AllCustomsWithLoyaltyCards]";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<Customer> myCustomers = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[0].ToString(), out int myCustomerID) && bool.TryParse(myReader[3].ToString(), out bool myActive))
                {
                    myCustomers.Add(new Customer(myCustomerID, myReader[1].ToString(), myReader[2].ToString(), myActive, (int?)myReader[4], (int?)myReader[5], (int?)myReader[6], (int?)myReader[7]));
                };
            }

            myReader.Close();

            myDBManager.CleanUp();

            return myCustomers;
        }


        public void AssignCustomerLoyaltyCard(int customerID, int loyaltyCardTypeID)
        {
            DatabaseManager myDBManager = new();

            string commandText = $"INSERT INTO [De-Store].[dbo].[CustomerLoyaltyCards] (LoyatyCardTypeID, CustomerID, Points, Revoked) VALUES ({loyaltyCardTypeID}, {customerID}, {0}, {0})";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            cmd.ExecuteNonQuery();

            myDBManager.CleanUp();
        }

        public void RevokeCustomerLoyaltyCard(int customerID)
        {
            DatabaseManager myDBManager = new();

            string commandText = "UPDATE [De-Store].[dbo].[CustomerLoyaltyCards] SET Revoked = 1 WHERE CustomerID = " + customerID;

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            cmd.ExecuteNonQuery();

            myDBManager.CleanUp();
        }
    }
}
