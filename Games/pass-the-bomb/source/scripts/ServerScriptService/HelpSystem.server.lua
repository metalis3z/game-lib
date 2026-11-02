--[[

	Documentation:
	# NTH | Help System
	---------------
	Author:
	@ lightyns
	---------------
	Server-side handler for the help requests panel.
	---------------
	Last Edited:
	# 2021-03-12

--]]

--# Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")

local gui = script:WaitForChild("HelpRequests")
local staffFolder = script:WaitForChild("StaffFolder")

local cooldowns = {}
local queue = {}

local folder
local helpRemoteFunction
local helpRemoteEvent

--# Variables
local function getTextObject(message, sender)
	local success, response = pcall(TextService.FilterStringAsync, TextService, message, sender)
	if success then
		return response
	end
	warn('NTH | Help System | Error with generating a filtering text object: '.. response)
end

local function filterMessage(object, receiver)
	local success, response = pcall(object.GetChatForUserAsync, object, receiver)
	if success then
		return response
	end
	warn('NTH | Help System | Error with filtering text: '.. response)
end

local handler = {
	['Queue'] = function()
		return queue
	end,
	['Submit'] = function(user, ...)
		local args = {...}
		local reason = tostring(args[1])
		local cooldown = cooldowns[user]
		local current = os.time()
		for _, v in ipairs(queue) do
			if v.User == user then
				return 'Error', 'You already have a pending help request! Please try again later!'
			end
		end
		if cooldown and (current - cooldown <= 300) then
			return 'Error', 'You are currently on a 5-minute cooldown! Please try again later!'
		end
		if reason == '' then
			return 'Error', 'You must provide a reason along with your help request!'
		end
		cooldowns[user] = current
		local textObject = getTextObject(reason, user.UserId) or 'Error while filtering text.'
		table.insert(queue, {
			User = user,
			Reason = args[1]
		})
		for _, v in ipairs(Players:GetPlayers()) do
			if v:GetRankInGroup(8025572) >= 17 then
				local filtered = filterMessage(textObject, v.UserId) or 'Error while filtering text.'
				helpRemoteEvent:FireClient(v, 'Request', user, filtered)
			end
		end
		return 'Success'
	end,
	['Delete'] = function(user, ...)
		if user:GetRankInGroup(8025572) < 17 then
			return
		end
		local args = {...}
		local removal = args[1]
		for pos, v in ipairs(queue) do
			if v.User.Name == removal then
				table.remove(queue, pos)
				break
			end
		end
		for _, v in ipairs(Players:GetPlayers()) do
			if v:GetRankInGroup(8025572) >= 17 then
				helpRemoteEvent:FireClient(v, 'Delete', removal)
			end
		end
		return 'Success'
	end,
}

local function onServerInvoke(user, key, ...)
	return handler[key](user, ...)
end

local function playerAdded(player)
	local rank = player:GetRankInGroup(8025572)
	local clone = gui:Clone()
	if rank >= 17 then
		local requestsButton = staffFolder:WaitForChild('Requests'):Clone()
		local requestsFrame = staffFolder:WaitForChild('RequestsFrame'):Clone()
		requestsFrame.Parent = clone:WaitForChild("Frame")
		requestsButton.Parent = clone:WaitForChild("Frame"):WaitForChild("Buttons")
	end
	clone.Parent = player:WaitForChild("PlayerGui")
end

--# Implicits
folder = Instance.new("Folder")
folder.Name = 'Help System'

helpRemoteFunction = Instance.new('RemoteFunction')
helpRemoteFunction.Name = 'Help Function'
helpRemoteFunction.Parent = folder

helpRemoteEvent = Instance.new('RemoteEvent')
helpRemoteEvent.Name = 'Help Event'
helpRemoteEvent.Parent = folder

folder.Parent = ReplicatedStorage

helpRemoteFunction.OnServerInvoke = onServerInvoke

for _, v in ipairs(Players:GetPlayers()) do
	coroutine.wrap(playerAdded)(v)
end
Players.PlayerAdded:Connect(playerAdded)
Players.PlayerRemoving:Connect(function(player)
	cooldowns[player] = nil
	for pos, v in ipairs(queue) do
		if v.User.Name == player.Name then
			table.remove(queue, pos)
			break
		end
	end
	for _, v in ipairs(Players:GetPlayers()) do
		if v:GetRankInGroup(8025572) >= 17 then
			helpRemoteEvent:FireClient(v, 'Delete', player.Name)
		end
	end
end)