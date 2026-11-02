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
-- CQMaCUFiaWxpdGllcwxXYWl0Rm9yQ2hpbGQIQWJpbGl0eTEORmluZEZpcnN0Q2hpbGQQSGFzVG9nZ2xlQWJpbGl0eQxHZXRBdHRyaWJ1dGUIQ29vbGRvd24FVmFsdWUMQXBwbHlUcmlua2V0DVJlbW92ZVRyaW5rZXQVR2hvc3QgU25ha2VzIEluIEEgQ2FuBE5hbWUccmJ4YXNzZXRpZDovLzExNjIyMjEyMzc5MTU2OQRJY29uBFJhcmUGUmFyaXR5MlJlZHVjZXMgeW91ciBBY3RpdmUgQWJpbGl0eSBjb29sZG93biBieSA1IHNlY29uZHMuC0Rlc2NyaXB0aW9uBkFjdGl2ZQtUcmlua2V0VHlwZQ9BYmlsaXR5Q29vbGRvd24MVHJpbmtldFN0YXRlDk1vbnN0ZXJUcmlua2V0BENvc3QEQ29pbgxSZXF1aXJlbWVudDEAAwcBAAAAACBvAwAAvAEA0wEAAACfAQMCbwQCALwCAQMDAAAAnwIDAg4CFgBvBQQAvAMAEgUAAACfAwMCKwMRAG8GBgC8BALTAQAAAJ8EAwJNBQTsBwAAAHgFBQgwBQTsBwAAAE0FBOwHAAAAjAYFAH0FBAAGAAAAjAUFADAFBOwHAAAAggABAAkDAQMCAwMDBAMFAwYDBwMIAgAAAAAAABRAABMJARgAAAAAAQAAAAICAAAAAQEAAAABAAAAAAIAAAAAAQAABBQAAAAABwEAAAAAGG8DAAC8AQDTAQAAAJ8BAwJvBAIAvAIBAwMAAACfAgMCDgIOAG8FBAC8AwASBQAAAJ8DAwIrAwkAbwYGALwEAtMBAAAAnwQDAk0FBOwHAAAAlQUFCDAFBOwHAAAAggABAAkDAQMCAwMDBAMFAwYDBwMIAgAAAAAAABRAACUKARgAAAAAAQAAAAICAAAAAQEAAAABAAAAAAMmAAAAAAQAAAECACujAAAA/wAFAAAAAABvAQAAMAEAugEAAABvAQIAMAEArgMAAABvAQQAMAEA8gUAAABvAQYAMAEA4gcAAABvAQgAMAEAvwkAAABvAQoAMAEArQsAAACpAQEAMAEA5gwAAACMAfQBMAEAIw0AAAD/AQAAAgAAAG8CDgBNAwAjDQAAAMUBAgMBAAAAMAEAnw8AAADAARAAMAEAaxEAAADAARIAMAEArRMAAACCAAIAFAMLAwwDDQMOAw8DEAMRAxIDEwMUAxUDFgMXAxgDGQMaBgADCQYBAwoCAAEBAAEYAAAAAgAAAQAAAgAAAgAAAgAAAgAAAgAAAgAAAQAAAAAAAAAAAgAAEgAADgEAAAAAAr7YB2iwacZRl31ar6aiWGvOwBAcjBxtaQ==

-- https://lua.expert/
local t = {
	Name = "Ghost Snakes In A Can",
	Icon = "rbxassetid://116222123791569",
	Rarity = "Rare",
	Description = "Reduces your Active Ability cooldown by 5 seconds.",
	TrinketType = "Active",
	TrinketState = "AbilityCooldown",
	MonsterTrinket = true,
	Cost = 500
}

t.Requirement1 = { "Coin", t.Cost }
function t.ApplyTrinket(p1) --[[ ApplyTrinket | Line: 19 ]]
	local Ability1 = p1:WaitForChild("Abilities"):FindFirstChild("Ability1")

	if not Ability1 or p1:GetAttribute("HasToggleAbility") then
		return
	end

	local Cooldown = Ability1:WaitForChild("Cooldown")

	Cooldown.Value = Cooldown.Value - 5

	if not (Cooldown.Value <= 5) then
		return
	end

	Cooldown.Value = 5
end
function t.RemoveTrinket(p1) --[[ RemoveTrinket | Line: 37 ]]
	local Ability1 = p1:WaitForChild("Abilities"):FindFirstChild("Ability1")

	if not Ability1 or p1:GetAttribute("HasToggleAbility") then
		return
	end

	local Cooldown = Ability1:WaitForChild("Cooldown")

	Cooldown.Value = Cooldown.Value + 5
end

return t