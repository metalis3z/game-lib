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
-- CQMqBVN0YXRzDFdhaXRGb3JDaGlsZA5DdXJyZW50U3RhbWluYQdTdGFtaW5hCEh1bWFub2lkBVZhbHVlB091dGNvbWUGUmVhc29uJENhbid0IHVzZSB0aGF0IGl0ZW0gYXQgZnVsbCBTdGFtaW5hIRBIdW1hbm9pZFJvb3RQYXJ0DkZpbmRGaXJzdENoaWxkBnNjcmlwdAhVc2VTb3VuZAVDbG9uZQZQYXJlbnQEUGxheQtTYWZlQ2xlYW51cAROb25lCXdvcmtzcGFjZQRJbmZvC1BsYXllclN0YXRzBE5hbWUOU3Vydml2YWxQb2ludHMHVXNlSXRlbQNQb3AJUG9pbnRDb3N0DkRhbmR5U3RvcmVJdGVtCUZsb29ySXRlbQZDb21tb24GUmFyaXR5GHJieGFzc2V0aWQ6Ly8xNzcxMzMxNjA1NQRJY29uN1VzZSB0aGlzIGl0ZW0gd2hlbiBsb3cgb24gU3RhbWluYSB0byByZWdhaW4gNDUgU3RhbWluYS4LRGVzY3JpcHRpb24EZ2FtZQZEZWJyaXMKR2V0U2VydmljZRFSZXBsaWNhdGVkU3RvcmFnZQdyZXF1aXJlB01vZHVsZXMFQXVkaW8KU291bmRVdGlscwACCwIBAAAAUW8EAAC8AgDTAQAAAJ8CAwJvBQIAvAMC0wEAAACfAwMCbwYDALwEAtMBAAAAnwQDAm8HBAC8BQDTAQAAAJ8FAwJNBgPsBQAAAE0HBOwFAAAAfQcDAAYAAADiBgoAggYCAOIGDABvCQ0AvAcAAw4AAACfBwMCDgcVAG8JDQC8BwDTAQAAAJ8HAwKkCBAAAADwQE0ICK4RAAAAvAgIOhIAAACfCAICMAcIJBMAAAC8CQjuFAAAAJ8JAgH7CQAATQkJkBUAAABSCggAnwkCAU0HA+wFAAAAlQcHFjAHA+wFAAAAbwcXADAHAewFAAAApAcZAAAAgEFNBwd6GgAAAE0HBwEbAAAATQkAuhwAAAC8BwcDDgAAAJ8HAwIOBwkAbwodALwIB9MBAAAAnwgDAk0JCOwFAAAAlQkJHjAJCOwFAAAAggYCAB8DAQMCAwMDBAMFAwYDBwEAAwgDCQgCBgcAAAAICQAAAAEBCAIGCwAAAAgJAAAAAwoDCwMMBAAA8EADDQMOAw8DEAMRAgAAAAAAgEZAAxIDEwQAAIBBAxQDFQMWAxcCAAAAAAAAAEAADxgBGAAAAAABAAAAAQAAAAEAAAABAAAAAAABBAIEAAAAAAEAAAABAAAAAAAAAQABAAABAAAAAAIAAAAAAQAAAQAAAAAAAAAAAAABAQAAAAEAAAAAAhAAAAAABQAAAQIAMqMAAAD/AAQAAAAAAG8BAAAwAQC6AQAAAIwBGQAwAQBjAgAAAKkBAQAwAQB4AwAAAKkBAQAwAQAfBAAAAG8BBQAwAQDyBgAAAG8BBwAwAQCuCAAAAG8BCQAwAQDiCgAAAKQBDAAAALBAbwMNALwBARYOAAAAnwEDAqQCDAAAALBAbwQPALwCAhYOAAAAnwIDAqQDEQAAAABBTQQC6BIAAABNBATSEwAAAE0EBNcUAAAAnwMCAsAEFQASAAMAMAQAWRYAAACCAAIAFwMZAxYDGgMbAxwDHQMeAx8DIAMhAyIDIwQAALBAAyQDJQMmAycEAAAAQQMoAykDKgYAAxgBAAEAARgAAAACAAABAAABAAABAAABAAABAAABAAACAAAAAAABAAAAAAABAAAAAAAAAAACAAAAIgEAAAAAAVT2w13HmWZHrYiIE/J4UQ4k7tQpZjKpXA==

-- https://lua.expert/
local t = {
	Name = "Pop",
	PointCost = 25,
	DandyStoreItem = true,
	FloorItem = true,
	Rarity = "Common",
	Icon = "rbxassetid://17713316055",
	Description = "Use this item when low on Stamina to regain 45 Stamina."
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

	CurrentStamina.Value = CurrentStamina.Value + 45
	p2.Value = "None"

	local v2 = workspace.Info.PlayerStats:FindFirstChild(p1.Name)

	if not v2 then
		return t
	end

	local SurvivalPoints = v2:WaitForChild("SurvivalPoints")

	SurvivalPoints.Value = SurvivalPoints.Value + 2

	return t
end

return t