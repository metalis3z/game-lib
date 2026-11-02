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
-- CQMfEFNsb3duZXNzSW1tdW5pdHkMU2V0QXR0cmlidXRlDEFwcGx5VHJpbmtldAhUcmlua2V0cwxXYWl0Rm9yQ2hpbGQIVHJpbmtldDEORmluZEZpcnN0Q2hpbGQIVHJpbmtldDIKQ2FudFJlbW92ZQVWYWx1ZQZzY3JpcHQETmFtZQROb25lBVNsb3QxBVNsb3QyDVJlbW92ZVRyaW5rZXQNVHJhaW4gV2hpc3RsZRxyYnhhc3NldGlkOi8vMTA1MDg0OTk0NzM2NzM0BEljb24GQ29tbW9uBlJhcml0eS1NYWtlcyB0aGUgdXNlciBpbW11bmUgdG8gdGhlIFNsb3duZXNzIERlYnVmZi4LRGVzY3JpcHRpb24HUGFzc2l2ZQtUcmlua2V0VHlwZQ5Nb25zdGVyVHJpbmtldAVPdGhlcgxUcmlua2V0U3RhdGUEQ29zdARDb2luDFJlcXVpcmVtZW50MQADBQEAAAAABm8DAACpBAEAvAEALgEAAACfAQQBggABAAIDAQMCABMDARgAAAAAAAEVAAAAAAgBAAAAADZvAwAAvAEA0wEAAACfAQMCbwQCALwCAQMDAAAAnwIDAm8FBAC8AwEDAwAAAJ8DAwIOAgEAKwMCAG8EBQCCBAIATQQC7AYAAACkBQgAAABwQE0FBboJAAAAmgQLAAUAAABvBAoAMAQC7AYAAABvBgsAqQcAALwEAC4MAAAAnwQEAW8EDQCCBAIATQQD7AYAAACkBQgAAABwQE0FBboJAAAAmgQLAAUAAABvBAoAMAQD7AYAAABvBgsAqQcAALwEAC4MAAAAnwQEAW8EDgCCBAIAbwQFAIIEAgAPAwQDBQMGAwcDCAMJAwoDCwQAAHBAAwwDDQMBAwIDDgMPABgQARgAAAAAAgAAAAEAAAABAAAAAgAAAAAAAAABAAADAAAAAAIAAwAAAAAAAAABAAADAAAAAAIAAwAZAAAAAAQAAAECAC6jAAAA/wAFAAAAAABvAQAAMAEAugEAAABvAQIAMAEArgMAAABvAQQAMAEA8gUAAABvAQYAMAEA4gcAAABvAQgAMAEAvwkAAACpAQEAMAEA5goAAACpAQEAMAEAKQsAAABvAQwAMAEArQ0AAACMAV4BMAEAIw4AAAD/AQAAAgAAAG8CDwBNAwAjDgAAAMUBAgMBAAAAMAEAnxAAAADAAREAMAEAaxIAAADAARMAMAEArRQAAACCAAIAFQMRAwwDEgMTAxQDFQMWAxcDGAMZAxoDAQMbAxwDHQMeAx8GAAMDBgEDEAIAAQEAARgAAAACAAABAAACAAACAAACAAACAAABAAABAAACAAABAAAAAAAAAAACAAAFAAAcAQAAAAAC/+UtttF1fhXtT6XBVZZpQI/9OsLNIUe3

-- https://lua.expert/
local t = {
	Name = "Train Whistle",
	Icon = "rbxassetid://105084994736734",
	Rarity = "Common",
	Description = "Makes the user immune to the Slowness Debuff.",
	TrinketType = "Passive",
	MonsterTrinket = true,
	SlownessImmunity = true,
	TrinketState = "Other",
	Cost = 350
}

t.Requirement1 = { "Coin", t.Cost }
function t.ApplyTrinket(p1) --[[ ApplyTrinket | Line: 19 ]]
	p1:SetAttribute("SlownessImmunity", true)
end
function t.RemoveTrinket(p1) --[[ RemoveTrinket | Line: 24 ]]
	local Trinkets = p1:WaitForChild("Trinkets")
	local Trinket1 = Trinkets:FindFirstChild("Trinket1")
	local Trinket2 = Trinkets:FindFirstChild("Trinket2")

	if not (Trinket1 and Trinket2) then
		return "CantRemove"
	end

	if Trinket1.Value == script.Name then
		Trinket1.Value = "None"
		p1:SetAttribute("SlownessImmunity", false)

		return "Slot1"
	end

	if Trinket2.Value == script.Name then
		Trinket2.Value = "None"
		p1:SetAttribute("SlownessImmunity", false)

		return "Slot2"
	end

	return "CantRemove"
end

return t