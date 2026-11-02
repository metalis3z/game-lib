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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRtyYnhhc3NldGlkOi8vODkyNTMzOTkxNDU1MTcJVGV4dHVyZUlEBkNvbmZpZwxXYWl0Rm9yQ2hpbGQLSHVydFRleHR1cmUbcmJ4YXNzZXRpZDovLzc5NDk3NDIzNjIxMjg1B1RleHR1cmUNTm9ybWFsVGV4dHVyZQxCbGlua1RleHR1cmUbcmJ4YXNzZXRpZDovLzg1MDExMDI2MTE3ODAxCUFwcGx5U2tpbg1WaW50YWdlIENvY29hBE5hbWUHTWFzdGVyeQACCQEAAAAAK6QBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvAwoAMAMCTwsAAABvBQwAvAMB0wgAAACfAwMCbwYNALwEAdMIAAAAnwQDAm8FBQAwBQNPCwAAAG8FDgAwBQRPCwAAAIIAAQAPAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAAYPARgAAAAAAAAAAQAAAAABAAD+AAYAAAABAAAAAgAAAgAAAAEAAAACAAABAAABBwAAAAACAAABAgANowAAAP8AAwAAAAAAbwEAADABALoBAAAAqQEBADABADwCAAAAwAEDADABAOkEAAAAggACAAUDEAMRAxIGAAMPAQABAAEYAAAAAgAAAQAAAgAAEwEAAAAAAQVAN/0Iep8ArYsYdNBHno51WCCJN4Rd/A==

-- https://lua.expert/
return {
	Name = "Vintage Cocoa",
	Mastery = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://89253399145517"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://79497423621285"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://89253399145517"
		BlinkTexture.Texture = "rbxassetid://85011026117801"
	end
}