namespace De_Store.Service.LoyaltyCards.Models
{
    public class LoyaltyCard
    {
        public LoyaltyCard(int loyaltyCardID, string loyaltyCardName, List<LoyaltyCardOffer> myOffers)
        {
            LoyaltyCardID = loyaltyCardID;
            LoyaltyCardName = loyaltyCardName;
            LoyaltyOffers = myOffers;
        }

        public int LoyaltyCardID { get; set; }
        public string LoyaltyCardName { get; set; }
        public List<LoyaltyCardOffer> LoyaltyOffers { get; set;}
    }
}
