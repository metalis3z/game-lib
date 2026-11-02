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
-- CQMeBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQFcGFpcnMJd29ya3NwYWNlDUluR2FtZVBsYXllcnMLR2V0Q2hpbGRyZW4JQWJpbGl0aWVzCEFiaWxpdHkxDFdhaXRGb3JDaGlsZAhDb29sZG93bg9DdXJyZW50Q29vbGRvd24QQXBwbHlDYXJkRWZmZWN0cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQRJbmZvDUNhcmRNb2RpZmllcnMLUGxheWVyU3RhdHMJUmVoZWFyc2FsGHJieGFzc2V0aWQ6Ly8xODE2NjQwOTczNARJY29uNURlY3JlYXNlcyBUb29uIEFjdGl2ZSBBYmlsaXR5IGNvb2xkb3ducyBieSA1IHNlY29uZHMuC0Rlc2NyaXB0aW9uAAIMAAEAAABT+wAAAKQCAQAAAABATQICugIAAAC8AAADAwAAAJ8AAwIrAEkApAAGAAAUQIBvAQcAnwACAqQBAQAAAABATQEBugIAAAAwAQC6AgAAAIwBCgAwAQDsCAAAAPsBAAAwAQAkCQAAAKQBCwAAAKBApAINAAAAwEBNAgJKDgAAALwCAmgPAAAAnwICAJ8BAAQXASwADgUrAG8IEAC8BgUDAwAAAJ8GAwIOBiYAbwgQALwGBQMDAAAAnwYDAm8IEQC8BgYDAwAAAJ8GAwIOBh0AbwgQALwGBdMSAAAAnwYDAm8JEQC8BwbTEgAAAJ8HAwJvChMAvAgH0xIAAACfCAMCbwsUALwJB9MSAAAAnwkDAk0KCOwIAAAAeAoKFTAKCOwIAAAATQoI7AgAAACMCwUAfQoEAAsAAACMCgUAMAoI7AgAAABuAdP/AgAAAIIAAQAWAwEEAAAAQAMCAwMDBAMFBAAUQIADBgMHAwgDCQQAAKBAAwoEAADAQAMLAwwDDQMOAw8DEAMRAgAAAAAAABRAAAwSARgAAAAAAAAAAAABAAAAAQAAAAAAAQAAAQAAAQAAAAAAAAAAAAABAQAAAAABAAAAAAAAAAABAAAAAQAAAAEAAAABAAAAAgAAAAACAAAAAAEAAPQAEw0AAAAABgAAAQIAKaMAAAD/AAMAAAAAAKQBAQAAAABAbwMCALwBARYDAAAAnwEDAqQCAQAAAABAbwQEALwCAhYDAAAAnwIDAqQDBgAAAFBATQMDegcAAABNAwOkCAAAAKQEBgAAAFBATQQEegcAAABNBAQBCQAAAG8FCgAwBQC6CwAAAG8FDAAwBQCuDQAAAG8FDgAwBQDiDwAAAMAFEAASAAMAMAUAgxEAAACCAAIAEgMTBAAAAEADFAMVAxYDCgQAAFBAAxcDGAMZAxoDAgMbAxwDHQMeBgADEgEAAQABGAAAAAIAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAIAAAEAAAEAAAIAAAAbAQAAAAABI79wqVqKSXkGLFlif60yyVOnZ90Rexqo

-- https://lua.expert/
local Rehearsal = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

Rehearsal.Name = "Rehearsal"
Rehearsal.Icon = "rbxassetid://18166409734"
Rehearsal.Description = "Decreases Toon Active Ability cooldowns by 5 seconds."
function Rehearsal.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 10
	v1.Parent = CardModifiers

	for k, v in pairs(workspace.InGamePlayers:GetChildren()) do
		if v and (v:FindFirstChild("Abilities") and v:FindFirstChild("Abilities"):FindFirstChild("Ability1")) then
			local Ability1 = v:WaitForChild("Abilities"):WaitForChild("Ability1")
			local Cooldown = Ability1:WaitForChild("Cooldown")

			Ability1:WaitForChild("CurrentCooldown")
			Cooldown.Value = Cooldown.Value - 5

			if Cooldown.Value <= 5 then
				Cooldown.Value = 5
			end
		end
	end
end

return Rehearsal