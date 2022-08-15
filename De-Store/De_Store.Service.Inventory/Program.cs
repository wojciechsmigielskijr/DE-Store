using De_Store.Service.Inventory.Manager;
using De_Store.Service.Inventory.Services;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddCors(options =>
{
    options.AddPolicy("DevCorsPolicy", builder =>
    {
        builder
            .AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader();
    });
});

builder.Services.AddGrpc();

var app = builder.Build();

app.UseGrpcWeb();

app.UseCors("DevCorsPolicy");

app.MapGrpcService<InventoryService>().EnableGrpcWeb();
app.MapGet("/", () => "Communication with gRPC endpoints must be made through a gRPC client. To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909");

StockManager stockManager = new();
stockManager.CheckStockAsync();

app.Run();