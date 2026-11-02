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
-- CQMdCFRyaW5rZXRzDFdhaXRGb3JDaGlsZAVTdGF0cw9PcmlnaW5hbFN0YW1pbmEOQ3VycmVudFN0YW1pbmEFVmFsdWUMQXBwbHlUcmlua2V0CFRyaW5rZXQxDkZpbmRGaXJzdENoaWxkCFRyaW5rZXQyCkNhbnRSZW1vdmUGc2NyaXB0BE5hbWUETm9uZQVTbG90MQVTbG90Mg1SZW1vdmVUcmlua2V0C1NwZWVkb21ldGVyGHJieGFzc2V0aWQ6Ly8xNzY2MDE0NjA1NwRJY29uBkNvbW1vbgZSYXJpdHkgR3JhbnRzIHRoZSB1c2VyIDE1IG1vcmUgU3RhbWluYS4LRGVzY3JpcHRpb24HUGFzc2l2ZQtUcmlua2V0VHlwZQRDb3N0BENvaW4MUmVxdWlyZW1lbnQxAAMHAQAAAAAbbwMAALwBANMBAAAAnwEDAm8EAgC8AgDTAQAAAJ8CAwJvBQMAvAMC0wEAAACfAwMCbwYEALwEAtMBAAAAnwQDAk0FA+wFAAAAlQUFBjAFA+wFAAAATQUE7AUAAACVBQUGMAUE7AUAAACCAAEABwMBAwIDAwMEAwUDBgIAAAAAAAAuQAAPBwEYAAAAAAEAAAABAAAAAQAAAAIAAAAAAQAAAAABEAAAAAAJAQAAAABMbwMAALwBANMBAAAAnwEDAm8EAgC8AgDTAQAAAJ8CAwJvBQMAvAMC0wEAAACfAwMCbwYEALwEAtMBAAAAnwQDAm8HBQC8BQEDBgAAAJ8FAwJvCAcAvAYBAwYAAACfBgMCDgUBACsGAgBvBwgAggcCAE0HBewJAAAApAgLAAAAoEBNCAi6DAAAAJoHEAAIAAAAbwcNADAHBewJAAAATQcD7AkAAAB4BwcOMAcD7AkAAABNBwTsCQAAAHgHBw4wBwTsCQAAAG8HDwCCBwIATQcG7AkAAACkCAsAAACgQE0ICLoMAAAAmgcQAAgAAABvBw0AMAcG7AkAAABNBwPsCQAAAHgHBw4wBwPsCQAAAE0HBOwJAAAAeAcHDjAHBOwJAAAAbwcQAIIHAgBvBwgAggcCABEDAQMCAwMDBAMFAwgDCQMKAwsDBgMMBAAAoEADDQMOAgAAAAAAAC5AAw8DEAAZEQEYAAAAAAEAAAABAAAAAQAAAAIAAAABAAAAAQAAAAIAAAAAAAAAAQAAAgAAAAABAAAAAAIAAwAAAAAAAAABAAACAAAAAAEAAAAAAgADABoAAAAABAAAAQIAJKMAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCuAwAAAG8BBAAwAQDyBQAAAG8BBgAwAQDiBwAAAG8BCAAwAQC/CQAAAIwBdwEwAQAjCgAAAP8BAAACAAAAbwILAIwDdwHFAQIDAQAAADABAJ8MAAAAwAENADABAGsOAAAAwAEPADABAK0QAAAAggACABEDEgMNAxMDFAMVAxYDFwMYAxkDGgMbAxwDHQYAAwcGAQMRAgABAQABGAAAAAIAAAEAAAIAAAIAAAIAAAIAAAEAAAAAAAAAAgAACgAAHwEAAAAAAmOUM+lNrqWzDd4CuT+b1eITjCSdUVBZ6A==

-- https://lua.expert/
return {
	Name = "Speedometer",
	Icon = "rbxassetid://17660146057",
	Rarity = "Common",
	Description = "Grants the user 15 more Stamina.",
	TrinketType = "Passive",
	Cost = 375,
	Requirement1 = { "Coin", 375 },
	ApplyTrinket = function(p1) --[[ ApplyTrinket | Line: 15 ]]
		p1:WaitForChild("Trinkets")

		local Stats = p1:WaitForChild("Stats")
		local OriginalStamina = Stats:WaitForChild("OriginalStamina")
		local CurrentStamina = Stats:WaitForChild("CurrentStamina")

		OriginalStamina.Value = OriginalStamina.Value + 15
		CurrentStamina.Value = CurrentStamina.Value + 15
	end,
	RemoveTrinket = function(p1) --[[ RemoveTrinket | Line: 25 ]]
		local Trinkets = p1:WaitForChild("Trinkets")
		local Stats = p1:WaitForChild("Stats")
		local OriginalStamina = Stats:WaitForChild("OriginalStamina")
		local CurrentStamina = Stats:WaitForChild("CurrentStamina")
		local Trinket1 = Trinkets:FindFirstChild("Trinket1")
		local Trinket2 = Trinkets:FindFirstChild("Trinket2")

		if not (Trinket1 and Trinket2) then
			return "CantRemove"
		end

		if Trinket1.Value == script.Name then
			Trinket1.Value = "None"
			OriginalStamina.Value = OriginalStamina.Value - 15
			CurrentStamina.Value = CurrentStamina.Value - 15

			return "Slot1"
		end

		if Trinket2.Value == script.Name then
			Trinket2.Value = "None"
			OriginalStamina.Value = OriginalStamina.Value - 15
			CurrentStamina.Value = CurrentStamina.Value - 15

			return "Slot2"
		end

		return "CantRemove"
	end
}