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
-- CQMmCUFwcGx5U2tpbhBDcmFua3kgQ2hyaXN0bWFzBE5hbWUHU2hyaW1wbwlUb3dlck5hbWUSTm8gZGVzY3JpcHRpb24geWV0C0Rlc2NyaXB0aW9uB01hc3RlcnkEQ29zdAdyZXF1aXJlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQpTaGFyZWREYXRhDFJlbGVhc2VUaW1lcxBDaHJpc3RtYXMyMDI1X1czB1VubG9ja3MJQ2hyaXN0bWFzC0hvbGlkYXlTa2luHHJieGFzc2V0aWQ6Ly8xMjU3NjQ5MDgxMzk5NTADUnVuHHJieGFzc2V0aWQ6Ly8xMjc0MzM0Njc4OTAyMzUEV2FsaxxyYnhhc3NldGlkOi8vMTA4NDU2Mzk1NzQwNTgxBElkbGUccmJ4YXNzZXRpZDovLzEyMzIzNjU2NDM2NzgyMwVRdWlyaxxyYnhhc3NldGlkOi8vMTE2NzgxNzE0MDEwMTQ0BkRlY29kZRNPdmVyd3JpdGVBbmltYXRpb25zHHJieGFzc2V0aWQ6Ly8xMzMwMjAwODQ0NzgyMzYFQmxpbmsbcmJ4YXNzZXRpZDovLzc3NjEyOTQ4MDA2NTU1BEh1cnQccmJ4YXNzZXRpZDovLzExNjgwNTg1NDAwNzIyOAZOb3JtYWwMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMAAIBAQAAAAYDAAAFAQcBggABAAAAHwEBGAAjAAAAAAUAAAECAFCjAAAA/wAFAAAAAABvAQAAMAEAugEAAABvAQIAMAEAhwMAAABvAQQAMAEA4gUAAACpAQAAMAEAPAYAAACMAVgCMAEAIwcAAACkAQkAAACAQKQCCwAAAKBAbwQMALwCAhYNAAAAnwIDAk0CAmQOAAAATQICCg8AAACfAQICTQEBMBAAAAAwAQBREQAAAKkBAQAwAQCtEgAAAKkBAQAwAQC8EwAAAP8BBAAAAAAAbwIUADACARYVAAAAbwIWADACAZ8XAAAAbwIYADACAZIZAAAAbwIaADACAXgbAAAAbwIcADACAe4dAAAAMAEA6R4AAAD/AQMAAAAAAG8CHwAwAgGZIAAAAG8CIQAwAgHFIgAAAG8CIwAwAgEQJAAAADABACElAAAAqQEBADABAMImAAAAwAEnADABAOkoAAAAggACACkDAgMDAwQDBQMGAwcDCAMJAwoEAACAQAMLBAAAoEADDAMNAw4DDwMQAxEDEgMTAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgMfAyADIQMiAyMDJAMlAyYGAAMBAQABAAEYAAAAAgAAAQAAAQAAAQAAAgAAAQAAAAAAAAAAAAAAAAAAAAADAAABAAACAAEAAAEAAAEAAAEAAAEAAPsACAABAAABAAABAAD9AAYAAAIAAAgBAAAAAAHOTIz0mooj5WvdIgfhg/ASvlSbgPyI5vU=

-- https://lua.expert/
return {
	Name = "Cranky Christmas",
	TowerName = "Shrimpo",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Christmas2025_W3,
	Christmas = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://125764908139950",
		Walk = "rbxassetid://127433467890235",
		Idle = "rbxassetid://108456395740581",
		Quirk = "rbxassetid://123236564367823",
		Decode = "rbxassetid://116781714010144"
	},
	FaceTextures = {
		Blink = "rbxassetid://133020084478236",
		Hurt = "rbxassetid://77612948006555",
		Normal = "rbxassetid://116805854007228"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 31 ]] end
}