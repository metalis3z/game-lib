--credit to prince games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local MessagePrompt = require(ReplicatedStorage.ClientModules.MessagePrompt)
local NotificationController = require(Players.LocalPlayer.PlayerScripts.Controllers.NotificationController)
local t = {
	StartOrder = 9
}

local function HexFromMaybe(p1) --[[ HexFromMaybe | Line: 24 ]]
	if typeof(p1) ~= "string" or p1 == "" then
		return "#FFFFFF"
	end

	if string.sub(p1, 1, 1) == "#" then
		return p1
	end

	return "#" .. p1
end

local function EscapeRichText(p1) --[[ EscapeRichText | Line: 34 ]]
	return string.gsub(string.gsub(string.gsub(string.gsub(p1, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"), "\"", "&quot;")
end

local function BuildMessage(p1, p2, p3, p4) --[[ BuildMessage | Line: 42 | Upvalues: EscapeRichText (copy) ]]
	return string.format("Are you sure you want to %s <font color=\"%s\">%s</font> <font color=\"%s\">[%s]</font>?", if p4 then "disband" else "leave", p3, EscapeRichText(p1), p3, (EscapeRichText(p2)))
end

local function FireLeave(p1, p2) --[[ FireLeave | Line: 52 | Upvalues: Networking (copy), NotificationController (copy) ]]
	task.spawn(function() --[[ Line: 53 | Upvalues: Networking (ref), p2 (copy), NotificationController (ref), p1 (copy) ]]
		local ok, result, result2 = pcall(function() --[[ Line: 54 | Upvalues: Networking (ref) ]]
			return Networking.Guild.Leave:Fire()
		end)

		if ok and result then
			NotificationController:CreateNotification(string.format("%s %s", if p2 then "Disbanded" else "Left", p1))
		else
			NotificationController:CreateNotification(if typeof(result2) == "string" and result2 ~= "" then result2 elseif p2 then "Could not disband guild" else "Could not leave guild")
		end
	end)
end

function t.Open(p1, p2) --[[ Open | Line: 83 | Upvalues: MessagePrompt (copy), EscapeRichText (copy), Networking (copy), NotificationController (copy) ]]
	local v2 = typeof(p2.Name) == "string" and p2.Name or "Guild Name"
	local v3 = typeof(p2.Tag) == "string" and p2.Tag or "TAG"
	local v4 = p2 and p2.Color
	local v5 = if typeof(v4) == "string" and v4 ~= "" then if string.sub(v4, 1, 1) == "#" then v4 else "#" .. v4 else "#FFFFFF"
	local v6 = if p2 == nil then false else p2.IsOwner == true

	task.spawn(function() --[[ Line: 97 | Upvalues: MessagePrompt (ref), v2 (copy), v3 (copy), v5 (copy), v6 (copy), EscapeRichText (ref), Networking (ref), NotificationController (ref) ]]
		local t = {
			yield = true,
			dontRestoreOnSuccess = true
		}
		local v22 = v5

		t.message = string.format("Are you sure you want to %s <font color=\"%s\">%s</font> <font color=\"%s\">[%s]</font>?", if v6 then "disband" else "leave", v22, EscapeRichText(v2), v22, (EscapeRichText(v3)))
		t.titleOverride = if v6 then "Disband Guild" else "Leave Guild"
		t.options = MessagePrompt.Choices.YesNo

		if not MessagePrompt.Prompt(t) then
			return
		end

		local v8 = v2
		local v9 = v6

		task.spawn(function() --[[ Line: 53 | Upvalues: Networking (ref), v9 (copy), NotificationController (ref), v8 (copy) ]]
			local ok, result, result2 = pcall(function() --[[ Line: 54 | Upvalues: Networking (ref) ]]
				return Networking.Guild.Leave:Fire()
			end)

			if ok and result then
				NotificationController:CreateNotification(string.format("%s %s", if v9 then "Disbanded" else "Left", v8))
			else
				NotificationController:CreateNotification(if typeof(result2) == "string" and result2 ~= "" then result2 elseif v9 then "Could not disband guild" else "Could not leave guild")
			end
		end)
	end)
end
function t.Close(p1) --[[ Close | Line: 116 ]] end
function t.Init(p1) --[[ Init | Line: 118 ]] end
function t.Start(p1) --[[ Start | Line: 120 ]] end

return t