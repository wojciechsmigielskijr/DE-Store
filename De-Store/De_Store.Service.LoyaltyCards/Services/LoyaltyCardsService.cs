using De_Store.Service.LoyaltyCards;
using De_Store.Service.LoyaltyCards.Manager;
using De_Store.Service.LoyaltyCards.Models;
using De_Store.Service.LoyaltyCards.Protos;
using Grpc.Core;

namespace De_Store.Service.LoyaltyCards.Services
{
    public class LoyaltyCardsService : LoyaltyCardsCustomerService.LoyaltyCardsCustomerServiceBase
    {
        private readonly ILogger<LoyaltyCardsService> _logger;
        public LoyaltyCardsService(ILogger<LoyaltyCardsService> logger)
        {
            _logger = logger;
        }

        public override async Task GetOffersForLoyaltyCard(GetOffersForLoyaltyCardsRequest request, IServerStreamWriter<GetOffersForLoyaltyCardsReply> response, ServerCallContext context)
        {
            return;
        }

        public override async Task<RemoveOfferForLoyaltyCardsReply> RemoveOffer(RemoveOfferForLoyaltyCardsRequest request, ServerCallContext context)
        {
            LoyaltyCardManager myManager = new();

            myManager.RemoveLoyaltyCardOffer(request.Loyaltycardid, request.Loyaltycardofferid);

            return new RemoveOfferForLoyaltyCardsReply();
        }

        public override async Task GetLoyaltyCards(GetLoyaltyCardsRequest request, IServerStreamWriter<GetLoyaltyCardsReply> response, ServerCallContext context)
        {
            LoyaltyCardManager myManager = new();

            List<LoyaltyCard> myCards = myManager.GetLoyaltyCards();

            foreach (LoyaltyCard c in myCards)
            {
                GetLoyaltyCardsReply myReply = new()
                {
                    Loyaltycardid = c.LoyaltyCardID,
                    Loyaltycardtype = c.LoyaltyCardName
                };

                foreach (LoyaltyCardOffer lo in c.LoyaltyOffers)
                {
                    var myLoyaltyOffer = new LoyaltyOffer
                    {
                        Loyaltycardofferid = lo.Id,
                        Offertype = lo.OfferType,
                        Offerdescription = lo.OfferDescription,
                        Offercost = lo.OfferCost
                    };

                    myReply.LoyaltyCardOffer.Add(myLoyaltyOffer);
                }
            
                await response.WriteAsync(myReply);
            }

            return;
        }

        public override async Task GetCustomers(CustomersRequest request, IServerStreamWriter<CustomersReply> response, ServerCallContext context)
        {
            LoyaltyCardManager myManager= new();

            List<Customer> myCustomers = myManager.GetCustomers();

            foreach (Customer c in myCustomers)
            {
                CustomersReply myReply = new()
                {
                    CustomerID = c.CustomerID,
                    Name = c.CustomerName,
                    Address = c.CustomerAddress,
                    Active = c.CustomerActive,
                    LoyaltyCardID = c.CustomerLoyaltyCardID,
                    LoyaltyCardTypeID = c.CustomerLoyaltyCardTypeID,
                    LoyaltyCardRevoked = c.CustomerLoyaltyCardRevoked,
                    LoyaltyPoints = c.CustomerLoyaltyCardPoints, 
                    LoyaltyCardDescription = c.LoyaltyCardTypeDescription
                };

                await response.WriteAsync(myReply);
            }

            return;
        }

        public override async Task<AssignCustomerLoyaltyCardReply> GiveCustomerLoyaltyCard(AssignCustomerLoyaltyCardRequest request, ServerCallContext context)
        {
            return new();
        }

        public override async Task<RevokeLoyaltyCardReply> RevokeLoyaltyCard(RevokeLoyaltyCardRequest request, ServerCallContext context)
        {
            return new();
        }

        public override async Task<CreateOfferReply> CreateOffer(CreateOfferRequest request, ServerCallContext context)
        {
            LoyaltyCardManager myManager = new();

            myManager.CreateNewOffer(request.OfferType, request.OfferDescription, request.OfferCost);

            return new();
        }
    }
}