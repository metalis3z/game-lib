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
-- CQMeCXdvcmtzcGFjZQRJbmZvC1BsYXllclN0YXRzBE5hbWUORmluZEZpcnN0Q2hpbGQOU3Vydml2YWxQb2ludHMMV2FpdEZvckNoaWxkBVZhbHVlDEFwcGx5VHJpbmtldAhUcmlua2V0cwhUcmlua2V0MQhUcmlua2V0MgpDYW50UmVtb3ZlBnNjcmlwdAROb25lBVNsb3QxBVNsb3QyDVJlbW92ZVRyaW5rZXQKQ29pbiBQdXJzZRhyYnhhc3NldGlkOi8vMTc2NjAwMzAzOTIESWNvbgZDb21tb24GUmFyaXR5GlN0YXJ0IHdpdGggMzAgZXh0cmEgVGFwZXMuC0Rlc2NyaXB0aW9uB1Bhc3NpdmULVHJpbmtldFR5cGUEQ29zdARDb2luDFJlcXVpcmVtZW50MQADBQEAAAAAFqQBAQAAAABATQEBegIAAABNAQEBAwAAAE0DALoEAAAAvAEBAwUAAACfAQMCDgEJAG8EBgC8AgHTBwAAAJ8CAwJNAwLsCAAAAJUDAwkwAwLsCAAAAIIAAQAKAwEEAAAAQAMCAwMDBAMFAwYDBwMIAgAAAAAAAD5AAA8JARgAAAAAAAAAAAAAAAEBAAAAAQAAAAACEAAAAAAGAQAAAAAsbwMAALwBANMBAAAAnwEDAm8EAgC8AgEDAwAAAJ8CAwJvBQQAvAMBAwMAAACfAwMCDgIBACsDAgBvBAUAggQCAE0EAuwGAAAApAUIAAAAcEBNBQW6CQAAAJoEBgAFAAAAbwQKADAEAuwGAAAAbwQLAIIEAgBNBAPsBgAAAKQFCAAAAHBATQUFugkAAACaBAYABQAAAG8ECgAwBAPsBgAAAG8EDACCBAIAbwQFAIIEAgANAwoDBwMLAwUDDAMNAwgDDgQAAHBAAwQDDwMQAxEAFxIBGAAAAAABAAAAAQAAAAEAAAADAAAAAAAAAAEAAAEAAwAAAAAAAAABAAABAAMAGAAAAAAEAAABAgAlowAAAP8ABQAAAAAAbwEAADABALoBAAAAbwECADABAK4DAAAAbwEEADABAPIFAAAAbwEGADABAOIHAAAAbwEIADABAL8JAAAAjAH0ATABACMKAAAA/wEAAAIAAABvAgsATQMAIwoAAADFAQIDAQAAADABAJ8MAAAAwAENADABAGsOAAAAwAEPADABAK0QAAAAggACABEDEwMEAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgYAAwkGAQMSAgABAQABGAAAAAIAAAEAAAIAAAIAAAIAAAIAAAEAAAAAAAAAAAIAAAgAABQBAAAAAAItsjXxQqzV89BHY/SfFieKXaoihR92X/A=

-- https://lua.expert/
local t = {
	Name = "Coin Purse",
	Icon = "rbxassetid://17660030392",
	Rarity = "Common",
	Description = "Start with 30 extra Tapes.",
	TrinketType = "Passive",
	Cost = 500
}

t.Requirement1 = { "Coin", t.Cost }
function t.ApplyTrinket(p1) --[[ ApplyTrinket | Line: 15 ]]
	local v1 = workspace.Info.PlayerStats:FindFirstChild(p1.Name)

	if not v1 then
		return
	end

	local SurvivalPoints = v1:WaitForChild("SurvivalPoints")

	SurvivalPoints.Value = SurvivalPoints.Value + 30
end
function t.RemoveTrinket(p1) --[[ RemoveTrinket | Line: 23 ]]
	local Trinkets = p1:WaitForChild("Trinkets")
	local Trinket1 = Trinkets:FindFirstChild("Trinket1")
	local Trinket2 = Trinkets:FindFirstChild("Trinket2")

	if not (Trinket1 and Trinket2) then
		return "CantRemove"
	end

	if Trinket1.Value == script.Name then
		Trinket1.Value = "None"

		return "Slot1"
	end

	if Trinket2.Value == script.Name then
		Trinket2.Value = "None"

		return "Slot2"
	end

	return "CantRemove"
end

return t