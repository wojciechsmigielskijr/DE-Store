namespace De_Store.Service.LoyaltyCards.Models
{
    public class Customer
    {
        public Customer(int customerID, string customerName, string customerAddress, bool customerActive, int? customerLoyaltyCardID, int? customerLoyaltyCardPoints, int? customerLoyaltyCardRevoked, int? customerLoyaltyCardTypeID, string loyaltyCardTypeDescription)
        {
            CustomerID = customerID;
            CustomerName = customerName;
            CustomerAddress = customerAddress;
            CustomerActive = customerActive;
            CustomerLoyaltyCardID = customerLoyaltyCardID;
            CustomerLoyaltyCardPoints = customerLoyaltyCardPoints;
            CustomerLoyaltyCardRevoked = customerLoyaltyCardRevoked;
            CustomerLoyaltyCardTypeID = customerLoyaltyCardTypeID;
            LoyaltyCardTypeDescription = loyaltyCardTypeDescription;
        }

        public int CustomerID { get; set; }
        public string CustomerName { get; set; }
        public string CustomerAddress { get; set; }
        public bool CustomerActive { get; set; }
        public int? CustomerLoyaltyCardID { get; set; }
        public int? CustomerLoyaltyCardPoints { get; set; }
        public int? CustomerLoyaltyCardRevoked { get; set; }
        public int? CustomerLoyaltyCardTypeID { get; set; }
        public string LoyaltyCardTypeDescription { get; set; }

    }

}
