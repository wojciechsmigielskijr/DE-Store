using De_Store.Shared.Services;
using Microsoft.AspNetCore.ResponseCompression;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllersWithViews();
builder.Services.AddRazorPages();
builder.Services.AddGrpc();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseWebAssemblyDebugging();
}
else
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseBlazorFrameworkFiles();
app.UseStaticFiles();

app.UseRouting();

app.UseGrpcWeb();

app.MapRazorPages();
app.MapControllers();
app.MapGrpcService<PriceService>().EnableGrpcWeb();
app.MapGrpcService<AnalysisReportingService>().EnableGrpcWeb();
app.MapGrpcService<FinanceService>().EnableGrpcWeb();
app.MapGrpcService<InventoryService>().EnableGrpcWeb();
app.MapGrpcService<LoyaltyService>().EnableGrpcWeb();
app.MapFallbackToFile("index.html");

app.Run();
