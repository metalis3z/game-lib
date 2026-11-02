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
-- CQMdBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQFcGFpcnMJd29ya3NwYWNlDUluR2FtZVBsYXllcnMLR2V0Q2hpbGRyZW4FU3RhdHMMV2FpdEZvckNoaWxkD09yaWdpbmFsU3RhbWluYQ5DdXJyZW50U3RhbWluYRBBcHBseUNhcmRFZmZlY3RzBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQ1TZXJ2ZXJTdG9yYWdlBEluZm8NQ2FyZE1vZGlmaWVycwtQbGF5ZXJTdGF0cwlFbmR1cmFuY2UYcmJ4YXNzZXRpZDovLzE3NzAyMzYzMjgzBEljb24tSW5jcmVhc2VzIHRoZSBtYXggU3RhbWluYSBvZiBhbGwgVG9vbnMgYnkgMTAuC0Rlc2NyaXB0aW9uAAILAAEAAABC+wAAAKQCAQAAAABATQICugIAAAC8AAADAwAAAJ8AAwIrADgApAAGAAAUQIBvAQcAnwACAqQBAQAAAABATQEBugIAAAAwAQC6AgAAAIwBCgAwAQDsCAAAAPsBAAAwAQAkCQAAAKQBCwAAAKBApAINAAAAwEBNAgJKDgAAALwCAmgPAAAAnwICAJ8BAAQXARsADgUaAG8IEAC8BgXTEQAAAJ8GAwJvCRIAvAcG0xEAAACfBwMCbwoTALwIBtMRAAAAnwgDAk0JB+wIAAAATQoA7AgAAABDCQkKMAkH7AgAAABNCQjsCAAAAE0KAOwIAAAAQwkJCjAJCOwIAAAAbgHk/wIAAACCAAEAFAMBBAAAAEADAgMDAwQDBQQAFECAAwYDBwMIAwkEAACgQAMKBAAAwEADCwMMAw0DDgMPAxAADBEBGAAAAAAAAAAAAAEAAAABAAAAAAABAAABAAABAAAAAAAAAAAAAAEBAAAAAQAAAAEAAAABAAAAAAAAAQAAAAAAAPoACg0AAAAABgAAAQIAKaMAAAD/AAMAAAAAAKQBAQAAAABAbwMCALwBARYDAAAAnwEDAqQCAQAAAABAbwQEALwCAhYDAAAAnwIDAqQDBgAAAFBATQMDegcAAABNAwOkCAAAAKQEBgAAAFBATQQEegcAAABNBAQBCQAAAG8FCgAwBQC6CwAAAG8FDAAwBQCuDQAAAG8FDgAwBQDiDwAAAMAFEAASAAMAMAUAgxEAAACCAAIAEgMSBAAAAEADEwMUAxUDCgQAAFBAAxYDFwMYAxkDAgMaAxsDHAMdBgADEQEAAQABGAAAAAIAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAIAAAEAAAEAAAIAAAASAQAAAAABk7SndQmCqBToje2UIMUW/eOssAGhcM10

-- https://lua.expert/
local Endurance = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

Endurance.Name = "Endurance"
Endurance.Icon = "rbxassetid://17702363283"
Endurance.Description = "Increases the max Stamina of all Toons by 10."
function Endurance.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 10
	v1.Parent = CardModifiers

	for k, v in pairs(workspace.InGamePlayers:GetChildren()) do
		if v then
			local Stats = v:WaitForChild("Stats")
			local OriginalStamina = Stats:WaitForChild("OriginalStamina")
			local CurrentStamina = Stats:WaitForChild("CurrentStamina")

			OriginalStamina.Value = OriginalStamina.Value + v1.Value
			CurrentStamina.Value = CurrentStamina.Value + v1.Value
		end
	end
end

return Endurance