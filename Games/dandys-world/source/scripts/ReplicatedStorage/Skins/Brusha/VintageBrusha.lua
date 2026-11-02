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
-- CQMgD1BhaW50aW5nVGV4dHVyZRtyYnhhc3NldGlkOi8vOTE2Mjc1NTI0MzIyOTMMU2V0QXR0cmlidXRlBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQhNYXRlcmlhbARFbnVtBE5lb24ccmJ4YXNzZXRpZDovLzEyNzQ3MDY5NjE0Nzk0OAlUZXh0dXJlSUQGQ29sb3IzB2Zyb21SR0IFQ29sb3IPUGFydGljbGVFbWl0dGVyDUNvbG9yU2VxdWVuY2UDbmV3FUNvbG9yU2VxdWVuY2VLZXlwb2ludAZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlDEJsaW5rVGV4dHVyZQ5GaW5kRmlyc3RDaGlsZA1Ob3JtYWxUZXh0dXJlB1RleHR1cmUbcmJ4YXNzZXRpZDovLzc4MDIxMzg3ODY0MzYyHHJieGFzc2V0aWQ6Ly8xMjA0NzgyOTgwODk0NDUJQXBwbHlTa2luDlZpbnRhZ2UgQnJ1c2hhBE5hbWUHTWFzdGVyeQACDwEAAAAAY28DAABvBAEAvAEALgIAAACfAQQBpAEEAAAAMEC8AgBHBQAAAJ8CAgCfAQAEFwE6AG8IBgC8BgX+BwAAAJ8GAwIOBhMATQYFLQgAAACkBwsACiCQwPEGBQAHAAAAbwYMADAGBYQNAAAAZQArAKQGEAAAPOCAjAebAIwImwCMCZsAnwYEAjAGBaQRAAAAZQAiAG8IEgC8BgX+BwAAAJ8GAwIOBh0ApAYVAABQMIH/BwAAAgAAAKQIFwAAUGCBjAkAAKQKEAAAPOCAjAv/AIwM/wCMDf8AnwoEAJ8IAAKkCRcAAFBggYwKAQCkCxAAADzggIwM/wCMDf8AjA7/AJ8LBACfCQAAxQcIAAEAAACfBgICMAYFpBEAAABuAcX/AgAAAG8DGAC8AQDTGQAAAJ8BAwJvBBoAvAIB0xkAAACfAgMCbwUbALwDAQMcAAAAnwMDAm8GHQC8BAEDHAAAAJ8EAwJvBQwAMAUETx4AAABvBR8AMAUCTx4AAAAOAwMAbwUgADAFA08eAAAAggABACEDAQMCAwMDBAQAADBAAwUDBgMHAwgDCQMKBAogkMADCwMMAw0DDgQAPOCAAw8DEAMRAxIEAFAwgQMTBABQYIEDFAMVAxYDFwMYAxkDGgMbAxwABh0BGAAAAAAAAgAAAAAAAAEAAAAAAQAAAAAAAQAAAAIAAAAAAAAAAAIAAAAAAQAAAAEAAAAAAAAAAAABAAAAAAAAAAAAAAD+AAD4AA8AAAABAAAAAQAAAAEAAAACAAABAAACAQAABQkAAAAAAgAAAQIADaMAAAD/AAMAAAAAAG8BAAAwAQC6AQAAAKkBAQAwAQA8AgAAAMABAwAwAQDpBAAAAIIAAgAFAx4DHwMgBgADHQEAAQABGAAAAAIAAAEAAAIAACYBAAAAAAHLYmkzicKmmJZIAnNeEmw1u3p+R/mmAzI=

-- https://lua.expert/
return {
	Name = "Vintage Brusha",
	Mastery = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		p1:SetAttribute("PaintingTexture", "rbxassetid://91627552432293")

		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				if v.Material == Enum.Material.Neon then
					v.Color = Color3.fromRGB(155, 155, 155)

					continue
				end

				v.TextureID = "rbxassetid://127470696147948"

				continue
			end

			if v:IsA("ParticleEmitter") then
				v.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
			end
		end

		local Config = p1:WaitForChild("Config")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local BlinkTexture = Config:FindFirstChild("BlinkTexture")

		Config:FindFirstChild("NormalTexture").Texture = "rbxassetid://127470696147948"
		HurtTexture.Texture = "rbxassetid://78021387864362"

		if not BlinkTexture then
			return
		end

		BlinkTexture.Texture = "rbxassetid://120478298089445"
	end
}