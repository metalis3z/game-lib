--These are all donations that can be done. You must set this up with your own products to make money of it.
--To make a product you have to make a Developer Product in your game's settings page.
--You can make as many as you want, Once you made one, copy it's ID and past it in the 'ProductId' variable in this script. 
--Change the 'ProductPrice' to what the Developer Product Costs.


local module = {}	
module.Products = {
	
	{
		ProductPrice = 5, --The price from the Developer Product.
		ProductId = 1774361575 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 10, --The price from the Developer Product.
		ProductId = 1774361406 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 50, --The price from the Developer Product.
		ProductId = 1774360465 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 100, --The price from the Developer Product.
		ProductId = 1774361407 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 500, --The price from the Developer Product.
		ProductId = 1774361860 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 1000, --The price from the Developer Product.
		ProductId = 1774361409 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 5000, --The price from the Developer Product.
		ProductId = 1774361408 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 10000, --The price from the Developer Product.
		ProductId = 1774361410 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 50000, --The price from the Developer Product.
		ProductId = 1774361414 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 100000, --The price from the Developer Product.
		ProductId = 1774361405 -- The ID from the Developer Product.	
	},
}

--module.AbortCustomPurchases = true --READ Below for what this does. 


return module

--[[
	to make more products just copy and past like this:
	
module.Products = {
	{
		ProductPrice = 0, --The price from the Developer Product.
		ProductId = 0 -- The ID from the Developer Product.	
	},
	
	{
		ProductPrice = 0, --The price from the Developer Product.
		ProductId = 0 -- The ID from the Developer Product.	
	},
	
	
	{
		ProductPrice = 0, --The price from the Developer Product.
		ProductId = 0 -- The ID from the Developer Product.	
	},	
}

For the more advanced scripters, READ THIS!
if you're already using the function ProcessReceipt then you must add custom code for this board to work,
as only one of these functions may be used in a game.

to disable the ProcessReceipt function from this board, unquote this above the 'return module' line:
module.AbortCustomPurchases = true

you can update the boards datastore with this line:
game:GetService("DataStoreService"):GetOrderedDataStore("TopDonators"):IncrementAsync(PlayerId, ProductPrice)
-PlayerId, the id from the player who bought the pruduct.
-ProductPrice, the developer products price (In Rs!)
--]]