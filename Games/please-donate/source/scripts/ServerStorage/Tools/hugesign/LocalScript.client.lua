
local Player = game.Players.LocalPlayer
script.Parent.Equipped:Connect(function()
	script.Parent.RemoteEvent:FireServer()
end)