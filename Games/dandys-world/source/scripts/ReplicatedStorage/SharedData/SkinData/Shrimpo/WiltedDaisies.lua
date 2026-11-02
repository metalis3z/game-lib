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
-- CQMmCUFwcGx5U2tpbg5XaWx0ZWQgRGFpc2llcwROYW1lB1NocmltcG8JVG93ZXJOYW1lEk5vIGRlc2NyaXB0aW9uIHlldAtEZXNjcmlwdGlvbgdNYXN0ZXJ5BENvc3QHcmVxdWlyZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UKU2hhcmVkRGF0YQxSZWxlYXNlVGltZXMNRWFzdGVyMjAyNl9XMwdVbmxvY2tzBkVhc3RlcgtIb2xpZGF5U2tpbhtyYnhhc3NldGlkOi8vODIxMTUwMjg4MzcyMzcGRGVjb2RlHHJieGFzc2V0aWQ6Ly8xMDQ4NTU5ODMzNjE4NDQESWRsZRxyYnhhc3NldGlkOi8vMTE4NTk2MTk1MjU3OTUwBVF1aXJrHHJieGFzc2V0aWQ6Ly8xMTg0MDg2MTc0MzgzMjUDUnVuG3JieGFzc2V0aWQ6Ly84Mzc5NzAwMzM2OTg5NARXYWxrE092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzc2NDM0NjM3NTE5Nzg1Bk5vcm1hbBtyYnhhc3NldGlkOi8vNzY4OTY0MDkzNzM5NDgFQmxpbmsccmJ4YXNzZXRpZDovLzEzODI0MjU0NzAwNTI0MgRIdXJ0DEZhY2VUZXh0dXJlcw5VU0VfU0tJTl9NT0RFTAACAQEAAAAGAwAABQEHAYIAAQAAACABARgAJAAAAAAFAAABAgBQowAAAP8ABQAAAAAAbwEAADABALoBAAAAbwECADABAIcDAAAAbwEEADABAOIFAAAAqQEAADABADwGAAAAjAFYAjABACMHAAAApAEJAAAAgECkAgsAAACgQG8EDAC8AgIWDQAAAJ8CAwJNAgJkDgAAAE0CAgoPAAAAnwECAk0BASAQAAAAMAEAUREAAACpAQEAMAEAERIAAACpAQEAMAEAvBMAAAD/AQQAAAAAAG8CFAAwAgHuFQAAAG8CFgAwAgGSFwAAAG8CGAAwAgF4GQAAAG8CGgAwAgEWGwAAAG8CHAAwAgGfHQAAADABAOkeAAAA/wEDAAAAAABvAh8AMAIBECAAAABvAiEAMAIBmSIAAABvAiMAMAIBxSQAAAAwAQAhJQAAAKkBAQAwAQDCJgAAAMABJwAwAQDpKAAAAIIAAgApAwIDAwMEAwUDBgMHAwgDCQMKBAAAgEADCwQAAKBAAwwDDQMOAw8DEAMRAxIDEwMUAxUDFgMXAxgDGQMaAxsDHAMdAx4DHwMgAyEDIgMjAyQDJQMmBgADAQEAAQABGAAAAAIAAAEAAAEAAAEAAAIAAAEAAAAAAAAAAAAAAAAAAAAAAwAAAQAAAgABAAABAAABAAABAAABAAD7AAgAAQAAAQAAAQAA/QAHAAACAAAIAQAAAAAB3Plie5rB7XK4KyBhfmKaMazhdQ/uPQh6

-- https://lua.expert/
return {
	Name = "Wilted Daisies",
	TowerName = "Shrimpo",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W3,
	Easter = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Decode = "rbxassetid://82115028837237",
		Idle = "rbxassetid://104855983361844",
		Quirk = "rbxassetid://118596195257950",
		Run = "rbxassetid://118408617438325",
		Walk = "rbxassetid://83797003369894"
	},
	FaceTextures = {
		Normal = "rbxassetid://76434637519785",
		Blink = "rbxassetid://76896409373948",
		Hurt = "rbxassetid://138242547005242"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 32 ]] end
}