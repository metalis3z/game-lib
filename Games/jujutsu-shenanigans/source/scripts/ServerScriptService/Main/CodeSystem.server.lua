local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local codeEvent = ReplicatedStorage.Remotes:WaitForChild("Code")
local usedCodesStore = DataStoreService:GetDataStore("UsedCodesStore")

local validCodes = {
	["ROB_CODE"] = "150",
	["JJSR_GREAT"] = "50",
	["ROB_RELAX"] = "100",
	["RELAX"] = "1000",
	["RELAX2"] = "1001",
	["DEV_TEST2"] = "100000000000000"
}

local function giveRewardToPlayer(player, reward)
	print("Reward given to " .. player.Name .. ": " .. reward)
	
	local money = player:WaitForChild("leaderstats", 2):WaitForChild("Hidden", 2):WaitForChild("Money", 2)

	money.Value += reward
end

local function onCodeReceived(player, enteredCode)
	if validCodes[enteredCode] then
		local key = player.UserId .. "_" .. enteredCode
		local usedCodes = usedCodesStore:GetAsync(key)

		if usedCodes then
			return "Code already used."
		else
			usedCodesStore:SetAsync(key, true)
			giveRewardToPlayer(player, validCodes[enteredCode])
			return "Code accepted! You received: " .. validCodes[enteredCode]
		end
	else
		return "Invalid code. Please try again."
	end
end

codeEvent.OnServerEvent:Connect(function(player, enteredCode)
	local response = onCodeReceived(player, enteredCode)
	codeEvent:FireClient(player, response)
end)
