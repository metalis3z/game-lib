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
-- CQMkBXBhaXJzDkdldERlc2NlbmRhbnRzD1BhcnRpY2xlRW1pdHRlcgNJc0ENQ29sb3JTZXF1ZW5jZQNuZXcVQ29sb3JTZXF1ZW5jZUtleXBvaW50BkNvbG9yMwdmcm9tUkdCBUNvbG9yCUFwcGx5U2tpbg1BbnRpcXVlIFNoYWRlBE5hbWUEQ29zdApEYW5keVN0b3JlHHJieGFzc2V0aWQ6Ly8xNDA0NjAwMjU1MjgxODgDUnVuHHJieGFzc2V0aWQ6Ly8xMTIzODg5NzQ5ODM3NDYEV2FsaxxyYnhhc3NldGlkOi8vMTAwMjg0MDkzNTMzODUxBElkbGUbcmJ4YXNzZXRpZDovLzcyMjQxMTg5NTAwOTc0BVF1aXJrHHJieGFzc2V0aWQ6Ly8xMTc1NjYyMDU1MDE5MjAGRGVjb2RlG3JieGFzc2V0aWQ6Ly84NTI4OTA5MTE3MDE0NQdBYmlsaXR5E092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzg5MTA3NTA0NDUyMDg0Bk5vcm1hbBxyYnhhc3NldGlkOi8vMTMwNTcwMzkzMDczNDU3BUJsaW5rHHJieGFzc2V0aWQ6Ly8xMzU0MzMwNzA1MjE0NTQESHVydAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAg8BAAAABgMAAAUBByykAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXASIAbwgDALwGBf4EAAAAnwYDAg4GHQCkBgcAABhQgP8HAAACAAAApAgJAAAYgICMCQAApAoMAAAsoICMC/8AjAz/AIwN/wCfCgQAnwgAAqQJCQAAGICAjAoBAKQLDAAALKCAjAz/AIwN/wCMDv8AnwsEAJ8JAADFBwgAAQAAAJ8GAgIwBgWkDQAAAG4B3f8CAAAAggABAA4DAQQAAABAAwIDAwMEAwUDBgQAGFCAAwcEABiAgAMIAwkEACyggAMKABgLARgAAAAAAAAAAQAAAAABAAAAAQAAAAAAAAAAAAEAAAAAAAAAAAAAAP4AAP4ACRoAAAAAAwAAAQIANqMAAAD/AAQAAAAAAG8BAAAwAQC6AQAAAIwBWAIwAQAjAgAAAKkBAQAwAQBOAwAAAP8BBAAAAAAAbwIEADACARYFAAAAbwIGADACAZ8HAAAAbwIIADACAZIJAAAAbwIKADACAXgLAAAAbwIMADACAe4NAAAAbwIOADACAfQPAAAAMAEA6RAAAAD/AQMAAAAAAG8CEQAwAgEQEgAAAG8CEwAwAgGZFAAAAG8CFQAwAgHFFgAAADABACEXAAAAqQEBADABAMIYAAAAwAEZADABAOkaAAAAggACABsDDAMNAw4DDwMQAxEDEgMTAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgMfAyADIQMiAyMDJAYAAwsBAAEAARgAAAACAAABAAABAAACAAEAAAEAAAEAAAEAAAEAAAEAAPoACQABAAABAAABAAD9AAYAAAIAAA8BAAAAAAFiRumKFcnCODtwHMwC5eJWEl7+/lCCg4s=

-- https://lua.expert/
return {
	Name = "Antique Shade",
	Cost = 600,
	DandyStore = true,
	OverwriteAnimations = {
		Run = "rbxassetid://140460025528188",
		Walk = "rbxassetid://112388974983746",
		Idle = "rbxassetid://100284093533851",
		Quirk = "rbxassetid://72241189500974",
		Decode = "rbxassetid://117566205501920",
		Ability = "rbxassetid://85289091170145"
	},
	FaceTextures = {
		Normal = "rbxassetid://89107504452084",
		Blink = "rbxassetid://130570393073457",
		Hurt = "rbxassetid://135433070521454"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 24 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
			end
		end
	end
}