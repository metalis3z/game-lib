--!strict
-- SpinHandler
-- Client invokes RequestSpin -> we pick a reward wedge, return its index to
-- the client so the wheel can animate to that wedge, then deliver the reward
-- AFTER the spin animation finishes so the player doesn't see the result
-- before the wheel stops.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataManager = require(script.Parent.DataManager)
local SpinConfig  = require(ReplicatedStorage.Modules.DailySpinConfiguration)
local ItemManager = require(game:GetService("ServerScriptService").Modules.ItemManager)
local Events = ReplicatedStorage:WaitForChild("Events")
local RequestSpin = Events:WaitForChild("RequestSpin")
local ShowNotification = Events:WaitForChild("ShowNotification")
local TriggerUIEffect = Events:WaitForChild("TriggerUIEffect")
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

-- Give the client enough time to run its spin animation before we tell them
-- what they won. The controller tweens for 6 seconds; pad slightly.
local SPIN_ANIMATION_SECONDS = 6.5

-- Pick a weighted random wedge; returns the reward AND its index in SpinConfig.Rewards
local function rollReward(): (any, number)
	local total = 0
	for _, r in ipairs(SpinConfig.Rewards) do total += r.Chance end
	local roll = math.random(1, total)
	local cum = 0
	for i, r in ipairs(SpinConfig.Rewards) do
		cum += r.Chance
		if roll <= cum then return r, i end
	end
	return SpinConfig.Rewards[1], 1
end

-- Keep player attributes in sync so the UI controller (DailySpinUIController)
-- can read them to update the button text / countdown.
local function syncAttributes(player: Player)
	local data = DataManager.get(player)
	if not data then return end
	player:SetAttribute("SpinNumber", data.DailySpins or 0)
	player:SetAttribute("LastDailySpin", data.LastSpinReset or 0)
end

-- On join / respawn, make sure the attributes are set so the UI is correct.
local function initPlayer(player: Player)
	task.defer(function()
		-- DataManager.load runs on PlayerAdded; give it a moment.
		for _ = 1, 50 do
			if DataManager.get(player) then break end
			task.wait(0.1)
		end
		local data = DataManager.get(player)
		if not data then return end
		-- Reset daily spins if 24h have passed
		local now = os.time()
		if now - (data.LastSpinReset or 0) >= 86400 then
			data.DailySpins = 1  -- 1 free spin per 24h cycle
			data.LastSpinReset = now
		end
		syncAttributes(player)
	end)
end
Players.PlayerAdded:Connect(initPlayer)
for _, p in ipairs(Players:GetPlayers()) do initPlayer(p) end

RequestSpin.OnServerInvoke = function(player: Player)
	local data = DataManager.get(player)
	if not data then return { success = false, error = "No data" } end

	-- Daily reset check (also handled in initPlayer, re-check here in case of long session)
	local now = os.time()
	if now - (data.LastSpinReset or 0) >= 86400 then
		data.DailySpins = 1
		data.LastSpinReset = now
	end

	if (data.DailySpins or 0) <= 0 then
		syncAttributes(player)
		return { success = false, error = "No spins left today!" }
	end

	-- Consume the spin BEFORE rolling so the client can't spam-click while
	-- the animation is in-flight.
	data.DailySpins -= 1
	-- First spin of a new cycle resets the 24h timer from the moment they spin.
	-- (If they had extra bonus spins this doesn't reset the cooldown; we only
	-- reset when crossing the 24h boundary above.)
	syncAttributes(player)

	local reward, index = rollReward()

	-- Deliver the reward AFTER the client finishes animating. Use task.delay
	-- so we return immediately with the wedge index.
	task.delay(SPIN_ANIMATION_SECONDS, function()
		if not player.Parent then return end
		if reward.Type == "Cash" then
			DataManager.addMoney(player, reward.Amount or 0)
			ShowNotification:FireClient(player, "Won $" .. NumberFormatter.Format(reward.Amount or 0) .. "!", "Success")
		elseif reward.Type == "Spins" then
			local d = DataManager.get(player)
			if d then
				d.DailySpins = (d.DailySpins or 0) + (reward.Amount or 1)
				syncAttributes(player)
			end
			ShowNotification:FireClient(player, "Won " .. (reward.Amount or 1) .. " extra spin(s)!", "Success")
		elseif reward.Type == "Item" then
			local ic = require(ReplicatedStorage.Modules.ItemConfigurations)
			local idata = ic.GetItemData(reward.Name or "")
			local rarity = idata and idata.Rarity or "Common"
			ItemManager.GiveItemToPlayer(player, reward.Name or "?", "Normal", rarity, 1)
			ShowNotification:FireClient(player, "Won item: " .. (reward.Name or "?") .. "!", "Success")
		end
		TriggerUIEffect:FireClient(player, "HighlightLight")
	end)

	return {
		success = true,
		Index = index,               -- Which wedge (1..#Rewards) the wheel should land on
		RewardType = reward.Type,
		RewardAmount = reward.Amount,
		RewardName = reward.Name,
		RewardImage = reward.Image,
		SpinsLeft = data.DailySpins,
	}
end

print("[SpinHandler] Active")
local SpinHandler = {}
return SpinHandler
