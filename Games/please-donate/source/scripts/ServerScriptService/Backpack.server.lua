--[[
    nexus = poopie head
]]

game.Players.PlayerAdded:Connect(function(plr)
	wait(1)
	if plr.leaderstats.Donated.Value >= 1000 then
		local s, f = pcall(function()
			local smite = game.ServerStorage.Tools:FindFirstChild("SmiteHammer"):Clone()
			if not plr.Backpack:FindFirstChild("SmiteHammer") then
				smite.Parent = plr.Backpack
			end
		end)
		if f then
			warn(f)
		end
	end
	
end)

while wait(1) do
for i,v in pairs(game.Players:GetChildren()) do
	v:FindFirstChild("leaderstats").Donated:GetPropertyChangedSignal("Value"):Connect(function()
		if v.leaderstats.Donated.Value >= 1000 then
			local smite = game.ServerStorage.Tools:FindFirstChild("SmiteHammer"):Clone()
			if not v.Backpack:FindFirstChild("SmiteHammer") then
				smite.Parent = v.Backpack
			end
		else
			if v.Backpack:FindFirstChild("SmiteHammer") then
				v.Backpack:FindFirstChild("SmiteHammer"):Destroy()
			end
		end
	end)
end
end