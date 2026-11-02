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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRhyYnhhc3NldGlkOi8vMTc2NzU5ODI5MzgJVGV4dHVyZUlEBkNvbmZpZwxXYWl0Rm9yQ2hpbGQLSHVydFRleHR1cmUccmJ4YXNzZXRpZDovLzEyMDg0MzIxODQ0ODI2NAdUZXh0dXJlDEJsaW5rVGV4dHVyZRxyYnhhc3NldGlkOi8vMTMzNzgzNDgyMTc2OTE2DU5vcm1hbFRleHR1cmUJQXBwbHlTa2luDlZpbnRhZ2UgQm94dGVuBE5hbWUHTWFzdGVyeQACCQEAAAAAK6QBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvAwoAMAMCTwsAAABvBQwAvAMB0wgAAACfAwMCbwQNADAEA08LAAAAbwYOALwEAdMIAAAAnwQDAm8FBQAwBQRPCwAAAIIAAQAPAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAAYPARgAAAAAAAAAAQAAAAABAAD+AAYAAAABAAAAAgAAAQAAAAIAAAEAAAADAAABBwAAAAACAAABAgANowAAAP8AAwAAAAAAbwEAADABALoBAAAAqQEBADABADwCAAAAwAEDADABAOkEAAAAggACAAUDEAMRAxIGAAMPAQABAAEYAAAAAgAAAQAAAgAAFgEAAAAAAcePW/jNrUlg9mGB027R0OO3l0yM9Usx+Q==

-- https://lua.expert/
return {
	Name = "Vintage Boxten",
	Mastery = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://17675982938"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://120843218448264"
		Config:WaitForChild("BlinkTexture").Texture = "rbxassetid://133783482176916"
		Config:WaitForChild("NormalTexture").Texture = "rbxassetid://17675982938"
	end
}