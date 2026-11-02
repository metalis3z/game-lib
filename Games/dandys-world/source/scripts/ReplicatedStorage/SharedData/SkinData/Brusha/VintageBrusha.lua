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
-- CQMgD1BhaW50aW5nVGV4dHVyZRtyYnhhc3NldGlkOi8vOTE2Mjc1NTI0MzIyOTMMU2V0QXR0cmlidXRlBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQhNYXRlcmlhbARFbnVtBE5lb24NU21vb3RoUGxhc3RpYwZDb2xvcjMHZnJvbVJHQgVDb2xvcgxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRA9QYXJ0aWNsZUVtaXR0ZXINQ29sb3JTZXF1ZW5jZQNuZXcVQ29sb3JTZXF1ZW5jZUtleXBvaW50CUFwcGx5U2tpbg5WaW50YWdlIEJydXNoYQROYW1lB01hc3RlcnkTT3ZlcndyaXRlQW5pbWF0aW9ucxxyYnhhc3NldGlkOi8vMTI3NDcwNjk2MTQ3OTQ4HHJieGFzc2V0aWQ6Ly8xMjA0NzgyOTgwODk0NDUFQmxpbmsbcmJ4YXNzZXRpZDovLzc4MDIxMzg3ODY0MzYyBEh1cnQOVVNFX1NLSU5fTU9ERUwAAg8BAQAAAFNvAwAAbwQBALwBAC4CAAAAnwEEAaQBBAAAADBAvAIARwUAAACfAgIAnwEABBcBRABvCAYAvAYF/gcAAACfBgMCDgYdAE0GBS0IAAAApAcLAAogkMDxBgcABwAAAE0GBS0IAAAApAcNAAwgkMCaBgoABwAAAKQGEAAAPOCAjAebAIwImwCMCZsAnwYEAjAGBaQRAAAAZQAqAPsGAABNBgYhEgAAAE0GBhATAAAAMAYFhBQAAABlACIAbwgVALwGBf4HAAAAnwYDAg4GHQCkBhgAAFxggf8HAAACAAAApAgaAABckIGMCQAApAoQAAA84ICMC/8AjAz/AIwN/wCfCgQAnwgAAqQJGgAAXJCBjAoBAKQLEAAAPOCAjAz/AIwN/wCMDv8AnwsEAJ8JAADFBwgAAQAAAJ8GAgIwBgWkEQAAAG4Bu/8CAAAAggABABsDAQMCAwMDBAQAADBAAwUDBgMHAwgDCQMKBAogkMADCwQMIJDAAwwDDQQAPOCAAw4DDwMQAxEDEgMTAxQEAFxggQMVBABckIEAERYBGAAAAAAAAgAAAAAAAAEAAAAAAQAAAAAAAAAAAAAAAQAAAAAAAAAAAgAAAAAAAAACAAAAAAEAAAABAAAAAAAAAAAAAQAAAAAAAAAAAAAA/gAA+AAPFAAAAAADAAABAgAiowAAAP8ABAAAAAAAbwEAADABALoBAAAAqQEBADABADwCAAAA/wEAAAAAAAAwAQDpAwAAAP8BAwAAAAAAbwIEADACARAFAAAAbwIGADACAZkHAAAAbwIIADACAcUJAAAAMAEAIQoAAACpAQAAMAEAwgsAAADAAQwAEgAAADABAOkNAAAAggACAA4DFwMYAxkDGgMbAxADHAMdAx4DHwMPAyAGAAMWAQABAAEYAAAAAgAAAQAAAgAAAAMAAQAAAQAAAQAA/QAGAAACAAAAGAEAAAAAATol7Kd0XXedduwyrvNnA4FKPfvTCOGGpg==

-- https://lua.expert/
local t = {
	Name = "Vintage Brusha",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Normal = "rbxassetid://127470696147948",
		Blink = "rbxassetid://120478298089445",
		Hurt = "rbxassetid://78021387864362"
	},
	USE_SKIN_MODEL = false
}

function t.ApplySkin(p1) --[[ ApplySkin | Line: 17 | Upvalues: t (copy) ]]
	p1:SetAttribute("PaintingTexture", "rbxassetid://91627552432293")

	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") then
			if v.Material == Enum.Material.Neon or v.Material == Enum.Material.SmoothPlastic then
				v.Color = Color3.fromRGB(155, 155, 155)

				continue
			end

			v.TextureID = t.FaceTextures.Normal

			continue
		end

		if v:IsA("ParticleEmitter") then
			v.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
		end
	end
end

return t