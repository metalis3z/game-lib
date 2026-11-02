script.Parent.Head.Touched:connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player ~= nil then
		local cashmoney = game.ServerStorage.MoneyStorage:FindFirstChild(player.Name)
		if cashmoney ~= nil then
			local ownstycoon = cashmoney:FindFirstChild("OwnsTycoon")
			if ownstycoon ~= nil then
				if ownstycoon.Value == false then
					if script.Parent.Parent.Parent.Owner.Value == nil then
						if hit.Parent:FindFirstChild("Humanoid") then
							if hit.Parent.Humanoid.Health > 0 then
								player.TeamColor = BrickColor.new(script.Parent.Parent.Parent.Name)
								script.Parent.Parent.Parent.Owner.Value = player
								script.Parent.Parent.Parent.Own2.Value = hit.Parent.Name
								ownstycoon.Value = true
								script.Parent.Name = player.Name.."'s Tycoon"
								script.Parent.Head.Transparency = 0.6
								script.Parent.Head.CanCollide = false
								
							end
						end
					end
				end
			end
		end
	end
end)