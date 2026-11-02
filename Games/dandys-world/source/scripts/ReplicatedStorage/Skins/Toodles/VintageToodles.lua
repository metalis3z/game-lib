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
-- CQMRBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTA0MTEyMDI4NzM4NzExCVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkDEJsaW5rVGV4dHVyZQtIdXJ0VGV4dHVyZQ1Ob3JtYWxUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMzU0MzQ1MTY2OTg3MDEHVGV4dHVyZRxyYnhhc3NldGlkOi8vMTIxMTEwMDk1ODg1NTg3CUFwcGx5U2tpbg9WaW50YWdlIFRvb2RsZXMETmFtZQACCQEAAAAAK6QBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvBQoAvAMB0wgAAACfAwMCbwYLALwEAdMIAAAAnwQDAm8FDAAwBQJPDQAAAG8FDgAwBQNPDQAAAG8FBQAwBQRPDQAAAIIAAQAPAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAAUPARgAAAAAAAAAAQAAAAABAAD+AAYAAAABAAAAAQAAAAEAAAACAAABAAABAAABBgAAAAACAAABAgAKowAAAP8AAgAAAAAAbwEAADABALoBAAAAwAECADABAOkDAAAAggACAAQDEAMRBgADDwEAAQABGAAAAAIAAAIAABMBAAAAAAHwOD3LdDq28IL3hBScS08JgCAqv8L8V8o=

-- https://lua.expert/
return {
	Name = "Vintage Toodles",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://104112028738711"
			end
		end

		local Config = p1:WaitForChild("Config")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local NormalTexture = Config:WaitForChild("NormalTexture")

		BlinkTexture.Texture = "rbxassetid://135434516698701"
		HurtTexture.Texture = "rbxassetid://121110095885587"
		NormalTexture.Texture = "rbxassetid://104112028738711"
	end
}