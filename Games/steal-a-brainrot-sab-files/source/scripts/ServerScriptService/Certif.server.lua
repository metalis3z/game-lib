local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")

	-- Seulement toi
	if player.Name ~= "omaramgad2009" then
		return
	end
	if player.Name ~= "omaramgad2009" then
		return
	end

	-- Si pas de displayname
	if humanoid.DisplayName == "" then
		humanoid.DisplayName = player.Name
	end

	-- Ajoute la certification
	humanoid.DisplayName = humanoid.DisplayName .. " "
end)