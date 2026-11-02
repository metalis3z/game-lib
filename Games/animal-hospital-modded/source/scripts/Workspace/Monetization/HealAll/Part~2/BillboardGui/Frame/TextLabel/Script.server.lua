-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local MarketplaceService = game:GetService("MarketplaceService")
local ProductConfig = require(game.ReplicatedStorage.Data.ProductConfig)
local v1 = script.Parent
local ok, result = pcall(function() --[[ Line: 6 | Upvalues: MarketplaceService (copy) ]]
	return MarketplaceService:GetProductInfoAsync(ProductConfig.legacy_heal_all_display.id, Enum.InfoType.Product)
end)

if ok then
	v1.Text = result.PriceInRobux
end