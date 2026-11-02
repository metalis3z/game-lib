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
-- CQMmCUFwcGx5U2tpbg1NYXJjaGluZyBCYW5kBE5hbWUFTG9vZXkJVG93ZXJOYW1lEk5vIGRlc2NyaXB0aW9uIHlldAtEZXNjcmlwdGlvbgdNYXN0ZXJ5BENvc3QHcmVxdWlyZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UKU2hhcmVkRGF0YQxSZWxlYXNlVGltZXMQQ2hyaXN0bWFzMjAyNV9XNAdVbmxvY2tzCUNocmlzdG1hcwtIb2xpZGF5U2tpbhxyYnhhc3NldGlkOi8vMTI3ODkzMzk4NDM0NjI0BFdhbGsccmJ4YXNzZXRpZDovLzExNDYxMTQ5MjI5Nzk3NARJZGxlG3JieGFzc2V0aWQ6Ly83OTc2ODYzNzA3MTM0MQZEZWNvZGUccmJ4YXNzZXRpZDovLzEzNzI2NTQ1NDM0ODkxOQNSdW4bcmJ4YXNzZXRpZDovLzk3OTU3MTEzMDM1NTIyBVF1aXJrE092ZXJ3cml0ZUFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzEyMTU1MzMzMDQ4ODM3NwZOb3JtYWwccmJ4YXNzZXRpZDovLzEwNjgxMDA1MzI1MzExOQVCbGluaxxyYnhhc3NldGlkOi8vMTEzMTkxNTAxOTU5MTcwBEh1cnQMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMAAIBAQAAAAYDAAAFAQcBggABAAAAHwEBGAAjAAAAAAUAAAECAFCjAAAA/wAFAAAAAABvAQAAMAEAugEAAABvAQIAMAEAhwMAAABvAQQAMAEA4gUAAACpAQAAMAEAPAYAAACMAVgCMAEAIwcAAACkAQkAAACAQKQCCwAAAKBAbwQMALwCAhYNAAAAnwIDAk0CAmQOAAAATQICCg8AAACfAQICTQEBdRAAAAAwAQBREQAAAKkBAQAwAQCtEgAAAKkBAQAwAQC8EwAAAP8BBAAAAAAAbwIUADACAZ8VAAAAbwIWADACAZIXAAAAbwIYADACAe4ZAAAAbwIaADACARYbAAAAbwIcADACAXgdAAAAMAEA6R4AAAD/AQMAAAAAAG8CHwAwAgEQIAAAAG8CIQAwAgGZIgAAAG8CIwAwAgHFJAAAADABACElAAAAqQEBADABAMImAAAAwAEnADABAOkoAAAAggACACkDAgMDAwQDBQMGAwcDCAMJAwoEAACAQAMLBAAAoEADDAMNAw4DDwMQAxEDEgMTAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgMfAyADIQMiAyMDJAMlAyYGAAMBAQABAAEYAAAAAgAAAQAAAQAAAQAAAgAAAQAAAAAAAAAAAAAAAAAAAAADAAABAAACAAEAAAEAAAEAAAEAAAEAAPsACAABAAABAAABAAD9AAYAAAIAAAYBAAAAAAHKNj5ga9GyjgShmLZt4/5tui4pFPjyVGE=

-- https://lua.expert/
return {
	Name = "Marching Band",
	TowerName = "Looey",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Christmas2025_W4,
	Christmas = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Walk = "rbxassetid://127893398434624",
		Idle = "rbxassetid://114611492297974",
		Decode = "rbxassetid://79768637071341",
		Run = "rbxassetid://137265454348919",
		Quirk = "rbxassetid://97957113035522"
	},
	FaceTextures = {
		Normal = "rbxassetid://121553330488377",
		Blink = "rbxassetid://106810053253119",
		Hurt = "rbxassetid://113191501959170"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 31 ]] end
}