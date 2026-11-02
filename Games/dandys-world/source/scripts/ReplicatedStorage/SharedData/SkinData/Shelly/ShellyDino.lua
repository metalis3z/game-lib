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
-- CQMpB3JlcXVpcmULU2hhcmVkVXRpbHMIVW5pdmVyc2UHSXNMb2JieQRIZWFkDFdhaXRGb3JDaGlsZApBdHRhY2htZW50BUNsb25lBlBhcmVudAlBcHBseVNraW4PUGFydGljbGVFbWl0dGVyBEVtaXQKVXNlQWJpbGl0eQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UKRGlubyBTbm9yZQROYW1lBENvc3QKRGFuZHlTdG9yZRtyYnhhc3NldGlkOi8vNzMwMjAxOTMxMTkzMzYEV2FsaxxyYnhhc3NldGlkOi8vMTAwODQ5MzQ1MjEzNDQ3BElkbGUccmJ4YXNzZXRpZDovLzExMjUzMDE5NDYxMjUxOQdBYmlsaXR5G3JieGFzc2V0aWQ6Ly83NzA1NzQzNTM5ODkwNgNSdW4ccmJ4YXNzZXRpZDovLzEzNDU2ODUzNTAwNTUwMQVRdWlyaxxyYnhhc3NldGlkOi8vMTI1MjMxNTQ5Nzg2Nzg5BkRlY29kZRNPdmVyd3JpdGVBbmltYXRpb25zHHJieGFzc2V0aWQ6Ly8xMDA2OTQ4MzcyMjEzNjcGTm9ybWFsHHJieGFzc2V0aWQ6Ly8xMTE3MTYwMDE0NDU0NzcFQmxpbmsccmJ4YXNzZXRpZDovLzEyOTY5NjAyNDU2MjcyNARIdXJ0DEZhY2VUZXh0dXJlcw5VU0VfU0tJTl9NT0RFTAADBwIBAAAHBAAABQIHBx+kAgEAAAAAQPsDAABNAwOgAgAAAE0DAxkDAAAAnwICArwDAiMEAAAAnwMCAg4DAQCCAAEAbwUFALwDAdMGAAAAnwMDAm8FBwC8AwPTBgAAAJ8DAwK8AwM6CAAAAJ8DAgJvBgUAvAQA0wYAAACfBAMCMAQDJAkAAACCAAEACgMBBAAAAEADAgMDAwQDBQMGAwcDCAMJABkKARgAAAAAAAAAAAEAAAAAAgAAAAAAAAAAAAABAAAAAAACGwAAAAAHAQAAAAARbwMAALwBANMBAAAAnwEDAm8EAgC8AgHTAQAAAJ8CAwJvBQMAvAMC0wEAAACfAwMCjAYCALwEA1YEAAAAnwQDAYIAAQAFAwUDBgMHAwsDDAAjDQEYAAAAAAEAAAABAAAAAQAAAAEkAAAAAAQAAAECAECjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMC/wEEAAAAAABvAgQAMAIBugUAAACMAlgCMAIBIwYAAACpAgEAMAIBTgcAAAD/AgQAAAAAAG8DCAAwAwKfCQAAAG8DCgAwAwKSCwAAAG8DDAAwAwL0DQAAAG8DDgAwAwIWDwAAAG8DEAAwAwJ4EQAAAG8DEgAwAwLuEwAAADACAekUAAAA/wIDAAAAAABvAxUAMAMCEBYAAABvAxcAMAMCmRgAAABvAxkAMAMCxRoAAAAwAgEhGwAAAKkCAQAwAgHCHAAAAMACHQASAAAAMAIB6R4AAADAAh8AMAIBsiAAAACCAQIAIQMOBAAAAEADDwMQAxEDEgMTAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgMfAyADIQMiAyMDJAMlAyYDJwMoAykGAAMKBgEDDQIAAQEAARgAAAAAAAAAAQACAAABAAABAAACAAEAAAEAAAEAAAEAAAEAAAEAAPoACQABAAABAAABAAD9AAYAAAIAAAAKAAAIAQAAAAAC1AoIM2JhiPGsCcTpIQUMCaQSH0fmzmIy

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

return {
	Name = "Dino Snore",
	Cost = 600,
	DandyStore = true,
	OverwriteAnimations = {
		Walk = "rbxassetid://73020193119336",
		Idle = "rbxassetid://100849345213447",
		Ability = "rbxassetid://112530194612519",
		Run = "rbxassetid://77057435398906",
		Quirk = "rbxassetid://134568535005501",
		Decode = "rbxassetid://125231549786789"
	},
	FaceTextures = {
		Normal = "rbxassetid://100694837221367",
		Blink = "rbxassetid://111716001445477",
		Hurt = "rbxassetid://129696024562724"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1, p2) --[[ ApplySkin | Line: 25 | Upvalues: ReplicatedStorage (copy) ]]
		if not require(ReplicatedStorage.SharedUtils.Universe):IsLobby() then
			p2:WaitForChild("Head"):WaitForChild("Attachment"):Clone().Parent = p1:WaitForChild("Head")
		end
	end,
	UseAbility = function(p1) --[[ UseAbility | Line: 35 ]]
		p1:WaitForChild("Head"):WaitForChild("Attachment"):WaitForChild("ParticleEmitter"):Emit(2)
	end
}