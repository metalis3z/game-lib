local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

mouse.Button1Down:Connect(function()
	if script.Parent.Visible then
		--app running
		game.ReplicatedStorage.Photo:FireServer()
	end
end)