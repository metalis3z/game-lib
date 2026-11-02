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
-- CQMnDUFwcGx5TW9kaWZpZXINU3BlZWRNb2RpZmllcghEb2dQbHVzaAhjYXRlZ29yeQd0cmlua2V0DEFwcGx5VHJpbmtldAhUcmlua2V0cwxXYWl0Rm9yQ2hpbGQIVHJpbmtldDEORmluZEZpcnN0Q2hpbGQIVHJpbmtldDIKQ2FudFJlbW92ZQ5SZW1vdmVNb2RpZmllcgVWYWx1ZQZzY3JpcHQETmFtZQROb25lBVNsb3QxBVNsb3QyDVJlbW92ZVRyaW5rZXQHcmVxdWlyZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlB01vZHVsZXMERGF0YRNTdGF0TW9kaWZpZXJNYW5hZ2VyCURvZyBQbHVzaBhyYnhhc3NldGlkOi8vMTc2NTM4MTAxODYESWNvbgZDb21tb24GUmFyaXR5HEluY3JlYXNlcyBXYWxrIFNwZWVkIGJ5IDEwJS4LRGVzY3JpcHRpb24HUGFzc2l2ZQtUcmlua2V0VHlwZQ5Nb25zdGVyVHJpbmtldARDb3N0BENvaW4MUmVxdWlyZW1lbnQxAAMHAQIAAAAM+wEAAE0BAaMAAAAAUgIAAG8DAQBvBAIAbwUDAOIGBgCfAQYC+wIBAGoBAgCCAAEABwMBAwICmpmZmZmZ8T8DAwMEAwUIAQQFAAAAABQGARgAAAAAAAAAAAADAAEVAAAAAAkBAgAAADpvAwAAvAEA0wEAAACfAQMCbwQCALwCAQMDAAAAnwIDAm8FBAC8AwEDAwAAAJ8DAwIOAgEAKwMCAG8EBQCCBAIA+wUAAIcEBQAOBAsA+wQBAE0EBJYGAAAAUgUAAG8GBwD7CAAAhwcIAJ8EBAH7BAAAxgUAAGoFBABNBALsCAAAAKQFCgAAAJBATQUFugsAAACaBAYABQAAAG8EDAAwBALsCAAAAG8EDQCCBAIATQQD7AgAAACkBQoAAACQQE0FBboLAAAAmgQGAAUAAABvBAwAMAQD7AgAAABvBA4AggQCAG8EBQCCBAIADwMHAwgDCQMKAwsDDAMNAwIDDgMPBAAAkEADEAMRAxIDEwAbFAEYAAAAAAIAAAABAAAAAQAAAAIAAAEAAAAAAAAAAQAAAwAAAAAAAAABAAABAAMAAAAAAAAAAQAAAQADABwAAAAABgAAAQIAO6MAAACkAAEAAAAAQKQBAwAAACBATQEBPwQAAABNAQHoBQAAAE0BAcYGAAAATQEB4QcAAACfAAIC/wEAAAAAAAD/AgUAAAAAAG8DCAAwAwK6CQAAAG8DCgAwAwKuCwAAAG8DDAAwAwLyDQAAAG8DDgAwAwLiDwAAAG8DEAAwAwK/EQAAAKkDAQAwAwLmEgAAAIwDXgEwAwIjEwAAAP8DAAACAAAAbwQUAE0FAiMTAAAAxQMEAwEAAAAwAwKfFQAAAMADFgASAAAAEgABADADAmsXAAAAwAMYABIAAQASAAAAMAMCrRkAAACCAgIAGgMVBAAAAEADFgQAACBAAxcDGAMZAxoDGwMQAxwDHQMeAx8DIAMhAyIDIwMkAyUDJgMnBgADBgYBAxQCAAEBAAEYAAAAAAAAAAAAAAAAAAABAAIAAgAAAQAAAgAAAgAAAgAAAgAAAgAAAQAAAAAAAAAAAgAAAAAHAAAAABkBAAAAAAIW5Z7rw5vYvOoBXX2kUYWGZv2JnyQh9Oo=

-- https://lua.expert/
local StatModifierManager = require(game.ReplicatedStorage.Modules.Data.StatModifierManager)
local t = {}
local t2 = {
	Name = "Dog Plush",
	Icon = "rbxassetid://17653810186",
	Rarity = "Common",
	Description = "Increases Walk Speed by 10%.",
	TrinketType = "Passive",
	MonsterTrinket = true,
	Cost = 350
}

t2.Requirement1 = { "Coin", t2.Cost }
function t2.ApplyTrinket(p1) --[[ ApplyTrinket | Line: 20 | Upvalues: StatModifierManager (copy), t (copy) ]]
	t[p1] = StatModifierManager.ApplyModifier(p1, "SpeedModifier", 1.1, "DogPlush", {
		category = "trinket"
	})
end
function t2.RemoveTrinket(p1) --[[ RemoveTrinket | Line: 27 | Upvalues: t (copy), StatModifierManager (copy) ]]
	local Trinkets = p1:WaitForChild("Trinkets")
	local Trinket1 = Trinkets:FindFirstChild("Trinket1")
	local Trinket2 = Trinkets:FindFirstChild("Trinket2")

	if not (Trinket1 and Trinket2) then
		return "CantRemove"
	end

	if t[p1] then
		StatModifierManager.RemoveModifier(p1, "SpeedModifier", t[p1])
		t[p1] = nil
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

return t2