local gui = game.StarterGui.Shop.Interact.ShopInteract
local shop = script.Parent.Seasonal
gui.Triggered:Connect(function()
	shop.Visible = true
end)