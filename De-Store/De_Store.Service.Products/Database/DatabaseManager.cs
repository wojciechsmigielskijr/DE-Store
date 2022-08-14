using System.Data.SqlClient;

namespace De_Store.Service.Products.Database
{
    public class DatabaseManager
    {
        public DatabaseManager()
        {
            Initialise();
        }
        public string? DatabaseConnectionString { get; set; }

        public SqlConnection? SQLConnection { get; set; }

        public void Initialise()
        {
            DatabaseConnectionString = "Data Source=WOJCIECHSDESK\\WOJCIECHSDESK;Initial Catalog=De-Store;Integrated Security=True";
            SQLConnection = new SqlConnection(DatabaseConnectionString);
            //Call Db connection to get stock amount
        }

        public void CleanUp()
        {
            SQLConnection.Close();
        }
    }
}
