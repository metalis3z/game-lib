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
-- CQMWBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQQQXBwbHlDYXJkRWZmZWN0cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQl3b3Jrc3BhY2UESW5mbw1DYXJkTW9kaWZpZXJzC1BsYXllclN0YXRzClRlY2ggU2F2dnkYcmJ4YXNzZXRpZDovLzE3NzAyMzYzNzQ0BEljb25FRGVjcmVhc2VzIHRoZSBhbW91bnQgb2YgdGltZSBuZWVkZWQgdG8gZmlsbCB1cCBNYWNoaW5lcyBieSA1IHNlY29uZHMuC0Rlc2NyaXB0aW9uAAIDAAEAAAAa+wAAAKQCAQAAAABATQICugIAAAC8AAADAwAAAJ8AAwIrABAApAAGAAAUQIBvAQcAnwACAqQBAQAAAABATQEBugIAAAAwAQC6AgAAAIwB+/8wAQDsCAAAAPsBAAAwAQAkCQAAAIIAAQAKAwEEAAAAQAMCAwMDBAMFBAAUQIADBgMHAwgADAkBGAAAAAAAAAAAAAEAAAABAAAAAAABAAABAAACDQAAAAAGAAABAgApowAAAP8AAwAAAAAApAEBAAAAAEBvAwIAvAEBFgMAAACfAQMCpAIBAAAAAEBvBAQAvAICFgMAAACfAgMCpAMGAAAAUEBNAwN6BwAAAE0DA6QIAAAApAQGAAAAUEBNBAR6BwAAAE0EBAEJAAAAbwUKADAFALoLAAAAbwUMADAFAK4NAAAAbwUOADAFAOIPAAAAwAUQABIAAwAwBQCDEQAAAIIAAgASAwoEAAAAQAMLAwwDDQMOBAAAUEADDwMQAxEDEgMCAxMDFAMVAxYGAAMJAQABAAEYAAAAAgAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAgAAAQAAAQAAAgAAAAkBAAAAAAEv17I8+pJxlt1VbWK2XOHwX8+lSB0T2D0=

-- https://lua.expert/
local t = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

t.Name = "Tech Savvy"
t.Icon = "rbxassetid://17702363744"
t.Description = "Decreases the amount of time needed to fill up Machines by 5 seconds."
function t.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = -5
	v1.Parent = CardModifiers
end

return t