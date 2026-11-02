-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Synchronizer = require(Packages.Synchronizer)
local Timer = require(Packages.Timer)
local Net = require(Packages.Net)

local Datas = ReplicatedStorage:WaitForChild("Datas")
local TipsData = require(Datas.Tips)

local ChatTimer = Timer.new(1)
local ChatMessageEvent = Net:RemoteEvent("ChatService/ChatMessage")
local SystemChannel = nil

local ChatService = {
	["SendMessage"] = function(_, message)
		if SystemChannel then
			SystemChannel:DisplaySystemMessage(message)
		end
	end,

	["Start"] = function(self)
		SystemChannel = TextChatService:WaitForChild("TextChannels"):FindFirstChild("RBXSystem") 
			or Instance.new("TextChannel", TextChatService.TextChannels)
		SystemChannel.Name = "RBXSystem"

		local PlayerData = Synchronizer:Wait(Players.LocalPlayer)

		ChatMessageEvent.OnClientEvent:Connect(function(content)
			self:SendMessage(content)
		end)

		local lastTipTimes = {}
		ChatTimer.Tick:Connect(function()
			for index, tip in ipairs(TipsData) do
				local currentTime = os.clock()
				lastTipTimes[index] = lastTipTimes[index] or currentTime

				local tipsEnabled = PlayerData:Get("Settings.Chat Tips")
				if (currentTime - lastTipTimes[index]) >= tip.ShowEvery and tipsEnabled then
					lastTipTimes[index] = currentTime
					self:SendMessage(tip.ChatMessage)
				end
			end
		end)

		ChatTimer:Start()
	end
}

return ChatService