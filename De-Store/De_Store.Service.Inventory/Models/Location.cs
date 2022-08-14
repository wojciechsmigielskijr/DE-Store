namespace De_Store.Service.Inventory.Models
{
    public class Location
    {
        public Location(int id, string locationName)
        {
            ID = id;
            LocationName = locationName;
        }

        public int ID { get; set; }
        public string LocationName { get; set; }
    }
}
