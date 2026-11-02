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
-- CQMWBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQQQXBwbHlDYXJkRWZmZWN0cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQl3b3Jrc3BhY2UESW5mbw1DYXJkTW9kaWZpZXJzC1BsYXllclN0YXRzCUV0aXF1ZXR0ZRhyYnhhc3NldGlkOi8vMTc3MDIzNjQzNTAESWNvbitBZGRzIDUgc2Vjb25kcyB0byB0aGUgZWxldmF0b3IgcGFuaWMgdGltZXIuC0Rlc2NyaXB0aW9uAAIDAAEAAAAa+wAAAKQCAQAAAABATQICugIAAAC8AAADAwAAAJ8AAwIrABAApAAGAAAUQIBvAQcAnwACAqQBAQAAAABATQEBugIAAAAwAQC6AgAAAIwBBQAwAQDsCAAAAPsBAAAwAQAkCQAAAIIAAQAKAwEEAAAAQAMCAwMDBAMFBAAUQIADBgMHAwgADAkBGAAAAAAAAAAAAAEAAAABAAAAAAABAAABAAACDQAAAAAGAAABAgApowAAAP8AAwAAAAAApAEBAAAAAEBvAwIAvAEBFgMAAACfAQMCpAIBAAAAAEBvBAQAvAICFgMAAACfAgMCpAMGAAAAUEBNAwN6BwAAAE0DA6QIAAAApAQGAAAAUEBNBAR6BwAAAE0EBAEJAAAAbwUKADAFALoLAAAAbwUMADAFAK4NAAAAbwUOADAFAOIPAAAAwAUQABIAAwAwBQCDEQAAAIIAAgASAwoEAAAAQAMLAwwDDQMOBAAAUEADDwMQAxEDEgMCAxMDFAMVAxYGAAMJAQABAAEYAAAAAgAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAgAAAQAAAQAAAgAAAAkBAAAAAAGLLGuuNyoo5uLLSKTUpHDR+zR82rnoAa8=

-- https://lua.expert/
local Etiquette = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

Etiquette.Name = "Etiquette"
Etiquette.Icon = "rbxassetid://17702364350"
Etiquette.Description = "Adds 5 seconds to the elevator panic timer."
function Etiquette.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 5
	v1.Parent = CardModifiers
end

return Etiquette