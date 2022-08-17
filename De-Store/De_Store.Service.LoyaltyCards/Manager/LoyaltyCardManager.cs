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
            DatabaseManager myDBManager = new();

            string commandText = "SELECT * FROM [De-Store].[dbo].[LoyaltyCards]";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<LoyaltyCardOffer> myCards = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[0].ToString(), out int myID) && int.TryParse(myReader[3].ToString(), out int myCost))
                {
                    myCards.Add(new LoyaltyCardOffer(myID, myReader[1].ToString(), myReader[2].ToString(), myCost));
                };
            }

            myReader.Close();

            myDBManager.CleanUp();

            return myCards;
        }

        public void SetLoyaltyCardOffer(int loyaltyCardID, int loyaltyCardOffer)
        {
            DatabaseManager myDBManager = new();

            string commandText = "UPDATE [De-Store].[dbo].[CustomerLoyaltyCards] SET Revoked = 1 WHERE CustomerID = " + loyaltyCardID;

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            cmd.ExecuteNonQuery();

            myDBManager.CleanUp();
        }

        public List<Customer> GetCustomers()
        {
            DatabaseManager myDBManager = new();

            string commandText = "SELECT [CustomerID], [Name], [Address], [Active], [LoyatyCardTypeID], [Points], [Revoked], [LoyaltyCardID], [CardType] FROM [De-Store].[dbo].[AllCustomsWithLoyaltyCards]";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<Customer> myCustomers = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[0].ToString(), out int myCustomerID) && bool.TryParse(myReader[3].ToString(), out bool myActive))
                {
                    int? loyaltyCardID = myReader[4] as int? ?? null;
                    int? loyaltyCardPoints = myReader[5] as int? ?? null;
                    bool loyaltyCardRevoked = myReader[6] as bool? ?? false;

                    int? isloyaltyCardRevoked;


                    if (loyaltyCardRevoked)
                    {
                        isloyaltyCardRevoked = 1;
                    }
                    else
                    {
                        isloyaltyCardRevoked = 0;
                    }

                    int? loyaltyCardTypeID = myReader[7] as int? ?? null;
                    myCustomers.Add(new Customer(myCustomerID, myReader[1].ToString(), myReader[2].ToString(), myActive, loyaltyCardID, loyaltyCardPoints, isloyaltyCardRevoked, loyaltyCardTypeID, myReader[8].ToString()));
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
