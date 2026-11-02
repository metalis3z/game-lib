local gui = game.Workspace.GunShop.GunShopModel.OpenGunShop
local GunShop = script.Parent.Frame
gui.Triggered:Connect(function()
	GunShop.Visible = true
end)