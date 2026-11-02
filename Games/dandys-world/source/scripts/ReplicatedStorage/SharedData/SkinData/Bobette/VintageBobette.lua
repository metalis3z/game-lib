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
-- CQMhB3JlcXVpcmULU2hhcmVkVXRpbHMIVW5pdmVyc2UHSXNMb2JieQdQcmVzZW50DFdhaXRGb3JDaGlsZANCb3gDQm93ClJpbmdSYW5nZXIGQ29sb3IzA25ldwVDb2xvcgVwYWlycw5HZXREZXNjZW5kYW50cwhNZXNoUGFydANJc0EMRmFjZVRleHR1cmVzBk5vcm1hbAlUZXh0dXJlSUQJQXBwbHlTa2luBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQ9WaW50YWdlIEJvYmV0dGUETmFtZQdNYXN0ZXJ5E092ZXJ3cml0ZUFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzEyMDk3NzE1NDYxODA0NxtyYnhhc3NldGlkOi8vOTU0MTc4OTU3MDcyODQFQmxpbmsccmJ4YXNzZXRpZDovLzExNzgwMDE4NTYwMDE5OARIdXJ0DlVTRV9TS0lOX01PREVMAAINAQIAAABOpAEBAAAAAED7AgAATQICoAIAAABNAgIZAwAAAJ8BAgLGAgAAxgMAAMYEAAC8BQEjBAAAAJ8FAgIrBSMAbwcFALwFANMGAAAAnwUDAm8IBwC8BgXTBgAAAJ8GAwJSAwYAbwgIALwGBdMGAAAAnwYDAlIEBgBvCAkAvAYA0wYAAACfBgMCUgIGAKQGDAAALKCAjAcAAIwIAACMCQAAnwYEAjAGBKQNAAAApAYMAAAsoICMBwEAjAgBAIwJAQCfBgQCMAYDpA0AAACkBQ8AAADgQLwGAEcQAAAAnwYCAJ8FAAQXBRIAbwwRALwKCf4SAAAAnwoDAg4KDQDxCQwAAwAAAPEJCgAEAAAA8QkIAAIAAAD7CgEATQoKIRMAAABNCgoQFAAAADAKCYQVAAAAbgXt/wIAAACCAAEAFgMBBAAAAEADAgMDAwQDBQMGAwcDCAMJAwoDCwQALKCAAwwDDQQAAOBAAw4DDwMQAxEDEgMTABIUARgAAAAAAAAAAAEAAAIAAAABAAAAAQAAAAABAAAAAAEAAAAAAgAAAAAAAAABAAAAAAAAAAQAAAAAAAABAAAAAAAAAAAAAAEAAAAAAAD+AAYUAAAAAAQAAAECACmjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMC/wEEAAAAAABvAgQAMAIBugUAAACpAgEAMAIBPAYAAAD/AgAAAAAAADACAekHAAAA/wIDAAAAAABvAwgAMAMCEAkAAABvAwoAMAMCmQsAAABvAwwAMAMCxQ0AAAAwAgEhDgAAAKkCAAAwAgHCDwAAAMACEAASAAAAEgABADACAekRAAAAggECABIDFQQAAABAAxYDFwMYAxkDGgMbAxwDEgMdAx4DHwMgAxEDIQYAAxQBAAEAARgAAAAAAAAAAQACAAABAAACAAAAAwABAAABAAABAAD9AAYAAAIAAAAAGAEAAAAAAaucVevwkV5GB5sdrvt0FdzbhEKfmVg/6g==

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {
	Name = "Vintage Bobette",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Normal = "rbxassetid://120977154618047",
		Blink = "rbxassetid://95417895707284",
		Hurt = "rbxassetid://117800185600198"
	},
	USE_SKIN_MODEL = false
}

function t.ApplySkin(p1) --[[ ApplySkin | Line: 18 | Upvalues: ReplicatedStorage (copy), t (copy) ]]
	local v1, v2, v3

	if require(ReplicatedStorage.SharedUtils.Universe):IsLobby() then
		v1 = nil
		v2 = nil
		v3 = nil
	else
		local Present = p1:WaitForChild("Present")
		local Box = Present:WaitForChild("Box")
		local Bow = Present:WaitForChild("Bow")
		local RingRanger = p1:WaitForChild("RingRanger")

		Bow.Color = Color3.new(0/255, 0/255, 0/255)
		Box.Color = Color3.new(255/255, 255/255, 255/255)
		v1 = Box
		v2 = Bow
		v3 = RingRanger
	end

	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") and (v ~= v1 and (v ~= v2 and v ~= v3)) then
			v.TextureID = t.FaceTextures.Normal
		end
	end
end

return t