local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataHandler = require(ServerScriptService:WaitForChild("DataService"):WaitForChild("DataHandler"))
local Config = require(ReplicatedStorage:WaitForChild("Config"))
local WinsMultiplierManager = require(ServerScriptService:WaitForChild("WinsMultiplierManager"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateUI = Remotes:WaitForChild("UpdateUI")

return function(context, target, amount)
	local data = DataHandler.Get(target)
	if not data then
		return "Player data not loaded."
	end
	
	if amount <= 0 then
		return "Amount must be greater than 0."
	end
	
	local winsMultiplier = data.WinsMultiplier or 1
	local globalWinsMult = WinsMultiplierManager.Get()
	local finalWins = math.floor(amount * winsMultiplier * globalWinsMult)
	
	data.Wins = data.Wins + finalWins
	
	-- Auto-upgrade StepBonus based on new win count
	data.StepBonus = Config.GetBestStepBonus(data.Wins)
	
	-- Update leaderstats
	local leaderstats = target:FindFirstChild("leaderstats")
	if leaderstats and leaderstats:FindFirstChild("Wins") then
		leaderstats.Wins.Value = data.Wins
	end
	
	-- Update client UI
	UpdateUI:FireClient(target, {
		Wins = data.Wins,
		StepBonus = data.StepBonus,
	})
	
	return string.format("Gave %d wins to %s. Total wins: %d. StepBonus: %dx", finalWins, target.Name, data.Wins, data.StepBonus)
end