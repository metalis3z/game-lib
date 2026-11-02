local gui = workspace.Lobby.MainLobby.FixPart
local shop = script.Parent.Shop

gui.Triggered:Connect(function()
	shop.Visible = true
end)