Toolname = "Crude Knife"

function boop(Player)
	if Player.Team == game.Teams.Inmates then
		if not Player.Backpack:FindFirstChild(Toolname) then
			local Tool = game.ServerStorage[Toolname]:clone()
			Tool.Parent = Player.Backpack
		end
	end
end

script.Parent.ClickDetector.MouseClick:Connect(boop)
