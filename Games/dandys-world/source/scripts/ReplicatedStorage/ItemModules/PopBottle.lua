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
-- CQMqBVN0YXRzDFdhaXRGb3JDaGlsZA5DdXJyZW50U3RhbWluYQdTdGFtaW5hCEh1bWFub2lkBVZhbHVlB091dGNvbWUGUmVhc29uJENhbid0IHVzZSB0aGF0IGl0ZW0gYXQgZnVsbCBTdGFtaW5hIRBIdW1hbm9pZFJvb3RQYXJ0DkZpbmRGaXJzdENoaWxkBnNjcmlwdAhVc2VTb3VuZAVDbG9uZQZQYXJlbnQEUGxheQtTYWZlQ2xlYW51cAROb25lCXdvcmtzcGFjZQRJbmZvC1BsYXllclN0YXRzBE5hbWUOU3Vydml2YWxQb2ludHMHVXNlSXRlbQ1Cb3R0bGUgbycgUG9wCVBvaW50Q29zdA5EYW5keVN0b3JlSXRlbQlGbG9vckl0ZW0IVmVyeVJhcmUGUmFyaXR5GHJieGFzc2V0aWQ6Ly8xNzcxNDc0MTU5MwRJY29uSlVzZSB0aGlzIGl0ZW0gd2hlbiBsb3cgb24gU3RhbWluYSB0byByZWZpbGwgeW91ciBTdGFtaW5hIHRvIGZ1bGwgY2FwYWNpdHkuC0Rlc2NyaXB0aW9uBGdhbWUGRGVicmlzCkdldFNlcnZpY2URUmVwbGljYXRlZFN0b3JhZ2UHcmVxdWlyZQdNb2R1bGVzBUF1ZGlvClNvdW5kVXRpbHMAAgsCAQAAAFNvBAAAvAIA0wEAAACfAgMCbwUCALwDAtMBAAAAnwMDAm8GAwC8BALTAQAAAJ8EAwJvBwQAvAUA0wEAAACfBQMCTQYD7AUAAABNBwTsBQAAAH0HAwAGAAAA4gYKAIIGAgDiBgwAbwkNALwHAAMOAAAAnwcDAg4HFQBvCQ0AvAcA0wEAAACfBwMCpAgQAAAA8EBNCAiuEQAAALwICDoSAAAAnwgCAjAHCCQTAAAAvAkI7hQAAACfCQIB+wkAAE0JCZAVAAAAUgoIAJ8JAgFNBwPsBQAAAE0IBOwFAAAAQwcHCDAHA+wFAAAAbwcWADAHAewFAAAApAcYAAAAcEFNBwd6GQAAAE0HBwEaAAAATQkAuhsAAAC8BwcDDgAAAJ8HAwIOBwkAbwocALwIB9MBAAAAnwgDAk0JCOwFAAAAlQkJHTAJCOwFAAAAggYCAB4DAQMCAwMDBAMFAwYDBwEAAwgDCQgCBgcAAAAICQAAAAEBCAIGCwAAAAgJAAAAAwoDCwMMBAAA8EADDQMOAw8DEAMRAxIDEwQAAHBBAxQDFQMWAxcCAAAAAAAAIEAADxgBGAAAAAABAAAAAQAAAAEAAAABAAAAAAABBAIEAAAAAAEAAAABAAAAAAAAAQABAAABAAAAAAIAAAAAAAABAAABAAAAAAAAAAAAAAEBAAAAAQAAAAACEAAAAAAFAAABAgAyowAAAP8ABAAAAAAAbwEAADABALoBAAAAjAFVADABAGMCAAAAqQEBADABAHgDAAAAqQEBADABAB8EAAAAbwEFADABAPIGAAAAbwEHADABAK4IAAAAbwEJADABAOIKAAAApAEMAAAAsEBvAw0AvAEBFg4AAACfAQMCpAIMAAAAsEBvBA8AvAICFg4AAACfAgMCpAMRAAAAAEFNBALoEgAAAE0EBNITAAAATQQE1xQAAACfAwICwAQVABIAAwAwBABZFgAAAIIAAgAXAxkDFgMaAxsDHAMdAx4DHwMgAyEDIgMjBAAAsEADJAMlAyYDJwQAAABBAygDKQMqBgADGAEAAQABGAAAAAIAAAEAAAEAAAEAAAEAAAEAAAEAAAIAAAAAAAEAAAAAAAEAAAAAAAAAAAIAAAAiAQAAAAABdpi2TpjpkXVy/3dQ0O8TIwaAoTpEXNxP

-- https://lua.expert/
local t = {
	Name = "Bottle o\' Pop",
	PointCost = 85,
	DandyStoreItem = true,
	FloorItem = true,
	Rarity = "VeryRare",
	Icon = "rbxassetid://17714741593",
	Description = "Use this item when low on Stamina to refill your Stamina to full capacity."
}

game:GetService("Debris")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundUtils = require(ReplicatedStorage.Modules.Audio.SoundUtils)

function t.UseItem(p1, p2) --[[ UseItem | Line: 15 | Upvalues: SoundUtils (copy) ]]
	local Stats = p1:WaitForChild("Stats")
	local CurrentStamina = Stats:WaitForChild("CurrentStamina")
	local Stamina = Stats:WaitForChild("Stamina")

	p1:WaitForChild("Humanoid")

	if CurrentStamina.Value >= Stamina.Value then
		return {
			Outcome = false,
			Reason = "Can\'t use that item at full Stamina!"
		}
	end

	local t = {
		Outcome = true,
		Reason = "Can\'t use that item at full Stamina!"
	}

	if p1:FindFirstChild("HumanoidRootPart") then
		local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")
		local v1 = script.UseSound:Clone()

		v1.Parent = HumanoidRootPart
		v1:Play()
		SoundUtils.SafeCleanup(v1)
	end

	CurrentStamina.Value = CurrentStamina.Value + Stamina.Value
	p2.Value = "None"

	local v2 = workspace.Info.PlayerStats:FindFirstChild(p1.Name)

	if not v2 then
		return t
	end

	local SurvivalPoints = v2:WaitForChild("SurvivalPoints")

	SurvivalPoints.Value = SurvivalPoints.Value + 8

	return t
end

return t