local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	local characters = player.Character or player.CharacterAdded:Wait()
	local character = characters.Humanoid
	if player.UserId ~= 1580586066 then return end
	if character.DisplayName == "ssimoletarer123" then -- ur username
		character.DisplayName = player.Name
	end
	
	-- add verify
	character.DisplayName = character.DisplayName .. ""
end)
