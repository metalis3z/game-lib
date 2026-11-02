local gui = game.Workspace.GUI.Interact.ShopInteract
local shop = script.Parent.Seasonal
gui.Triggered:Connect(function()
	shop.Visible = true
end)