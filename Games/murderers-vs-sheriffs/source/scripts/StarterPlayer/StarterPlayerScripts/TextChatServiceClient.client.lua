local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local SystemMessage = script:WaitForChild("SystemMessage")
local ChromaCommand = TextChatService:WaitForChild("ChromaCommad")
local TextChannels = TextChatService:FindFirstChild("TextChannels")
local RBXSystem = TextChannels and TextChannels:FindFirstChild("RBXSystem")

local Sync = require(ReplicatedStorage.Database:WaitForChild("Sync"))
local CurrentRound = require(ReplicatedStorage.Modules:WaitForChild("CurrentRoundClient"))
local Constants = require(ReplicatedStorage:WaitForChild("Constants"))

local customTags = {
	["MMZGroupHoIder"] = {text = "[Creator]", color = Color3.fromRGB(33, 84, 185)},
	["ItsPlayFede"] = {text = "[Creator]", color = Color3.fromRGB(33, 84, 185)},
	["42devy"] = {text = "[Developer]", color = Color3.fromRGB(98, 37, 209)},
	["MMT0wner"] = {text = "[Developer]", color = Color3.fromRGB(98, 37, 209)}
}

local function getChromaTag()
	local colors = {Color3.fromRGB(255,0,0), Color3.fromRGB(255,100,0), Color3.fromRGB(255,225,0),
		Color3.fromRGB(0,255,0), Color3.fromRGB(0,255,255), Color3.fromRGB(0,125,255)}
	local letters = {"C","h","r","o","m","a"}
	local result = ""
	for i, letter in ipairs(letters) do
		result ..= "<font color='#"..colors[i]:ToHex().."'>"..letter.."</font>"
	end
	return result .. " "
end

local function isPlayerAlive(player)
	if player == nil or not player:IsDescendantOf(Players) then
		return false
	elseif CurrentRound.PlayerData[player.Name] == nil then
		return false
	elseif CurrentRound.PlayerData[player.Name].Dead == true then
		return false
	else
		return true
	end
end

local function getDisguiseName(player)
	if player == nil or not player:IsDescendantOf(Players) then
		return nil
	elseif CurrentRound.PlayerData[player.Name] == nil then
		return nil
	else
		return CurrentRound.PlayerData[player.Name].CodeName
	end
end

local function getDisguiseColor(player)
	if player == nil or not player:IsDescendantOf(Players) then
		return nil
	elseif CurrentRound.PlayerData[player.Name] == nil then
		return nil
	else
		local colorHex = "ffffff"
		local color = CurrentRound.PlayerData[player.Name].Color
		if color then
			colorHex = color.Color:ToHex()
		end
		return colorHex
	end
end

local function isWhisper(textChannel)
	return string.sub(textChannel.Name, 1, 10) == "RBXWhisper"
end

local function getPlayerTag(player)
	local tagData = customTags[player.Name]
	if tagData then
		return tagData.text, tagData.color
	end


	if player:GetAttribute("Elite") then
		return "[ELITE]", Color3.fromRGB(232, 42, 42)
	end

	return "", Color3.fromRGB(255,255,255)
end

local function getColoredItemText(itemId)
	local item = Sync.Item[itemId]
	if not item then
		warn("ItemData not found for: "..tostring(itemId))
		return itemId
	end
	local colorHex = Sync.Rarity[item.Rarity]:ToHex()
	local name = item.ItemName or item.Name
	return (item.Chroma and getChromaTag() or "") .. "<font color='#"..colorHex.."'>"..name.."</font>"
end

local function replicateMessage(data)
	local text = data.text
	if data.item then
		text ..= " "..getColoredItemText(data.item)
	end
	if data.color  then
		text = "<font color='#"..data.color:ToHex().."'>"..text.."</font>"
	end
	if RBXSystem then
		RBXSystem:DisplaySystemMessage(text)
	end
end

if TextChatService.ChatVersion ~= Enum.ChatVersion.LegacyChatService then
	TextChatService.OnIncomingMessage = function(msg)
		local props = Instance.new("TextChatMessageProperties")

		if msg.TextSource then
			if msg.TextSource.UserId == LocalPlayer.UserId and isWhisper(msg.TextChannel) then
				local userIds = string.split(string.sub(msg.TextChannel.Name, 12), "_")
				local player1 = Players:GetPlayerByUserId(userIds[1])
				local player2 = Players:GetPlayerByUserId(userIds[2])

				if (player1 and isPlayerAlive(player1) and player2 and not isPlayerAlive(player2)) or
					(player2 and isPlayerAlive(player2) and player1 and not isPlayerAlive(player1)) then
					SystemMessage:Fire({
						text = "You cannot whisper remaining players while eliminated."
					})
					msg.Status = Enum.TextChatMessageStatus.InvalidTextChannelPermissions
					return props
				end
			end

			local player = Players:GetPlayerByUserId(msg.TextSource.UserId)
			if not player then
				return props
			end

			local alive = isPlayerAlive(player)
			local isElite = player:GetAttribute("Elite")
			local playerName = player.Name
			local disguiseName = getDisguiseName(player)

			local displayName
			if disguiseName then
				if alive then
					displayName = disguiseName
				else
					displayName = playerName .. " (" .. disguiseName .. ")"
				end
			else
				displayName = playerName
			end

			local nameColor = "ffffff"
			local deadColor = "a3a2a5"

			if disguiseName then
				local disguiseColor = getDisguiseColor(player)
				if disguiseColor then
					nameColor = disguiseColor
				end
			elseif isElite then
				displayName = "[ELITE] " .. displayName
				nameColor = "e82a2a"
				deadColor = "bf5f5f"
			else
				local tagText, tagColor = getPlayerTag(player)
				if tagText ~= "" then
					displayName = tagText .. " " .. displayName
					nameColor = tagColor:ToHex()
				end
			end

			local finalColor = alive and nameColor or deadColor
			msg.PrefixText = "<font color='#"..finalColor.."'>"..displayName..":</font>"

			if not alive then
				local localAlive = isPlayerAlive(LocalPlayer)
				if localAlive then
					msg.Status = Enum.TextChatMessageStatus.InvalidTextChannelPermissions
					return props
				end
			end
		end

		return props
	end

	SystemMessage.Event:Connect(function(data)
		task.defer(function()
			local text = data.text
			if data.item then
				text ..= " "..getColoredItemText(data.item)
			end
			if RBXSystem then
				RBXSystem:DisplaySystemMessage(text)
			end
		end)
	end)

	task.defer(function()
		SystemMessage:Fire({text = "Welcome to "..Constants.Name})
	end)

	ChromaCommand.Triggered:Connect(function()
		LocalPlayer.PlayerScripts.WeaponVisuals.ChromaScript.ToggleChromas:Fire()
	end)

	ReplicatedStorage.ChatMessage.OnClientEvent:Connect(replicateMessage)
end