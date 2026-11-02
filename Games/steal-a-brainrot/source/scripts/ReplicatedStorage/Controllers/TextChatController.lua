local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")
require(Packages:WaitForChild("Synchronizer"))

local ServerData = require(ReplicatedStorage:WaitForChild("Datas"):WaitForChild("ServerData"))

return {
	Start = function()
		TextChatService.OnIncomingMessage = function(message)
			if not message.TextSource then
				return
			end

			local Player = Players:GetPlayerByUserId(message.TextSource.UserId)
			if not Player then
				return
			end

			local properties = Instance.new("TextChatMessageProperties")
			local prefix = ""

			local Role = Player:GetAttribute("Role")

			if Role == "Lead" and (not ServerData.IsProdGame() or Player.UserId == 1381965313) then
				prefix = string.format(
					"<font color=\"#fa0909\">[SPYDER]</font> %s",
					message.PrefixText or ""
				)

			elseif Role == "Dev" then
				prefix = string.format(
					"<font color=\"#9fc1ff\">[DEV]</font> %s",
					message.PrefixText or ""
				)

			elseif Role == "Tester" then
				prefix = string.format(
					"<font color=\"#00aeff\">[TESTER]</font> %s",
					message.PrefixText or ""
				)

			elseif Player:GetAttribute("VIP") then
				prefix = string.format(
					"<font color=\"#FFD700\">[VIP]</font> %s",
					message.PrefixText or ""
				)
			end

			properties.PrefixText = prefix
			return properties
		end
	end
}