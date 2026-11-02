local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataHandler = require(ServerScriptService:WaitForChild("DataService"):WaitForChild("DataHandler"))
local Config = require(ReplicatedStorage:WaitForChild("Config"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateUI = Remotes:WaitForChild("UpdateUI")

local function formatNumber(n)
	local suffixes = {"", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc"}
	if n < 1000 then return tostring(math.floor(n)) end
	local i = math.floor(math.log10(n) / 3)
	local suffix = suffixes[i + 1] or "inf"
	local val = n / 10 ^ (i * 3)
	return string.format("%.1f%s", val, suffix):gsub("%.0", "")
end

return function(context, target, level)
	local data = DataHandler.Get(target)
	if not data then
		return "Player data not loaded."
	end
	
	if level < 1 then
		return "Level must be at least 1."
	end
	
	-- Calculate TotalXP needed for this level
	local totalXP = 0
	for i = 1, level - 1 do
		totalXP = totalXP + Config.GetXPRequired(i)
	end
	
	data.Level = level
	data.TotalXP = totalXP
	data.XP = 0
	
	-- Update walk speed
	if (not data.CustomWalkSpeed or data.CustomWalkSpeed == 0) and target.Character and target.Character:FindFirstChild("Humanoid") then
		target.Character.Humanoid.WalkSpeed = Config.CalculateMaxSpeed(data.Level, data.Multiplier)
	end
	
	-- Update leaderstats
	local leaderstats = target:FindFirstChild("leaderstats")
	if leaderstats then
		if leaderstats:FindFirstChild("Speed") then
			leaderstats.Speed.Value = formatNumber(data.TotalXP)
		end
	end
	
	-- Update client UI
	UpdateUI:FireClient(target, {
		Level = data.Level,
		XP = data.XP,
		TotalXP = data.TotalXP,
		XPRequired = Config.GetXPRequired(data.Level),
	})
	
	return string.format("Set %s's level to %d.", target.Name, level)
end