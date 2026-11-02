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
-- CQMcBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRARIZWFkCVBhcnRpY2xlcw9QYXJ0aWNsZUVtaXR0ZXINQ29sb3JTZXF1ZW5jZQNuZXcVQ29sb3JTZXF1ZW5jZUtleXBvaW50BkNvbG9yMwdmcm9tUkdCBUNvbG9yEFBhcnRpY2xlRW1pdHRlcjIJQXBwbHlTa2luDlZpbnRhZ2UgVGVhZ2FuBE5hbWUHTWFzdGVyeRNPdmVyd3JpdGVBbmltYXRpb25zHHJieGFzc2V0aWQ6Ly8xMzQzNjIyNDU2MjAwMDcFQmxpbmsccmJ4YXNzZXRpZDovLzExMzAwODc3OTU2MzQwMQRIdXJ0HHJieGFzc2V0aWQ6Ly8xMDAxOTQ2MjIyMTEyODIOVVNFX1NLSU5fTU9ERUwAAgsBAQAABgMAAAUBB1ykAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQwAbwgDALwGBf4EAAAAnwYDAg4GBwD7BgAATQYGIQUAAABNBgYQBgAAADAGBYQHAAAAbgHz/wIAAABNAQATCAAAAE0BAa4JAAAATQEBowoAAACkAg0AADCwgP8DAAACAAAApAQPAAAw4ICMBQAApAYSAABEAIGMBzIAjAgyAIwJMgCfBgQAnwQAAqQFDwAAMOCAjAYBAKQHEgAARACBjAgyAIwJMgCMCjIAnwcEAJ8FAADFAwQAAQAAAJ8CAgIwAgGkEwAAAE0BABMIAAAATQEBrgkAAABNAQEIFAAAAKQCDQAAMLCA/wMAAAIAAACkBA8AADDggIwFAACkBhIAAEQAgYwHMgCMCDIAjAkyAJ8GBACfBAACpAUPAAAw4ICMBgEApAcSAABEAIGMCDIAjAkyAIwKMgCfBwQAnwUAAMUDBAABAAAAnwICAjACAaQTAAAAggABABUDAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAQAMLCAAw0EADDggAMOAw8EAEQAgQMQAxEAERIBGAAAAAAAAAABAAAAAAEAAAAAAAD+AAYAAAAAAAAAAAABAAAAAAAAAAAAAQAAAAAAAAAAAAAA/gAABQAAAAAAAAAAAAEAAAAAAAAAAAABAAAAAAAAAAAAAAD+AAAEEwAAAAADAAABAgAiowAAAP8ABAAAAAAAbwEAADABALoBAAAAqQEBADABADwCAAAA/wEAAAAAAAAwAQDpAwAAAP8BAwAAAAAAbwIEADACAZkFAAAAbwIGADACAcUHAAAAbwIIADACARAJAAAAMAEAIQoAAACpAQAAMAEAwgsAAADAAQwAEgAAADABAOkNAAAAggACAA4DEwMUAxUDFgMXAxgDGQMaAxsDBgMFAxwGAAMSAQABAAEYAAAAAgAAAQAAAgAAAAMAAQAAAQAAAQAA/QAGAAACAAAAFQEAAAAAATxYLdPoo2PRl0bCQExLQNdMQDqnDpxH0g==

-- https://lua.expert/
local t = {
	Name = "Vintage Teagan",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Blink = "rbxassetid://134362245620007",
		Hurt = "rbxassetid://113008779563401",
		Normal = "rbxassetid://100194622211282"
	},
	USE_SKIN_MODEL = false
}

function t.ApplySkin(p1) --[[ ApplySkin | Line: 17 | Upvalues: t (copy) ]]
	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") then
			v.TextureID = t.FaceTextures.Normal
		end
	end

	p1.Head.Particles.ParticleEmitter.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50)) })
	p1.Head.Particles.ParticleEmitter2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50)) })
end

return t