--These are all donations that can be done. You must set this up with your own products to make money of it.
--To make a product you have to make a Developer Product in your game's settings page.
--You can make as many as you want, Once you made one, copy it's ID and past it in the 'ProductId' variable in this script. 
--Change the 'ProductPrice' to what the Developer Product Costs.
local module = {}	
module.Products = {
	
	{
		ProductPrice = 15, -- Put the PRICE of the Developer Product here.
		ProductId = 3262682654 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 25, -- Put the PRICE of the Developer Product here.
		ProductId = 3262682655 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 50, -- Put the PRICE of the Developer Product here.
		ProductId = 3262682656 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 75, -- Put the PRICE of the Developer Product here.
		ProductId = 3262682657 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 100, -- Put the PRICE of the Developer Product here.
		ProductId = 3262682658 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 250, -- Put the PRICE of the Developer Product here.
		ProductId = 3262682659	 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 500, -- Put the PRICE of the Developer Product here.
		ProductId = 3262682660 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 750, -- Put the PRICE of the Developer Product here.
		ProductId = 3262682661 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 1000, -- Put the PRICE of the Developer Product here.
		ProductId = 3262682664 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 2500, -- Put the PRICE of the Developer Product here.
		ProductId = 3262684288 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 5000, -- Put the PRICE of the Developer Product here.
		ProductId = 3262684586 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 7500, -- Put the PRICE of the Developer Product here.
		ProductId = 3262684584 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 10000, -- Put the PRICE of the Developer Product here.
		ProductId = 3262684585 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 25000, -- Put the PRICE of the Developer Product here.
		ProductId = 3262685506 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 50000, -- Put the PRICE of the Developer Product here.
		ProductId = 3262685507 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 75000, -- Put the PRICE of the Developer Product here.
		ProductId = 3262685509 -- Put the ID of the Developer Product here.
	},
	{
		ProductPrice = 100000, -- Put the PRICE of the Developer Product here.
		ProductId = 3262685510 -- Put the ID of the Developer Product here.
	},
}

--module.AbortCustomPurchases = true --READ Below for what this does. 

return module

--[[
	to make more products just cope and past like this:
	
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