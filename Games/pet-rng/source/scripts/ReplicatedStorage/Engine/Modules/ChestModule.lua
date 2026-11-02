local RunService = game:GetService("RunService")

local DataManager

if RunService:IsServer() then
	local ServerScriptService = game:GetService("ServerScriptService")
	local Engine = ServerScriptService:WaitForChild("Engine")
	local Scripts = Engine:WaitForChild("Scripts")
	local Data = Scripts:WaitForChild("Data")
	DataManager = require(Data:WaitForChild("DataManager"))
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RSEngine = ReplicatedStorage:WaitForChild("Engine")
local RemoteFunctions = RSEngine:WaitForChild("RemotesFunctions")
local GetValue = RemoteFunctions:WaitForChild("GetValue")
local Modules = RSEngine:WaitForChild("Modules")
local Luck = require(Modules:WaitForChild("Luck"))

local chestResetTime = 86400

local ChestModule = {}

function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
end

local function getTimePassed(claimTime)
	return os.time() - claimTime
end

ChestModule.ClaimChest = function(player: Player)
	local chestData = DataManager.profiles[player].Data["Chest"]
	local claimTime = chestData["ClaimTime"]
	
	local timePassed = getTimePassed(claimTime)
	if timePassed >= chestResetTime then
		chestData["ClaimTime"] = os.time()
		Luck.GiveLuck(player, "Luck Potion I")
	end
end

ChestModule.SetUp = function(player: Player)
	local chestGui = workspace:WaitForChild("Main Map"):WaitForChild("Interactions"):WaitForChild("Epic Chest"):WaitForChild("Hitbox"):WaitForChild("ChestGui")
	local countDown = chestGui:WaitForChild("Count_Down")
	
	while wait(1) do
		local chestData = GetValue:InvokeServer("Chest")
		local timeLeft = chestResetTime - getTimePassed(chestData["ClaimTime"])
		if timeLeft >= 0 then
			countDown.Amount.Text = convertToHMS(timeLeft)
		else
			countDown.Amount.Text = "Claim"
		end
	end
end

return ChestModule
