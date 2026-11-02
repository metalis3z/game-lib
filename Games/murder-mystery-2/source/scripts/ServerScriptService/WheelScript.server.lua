local DataStoreService = game:GetService("DataStoreService")
local dailyRewardDS = DataStoreService:GetDataStore("Wheel")
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local MarketplaceService = game:GetService("MarketplaceService")
local Module = require(game.ServerScriptService.Misc.External.GameScript.DataModule) -- Check ServerScriptService.

local RewardTable = {
	["1"] = {"Item", {"CandleF"}}, -- Change It.
	["2"] = {"Item", {"Evergreen"}}, -- Change It.
	["3"] = {"Item", {"Pum"}}, -- Change It.
	["4"] = {"Item", {"Eternalh"}}, -- Change It.
	["5"] = {"Item", {"Flames"}}, -- Change It.
	["6"] = {"Item", {"VampireE"}}, -- Change It.
}

local spinning = {}  
local function GetTimeRemaining(StartTime)
	local CurrentTime = os.time()
	local TimeRemaining = StartTime + 1800 - CurrentTime
	return math.max(0, TimeRemaining)
end

local wheelPart = game.Workspace.Lobby.Wheel.Spin
local proximityPrompt = game.Workspace.Lobby.Wheel.Pivot.ProximityPrompt

if not proximityPrompt or not proximityPrompt:IsA("ProximityPrompt") then
	error("ProximityPrompt not found or not valid.")
end

local billboardGui = game.Workspace.Lobby.Wheel.Pivot.BillboardGui
local timeTextLabel = billboardGui:WaitForChild("NextSpin")

local devProductID = 0

local function GiveItem(player, item)
	Module.SaveData(player)
	Module.GiveItem(player, item, 1, "Weapons")
	game.ReplicatedStorage.ItemGift:FireClient(player, item, "Weapons")
end

local function InitializePlayer(player)
	local success, dailyRewardInfo = pcall(function()
		return dailyRewardDS:GetAsync(player.UserId .. "Wheel")
	end)

	if not success then
		warn("Error fetching daily reward info:", dailyRewardInfo)
		return
	end

	if type(dailyRewardInfo) ~= "table" then
		dailyRewardInfo = {os.time() - 300, 0} 
		dailyRewardDS:SetAsync(player.UserId .. "Wheel", dailyRewardInfo)
	end
end

game.Players.PlayerAdded:Connect(function(player)
	InitializePlayer(player)
end)

proximityPrompt.Triggered:Connect(function(player)
	if spinning[player] then
		print(player.Name .. " cannot spin the wheel, it is already spinning.")
		return
	end

	local success, dailyRewardInfo = pcall(function()
		return dailyRewardDS:GetAsync(player.UserId .. "Wheel")
	end)

	if not success then
		warn("Error fetching daily reward info:", dailyRewardInfo)
		return
	end

	local StartTime = dailyRewardInfo[1]
	local TimeRemaining = GetTimeRemaining(StartTime)

	print(player.Name .. "'s Time Remaining:", TimeRemaining)

	if TimeRemaining == 0 then
		spinning[player] = true


		local spinSpeed = math.rad(15)
		local spinTime = 3  

		local startTime = tick()

		while tick() - startTime < spinTime do
			wheelPart.CFrame = wheelPart.CFrame * CFrame.Angles(spinSpeed, 0, 0)
			wait(0.01)
		end


		local streak = math.random(1, 6)

		local RewardData = RewardTable[tostring(streak)]

		if RewardData then
			print(player.Name .. " won: " .. table.unpack(RewardData))

			if RewardData[1] == "Cash" then
				Module.Give(player, "Credits", RewardData[2])
			elseif RewardData[1] == "Item" then
				GiveItem(player, RewardData[2][1])
			end


			dailyRewardDS:SetAsync(player.UserId .. "Wheel", {os.time()})
		else
			warn("Invalid reward data for streak:", streak)
		end

		spinning[player] = false
	else
		print(player.Name .. " can't spin the wheel yet. Time remaining:", TimeRemaining)

		local hasDevProduct, isPurchased = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, devProductID)
		end)

		if hasDevProduct and isPurchased then
			print(player.Name .. " has purchased the dev product for an immediate spin.")

			local immediateReward = RewardTable[tostring(math.random(1, 6))]

			if immediateReward then
				print(player.Name .. " won: " .. table.unpack(immediateReward))

				if immediateReward[1] == "Cash" then
					Module.Give(player, "Credits", immediateReward[2])
				elseif immediateReward[1] == "Item" then
					GiveItem(player, immediateReward[2][1])
				end

				dailyRewardDS:SetAsync(player.UserId .. "Wheel", {os.time()})
			else
				warn("Invalid reward data for immediate spin.")
			end
		else
			print(player.Name .. " can purchase a spin with a dev product.")
			local success, purchaseError = pcall(function()
				local productInfo = MarketplaceService:GetProductInfo(devProductID, Enum.InfoType.GamePass)
				if productInfo then
					MarketplaceService:PromptGamePassPurchase(player, devProductID)
				else
					warn("Invalid dev product ID:", devProductID)
				end
			end)

			if not success then
				warn("Error prompting purchase:", purchaseError)
			end
		end
	end
end)

while wait(1) do
	for _, player in pairs(game.Players:GetPlayers()) do
		local dailyRewardInfo = dailyRewardDS:GetAsync(player.UserId .. "Wheel")
		if dailyRewardInfo then
			local TimeRemaining = GetTimeRemaining(dailyRewardInfo[1])
			timeTextLabel.Text = "Time Remaining: " .. tostring(math.ceil(TimeRemaining)) .. "s"
		end
	end
end

game.Players.PlayerRemoving:Connect(function(player)
	spinning[player] = nil
	local success, errormsg = pcall(function()
		Module.SaveData(player)
		print(player.Name .. "'s data saved on leaving.")
	end)

	if not success then
		warn("Error saving data for PlayerRemoving:", errormsg)
	end
end)