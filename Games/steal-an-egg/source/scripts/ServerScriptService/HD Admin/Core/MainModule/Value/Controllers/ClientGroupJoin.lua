--!strict

--[[ 

	Client half of the group-join flow. Runs PromptJoinAsync (client-only) and,
	once the local player has actually joined, tells the server to verify and grant

]]


-- LOCAL
local Players = game:GetService("Players")
local GroupService = game:GetService("GroupService")
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Remote = require(modules.Objects.Remote)
local ClientGroupJoin = {}
local groupJoinSignal = Remote.get("GroupJoinSignal")


-- FUNCTIONS
-- The client's cache clears the moment they join, so IsInGroup is accurate right
-- after the prompt closes
function ClientGroupJoin.promptAndVerify(groupId: number)
	if typeof(groupId) ~= "number" then return end
	task.spawn(function()
		local localPlayer = Players.LocalPlayer
		local okWas, wasInGroup = pcall(localPlayer.IsInGroup, localPlayer, groupId)
		local alreadyMember = okWas and wasInGroup == true
		local ok = pcall(function()
			return GroupService:PromptJoinAsync(groupId)
		end)
		if not ok or alreadyMember then return end
		local okIn, isIn = pcall(localPlayer.IsInGroup, localPlayer, groupId)
		if okIn and isIn == true then
			groupJoinSignal:fireServer(groupId)
		end
	end)
end


-- SETUP
Remote.get("PromptJoinGroup"):onClientEvent(function(groupId)
	if typeof(groupId) ~= "number" then return end
	ClientGroupJoin.promptAndVerify(groupId)
end)


return ClientGroupJoin