using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace De_Store.Service.Products.Models
{
    public class Offers
    {
        public Offers(int offerID, string offerName, string offerDescription)
        {
            OfferID = offerID;
            OfferName = offerName;
            OfferDescription = offerDescription;
        }

        public int OfferID { get; set; }
        public string OfferName { get; set; }
        public string OfferDescription { get; set; }    
    }
}
