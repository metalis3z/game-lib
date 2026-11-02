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
-- CQMbBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQFcGFpcnMJd29ya3NwYWNlDUluR2FtZVBsYXllcnMLR2V0Q2hpbGRyZW4ESW5mbwtQbGF5ZXJTdGF0cw5TdXJ2aXZhbFBvaW50cwxXYWl0Rm9yQ2hpbGQQQXBwbHlDYXJkRWZmZWN0cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQ1DYXJkTW9kaWZpZXJzDFNwYXJlIENoYW5nZRhyYnhhc3NldGlkOi8vMTc3MDIzNjMxMTEESWNvbh1FdmVyeSBUb29uIHJlY2VpdmVzIDQ1IFRhcGVzLgtEZXNjcmlwdGlvbgACCgABAAAAPfsAAACkAgEAAAAAQE0CAroCAAAAvAAAAwMAAACfAAMCKwAzAKQABgAAFECAbwEHAJ8AAgKkAQEAAAAAQE0BAboCAAAAMAEAugIAAACMAQ8AMAEA7AgAAAD7AQAAMAEAJAkAAACkAQsAAACgQKQCDQAAAMBATQICSg4AAAC8AgJoDwAAAJ8CAgCfAQAEFwEWAA4FFQCkBg0AAADAQE0GBnoQAAAATQYGAREAAABNCAW6AgAAALwGBgMDAAAAnwYDAg4GCQBvCRIAvAcG0xMAAACfBwMCTQgH7AgAAACVCAgUMAgH7AgAAABuAen/AgAAAIIAAQAVAwEEAAAAQAMCAwMDBAMFBAAUQIADBgMHAwgDCQQAAKBAAwoEAADAQAMLAwwDDQMOAw8DEAIAAAAAAIBGQAAMEQEYAAAAAAAAAAAAAQAAAAEAAAAAAAEAAAEAAAEAAAAAAAAAAAAAAQEAAAAAAAAAAAAAAQEAAAABAAAAAPsACg0AAAAABgAAAQIAKaMAAAD/AAMAAAAAAKQBAQAAAABAbwMCALwBARYDAAAAnwEDAqQCAQAAAABAbwQEALwCAhYDAAAAnwIDAqQDBgAAAFBATQMDegcAAABNAwOkCAAAAKQEBgAAAFBATQQEegcAAABNBAQBCQAAAG8FCgAwBQC6CwAAAG8FDAAwBQCuDQAAAG8FDgAwBQDiDwAAAMAFEAASAAMAMAUAgxEAAACCAAIAEgMSBAAAAEADEwMUAxUDCgQAAFBAAw0DFgMOAxcDAgMYAxkDGgMbBgADEQEAAQABGAAAAAIAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAIAAAEAAAEAAAIAAAASAQAAAAAB7T67qrQ9QYjQqc9C2d7ZBp0mrN7f+tGr

-- https://lua.expert/
local t = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

t.Name = "Spare Change"
t.Icon = "rbxassetid://17702363111"
t.Description = "Every Toon receives 45 Tapes."
function t.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 15
	v1.Parent = CardModifiers

	for k, v in pairs(workspace.InGamePlayers:GetChildren()) do
		if v then
			local v2 = workspace.Info.PlayerStats:FindFirstChild(v.Name)

			if v2 then
				local SurvivalPoints = v2:WaitForChild("SurvivalPoints")

				SurvivalPoints.Value = SurvivalPoints.Value + 45
			end
		end
	end
end

return t