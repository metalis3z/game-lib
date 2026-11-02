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
-- CQMWBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQQQXBwbHlDYXJkRWZmZWN0cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQl3b3Jrc3BhY2UESW5mbw1DYXJkTW9kaWZpZXJzC1BsYXllclN0YXRzC1N1cHByZXNzaW9uGHJieGFzc2V0aWQ6Ly8xNzcwMjM2MzUyMwRJY29uPlJlZHVjZXMgdGhlIGFtb3VudCBvZiBzcGVlZCBUd2lzdGVkcyBnYWluIGluIFBhbmljIE1vZGUgYnkgNSUuC0Rlc2NyaXB0aW9uAAIDAAEAAAAa+wAAAKQCAQAAAABATQICugIAAAC8AAADAwAAAJ8AAwIrABAApAAGAAAUQIBvAQcAnwACAqQBAQAAAABATQEBugIAAAAwAQC6AgAAAG8BCAAwAQDsCQAAAPsBAAAwAQAkCgAAAIIAAQALAwEEAAAAQAMCAwMDBAMFBAAUQIADBgKamZmZmZmpvwMHAwgADAkBGAAAAAAAAAAAAAEAAAABAAAAAAABAAABAAACDQAAAAAGAAABAgApowAAAP8AAwAAAAAApAEBAAAAAEBvAwIAvAEBFgMAAACfAQMCpAIBAAAAAEBvBAQAvAICFgMAAACfAgMCpAMGAAAAUEBNAwN6BwAAAE0DA6QIAAAApAQGAAAAUEBNBAR6BwAAAE0EBAEJAAAAbwUKADAFALoLAAAAbwUMADAFAK4NAAAAbwUOADAFAOIPAAAAwAUQABIAAwAwBQCDEQAAAIIAAgASAwoEAAAAQAMLAwwDDQMOBAAAUEADDwMQAxEDEgMCAxMDFAMVAxYGAAMJAQABAAEYAAAAAgAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAgAAAQAAAQAAAgAAAAkBAAAAAAHrZowtI5U0ij1F7+S1TAX7m36bWdmi5iw=

-- https://lua.expert/
local Suppression = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

Suppression.Name = "Suppression"
Suppression.Icon = "rbxassetid://17702363523"
Suppression.Description = "Reduces the amount of speed Twisteds gain in Panic Mode by 5%."
function Suppression.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = -0.05
	v1.Parent = CardModifiers
end

return Suppression