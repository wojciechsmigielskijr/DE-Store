using De_Store.Service.Inventory.Models;
using System.Linq;

namespace De_Store.Service.Inventory.Manager
{
    public class StockManager
    {
        public StockManager()
        { }

        public async Task CheckStockAsync()
        {
            List<LowStockItem> CurrentLowStock = new();

            InventoryManager inventoryManager = new();

            MailServerManager mailManager = new();

            CurrentLowStock = inventoryManager.GetLowStock();

            var timer = new PeriodicTimer(TimeSpan.FromSeconds(1));

            while (await timer.WaitForNextTickAsync())
            {
                List<LowStockItem> newLowStock = new();

                string myNewAlertMessge = null;
                string myNewStockOrderedMessage = null;

                newLowStock = inventoryManager.GetLowStock();

                foreach (LowStockItem stockItem in newLowStock)
                {
                    if (!CurrentLowStock.Any(c => c.WarehouseID == stockItem.WarehouseID))
                    {
                        CurrentLowStock.Add(stockItem);
                        myNewAlertMessge += $@"<tr> 	
                                    <td>  {stockItem.ProductType}  </td> 
                                    <td>  {stockItem.ProductDescription}  </td>     
                                    <td>  {stockItem.Stock}  </td>     
                                    <td>  {stockItem.LocationName}  </td>     
                                    </tr>";

                        if(stockItem.Stock == 0)
                        {
                            if (inventoryManager.OrderNewStock(stockItem.ProductTypeID, 50).Result == true)
                            { myNewStockOrderedMessage = $"\n Stock Item was ordered {stockItem.ProductType} current order status is <b>Placed</b>"; }
                            else
                            { myNewStockOrderedMessage = $"\n Stock Item FAILED to be ordered {stockItem.ProductType}"; }
                        }
                    }
                }

                if (myNewAlertMessge != null)
                {
                    myNewAlertMessge = myNewAlertMessge.Insert(0, "<body> <table cellpadding=\"5\" cellspacing=\"0\" width=\"640\" align=\"left\" border=\"1\">  <tr> <th> Product Type </th> <th> Product Description </th> <th> Stock </th> <th> Location </th> </tr> ");
                    myNewAlertMessge = myNewAlertMessge + "</table> </body>";
                    mailManager.SendNewStockAlertMessage(myNewAlertMessge);

                    myNewAlertMessge = null;
                }

                if (myNewStockOrderedMessage != null)
                {
                    myNewStockOrderedMessage = myNewStockOrderedMessage.Insert(0, "Hi, ");
                    mailManager.SendNewOrderMessage(myNewStockOrderedMessage);

                    myNewStockOrderedMessage = null;
                }
            }
        }



    }
}
