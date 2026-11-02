script.Parent.MouseButton1Down:Connect(function()
	script.Parent.TextColor3 = Color3.fromRGB(0, 255, 0)
	local localPlr = game.Players.LocalPlayer
	local char = localPlr.Character
	char.VrMode.Enable:FireServer()
	script.Parent.Parent.Visible = false
end)