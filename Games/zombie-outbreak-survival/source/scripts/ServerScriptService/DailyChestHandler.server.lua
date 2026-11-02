local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ChestEvent = Remotes:WaitForChild("DailyChestEvent")
local TimeEvent = Remotes:WaitForChild("GetTimeEvent")

local DailyStore = DataStoreService:GetDataStore("DailyRewards_V4")

-- ONE CENTRAL REWARD TABLE
local REWARDS = {
	[1] = {Money = 100,  XP = 0},
	[2] = {Money = 150,  XP = 0},
	[3] = {Money = 200, XP = 0},
	[4] = {Money = 250, XP = 0},
	[5] = {Money = 300, XP = 0},
	[6] = {Money = 350, XP = 0},
	[7] = {Money = 400, XP = 100},
}

local TIME_DIFFERENCE = 86400 
local STREAK_EXPIRY = 172800
local claimDebounce = {}

-- Function to give rewards
local function giveReward(player, day)
	local reward = REWARDS[day]
	local stats = player:FindFirstChild("leaderstats")
	if stats then
		local m = stats:FindFirstChild("Money")
		local x = stats:FindFirstChild("XP")
		if m then m.Value += reward.Money end
		if x then x.Value += reward.XP end
	end
	return reward.Money, reward.XP
end

-- Claim Logic
ChestEvent.OnServerEvent:Connect(function(player)
	if claimDebounce[player] then return end
	claimDebounce[player] = true

	local userKey = "User_" .. player.UserId
	local data = DailyStore:GetAsync(userKey) or {LastClaim = 0, Streak = 0}

	local now = os.time()
	local timeSince = now - data.LastClaim

	if timeSince >= TIME_DIFFERENCE then
		local newStreak = (timeSince > STREAK_EXPIRY or data.Streak >= 7) and 1 or data.Streak + 1

		local success = pcall(function()
			DailyStore:SetAsync(userKey, {LastClaim = now, Streak = newStreak})
		end)

		if success then
			local m, x = giveReward(player, newStreak)
			ChestEvent:FireClient(player, true, "Claimed Day " .. newStreak .. "!", m, x)
		end
	else
		ChestEvent:FireClient(player, false, "Not ready yet!")
	end
	claimDebounce[player] = nil
end)

-- Sync Time, Streak, AND the Reward Table
TimeEvent.OnServerEvent:Connect(function(player)
	local userKey = "User_" .. player.UserId
	local data = DailyStore:GetAsync(userKey) or {LastClaim = 0, Streak = 0}
	local timeLeft = math.max(TIME_DIFFERENCE - (os.time() - data.LastClaim), 0)

	-- We pass the REWARDS table so the client knows what to display
	TimeEvent:FireClient(player, timeLeft, data.Streak, REWARDS)
end)