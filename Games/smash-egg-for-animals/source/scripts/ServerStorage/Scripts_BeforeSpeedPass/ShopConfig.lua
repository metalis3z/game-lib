-- Game passes.
local ShopConfig = {}

-- GAME PASSES
-- Create each pass on the Creator Dashboard (Monetization > Passes) with the price below,
-- then paste its pass id in "Id". While Id is 0 the pass shows as "Soon" in the shop.
ShopConfig.Passes = {
	{Key = "VIP", Id = 0, Name = "VIP", Price = 300, Description = "VIP tag over your head and in chat + 2x Money", Badge = "VIP"},
	{Key = "MutationLuck", Id = 0, Name = "2x Mutation Luck", Price = 200, Description = "Twice the chance of Gold, Diamond and Rainbow eggs and crops", Badge = "x2"},
	{Key = "WeightLuck", Id = 0, Name = "2x Weight Luck", Price = 250, Description = "Twice the chance of giant eggs and crops", Badge = "KG"},
	{Key = "FastHatch", Id = 0, Name = "2x Hatch Speed", Price = 150, Description = "Your eggs hatch twice as fast", Badge = "2x"},
	{Key = "DoubleXp", Id = 0, Name = "2x Pet XP", Price = 100, Description = "Your pets earn twice the XP when you feed them", Badge = "XP"},
}

ShopConfig.VipMoneyMult = 2

function ShopConfig.GetPass(key)
	for _, pass in ShopConfig.Passes do
		if pass.Key == key then return pass end
	end
	return nil
end

-- The server stores owned passes as player attributes ("Pass_VIP" = true, ...).
function ShopConfig.HasPass(player, key)
	return player:GetAttribute("Pass_" .. key) == true
end

-- Total money multiplier of a player (VIP).
function ShopConfig.MoneyMult(player)
	local mult = 1
	if ShopConfig.HasPass(player, "VIP") then mult *= ShopConfig.VipMoneyMult end
	return mult
end

-- ŒUF EN VEDETTE (haut de la boutique) : des lots d'œufs achetés en Robux.
-- Chaque lot est un GAMEPASS (PassId) : un joueur ne peut acheter chaque lot qu'une seule fois. Les œufs sont donnés à l'achat
-- (et à la connexion si l'achat a eu lieu ailleurs), une seule fois par gamepass. "Robux" = le prix du gamepass (affiché).
-- (ProductId : ancien système en produit développeur, rachetable ; 0 = pas utilisé.)
-- EndsAt : fin de l'offre (date UTC). OwnerFree : le créateur du jeu reçoit les œufs sans payer, pour essayer (mettre false pour l'enlever).
ShopConfig.Featured = {
	Egg = "AngelEgg",
	Title = "Fallen Angel Egg",
	EndsAt = os.time({year = 2026, month = 10, day = 26, hour = 12}),
	OwnerFree = true,
	Packs = {
		{Count = 1, Robux = 64, PassId = 2036090801, ProductId = 0},
		{Count = 3, Robux = 160, PassId = 2040722319, ProductId = 0},
		{Count = 10, Robux = 512, PassId = 2040422314, ProductId = 0},
		{Count = 50, Robux = 2240, PassId = 2037644819, ProductId = 0},
	},
}

return ShopConfig
