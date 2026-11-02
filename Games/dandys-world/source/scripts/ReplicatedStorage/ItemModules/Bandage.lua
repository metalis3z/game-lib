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
-- CQMpCEh1bWFub2lkDFdhaXRGb3JDaGlsZAZIZWFsdGgJTWF4SGVhbHRoB091dGNvbWUGUmVhc29uI0Nhbid0IHVzZSB0aGF0IGl0ZW0gYXQgZnVsbCBIZWFsdGghEEh1bWFub2lkUm9vdFBhcnQORmluZEZpcnN0Q2hpbGQGc2NyaXB0CFVzZVNvdW5kBUNsb25lBlBhcmVudARQbGF5C1NhZmVDbGVhbnVwBE5vbmUFVmFsdWUJd29ya3NwYWNlBEluZm8LUGxheWVyU3RhdHMETmFtZQ5TdXJ2aXZhbFBvaW50cwdVc2VJdGVtB0JhbmRhZ2UJUG9pbnRDb3N0DkRhbmR5U3RvcmVJdGVtCUZsb29ySXRlbQRSYXJlBlJhcml0eRhyYnhhc3NldGlkOi8vMTc1NjI2NDczNDMESWNvbitVc2UgdGhpcyBpdGVtIHdoZW4gaW5qdXJlZCB0byBoZWFsIDEgSGVhcnQuC0Rlc2NyaXB0aW9uBGdhbWUGRGVicmlzCkdldFNlcnZpY2URUmVwbGljYXRlZFN0b3JhZ2UHcmVxdWlyZQdNb2R1bGVzBUF1ZGlvClNvdW5kVXRpbHMAAggCAQAAAEVvBAAAvAIA0wEAAACfAgMCTQMCWgIAAABNBAKeAwAAAH0EAwADAAAA4gMIAIIDAgDiAwoAbwYLALwEAAMMAAAAnwQDAg4EFQBvBgsAvAQA0wEAAACfBAMCpAUOAAAA0EBNBQWuDwAAALwFBToQAAAAnwUCAjAEBSQRAAAAvAYF7hIAAACfBgIB+wYAAE0GBpATAAAAUgcFAJ8GAgFNBAJaAgAAAJUEBBQwBAJaAgAAAG8EFQAwBAHsFgAAAKQEGAAAAHBBTQQEehkAAABNBAQBGgAAAE0GALobAAAAvAQEAwwAAACfBAMCDgQJAG8HHAC8BQTTAQAAAJ8FAwJNBgXsFgAAAJUGBh0wBgXsFgAAAIIDAgAeAwEDAgMDAwQDBQEAAwYDBwgCBAUAAAAGBwAAAAEBCAIECQAAAAYHAAAAAwgDCQMKBAAA0EADCwMMAw0DDgMPAgAAAAAAAPA/AxADEQMSBAAAcEEDEwMUAxUDFgIAAAAAAAAUQAAPFwEYAAAAAAEAAAAAAAEEAgQAAAAAAQAAAAEAAAAAAAABAAEAAAEAAAAAAgAAAAABAAABAAAAAAAAAAAAAAEBAAAAAQAAAAACEAAAAAAFAAABAgAyowAAAP8ABAAAAAAAbwEAADABALoBAAAAjAE8ADABAGMCAAAAqQEBADABAHgDAAAAqQEBADABAB8EAAAAbwEFADABAPIGAAAAbwEHADABAK4IAAAAbwEJADABAOIKAAAApAEMAAAAsEBvAw0AvAEBFg4AAACfAQMCpAIMAAAAsEBvBA8AvAICFg4AAACfAgMCpAMRAAAAAEFNBALoEgAAAE0EBNITAAAATQQE1xQAAACfAwICwAQVABIAAwAwBABZFgAAAIIAAgAXAxgDFQMZAxoDGwMcAx0DHgMfAyADIQMiBAAAsEADIwMkAyUDJgQAAABBAycDKAMpBgADFwEAAQABGAAAAAIAAAEAAAEAAAEAAAEAAAEAAAEAAAIAAAAAAAEAAAAAAAEAAAAAAAAAAAIAAAAfAQAAAAABX7IpBv4GP8Jsvbu5L8AkDy+qPnJtdkMH

-- https://lua.expert/
local t = {
	Name = "Bandage",
	PointCost = 60,
	DandyStoreItem = true,
	FloorItem = true,
	Rarity = "Rare",
	Icon = "rbxassetid://17562647343",
	Description = "Use this item when injured to heal 1 Heart."
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

	Humanoid.Health = Humanoid.Health + 1
	p2.Value = "None"

	local v2 = workspace.Info.PlayerStats:FindFirstChild(p1.Name)

	if not v2 then
		return t
	end

	local SurvivalPoints = v2:WaitForChild("SurvivalPoints")

	SurvivalPoints.Value = SurvivalPoints.Value + 5

	return t
end

return t