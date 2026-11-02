local Players = game:GetService("Players")

function setParent(c, p)
	local connection
	connection = c.AncestryChanged:Connect(function(_, parent)
		if (parent == workspace) then
			connection:Disconnect()
			task.wait(1 / 30)
			c.Parent = p
		else
			connection:Disconnect()
		end
	end)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		setParent(character, workspace.Characters)
	end)
end)