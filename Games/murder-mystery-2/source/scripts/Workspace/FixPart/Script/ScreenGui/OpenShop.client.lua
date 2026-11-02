local gui = game.Workspace.Shop.Interact.ShopInteract
local shop = script.Parent.Seasonal
gui.Triggered:Connect(function()
	shop.Visible = true
end)