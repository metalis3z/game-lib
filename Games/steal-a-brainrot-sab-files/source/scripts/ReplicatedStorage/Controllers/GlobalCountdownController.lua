-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local Net = require(ReplicatedStorage.Packages.Net)
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local TopUI = PlayerGui:WaitForChild("TopUI")
local CountdownUI = TopUI.Frame.Countdown
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local countdownRemote = Net:RemoteFunction("UpdateCountdown")
local onUpdateEvent = Net:RemoteEvent("OnUpdate")
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
return {
	["Start"] = function()
		local isVisible = false
		local countdownData = nil

		local function RefreshUI()
			if not countdownData then return end

			local currentTime = workspace:GetServerTimeNow()
			local timeLeft = countdownData.timestamp - currentTime

			if timeLeft > 0 then
				if not isVisible then
					isVisible = true
					CountdownUI.Visible = true
					CountdownUI.Title.Text = countdownData.title or "EVENT"
					CountdownUI.Title.TextColor3 = Color3.fromHex(countdownData.color or "#ffea00")
				end

				CountdownUI.Timer.Text = TimeUtils:E(math.max(timeLeft, 0))
			else
				if isVisible then
					isVisible = false
					CountdownUI.Visible = false
				end
			end
		end

		task.spawn(function()
			local success, result = pcall(function()
				return countdownRemote:InvokeServer("Get")
			end)

			if success and result then
				countdownData = result
				RefreshUI()
			else
				warn("GlobalCountdown: Failed to fetch initial server state.")
			end
		end)

		onUpdateEvent.OnClientEvent:Connect(function(newData)
			countdownData = newData
			isVisible = false 
			RefreshUI()
		end)

		task.spawn(function()
			while true do
				RefreshUI()
				task.wait(1)
			end
		end)
	end
}