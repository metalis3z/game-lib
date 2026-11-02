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
-- CQMlDUFwcGx5TW9kaWZpZXIUU3RhbWluYVJlZ2VuTW9kaWZpZXIHVGhlcm1vcwhjYXRlZ29yeQd0cmlua2V0DEFwcGx5VHJpbmtldAhUcmlua2V0cwxXYWl0Rm9yQ2hpbGQIVHJpbmtldDEORmluZEZpcnN0Q2hpbGQIVHJpbmtldDIKQ2FudFJlbW92ZQ5SZW1vdmVNb2RpZmllcgVWYWx1ZQZzY3JpcHQETmFtZQROb25lBVNsb3QxBVNsb3QyDVJlbW92ZVRyaW5rZXQHcmVxdWlyZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlB01vZHVsZXMERGF0YRNTdGF0TW9kaWZpZXJNYW5hZ2VyGHJieGFzc2V0aWQ6Ly8xNzY2MDAzMDE0MwRJY29uBkNvbW1vbgZSYXJpdHkmSW5jcmVhc2VzIFN0YW1pbmEgcmVnZW5lcmF0aW9uIGJ5IDE1JS4LRGVzY3JpcHRpb24HUGFzc2l2ZQtUcmlua2V0VHlwZQRDb3N0BENvaW4MUmVxdWlyZW1lbnQxAAMHAQIAAAAM+wEAAE0BAaMAAAAAUgIAAG8DAQBvBAIAbwUDAOIGBgCfAQYC+wIBAGoBAgCCAAEABwMBAwICZmZmZmZm8j8DAwMEAwUIAQQFAAAAABIGARgAAAAAAAAAAAADAAETAAAAAAkBAgAAADpvAwAAvAEA0wEAAACfAQMCbwQCALwCAQMDAAAAnwIDAm8FBAC8AwEDAwAAAJ8DAwIOAgEAKwMCAG8EBQCCBAIA+wUAAIcEBQAOBAsA+wQBAE0EBJYGAAAAUgUAAG8GBwD7CAAAhwcIAJ8EBAH7BAAAxgUAAGoFBABNBALsCAAAAKQFCgAAAJBATQUFugsAAACaBAYABQAAAG8EDAAwBALsCAAAAG8EDQCCBAIATQQD7AgAAACkBQoAAACQQE0FBboLAAAAmgQGAAUAAABvBAwAMAQD7AgAAABvBA4AggQCAG8EBQCCBAIADwMHAwgDCQMKAwsDDAMNAwIDDgMPBAAAkEADEAMRAxIDEwAZFAEYAAAAAAIAAAABAAAAAQAAAAIAAAEAAAAAAAAAAQAAAwAAAAAAAAABAAABAAMAAAAAAAAAAQAAAQADABoAAAAABgAAAQIAN6MAAACkAAEAAAAAQKQBAwAAACBATQEBPwQAAABNAQHoBQAAAE0BAcYGAAAATQEB4QcAAACfAAIC/wEAAAAAAAD/AgUAAAAAAG8DCAAwAwK6CQAAAG8DCgAwAwKuCwAAAG8DDAAwAwLyDQAAAG8DDgAwAwLiDwAAAG8DEAAwAwK/EQAAAIwD+gAwAwIjEgAAAP8DAAACAAAAbwQTAIwF+gDFAwQDAQAAADADAp8UAAAAwAMVABIAAAASAAEAMAMCaxYAAADAAxcAEgABABIAAAAwAwKtGAAAAIICAgAZAxUEAAAAQAMWBAAAIEADFwMYAxkDGgMDAxADGwMcAx0DHgMfAyADIQMiAyMDJAMlBgADBgYBAxQCAAEBAAEYAAAAAAAAAAAAAAAAAAABAAIAAgAAAQAAAgAAAgAAAgAAAgAAAQAAAAAAAAACAAAAAAcAAAAAGQEAAAAAAh/cFFj6AaCPhheZye8HnnVvxAMsLRh+WQ==

-- https://lua.expert/
local StatModifierManager = require(game.ReplicatedStorage.Modules.Data.StatModifierManager)
local t = {}

return {
	Name = "Thermos",
	Icon = "rbxassetid://17660030143",
	Rarity = "Common",
	Description = "Increases Stamina regeneration by 15%.",
	TrinketType = "Passive",
	Cost = 250,
	Requirement1 = { "Coin", 250 },
	ApplyTrinket = function(p1) --[[ ApplyTrinket | Line: 18 | Upvalues: StatModifierManager (copy), t (copy) ]]
		t[p1] = StatModifierManager.ApplyModifier(p1, "StaminaRegenModifier", 1.15, "Thermos", {
			category = "trinket"
		})
	end,
	RemoveTrinket = function(p1) --[[ RemoveTrinket | Line: 25 | Upvalues: t (copy), StatModifierManager (copy) ]]
		local Trinkets = p1:WaitForChild("Trinkets")
		local Trinket1 = Trinkets:FindFirstChild("Trinket1")
		local Trinket2 = Trinkets:FindFirstChild("Trinket2")

		if not (Trinket1 and Trinket2) then
			return "CantRemove"
		end

		if t[p1] then
			StatModifierManager.RemoveModifier(p1, "StaminaRegenModifier", t[p1])
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
}