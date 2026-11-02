local v_u_1 = require(game:GetService("ReplicatedStorage").Modules.WindowService)
local v_u_2 = game:GetService("MarketplaceService")

script.Parent.Triggered:Connect(function()
	v_u_2:PromptGamePassPurchase(game:GetService("Players").LocalPlayer, require(game.ReplicatedStorage.Constants).Gamepasses.ItemPacks.BanHammer)
    v_u_1:AddToStack("ProcessPending")
end)

