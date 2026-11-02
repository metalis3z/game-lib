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
-- CQMpCEh1bWFub2lkDFdhaXRGb3JDaGlsZAZIZWFsdGgJTWF4SGVhbHRoB091dGNvbWUGUmVhc29uI0Nhbid0IHVzZSB0aGF0IGl0ZW0gYXQgZnVsbCBIZWFsdGghEEh1bWFub2lkUm9vdFBhcnQORmluZEZpcnN0Q2hpbGQGc2NyaXB0CFVzZVNvdW5kBUNsb25lBlBhcmVudARQbGF5C1NhZmVDbGVhbnVwBE5vbmUFVmFsdWUJd29ya3NwYWNlBEluZm8LUGxheWVyU3RhdHMETmFtZQ5TdXJ2aXZhbFBvaW50cwdVc2VJdGVtCkhlYWx0aCBLaXQJUG9pbnRDb3N0DkRhbmR5U3RvcmVJdGVtCUZsb29ySXRlbQhWZXJ5UmFyZQZSYXJpdHkYcmJ4YXNzZXRpZDovLzE3NTY0NTI2NTkyBEljb24/VXNlIHRoaXMgaXRlbSB3aGVuIGluanVyZWQgdG8gZnVsbHkgcmVzdG9yZSBhbGwgb2YgeW91ciBIZWFydHMuC0Rlc2NyaXB0aW9uBGdhbWUGRGVicmlzCkdldFNlcnZpY2URUmVwbGljYXRlZFN0b3JhZ2UHcmVxdWlyZQdNb2R1bGVzBUF1ZGlvClNvdW5kVXRpbHMAAggCAQAAAERvBAAAvAIA0wEAAACfAgMCTQMCWgIAAABNBAKeAwAAAH0EAwADAAAA4gMIAIIDAgDiAwoAbwYLALwEAAMMAAAAnwQDAg4EFQBvBgsAvAQA0wEAAACfBAMCpAUOAAAA0EBNBQWuDwAAALwFBToQAAAAnwUCAjAEBSQRAAAAvAYF7hIAAACfBgIB+wYAAE0GBpATAAAAUgcFAJ8GAgFNBAKeAwAAADAEAloCAAAAbwQUADAEAewVAAAApAQXAAAAYEFNBAR6GAAAAE0EBAEZAAAATQYAuhoAAAC8BAQDDAAAAJ8EAwIOBAkAbwcbALwFBNMBAAAAnwUDAk0GBewVAAAAlQYGHDAGBewVAAAAggMCAB0DAQMCAwMDBAMFAQADBgMHCAIEBQAAAAYHAAAAAQEIAgQJAAAABgcAAAADCAMJAwoEAADQQAMLAwwDDQMOAw8DEAMRAxIEAABgQQMTAxQDFQMWAgAAAAAAACBAAA8XARgAAAAAAQAAAAAAAQQCBAAAAAABAAAAAQAAAAAAAAEAAQAAAQAAAAACAAAAAQAAAQAAAAAAAAAAAAABAQAAAAEAAAAAAhAAAAAABQAAAQIAMqMAAAD/AAQAAAAAAG8BAAAwAQC6AQAAAIwBZAAwAQBjAgAAAKkBAQAwAQB4AwAAAKkBAQAwAQAfBAAAAG8BBQAwAQDyBgAAAG8BBwAwAQCuCAAAAG8BCQAwAQDiCgAAAKQBDAAAALBAbwMNALwBARYOAAAAnwEDAqQCDAAAALBAbwQPALwCAhYOAAAAnwIDAqQDEQAAAABBTQQC6BIAAABNBATSEwAAAE0EBNcUAAAAnwMCAsAEFQASAAMAMAQAWRYAAACCAAIAFwMYAxUDGQMaAxsDHAMdAx4DHwMgAyEDIgQAALBAAyMDJAMlAyYEAAAAQQMnAygDKQYAAxcBAAEAARgAAAACAAABAAABAAABAAABAAABAAABAAACAAAAAAABAAAAAAABAAAAAAAAAAACAAAAHwEAAAAAAY704F/8qgBI9YaKmP9EqHr+7PcrvDCKXg==

-- https://lua.expert/
local t = {
	Name = "Health Kit",
	PointCost = 100,
	DandyStoreItem = true,
	FloorItem = true,
	Rarity = "VeryRare",
	Icon = "rbxassetid://17564526592",
	Description = "Use this item when injured to fully restore all of your Hearts."
}

game:GetService("Debris")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundUtils = require(ReplicatedStorage.Modules.Audio.SoundUtils)

function t.UseItem(p1, p2) --[[ UseItem | Line: 15 | Upvalues: SoundUtils (copy) ]]
	local Humanoid = p1:WaitForChild("Humanoid")

	if Humanoid.Health >= Humanoid.MaxHealth then
		return {
			Outcome = false,
			Reason = "Can\'t use that item at full Health!"
		}
	end

	local t = {
		Outcome = true,
		Reason = "Can\'t use that item at full Health!"
	}

	if p1:FindFirstChild("HumanoidRootPart") then
		local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")
		local v1 = script.UseSound:Clone()

		v1.Parent = HumanoidRootPart
		v1:Play()
		SoundUtils.SafeCleanup(v1)
	end

	Humanoid.Health = Humanoid.MaxHealth
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