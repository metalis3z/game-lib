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
-- CQMfCXdvcmtzcGFjZQRJbmZvC1BsYXllclN0YXRzBE5hbWUORmluZEZpcnN0Q2hpbGQOU3Vydml2YWxQb2ludHMMV2FpdEZvckNoaWxkBVZhbHVlDEFwcGx5VHJpbmtldAhUcmlua2V0cwhUcmlua2V0MQhUcmlua2V0MgpDYW50UmVtb3ZlBnNjcmlwdAROb25lBVNsb3QxBVNsb3QyDVJlbW92ZVRyaW5rZXQLRmFuY3kgUHVyc2UYcmJ4YXNzZXRpZDovLzE4MTkyNzE2MTc0BEljb24GQ29tbW9uBlJhcml0eRtTdGFydCB3aXRoIDEwMCBleHRyYSBUYXBlcy4LRGVzY3JpcHRpb24HUGFzc2l2ZQtUcmlua2V0VHlwZQ5Nb25zdGVyVHJpbmtldARDb3N0BENvaW4MUmVxdWlyZW1lbnQxAAMFAQAAAAAWpAEBAAAAAEBNAQF6AgAAAE0BAQEDAAAATQMAugQAAAC8AQEDBQAAAJ8BAwIOAQkAbwQGALwCAdMHAAAAnwIDAk0DAuwIAAAAlQMDCTADAuwIAAAAggABAAoDAQQAAABAAwIDAwMEAwUDBgMHAwgCAAAAAAAAWUAAEQkBGAAAAAAAAAAAAAAAAQEAAAABAAAAAAcSAAAAAAYBAAAAACxvAwAAvAEA0wEAAACfAQMCbwQCALwCAQMDAAAAnwIDAm8FBAC8AwEDAwAAAJ8DAwIOAgEAKwMCAG8EBQCCBAIATQQC7AYAAACkBQgAAABwQE0FBboJAAAAmgQGAAUAAABvBAoAMAQC7AYAAABvBAsAggQCAE0EA+wGAAAApAUIAAAAcEBNBQW6CQAAAJoEBgAFAAAAbwQKADAEA+wGAAAAbwQMAIIEAgBvBAUAggQCAA0DCgMHAwsDBQMMAw0DCAMOBAAAcEADBAMPAxADEQAeEgEYAAAAAAEAAAABAAAAAQAAAAMAAAAAAAAAAQAAAQADAAAAAAAAAAEAAAEAAwAfAAAAAAQAAAECACijAAAA/wAFAAAAAABvAQAAMAEAugEAAABvAQIAMAEArgMAAABvAQQAMAEA8gUAAABvAQYAMAEA4gcAAABvAQgAMAEAvwkAAACpAQEAMAEA5goAAACMAfoAMAEAIwsAAAD/AQAAAgAAAG8CDABNAwAjCwAAAMUBAgMBAAAAMAEAnw0AAADAAQ4AMAEAaw8AAADAARAAMAEArREAAACCAAIAEgMTAwQDFAMVAxYDFwMYAxkDGgMbAxwDHQMeAx8GAAMJBgEDEgIAAQEAARgAAAACAAABAAACAAACAAACAAACAAACAAABAAAAAAAAAAACAAANAAAUAQAAAAACnC+bqaOJx9iZIuv4Ka8BC+w3jN2u6/Go

-- https://lua.expert/
local t = {
	Name = "Fancy Purse",
	Icon = "rbxassetid://18192716174",
	Rarity = "Common",
	Description = "Start with 100 extra Tapes.",
	TrinketType = "Passive",
	MonsterTrinket = true,
	Cost = 250
}

t.Requirement1 = { "Coin", t.Cost }
function t.ApplyTrinket(p1) --[[ ApplyTrinket | Line: 17 ]]
	local v1 = workspace.Info.PlayerStats:FindFirstChild(p1.Name)

	if not v1 then
		return
	end

	local SurvivalPoints = v1:WaitForChild("SurvivalPoints")

	SurvivalPoints.Value = SurvivalPoints.Value + 100
end
function t.RemoveTrinket(p1) --[[ RemoveTrinket | Line: 30 ]]
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