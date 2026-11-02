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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTA2Mzg5MDMxNTI4OTE0CVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkDU5vcm1hbFRleHR1cmULSHVydFRleHR1cmUMQmxpbmtUZXh0dXJlB1RleHR1cmUbcmJ4YXNzZXRpZDovLzg1OTU2Mzg2Mzk4NzQ1G3JieGFzc2V0aWQ6Ly84NDk4MDczNTAyNTQ1OAlBcHBseVNraW4PVmludGFnZSBSaWJlY2NhBE5hbWUHTWFzdGVyeQACCQEAAAAAK6QBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvBQoAvAMB0wgAAACfAwMCbwYLALwEAdMIAAAAnwQDAm8FBQAwBQJPDAAAAG8FDQAwBQNPDAAAAG8FDgAwBQRPDAAAAIIAAQAPAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAAYPARgAAAAAAAAAAQAAAAABAAD+AAYAAAABAAAAAQAAAAEAAAACAAABAAABAAABBwAAAAACAAABAgANowAAAP8AAwAAAAAAbwEAADABALoBAAAAqQEBADABADwCAAAAwAEDADABAOkEAAAAggACAAUDEAMRAxIGAAMPAQABAAEYAAAAAgAAAQAAAgAAEwEAAAAAAXjZnoZU/MRYt0ExzHCBFyQIwYnySh30hw==

-- https://lua.expert/
return {
	Name = "Vintage Ribecca",
	Mastery = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://106389031528914"
			end
		end

		local Config = p1:WaitForChild("Config")
		local NormalTexture = Config:WaitForChild("NormalTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://106389031528914"
		HurtTexture.Texture = "rbxassetid://85956386398745"
		BlinkTexture.Texture = "rbxassetid://84980735025458"
	end
}