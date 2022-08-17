namespace De_Store.Service.LoyaltyCards.Models
{
    public class LoyaltyCard
    {
        public LoyaltyCard(int loyaltyCardID, string loyaltyCardName)
        {
            LoyaltyCardID = loyaltyCardID;
            LoyaltyCardName = loyaltyCardName;
        }

        public int LoyaltyCardID { get; set; }
        public string LoyaltyCardName { get; set; }
    }
}
