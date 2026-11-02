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
-- CQMcBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQhNYXRlcmlhbARFbnVtDVNtb290aFBsYXN0aWMRRG9udENoYW5nZVRleHR1cmUGSGFzVGFnHHJieGFzc2V0aWQ6Ly8xMDM4NTkzNDY2MTg0NzkJVGV4dHVyZUlECUhlYWRHbGFzcwxXYWl0Rm9yQ2hpbGQFRGVjYWwMRmFjZVRleHR1cmVzBk5vcm1hbAdUZXh0dXJlCUFwcGx5U2tpbg5WaW50YWdlIFJvZGdlcgROYW1lB01hc3RlcnkTT3ZlcndyaXRlQW5pbWF0aW9ucxtyYnhhc3NldGlkOi8vOTYyMzQyNTgxOTMyNjkFQmxpbmsccmJ4YXNzZXRpZDovLzExNTg0MTgzMDI1NDk4NQRIdXJ0HHJieGFzc2V0aWQ6Ly8xNDAzMzg5ODYwNDY1ODcOVVNFX1NLSU5fTU9ERUwAAgkBAQAABgMAAAUBByykAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXARMAbwgDALwGBf4EAAAAnwYDAg4GDgBNBgUtBQAAAKQHCAAHFGDA8QYJAAcAAABvCAkAvAYF3goAAACfBgMCKwYDAG8GCwAwBgWEDAAAAG4B7P8CAAAAbwMNALwBANMOAAAAnwEDAm8DDwC8AQHTDgAAAJ8BAwL7AgAATQICIRAAAABNAgIQEQAAADACAU8SAAAAggABABMDAQQAAABAAwIDAwMEAwUDBgMHBAcUYMADCAMJAwoDCwMMAw0DDgMPAxADEQAREgEYAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAABAAD+AAcAAAAAAAAAAAAAAAAAAAITAAAAAAMAAAECACKjAAAA/wAEAAAAAABvAQAAMAEAugEAAACpAQEAMAEAPAIAAAD/AQAAAAAAADABAOkDAAAA/wEDAAAAAABvAgQAMAIBmQUAAABvAgYAMAIBxQcAAABvAggAMAIBEAkAAAAwAQAhCgAAAKkBAAAwAQDCCwAAAMABDAASAAAAMAEA6Q0AAACCAAIADgMTAxQDFQMWAxcDGAMZAxoDGwMQAw8DHAYAAxIBAAEAARgAAAACAAABAAACAAAAAwABAAABAAABAAD9AAYAAAIAAAAPAQAAAAABD4biophzkoryQGkl+esI3H+e9dY9Qoij

-- https://lua.expert/
local t = {
	Name = "Vintage Rodger",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Blink = "rbxassetid://96234258193269",
		Hurt = "rbxassetid://115841830254985",
		Normal = "rbxassetid://140338986046587"
	},
	USE_SKIN_MODEL = false
}

function t.ApplySkin(p1) --[[ ApplySkin | Line: 17 | Upvalues: t (copy) ]]
	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") and (v.Material ~= Enum.Material.SmoothPlastic and not v:HasTag("DontChangeTexture")) then
			v.TextureID = "rbxassetid://103859346618479"
		end
	end

	p1:WaitForChild("HeadGlass"):WaitForChild("Decal").Texture = t.FaceTextures.Normal
end

return t