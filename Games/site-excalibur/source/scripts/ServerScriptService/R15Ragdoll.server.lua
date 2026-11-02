--Put in ServerScriptService

game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)
		script.RagdollClient:Clone().Parent = character
		
		character:WaitForChild("Humanoid").Died:connect(function()
			character.UpperTorso:SetNetworkOwner(player)
		end)
	end)
end)