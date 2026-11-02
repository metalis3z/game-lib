-- // Adds a player to a list to ignore messages from.

local Chat = game:GetService("Chat")
local Players = game:GetService("Players")

local Shared = Chat:WaitForChild("Shared")
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))

local ChatScript = script.Parent.Parent
local SystemMessages = require(ChatScript.ChatInterface.SystemMessages)
local MutedPlayers = require(ChatScript.MutedPlayers)

local localPlayer = Players.LocalPlayer

local mute = {}

function mute.onSending(message: string): (boolean, boolean)
	local commandInfo = ChatUtil.getCommandInfoFromMessage(message)
	local playerQuery = commandInfo.arguments[1]
	
	local resultMessage: string = nil
	local resultColor: Color3 = nil
	
	local player, failureReason = ChatUtil.getPlayerFromTextQuery(localPlayer, playerQuery)
	if player ~= nil then
		local success, message = MutedPlayers.mute(player)
		if success then
			resultColor = ChatConstants.GuiColors.Text
		else
			resultColor = ChatConstants.GuiColors.ErrorText
		end
		resultMessage = message
	else
		if failureReason == "EMPTY_QUERY" then
			resultMessage = "Please specify a player."
		elseif failureReason == "TOO_MANY_RESULTS" then
			resultMessage = `More than one match found for "{player.Name}". Please type out more of the username.`
		elseif failureReason == "NO_RESULTS" then
			resultMessage = "No players found. Double check your spelling."
		end
		resultColor = ChatConstants.GuiColors.ErrorText
	end
	
	SystemMessages.displaySystemMessage(`<font color="#{resultColor:ToHex()}">{resultMessage}</font>`)
	
	return false, false
end

return mute