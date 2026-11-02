local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataHandler = require(ServerScriptService:WaitForChild("DataService"):WaitForChild("DataHandler"))
local Config = require(ReplicatedStorage:WaitForChild("Config"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateUI = Remotes:WaitForChild("UpdateUI")

return function(context, target, count)
	local data = DataHandler.Get(target)
	if not data then
		return "Player data not loaded."
	end
	
	if count < 0 then
		return "Rebirth count must be 0 or greater."
	end
	
	data.Rebirths = count
	
	-- Set the multiplier based on the rebirth tier
	local tier = Config.REBIRTH_TIERS[count]
	if tier then
		data.Multiplier = tier.multiplier
	else
		-- If no tier for this exact count, find the best matching tier
		local bestMult = 1
		for i = count, 1, -1 do
			if Config.REBIRTH_TIERS[i] then
				bestMult = Config.REBIRTH_TIERS[i].multiplier
				break
			end
		end
		data.Multiplier = bestMult
	end
	
	-- Update walk speed
	if (not data.CustomWalkSpeed or data.CustomWalkSpeed == 0) and target.Character and target.Character:FindFirstChild("Humanoid") then
		target.Character.Humanoid.WalkSpeed = Config.CalculateMaxSpeed(data.Level, data.Multiplier)
	end
	
	-- Update leaderstats
	local leaderstats = target:FindFirstChild("leaderstats")
	if leaderstats and leaderstats:FindFirstChild("Rebirths") then
		leaderstats.Rebirths.Value = data.Rebirths
	end
	
	-- Update client UI
	UpdateUI:FireClient(target, {
		Rebirths = data.Rebirths,
		Multiplier = data.Multiplier,
	})
	
	return string.format("Set %s's rebirths to %d (multiplier: %sx).", target.Name, count, data.Multiplier)
end