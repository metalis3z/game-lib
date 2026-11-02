local RunService = game:GetService("RunService")


RunService.RenderStepped:Connect(function()
	local teamcount = game.Teams.Players:GetPlayers()
	script.Parent.Text = ""..#teamcount
end)