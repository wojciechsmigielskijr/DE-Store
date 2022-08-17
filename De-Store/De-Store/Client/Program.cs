using De_Store.Client;
using De_Store.Service.Inventory.Protos;
using De_Store.Service.Products.Protos;
using De_Store.Service.AnalysisReporting.Protos;
using De_Store.Service.LoyaltyCards.Protos;
using Grpc.Net.Client;
using Grpc.Net.Client.Web;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(builder.HostEnvironment.BaseAddress) });

builder.Services.AddSingleton(services =>
{
    var httpClient = new HttpClient(new GrpcWebHandler(GrpcWebMode.GrpcWeb, new HttpClientHandler()));
    var baseUri = services.GetRequiredService<NavigationManager>().BaseUri;
    var channel = GrpcChannel.ForAddress("https://localhost:5001", new GrpcChannelOptions { HttpClient = httpClient });

    return new ProductManagementService.ProductManagementServiceClient(channel);
});

builder.Services.AddSingleton(services =>
{
    var httpClient = new HttpClient(new GrpcWebHandler(GrpcWebMode.GrpcWeb, new HttpClientHandler()));
    var baseUri = services.GetRequiredService<NavigationManager>().BaseUri;
    var channel = GrpcChannel.ForAddress("https://localhost:5002", new GrpcChannelOptions { HttpClient = httpClient });

    return new InventoryManagementService.InventoryManagementServiceClient(channel);
});

builder.Services.AddSingleton(services =>
{
    var httpClient = new HttpClient(new GrpcWebHandler(GrpcWebMode.GrpcWeb, new HttpClientHandler()));
    var baseUri = services.GetRequiredService<NavigationManager>().BaseUri;
    var channel = GrpcChannel.ForAddress("https://localhost:5005", new GrpcChannelOptions { HttpClient = httpClient });

    return new AnalysisReporter.AnalysisReporterClient(channel);
});

builder.Services.AddSingleton(services =>
{
    var httpClient = new HttpClient(new GrpcWebHandler(GrpcWebMode.GrpcWeb, new HttpClientHandler()));
    var baseUri = services.GetRequiredService<NavigationManager>().BaseUri;
    var channel = GrpcChannel.ForAddress("https://localhost:5003", new GrpcChannelOptions { HttpClient = httpClient });

    return new LoyaltyCardsCustomerService.LoyaltyCardsCustomerServiceClient(channel);
});

await builder.Build().RunAsync();
