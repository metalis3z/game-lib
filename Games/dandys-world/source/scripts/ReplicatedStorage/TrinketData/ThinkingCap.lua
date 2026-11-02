--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQMkGUFwcGx5QWRkaXRpdmVCb3VuZGFyeVNpemULVGhpbmtpbmdDYXAMQXBwbHlUcmlua2V0CFRyaW5rZXRzDFdhaXRGb3JDaGlsZAhUcmlua2V0MQ5GaW5kRmlyc3RDaGlsZAhUcmlua2V0MgpDYW50UmVtb3ZlBVZhbHVlBnNjcmlwdAROYW1lBE5vbmUfUmVtb3ZlQWRkaXRpdmVNb2RpZmllcnNCeVNvdXJjZQVTbG90MQVTbG90Mg1SZW1vdmVUcmlua2V0DFRoaW5raW5nIENhcBhyYnhhc3NldGlkOi8vMTc2NjAxMTE1MzYESWNvbgZDb21tb24GUmFyaXR5LkluY3JlYXNlcyBTa2lsbCBDaGVjayB3aW5kb3cgc2l6ZSBieSA0MCB1bml0cy4LRGVzY3JpcHRpb24HUGFzc2l2ZQtUcmlua2V0VHlwZQRDb3N0BENvaW4MUmVxdWlyZW1lbnQxBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlB01vZHVsZXMERGF0YRNTdGF0TW9kaWZpZXJNYW5hZ2VyAAMFAQEAAAAI+wEAAE0BAYUAAAAAUgIAAIwDKABvBAEAnwEEAYIAAQACAwEDAgASAwEYAAAAAAAAAAEUAAAAAAcBAQAAADhvAwAAvAEA0wEAAACfAQMCbwQCALwCAQMDAAAAnwIDAm8FBAC8AwEDAwAAAJ8DAwIOAgEAKwMCAG8EBQCCBAIATQQC7AYAAACkBQgAAABwQE0FBboJAAAAmgQMAAUAAABvBAoAMAQC7AYAAAD7BAAATQQEcgsAAABSBQAAbwYMAJ8EAwFvBA0AggQCAE0EA+wGAAAApAUIAAAAcEBNBQW6CQAAAJoEDAAFAAAAbwQKADAEA+wGAAAA+wQAAE0EBHILAAAAUgUAAG8GDACfBAMBbwQOAIIEAgBvBAUAggQCAA8DBAMFAwYDBwMIAwkDCgMLBAAAcEADDAMNAw4DAgMPAxAAFxEBGAAAAAACAAAAAQAAAAEAAAACAAAAAAAAAAEAAAIAAAAAAAEAAwAAAAAAAAABAAACAAAAAAABAAMAGAAAAAAEAAABAgA2owAAAP8ABQAAAAAAbwEAADABALoBAAAAbwECADABAK4DAAAAbwEEADABAPIFAAAAbwEGADABAOIHAAAAbwEIADABAL8JAAAAjAFeATABACMKAAAA/wEAAAIAAABvAgsATQMAIwoAAADFAQIDAQAAADABAJ8MAAAApAEOAAAA0EBvAw8AvAEBFhAAAACfAQMCpAISAAAAEEFNAwHoEwAAAE0DA8YUAAAATQMD4RUAAACfAgICwAMWABIAAgAwAwBrFwAAAMADGAASAAIAMAMArRkAAACCAAIAGgMSAwwDEwMUAxUDFgMXAxgDGQMaAxsDHAMdAx4EAADQQAMfAyADIQQAABBBAyIDIwMkBgADAwYBAxECAAEBAAEYAAAAAgAAAQAAAgAAAgAAAgAAAgAAAQAAAAAAAAAAAgAAAAAAAQAAAAAAAAAAAgAAAAUAAAAYAQAAAAACXIQVzfq4f2tyQISnoFID/yycArluQH/M

-- https://lua.expert/
local t = {
	Name = "Thinking Cap",
	Icon = "rbxassetid://17660111536",
	Rarity = "Common",
	Description = "Increases Skill Check window size by 40 units.",
	TrinketType = "Passive",
	Cost = 350
}

t.Requirement1 = { "Coin", t.Cost }

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StatModifierManager = require(ReplicatedStorage.Modules.Data.StatModifierManager)

function t.ApplyTrinket(p1) --[[ ApplyTrinket | Line: 18 | Upvalues: StatModifierManager (copy) ]]
	StatModifierManager.ApplyAdditiveBoundarySize(p1, 40, "ThinkingCap")
end
function t.RemoveTrinket(p1) --[[ RemoveTrinket | Line: 23 | Upvalues: StatModifierManager (copy) ]]
	local Trinkets = p1:WaitForChild("Trinkets")
	local Trinket1 = Trinkets:FindFirstChild("Trinket1")
	local Trinket2 = Trinkets:FindFirstChild("Trinket2")

	if not (Trinket1 and Trinket2) then
		return "CantRemove"
	end

	if Trinket1.Value == script.Name then
		Trinket1.Value = "None"
		StatModifierManager.RemoveAdditiveModifiersBySource(p1, "ThinkingCap")

		return "Slot1"
	end

	if Trinket2.Value == script.Name then
		Trinket2.Value = "None"
		StatModifierManager.RemoveAdditiveModifiersBySource(p1, "ThinkingCap")

		return "Slot2"
	end

	return "CantRemove"
end

return t