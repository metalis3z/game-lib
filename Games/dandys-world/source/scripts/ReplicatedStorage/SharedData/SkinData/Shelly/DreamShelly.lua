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
-- CQMnB3JlcXVpcmULU2hhcmVkVXRpbHMIVW5pdmVyc2UHSXNMb2JieQRIZWFkDFdhaXRGb3JDaGlsZApBdHRhY2htZW50BUNsb25lBlBhcmVudAlBcHBseVNraW4PUGFydGljbGVFbWl0dGVyBEVtaXQKVXNlQWJpbGl0eQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UQU3Rhci1UaW1lIFNoZWxseQROYW1lG3JieGFzc2V0aWQ6Ly85NzU2OTQyMTMzODQ5MgRXYWxrG3JieGFzc2V0aWQ6Ly84MTczOTIyMTU4Mjg4NwRJZGxlHHJieGFzc2V0aWQ6Ly8xMzIwNzQyNTMyNTkxNjMHQWJpbGl0eRtyYnhhc3NldGlkOi8vODc5NTIxNDY3MzkxNTUDUnVuG3JieGFzc2V0aWQ6Ly84Mjg0MzU2NTAzNjc0MAVRdWlyaxxyYnhhc3NldGlkOi8vMTEwNDA0MTM3NTkzMzQ4BkRlY29kZRNPdmVyd3JpdGVBbmltYXRpb25zG3JieGFzc2V0aWQ6Ly83NDIxMDY2NjM3NjAzNwZOb3JtYWwbcmJ4YXNzZXRpZDovLzg0NTI3MjkzNzk4MjE1BUJsaW5rG3JieGFzc2V0aWQ6Ly83OTA3MzkyNDUyOTgzMQRIdXJ0DEZhY2VUZXh0dXJlcw5VU0VfU0tJTl9NT0RFTAADBwIBAAAHBAAABQIHBx+kAgEAAAAAQPsDAABNAwOgAgAAAE0DAxkDAAAAnwICArwDAiMEAAAAnwMCAg4DAQCCAAEAbwUFALwDAdMGAAAAnwMDAm8FBwC8AwPTBgAAAJ8DAwK8AwM6CAAAAJ8DAgJvBgUAvAQA0wYAAACfBAMCMAQDJAkAAACCAAEACgMBBAAAAEADAgMDAwQDBQMGAwcDCAMJABcKARgAAAAAAAAAAAEAAAAAAgAAAAAAAAAAAAABAAAAAAACGQAAAAAHAQAAAAARbwMAALwBANMBAAAAnwEDAm8EAgC8AgHTAQAAAJ8CAwJvBQMAvAMC0wEAAACfAwMCjAYBALwEA1YEAAAAnwQDAYIAAQAFAwUDBgMHAwsDDAAhDQEYAAAAAAEAAAABAAAAAQAAAAEiAAAAAAQAAAECADqjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMC/wEEAAAAAABvAgQAMAIBugUAAAD/AgQAAAAAAG8DBgAwAwKfBwAAAG8DCAAwAwKSCQAAAG8DCgAwAwL0CwAAAG8DDAAwAwIWDQAAAG8DDgAwAwJ4DwAAAG8DEAAwAwLuEQAAADACAekSAAAA/wIDAAAAAABvAxMAMAMCEBQAAABvAxUAMAMCmRYAAABvAxcAMAMCxRgAAAAwAgEhGQAAAKkCAQAwAgHCGgAAAMACGwASAAAAMAIB6RwAAADAAh0AMAIBsh4AAACCAQIAHwMOBAAAAEADDwMQAxEDEgMTAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgMfAyADIQMiAyMDJAMlAyYDJwYAAwoGAQMNAgABAQABGAAAAAAAAAABAAIAAAIAAQAAAQAAAQAAAQAAAQAAAQAA+gAJAAEAAAEAAAEAAP0ABgAAAgAAAAoAAAgBAAAAAAKn40I3EqNlPL1eOc7JcOdz1/tVQ5UnKDY=

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

return {
	Name = "Star-Time Shelly",
	OverwriteAnimations = {
		Walk = "rbxassetid://97569421338492",
		Idle = "rbxassetid://81739221582887",
		Ability = "rbxassetid://132074253259163",
		Run = "rbxassetid://87952146739155",
		Quirk = "rbxassetid://82843565036740",
		Decode = "rbxassetid://110404137593348"
	},
	FaceTextures = {
		Normal = "rbxassetid://74210666376037",
		Blink = "rbxassetid://84527293798215",
		Hurt = "rbxassetid://79073924529831"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1, p2) --[[ ApplySkin | Line: 23 | Upvalues: ReplicatedStorage (copy) ]]
		if not require(ReplicatedStorage.SharedUtils.Universe):IsLobby() then
			p2:WaitForChild("Head"):WaitForChild("Attachment"):Clone().Parent = p1:WaitForChild("Head")
		end
	end,
	UseAbility = function(p1) --[[ UseAbility | Line: 33 ]]
		p1:WaitForChild("Head"):WaitForChild("Attachment"):WaitForChild("ParticleEmitter"):Emit(1)
	end
}