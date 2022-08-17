namespace De_Store.Service.LoyaltyCards.Models
{
    public class LoyaltyCardOffer
    {
        public LoyaltyCardOffer(int id, string offerType, string offerDescription, int offerCost)
        {
            Id = id;
            OfferType = offerType;
            OfferDescription = offerDescription;
            OfferCost = offerCost;
        }

        public int Id { get; set; }
        public string OfferType { get; set; }
        public string OfferDescription { get; set; }
        public int OfferCost { get; set; }
    }
}
