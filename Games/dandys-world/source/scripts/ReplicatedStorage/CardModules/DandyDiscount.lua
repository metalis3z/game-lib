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
-- CQMWBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQQQXBwbHlDYXJkRWZmZWN0cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQl3b3Jrc3BhY2UESW5mbw1DYXJkTW9kaWZpZXJzC1BsYXllclN0YXRzBkZydWdhbBhyYnhhc3NldGlkOi8vMTc3MDIzNjQ1MDYESWNvbjFBcHBsaWVzIGEgMTAlIERpc2NvdW50IHRvIGFsbCBEYW5keSdzIFNob3AgaXRlbXMuC0Rlc2NyaXB0aW9uAAIDAAEAAAAa+wAAAKQCAQAAAABATQICugIAAAC8AAADAwAAAJ8AAwIrABAApAAGAAAUQIBvAQcAnwACAqQBAQAAAABATQEBugIAAAAwAQC6AgAAAG8BCAAwAQDsCQAAAPsBAAAwAQAkCgAAAIIAAQALAwEEAAAAQAMCAwMDBAMFBAAUQIADBgLNzMzMzMzsPwMHAwgADAkBGAAAAAAAAAAAAAEAAAABAAAAAAABAAABAAACDQAAAAAGAAABAgApowAAAP8AAwAAAAAApAEBAAAAAEBvAwIAvAEBFgMAAACfAQMCpAIBAAAAAEBvBAQAvAICFgMAAACfAgMCpAMGAAAAUEBNAwN6BwAAAE0DA6QIAAAApAQGAAAAUEBNBAR6BwAAAE0EBAEJAAAAbwUKADAFALoLAAAAbwUMADAFAK4NAAAAbwUOADAFAOIPAAAAwAUQABIAAwAwBQCDEQAAAIIAAgASAwoEAAAAQAMLAwwDDQMOBAAAUEADDwMQAxEDEgMCAxMDFAMVAxYGAAMJAQABAAEYAAAAAgAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAgAAAQAAAQAAAgAAAAkBAAAAAAFwsFLf81TbKdtB2tVZ/UYcAKhFq0J0ON4=

-- https://lua.expert/
local Frugal = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

Frugal.Name = "Frugal"
Frugal.Icon = "rbxassetid://17702364506"
Frugal.Description = "Applies a 10% Discount to all Dandy\'s Shop items."
function Frugal.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 0.9
	v1.Parent = CardModifiers
end

return Frugal