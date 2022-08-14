﻿using De_Store.Service.Products.Database;
using De_Store.Service.Products.Models;
using System.Data.SqlClient;

namespace De_Store.Service.Products.Manager
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

            string commandText = "SELECT ID, ProductType, ProductDescription, ProductCost, AvailableToBuy, OfferID FROM [De-Store].[dbo].[Products]";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<Product> myCurrentStockPerItem = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[0].ToString(), out int myID) && double.TryParse(myReader[3].ToString(), out double myCost) && int.TryParse(myReader[5].ToString(), out int myOfferID))
                {
                    myCurrentStockPerItem.Add(new Product(myID, productType: myReader[1].ToString(), productDescription: myReader[2].ToString(), myCost, (bool)myReader[4], null, myOfferID));
                };
            }

            myReader.Close();

            myDBManager.CleanUp();

            return myCurrentStockPerItem;
        }

        public List<Offers> GetOffers()
        {
            DatabaseManager myDBManager = new();

            string commandText = "SELECT [ID], [OfferType], [OfferDescription] FROM [De-Store].[dbo].[Offers]";

            SqlCommand cmd = new(commandText, myDBManager.SQLConnection);

            myDBManager.SQLConnection.Open();

            SqlDataReader myReader = cmd.ExecuteReader();

            List<Offers> myOffers = new();

            while (myReader.Read())
            {
                if (int.TryParse(myReader[0].ToString(), out int myID))
                {
                    myOffers.Add(new Offers(myID, myReader[1].ToString(), myReader[2].ToString()));
                };
            }

            myReader.Close();

            myDBManager.CleanUp();

            return myOffers;
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

        public async Task UpdateOffer(int productID, int? offerID)
        {
            DatabaseManager myDBManager = new();

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

    }
}
