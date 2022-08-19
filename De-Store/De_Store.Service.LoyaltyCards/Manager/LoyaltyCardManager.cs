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

            myDBManager.SQLConnection.Open();

            string myLoyaltyCardsCommand = @"SELECT LC.ID, LC.CardType, LT.OfferType, LT.OfferDescription, LT.OfferLoyaltyCost, LT.ID as OfferID FROM [De-Store].[dbo].[LoyaltyCards] LC
                                                LEFT JOIN [De-Store].[dbo].LoyaltyCardOffers LO ON LO.LoyatyCardID = LC.ID 
                                                LEFT JOIN [De-Store].[dbo].LoyaltyCardOfferTypes LT ON LO.LoyaltyCardOfferID = LT.ID";

            SqlCommand myCardsCommand = new(myLoyaltyCardsCommand, myDBManager.SQLConnection);

            SqlDataReader myCardsReader = myCardsCommand.ExecuteReader();

            int myLastCardID = 1;

            string? myLastCardName = null;

            List<LoyaltyCard> myCards = new();

            List<LoyaltyCardOffer> myOffers = new();

            while (myCardsReader.Read())
            {
                if (int.TryParse(myCardsReader[0].ToString(), out int myCurrentCardID) && int.TryParse(myCardsReader[4].ToString(), out int myCost) && int.TryParse(myCardsReader[5].ToString(), out int myOfferID))
                {
                    if(myCards.Any(a => a.LoyaltyCardID == myCurrentCardID))
                    {
                        myCards.Find(a => a.LoyaltyCardID == myCurrentCardID).LoyaltyOffers.Add(new(myOfferID, offerType: myCardsReader[2].ToString(), offerDescription: myCardsReader[3].ToString(), offerCost: myCost));
                    }
                    else
                    {
                        myCards.Add(new(myCurrentCardID, myCardsReader[1].ToString(), new()));
                        myCards.Find(a => a.LoyaltyCardID == myCurrentCardID).LoyaltyOffers.Add(new(myOfferID, offerType: myCardsReader[2].ToString(), offerDescription: myCardsReader[3].ToString(), offerCost: myCost));
                    };
                };
            }

            myCardsReader.Close();
    
            myDBManager.CleanUp();

            return myCards;
        }

        public List<LoyaltyCardOffer> GetLoyaltyCardOffers()
        {
            DatabaseManager myDBManager = new();

            string commandText = "SELECT * FROM [De-Store].[dbo].[LoyaltyCardOfferTypes]";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<LoyaltyCardOffer> myOffers = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[0].ToString(), out int myID) && int.TryParse(myReader[3].ToString(), out int myCost))
                {
                    myOffers.Add(new LoyaltyCardOffer(myID, myReader[1].ToString(), myReader[2].ToString(), myCost));
                };
            }

            myReader.Close();

            myDBManager.CleanUp();

            return myOffers;
        }

        public void RemoveLoyaltyCardOffer(int loyaltyCardID, int loyaltyCardOfferID)
        {
            DatabaseManager myDBManager = new();

            string commandText = "DELETE FROM [De-Store].[dbo].[LoyaltyCardOffers] WHERE LoyatyCardID = " + loyaltyCardID + " AND LoyaltyCardOfferID = " + loyaltyCardOfferID;

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            cmd.ExecuteNonQuery();

            myDBManager.CleanUp();
        }

        public void CreateNewOffer(string offerType, string offerDescription, int offerCost)
        {
            DatabaseManager myDBManager = new();

            string commandText = $"INSERT INTO [De-Store].[dbo].[LoyaltyCardOfferTypes] (OfferType, OfferDescription, OfferLoyaltyCost) VALUES ('{offerType}', '{offerDescription}', {offerCost})";

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
