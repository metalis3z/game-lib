local db = false
script.Parent.Touched:connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		if db == false then
			db = true
			script.Parent.Transparency = 1
			local player = game.Players:GetPlayerFromCharacter(hit.Parent)
			player.leaderstats.Points.Value = player.leaderstats.Points.Value + math.random(20,30)
			script.Sound:Play()
			wait(math.random(20,65))
			script.Parent.Transparency = 0
			db = false
		end
	end	
end)