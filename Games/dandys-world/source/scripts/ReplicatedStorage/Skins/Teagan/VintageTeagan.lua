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
-- CQMbBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTAwMTk0NjIyMjExMjgyCVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkDEJsaW5rVGV4dHVyZQtIdXJ0VGV4dHVyZQ1Ob3JtYWxUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMzQzNjIyNDU2MjAwMDcHVGV4dHVyZRxyYnhhc3NldGlkOi8vMTEzMDA4Nzc5NTYzNDAxBEhlYWQJUGFydGljbGVzD1BhcnRpY2xlRW1pdHRlcg1Db2xvclNlcXVlbmNlA25ldxVDb2xvclNlcXVlbmNlS2V5cG9pbnQGQ29sb3IzB2Zyb21SR0IFQ29sb3IQUGFydGljbGVFbWl0dGVyMglBcHBseVNraW4OVmludGFnZSBUZWFnYW4ETmFtZQACDwEAAAAAcaQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvBQoAvAMB0wgAAACfAwMCbwYLALwEAdMIAAAAnwQDAm8FDAAwBQJPDQAAAG8FDgAwBQNPDQAAAG8FBQAwBQRPDQAAAE0FABMPAAAATQUFrhAAAABNBQWjEQAAAKQGFAAATCCB/wcAAAIAAACkCBYAAExQgYwJAACkChkAAGBwgYwLMgCMDDIAjA0yAJ8KBACfCAACpAkWAABMUIGMCgEApAsZAABgcIGMDDIAjA0yAIwOMgCfCwQAnwkAAMUHCAABAAAAnwYCAjAGBaQaAAAATQUAEw8AAABNBQWuEAAAAE0FBQgbAAAApAYUAABMIIH/BwAAAgAAAKQIFgAATFCBjAkAAKQKGQAAYHCBjAsyAIwMMgCMDTIAnwoEAJ8IAAKkCRYAAExQgYwKAQCkCxkAAGBwgYwMMgCMDTIAjA4yAJ8LBACfCQAAxQcIAAEAAACfBgICMAYFpBoAAACCAAEAHAMBBAAAAEADAgMDAwQDBQMGAwcDCAMJAwoDCwMMAw0DDgMPAxADEQMSAxMEAEwggQMUBABMUIEDFQMWBABgcIEDFwMYAAUZARgAAAAAAAAAAQAAAAABAAD+AAYAAAABAAAAAQAAAAEAAAACAAABAAABAAACAAAAAAAAAAAAAQAAAAAAAAAAAAEAAAAAAAAAAAAAAP4AAAQAAAAAAAAAAAABAAAAAAAAAAAAAQAAAAAAAAAAAAAA/gAABAcAAAAAAgAAAQIACqMAAAD/AAIAAAAAAG8BAAAwAQC6AQAAAMABAgAwAQDpAwAAAIIAAgAEAxoDGwYAAxkBAAEAARgAAAACAAACAAAdAQAAAAABy8K4Q1Hmz0iBY67LJREfRLvarzf5BtJC

-- https://lua.expert/
return {
	Name = "Vintage Teagan",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://100194622211282"
			end
		end

		local Config = p1:WaitForChild("Config")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local NormalTexture = Config:WaitForChild("NormalTexture")

		BlinkTexture.Texture = "rbxassetid://134362245620007"
		HurtTexture.Texture = "rbxassetid://113008779563401"
		NormalTexture.Texture = "rbxassetid://100194622211282"
		p1.Head.Particles.ParticleEmitter.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50)) })
		p1.Head.Particles.ParticleEmitter2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50)) })
	end
}