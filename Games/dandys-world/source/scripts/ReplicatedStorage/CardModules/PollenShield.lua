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
-- CQMeB3JlcXVpcmUKU2hhcmVkRGF0YRJIb2xpZGF5RXZlbnRDb25maWcHRU5BQkxFRAtDb250ZW50RmxhZwZFYXN0ZXINQ1VSUkVOVF9FVkVOVAVtYXRjaAVwY2FsbA9DYW5BcHBlYXJJblZvdGUGc2NyaXB0BE5hbWUORmluZEZpcnN0Q2hpbGQISW5zdGFuY2UDbmV3C051bWJlclZhbHVlBVZhbHVlBlBhcmVudBBBcHBseUNhcmRFZmZlY3RzBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQl3b3Jrc3BhY2UESW5mbw1DYXJkTW9kaWZpZXJzDUFpciBGcmVzaGVuZXIccmJ4YXNzZXRpZDovLzE0MDQ3Mzg3MTUxMjA0OQRJY29uN0RlY3JlYXNlcyB0aGUgY2hhbmNlIG9mIGEgU3ByaW5nIEZldmVyIGZsb29yIG9jY3VycmluZy4LRGVzY3JpcHRpb24ABAQAAQAAABekAAEAAAAAQPsBAABNAQFkAgAAAE0BASYDAAAAnwACAk0BAD8EAAAADgELAKkBAQBNAgAZBQAAAPACBwAGAAAATQEAwgcAAABvAwYAvAEB5wgAAACfAQMCggECAAkDAQQAAABAAwIDAwMEAwUDBgMHAwgADAABGAAAAAAAAAAAAQAAAQAAAAABAAAAAAAADQAAAAADAAEAAAAHpAABAAAAAEDAAQIAEgIAAJ8AAgPnAgABggICAAMDCQQAAABABgABAAsKARgAAAAAAAYADAAAAAADAAEAAAAa+wAAAKQCAQAAAABATQICugIAAAC8AAADAwAAAJ8AAwIrABAApAAGAAAUQIBvAQcAnwACAqQBAQAAAABATQEBugIAAAAwAQC6AgAAAG8BCAAwAQDsCQAAAPsBAAAwAQAkCgAAAIIAAQALAwsEAAAAQAMMAw0DDgMPBAAUQIADEALNzMzMzMzsPwMRAxIAFRMBGAAAAAAAAAAAAAEAAAABAAAAAAABAAABAAACFgAAAAAEAAABAgAhowAAAP8ABAAAAAAApAEBAAAAAEBvAwIAvAEBFgMAAACfAQMCpAIFAAAAQEBNAgJ6BgAAAE0CAqQHAAAAbwMIADADALoJAAAAbwMKADADAK4LAAAAbwMMADADAOINAAAAwAMOABIAAQAwAwAwDwAAAMADEAASAAIAMAMAgxEAAACCAAIAEgMUBAAAAEADFQMWAxcEAABAQAMYAxkDGgMMAxsDHAMdAx4GAQMKBgIDEwIBAgEAARgAAAACAAAAAAABAAAAAAACAAABAAABAAADAAAACgAAAAkBAAAAAAPTiF5Fic6EKxfqfEUpWxxZo5BJMeFMNEQ=

-- https://lua.expert/
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CardModifiers = workspace.Info.CardModifiers

t.Name = "Air Freshener"
t.Icon = "rbxassetid://140473871512049"
t.Description = "Decreases the chance of a Spring Fever floor occurring."
function t.CanAppearInVote() --[[ CanAppearInVote | Line: 11 | Upvalues: ReplicatedStorage (copy) ]]
	local ok, result = pcall(function() --[[ Line: 12 | Upvalues: ReplicatedStorage (ref) ]]
		local HolidayEventConfig = require(ReplicatedStorage.SharedData.HolidayEventConfig)

		return HolidayEventConfig.ENABLED and (if HolidayEventConfig.ContentFlag == "Easter" then true else HolidayEventConfig.CURRENT_EVENT:match("Easter"))
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