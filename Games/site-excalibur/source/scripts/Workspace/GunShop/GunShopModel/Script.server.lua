event = game.ReplicatedStorage.ShopEvents:WaitForChild("CloseGUI")
local part = game.StarterGui.GunShop.Frame
script.Parent.OpenGunShop.Triggered:Connect(function(player)
	player.PlayerGui.GunShop.Frame.Visible = true
	player.Character.HumanoidRootPart.Anchored = true
end)

local function closeshop(player)
	player.PlayerGui.GunShop.Frame.Visible = false
	player.Character.HumanoidRootPart.Anchored = false
end

event.OnServerEvent:Connect(closeshop)