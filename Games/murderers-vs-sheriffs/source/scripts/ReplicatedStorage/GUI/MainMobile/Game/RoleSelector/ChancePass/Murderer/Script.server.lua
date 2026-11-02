local v_u_1 = require(game:GetService("ReplicatedStorage").Modules.WindowService)
local v_u_2 = game:GetService("MarketplaceService")

script.Parent.Button.MouseButton1Click:Connect(function()
	v_u_2:PromptProductPurchase(game:GetService("Players").LocalPlayer, require(game.ReplicatedStorage.Constants).Gameplay.Murderer)
    v_u_1:AddToStack("ProcessPending")
end)

