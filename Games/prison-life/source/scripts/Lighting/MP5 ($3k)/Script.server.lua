Toolname = "MP5"

function onclick(Player)
	if not Player.Backpack:FindFirstChild(Toolname) then
		if Player.leaderstats.Coins.Value > 3000 or Player.leaderstats.Coins.Value == 3000 then
			Player.leaderstats.Coins.Value = Player.leaderstats.Coins.Value-3000

			local Tool = game.ServerStorage[Toolname]:clone()
			Tool.Parent = Player.Backpack
		end
	end
end

script.Parent.ClickDetector.MouseClick:Connect(onclick)
