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
	-- Featured = true : pas de ligne dans la liste des passes, il a sa propre bannière en haut de la boutique ("Speed Packs")
	{Key = "DoubleSpeed", Id = 2040194376, Name = "Double Speed", Price = 3, Description = "x2 Speed gained on your treadmill", Badge = "x2", Featured = true,
		Icon = "rbxassetid://105217550794256", From = "x1", To = "x2", Mult = 2, Headline = "DOUBLE Your Speed"},
	{Key = "QuadSpeed", Id = 2036204938, Name = "x4 Speed", Price = 6, Description = "x4 Speed gained on your treadmill", Badge = "x4", Featured = true,
		Icon = "rbxassetid://105217550794256", From = "x2", To = "x4", Mult = 4, Headline = "x4 Your Speed",
		Card = {Color3.fromRGB(255, 220, 250), Color3.fromRGB(230, 120, 255), Color3.fromRGB(150, 60, 240)}}, -- carte violette
	{Key = "OctoSpeed", Id = 2036804972, Name = "x8 Speed", Price = 12, Description = "x8 Speed gained on your treadmill", Badge = "x8", Featured = true,
		Icon = "rbxassetid://105217550794256", From = "x4", To = "x8", Mult = 8, Headline = "x8 Your Speed",
		Card = {Color3.fromRGB(255, 225, 215), Color3.fromRGB(255, 110, 90), Color3.fromRGB(220, 30, 60)}}, -- carte rouge
}
ShopConfig.SpeedPasses = {"OctoSpeed", "QuadSpeed", "DoubleSpeed"} -- du plus fort au plus faible : seul le meilleur compte (pas de cumul)

-- multiplicateur de vitesse gagnée sur le tapis (le meilleur pass speed possédé)
function ShopConfig.SpeedMult(player)
	for _, key in ShopConfig.SpeedPasses do
		if player:GetAttribute("Pass_" .. key) then
			for _, pass in ShopConfig.Passes do
				if pass.Key == key then return pass.Mult or 1 end
			end
		end
	end
	return 1
end

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
-- ProductId : un PRODUIT DÉVELOPPEUR (Creator Dashboard > Monetization > Developer Products), rachetable à l'infini.
-- Dès qu'il n'est plus 0, c'est lui qui est vendu (au lieu du gamepass, qui ne s'achète qu'une fois).
-- EndsAt : fin de l'offre (date UTC). OwnerFree : le créateur du jeu reçoit les œufs sans payer, pour essayer (mettre false pour l'enlever).
ShopConfig.Featured = {
	Egg = "AngelEgg",
	Title = "Fallen Angel Egg",
	EndsAt = os.time({year = 2026, month = 10, day = 26, hour = 12}),
	OwnerFree = true,
	Packs = {
		{Count = 1, Robux = 80, PassId = 2036090801, ProductId = 0},
		{Count = 3, Robux = 200, PassId = 2040722319, ProductId = 0},
		{Count = 10, Robux = 640, PassId = 2040422314, ProductId = 0},
		{Count = 50, Robux = 2800, PassId = 2037644819, ProductId = 0},
	},
}

return ShopConfig
