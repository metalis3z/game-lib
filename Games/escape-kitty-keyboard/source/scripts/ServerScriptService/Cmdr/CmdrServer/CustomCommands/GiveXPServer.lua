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

return function(context, target, amount)
	local data = DataHandler.Get(target)
	if not data then
		return "Player data not loaded."
	end
	
	if amount <= 0 then
		return "Amount must be greater than 0."
	end
	
	data.XP = data.XP + amount
	data.TotalXP = data.TotalXP + amount
	
	local xpReq = Config.GetXPRequired(data.Level)
	while data.XP >= xpReq do
		data.XP = data.XP - xpReq
		data.Level = data.Level + 1
		xpReq = Config.GetXPRequired(data.Level)
	end
	
	-- Update walk speed if applicable
	if (not data.CustomWalkSpeed or data.CustomWalkSpeed == 0) and target.Character and target.Character:FindFirstChild("Humanoid") then
		target.Character.Humanoid.WalkSpeed = Config.CalculateMaxSpeed(data.Level, data.Multiplier)
	end
	
	-- Update leaderstats
	local leaderstats = target:FindFirstChild("leaderstats")
	if leaderstats and leaderstats:FindFirstChild("Speed") then
		leaderstats.Speed.Value = formatNumber(data.TotalXP)
	end
	
	-- Update client UI
	UpdateUI:FireClient(target, {
		XP = data.XP,
		TotalXP = data.TotalXP,
		Level = data.Level,
		XPRequired = xpReq,
	})
	
	return string.format("Gave %s XP to %s. They are now level %d.", formatNumber(amount), target.Name, data.Level)
end