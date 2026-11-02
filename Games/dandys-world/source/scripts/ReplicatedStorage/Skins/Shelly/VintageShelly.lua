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
-- CQMXBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRtyYnhhc3NldGlkOi8vOTgyMTY5NDc5NDI2MTQJVGV4dHVyZUlEBkNvbmZpZwxXYWl0Rm9yQ2hpbGQLSHVydFRleHR1cmUccmJ4YXNzZXRpZDovLzExMTc1MzAzNTI1ODEyOAdUZXh0dXJlDU5vcm1hbFRleHR1cmUMQmxpbmtUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMTY1ODAzMzgzNzA0MTAJQXBwbHlTa2luBEhlYWQKQXR0YWNobWVudA9QYXJ0aWNsZUVtaXR0ZXIERW1pdApVc2VBYmlsaXR5DlZpbnRhZ2UgU2hlbGx5BE5hbWUHTWFzdGVyeQADCQEAAAAAK6QBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvAwoAMAMCTwsAAABvBQwAvAMB0wgAAACfAwMCbwYNALwEAdMIAAAAnwQDAm8FBQAwBQNPCwAAAG8FDgAwBQRPCwAAAIIAAQAPAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAAYPARgAAAAAAAAAAQAAAAABAAD+AAYAAAABAAAAAgAAAgAAAAEAAAACAAABAAABBwAAAAAHAQAAAAARbwMAALwBANMBAAAAnwEDAm8EAgC8AgHTAQAAAJ8CAwJvBQMAvAMC0wEAAACfAwMCjAYCALwEA1YEAAAAnwQDAYIAAQAFAxADCAMRAxIDEwAdFAEYAAAAAAEAAAABAAAAAgAAAAEeAAAAAAIAAAECABCjAAAA/wADAAAAAABvAQAAMAEAugEAAACpAQEAMAEAPAIAAADAAQMAMAEA6QQAAADAAQUAMAEAsgYAAACCAAIABwMVAxYDFwYAAw8GAQMUAgABAQABGAAAAAIAAAEAAAIAABcAAAgBAAAAAAI5nJqsoaIzMBpo771NqmkfSYSN2AtY8K0=

-- https://lua.expert/
return {
	Name = "Vintage Shelly",
	Mastery = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://98216947942614"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://111753035258128"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://98216947942614"
		BlinkTexture.Texture = "rbxassetid://116580338370410"
	end,
	UseAbility = function(p1) --[[ UseAbility | Line: 29 ]]
		p1:WaitForChild("Head"):WaitForChild("Attachment"):WaitForChild("ParticleEmitter"):Emit(2)
	end
}