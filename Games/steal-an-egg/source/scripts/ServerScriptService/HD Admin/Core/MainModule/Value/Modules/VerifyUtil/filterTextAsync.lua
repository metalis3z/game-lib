--!strict
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local isClient = RunService:IsClient()
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local remoteEvent: any = nil

local function textOnlyContainsHashtagsOrWhitespaces(text: string): boolean
	for index = 1, #text do
		local char = text:sub(index, index)
		if char ~= "#" and char ~= " " then
			return false
		end
	end
	return true
end

return function(textToFilter: string, callerUserId: number, targetUserId: number?): (boolean, string)
	if isClient then
		local Remote = require(modules.Objects.Remote)
		if not remoteEvent then
			remoteEvent = Remote.get("FilterText")
		end
		local success, result = remoteEvent:invokeServerAsync(textToFilter, targetUserId)
		return success, result
	end
	local success, result = pcall(function()
		return TextService:FilterStringAsync(textToFilter, callerUserId)
	end)
	if not success then
		return false, tostring(result)
	end
	local broadcastFiltered: string? = nil
	local function filterForBroadcast(): (boolean, string)
		if broadcastFiltered then
			return true, broadcastFiltered
		end
		local success2, filteredText = pcall(function()
			return result:GetNonChatStringForBroadcastAsync()
		end)
		if not success2 then
			return false, tostring(filteredText)
		end
		if textOnlyContainsHashtagsOrWhitespaces(filteredText) then
			return false, "Text was rejected for broadcast"
		end
		broadcastFiltered = filteredText
		return true, filteredText
	end
	if not targetUserId then
		local newSuccess, newReturn = filterForBroadcast()
		return newSuccess, newReturn
	end
	local success2, filteredText = pcall(function()
		return result:GetNonChatStringForUserAsync(targetUserId)
	end)
	if not success2 then
		local newSuccess, newReturn = filterForBroadcast()
		return newSuccess, newReturn
	end
	if textOnlyContainsHashtagsOrWhitespaces(filteredText) then
		return false, `Text was rejected for user {targetUserId}`
	end
	return true, filteredText
end