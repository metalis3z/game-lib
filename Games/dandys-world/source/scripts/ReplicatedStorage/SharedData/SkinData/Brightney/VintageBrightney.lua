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
-- CQMbBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRFEb250Q2hhbmdlVGV4dHVyZQZIYXNUYWcMRmFjZVRleHR1cmVzBk5vcm1hbAlUZXh0dXJlSUQPUGFydGljbGVFbWl0dGVyDUNvbG9yU2VxdWVuY2UDbmV3FUNvbG9yU2VxdWVuY2VLZXlwb2ludAZDb2xvcjMHZnJvbVJHQgVDb2xvcglBcHBseVNraW4RVmludGFnZSBCcmlnaHRuZXkETmFtZQdNYXN0ZXJ5E092ZXJ3cml0ZUFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzEyMjMzMzIzMjczMTY5MxxyYnhhc3NldGlkOi8vMTMwMzU5NjE1MjA4Njk1BUJsaW5rHHJieGFzc2V0aWQ6Ly8xMjEwODk4MzMwODQ3ODcESHVydA5VU0VfU0tJTl9NT0RFTAACDwEBAAAAPqQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBNABvCAMAvAYF/gQAAACfBgMCDgYNAG8IBQC8BgXeBgAAAJ8GAwIrBggA+wYAAE0GBiEHAAAATQYGEAgAAAAwBgWECQAAAGUAIgBvCAoAvAYF/gQAAACfBgMCDgYdAKQGDQAAMLCA/wcAAAIAAACkCA8AADDggIwJAACkChIAAEQAgYwL/wCMDP8AjA3/AJ8KBACfCAACpAkPAAAw4ICMCgEApAsSAABEAIGMDP8AjA3/AIwO/wCfCwQAnwkAAMUHCAABAAAAnwYCAjAGBaQTAAAAbgHL/wIAAACCAAEAFAMBBAAAAEADAgMDAwQDBQMGAwcDCAMJAwoDCwMMBAAwsIADDQQAMOCAAw4DDwQARACBAxAAEREBGAAAAAAAAAABAAAAAAAAAAAAAQAAAAAAAAABAAAAAAEAAAABAAAAAAAAAAAAAQAAAAAAAAAAAAAA/gAA/AALEwAAAAADAAABAgAiowAAAP8ABAAAAAAAbwEAADABALoBAAAAqQEBADABADwCAAAA/wEAAAAAAAAwAQDpAwAAAP8BAwAAAAAAbwIEADACARAFAAAAbwIGADACAZkHAAAAbwIIADACAcUJAAAAMAEAIQoAAACpAQAAMAEAwgsAAADAAQwAEgAAADABAOkNAAAAggACAA4DEgMTAxQDFQMWAwgDFwMYAxkDGgMHAxsGAAMRAQABAAEYAAAAAgAAAQAAAgAAAAMAAQAAAQAAAQAA/QAGAAACAAAAEQEAAAAAAVFGA3OOd3S10yS8r5X9MlAhXhQHY4Jpcg==

-- https://lua.expert/
local t = {
	Name = "Vintage Brightney",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Normal = "rbxassetid://122333232731693",
		Blink = "rbxassetid://130359615208695",
		Hurt = "rbxassetid://121089833084787"
	},
	USE_SKIN_MODEL = false
}

function t.ApplySkin(p1) --[[ ApplySkin | Line: 17 | Upvalues: t (copy) ]]
	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") and not v:HasTag("DontChangeTexture") then
			v.TextureID = t.FaceTextures.Normal

			continue
		end

		if v:IsA("ParticleEmitter") then
			v.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
		end
	end
end

return t