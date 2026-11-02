local Players = game:GetService("Players")

-- Remet la sante a 100 en permanence SAUF si le joueur est en train de se reset
while true do
	for _, player in pairs(Players:GetPlayers()) do
		-- Ne pas bloquer la mort si le joueur veut se reset
		if player:GetAttribute("IsResetting") then continue end

		if player.Character and player.Character:FindFirstChild("Humanoid") then
			local humanoid = player.Character.Humanoid
			if humanoid.Health < 100 and humanoid.Health > 0 then
				humanoid.Health = 100
			end
		end
	end
	task.wait(0.05)
end