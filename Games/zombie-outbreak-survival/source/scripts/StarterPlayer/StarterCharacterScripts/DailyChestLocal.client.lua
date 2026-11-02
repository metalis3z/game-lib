local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local touchPart = Workspace:WaitForChild("DailyChest")
local txt = touchPart:WaitForChild("BillboardGui"):WaitForChild("TextLabel")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local DailyChestEvent = Remotes:WaitForChild("DailyChestEvent")
local GetTimeEvent = Remotes:WaitForChild("GetTimeEvent")
local currentStreak = 0
local localTimeLeft = 0
local serverRewards = {} -- Will be populated by the server
local canClaim = true

-- Formatting numbers (e.g., 1000 -> 1K)
local function formatNum(num)
	if num >= 1000 then
		return string.format("%.1fK", num/1000):gsub("%.0", "")
	end
	return tostring(num)
end

local function updateUI()
	if not serverRewards or #serverRewards == 0 then 
		txt.Text = "Loading Rewards..."
		return 
	end

	if localTimeLeft > 0 then
		local hours = math.floor(localTimeLeft / 3600)
		local mins = math.floor((localTimeLeft % 3600) / 60)
		local secs = localTimeLeft % 60
		txt.Text = string.format("STREAK: Day %d\nNext: %02d:%02d:%02d", currentStreak, hours, mins, secs)
	else
		local nextDay = (currentStreak % 7) + 1
		local reward = serverRewards[nextDay]
		if reward then
			txt.Text = "CLAIM DAY " .. nextDay .. "!\n$" .. formatNum(reward.Money) .. " + " .. formatNum(reward.XP) .. " XP"
		end
	end
end

-- Receive the sync from server
GetTimeEvent.OnClientEvent:Connect(function(timeLeft, streak, rewardsTable)
	localTimeLeft = math.ceil(timeLeft)
	currentStreak = streak
	serverRewards = rewardsTable -- UI now gets data directly from server
	updateUI()
end)

-- Receive claim success
DailyChestEvent.OnClientEvent:Connect(function(success, msg, m, x)
	if success then
		txt.Text = "COLLECTED\n$" .. m .. " & " .. x .. " XP!"
		task.wait(3)
		GetTimeEvent:FireServer() -- Refresh
	else
		txt.Text = msg
	end
end)

-- Touch Logic
touchPart.Touched:Connect(function(hit)
	if canClaim and hit.Parent == LocalPlayer.Character then
		canClaim = false
		DailyChestEvent:FireServer()
		task.wait(2)
		canClaim = true
	end
end)

-- Local Timer Loop
task.spawn(function()
	while true do
		if localTimeLeft > 0 then
			localTimeLeft -= 1
			updateUI()
		end
		task.wait(1)
	end
end)

-- Initial Sync Request
GetTimeEvent:FireServer()