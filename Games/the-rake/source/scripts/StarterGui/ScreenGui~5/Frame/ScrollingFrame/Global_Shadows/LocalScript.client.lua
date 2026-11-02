local GlobalShadow = true

script.Parent.MouseButton1Down:Connect(function()
	if GlobalShadow == false then
		game.Lighting.GlobalShadows = true
		script.Parent.TextColor3 = Color3.fromRGB(0, 255, 0)
		GlobalShadow = true
	else
		game.Lighting.GlobalShadows = false
		script.Parent.TextColor3 = Color3.fromRGB(255, 255, 255)
		GlobalShadow = false
	end
end)