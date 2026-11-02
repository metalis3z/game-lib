-- // Sends messages only to members of the player's team.

local Players = game:GetService("Players")

local Chat = game:GetService("Chat")
local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local ChatScript = script.Parent.Parent
local CurrentChannel = require(ChatScript.ChatInterface.CurrentChannel)

local localPlayer = Players.LocalPlayer

local team = {}

function team.onSending(message: string): (boolean, boolean)
	if localPlayer.Team ~= nil then
		CurrentChannel.setOnlyForNextMessage("RBXTeam" .. localPlayer.TeamColor.Name)
	end
	return false, true
end

function team.shouldEnableMessageMode(message: string): (boolean, string, string, Color3, string?)
	if localPlayer.Team ~= nil then
		return true, "team", "Team", localPlayer.TeamColor.Color, nil
	else
		return false, nil, nil, nil, nil
	end
end

return team