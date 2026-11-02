local Tool = script.Parent

script.Parent.DropTool.OnServerEvent:Connect(function(Player,Player2)
	local Owner = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
	if Player == Owner then 
	local Player3 = game.Players:GetPlayerFromCharacter(Player2)
	Tool.Parent = Player3.Backpack 
	else
		print(Player.Name.."Is Exploiting What A Clown")
	end
end)