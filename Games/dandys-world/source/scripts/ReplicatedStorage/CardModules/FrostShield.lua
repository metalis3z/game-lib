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
-- CQMeB3JlcXVpcmUKU2hhcmVkRGF0YRJIb2xpZGF5RXZlbnRDb25maWcHRU5BQkxFRAtDb250ZW50RmxhZwlDaHJpc3RtYXMNQ1VSUkVOVF9FVkVOVAVtYXRjaAVwY2FsbA9DYW5BcHBlYXJJblZvdGUGc2NyaXB0BE5hbWUORmluZEZpcnN0Q2hpbGQISW5zdGFuY2UDbmV3C051bWJlclZhbHVlBVZhbHVlBlBhcmVudBBBcHBseUNhcmRFZmZlY3RzBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQl3b3Jrc3BhY2UESW5mbw1DYXJkTW9kaWZpZXJzDEZyb3N0IFNoaWVsZBxyYnhhc3NldGlkOi8vMTE1MjU5NzQ4MDI2MTc1BEljb241RGVjcmVhc2VzIHRoZSBjaGFuY2Ugb2YgYW4gSWNlZCBPdmVyIGZsb29yIG9jY3VycmluZy4LRGVzY3JpcHRpb24ABAQAAQAAABekAAEAAAAAQPsBAABNAQFkAgAAAE0BASYDAAAAnwACAk0BAD8EAAAADgELAKkBAQBNAgAZBQAAAPACBwAGAAAATQEAwgcAAABvAwYAvAEB5wgAAACfAQMCggECAAkDAQQAAABAAwIDAwMEAwUDBgMHAwgADAABGAAAAAAAAAAAAQAAAQAAAAABAAAAAAAADQAAAAADAAEAAAAHpAABAAAAAEDAAQIAEgIAAJ8AAgPnAgABggICAAMDCQQAAABABgABAAsKARgAAAAAAAYADAAAAAADAAEAAAAa+wAAAKQCAQAAAABATQICugIAAAC8AAADAwAAAJ8AAwIrABAApAAGAAAUQIBvAQcAnwACAqQBAQAAAABATQEBugIAAAAwAQC6AgAAAG8BCAAwAQDsCQAAAPsBAAAwAQAkCgAAAIIAAQALAwsEAAAAQAMMAw0DDgMPBAAUQIADEALNzMzMzMzsPwMRAxIAFRMBGAAAAAAAAAAAAAEAAAABAAAAAAABAAABAAACFgAAAAAEAAABAgAhowAAAP8ABAAAAAAApAEBAAAAAEBvAwIAvAEBFgMAAACfAQMCpAIFAAAAQEBNAgJ6BgAAAE0CAqQHAAAAbwMIADADALoJAAAAbwMKADADAK4LAAAAbwMMADADAOINAAAAwAMOABIAAQAwAwAwDwAAAMADEAASAAIAMAMAgxEAAACCAAIAEgMUBAAAAEADFQMWAxcEAABAQAMYAxkDGgMMAxsDHAMdAx4GAQMKBgIDEwIBAgEAARgAAAACAAAAAAABAAAAAAACAAABAAABAAADAAAACgAAAAkBAAAAAAMcnJqmnDS5qctvwkYjYyLPbISN0i5Y8Kc=

-- https://lua.expert/
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CardModifiers = workspace.Info.CardModifiers

t.Name = "Frost Shield"
t.Icon = "rbxassetid://115259748026175"
t.Description = "Decreases the chance of an Iced Over floor occurring."
function t.CanAppearInVote() --[[ CanAppearInVote | Line: 11 | Upvalues: ReplicatedStorage (copy) ]]
	local ok, result = pcall(function() --[[ Line: 12 | Upvalues: ReplicatedStorage (ref) ]]
		local HolidayEventConfig = require(ReplicatedStorage.SharedData.HolidayEventConfig)

		return HolidayEventConfig.ENABLED and (if HolidayEventConfig.ContentFlag == "Christmas" then true else HolidayEventConfig.CURRENT_EVENT:match("Christmas"))
	end)

	return ok and result
end
function t.ApplyCardEffects() --[[ ApplyCardEffects | Line: 21 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 0.9
	v1.Parent = CardModifiers
end

return t