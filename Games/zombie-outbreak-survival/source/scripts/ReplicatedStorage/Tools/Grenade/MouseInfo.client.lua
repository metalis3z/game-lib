local mouse = game.Players.LocalPlayer:GetMouse()


game:GetService("RunService").RenderStepped:Connect(function()
	
	
	script.Parent.MouseInfoRE:FireServer(mouse.Hit)
end)