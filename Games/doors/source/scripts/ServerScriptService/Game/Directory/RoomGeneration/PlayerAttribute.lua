local module = {}

function module:SetPlayerAttribute(v, num)
	v.Touched:Connect(function(hit)
		local character = hit.Parent
		local player = game.Players:GetPlayerFromCharacter(character)
		
		if player:FindFirstChild("Character") then
			game.Workspace.PlayerStats:FindFirstChild(player.Name).CurrentRoom.Value = num
		end
	end)
end

return module