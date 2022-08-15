using System.Net;
using System.Net.Mail;

namespace De_Store.Service.Inventory.Manager
{
    public class MailServerManager
    {
        public MailServerManager() => Initialise();

        private void Initialise()
        {
            Client = new()
            {
                Host = "localhost",
                Credentials = new NetworkCredential("Administrator", "Password123+"),
                EnableSsl = false
            };
        }

        private void SendMessage(MailMessage myMessage)
        {
            Client.Send(myMessage);
        }

        public void SendNewStockAlertMessage(string myMessage)
        {
            MailMessage message = new("stockalert@de-store.com", "manager@de-store.com")
            {
                Subject = "ALERT: New Stock Deficiencies",
                Body = myMessage,
                IsBodyHtml = true
            };

            SendMessage(message);
        }

        private SmtpClient? Client { get; set; }


    }
}
