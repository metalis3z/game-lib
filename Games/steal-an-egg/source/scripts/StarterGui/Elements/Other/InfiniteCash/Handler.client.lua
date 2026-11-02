-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local PurchaseIdConfig = require(ReplicatedStorage:WaitForChild("PurchaseIdConfig"))

script.Parent.MouseButton1Click:Connect(function() --[[ Line: 6 | Upvalues: PurchaseIdConfig (copy), MarketplaceService (copy) ]]
	local v1 = PurchaseIdConfig.ProductIds[script.Parent.Name]

	if v1 then
		MarketplaceService:PromptProductPurchase(game.Players.LocalPlayer, v1)
	else
		warn("Couldnt find Product for " .. script.Parent.Name)
	end
end)