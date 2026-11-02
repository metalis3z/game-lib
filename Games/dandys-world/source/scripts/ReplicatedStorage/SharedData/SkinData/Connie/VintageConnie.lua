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
-- CQMcBkNvbG9yMwdmcm9tUkdCBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAVDb2xvcg1Db2xvclNlcXVlbmNlA25ldxVDb2xvclNlcXVlbmNlS2V5cG9pbnQOQWx0ZXJuYXRlQ29sb3IMU2V0QXR0cmlidXRlEEh1bWFub2lkUm9vdFBhcnQFTGlnaHQJQXBwbHlTa2luDlZpbnRhZ2UgQ29ubmllBE5hbWUHTWFzdGVyeRNPdmVyd3JpdGVBbmltYXRpb25zG3JieGFzc2V0aWQ6Ly85MDI5OTc4MTk5NDAyMAVCbGluaxxyYnhhc3NldGlkOi8vMTIxNjEzNjUxODkwNDgxBEh1cnQbcmJ4YXNzZXRpZDovLzkzMjU5NDE0NjAxOTAyDlVTRV9TS0lOX01PREVMAAILAQEAAAYDAAAFAQdGpAECAAAEAICMAs8AjAPPAIwEzwCfAQQCpAIEAAAAMEC8AwBHBQAAAJ8DAgCfAgAEFwIOAG8JBgC8Bwb+BwAAAJ8HAwIOBwkA+wcAAE0HByEIAAAATQcHEAkAAAAwBwaECgAAADABBqQLAAAAbgLx/wIAAACkAg4AADTAgP8DAAACAAAApAQQAAA08ICMBQAAUgYBAJ8EAwKkBRAAADTwgIwGAQBSBwEAnwUDAMUDBAABAAAAnwICAm8FEQBSBgIAvAMALhIAAACfAwQBpAMEAAAAMEBNBABmEwAAALwEBEcFAAAAnwQCAJ8DAAQXAwcAbwoUALwIB/4HAAAAnwgDAg4IAgAwAQekCwAAAG4D+P8CAAAAggABABUDAQMCBAAEAIADAwQAADBAAwQDBQMGAwcDCAMJAwoDCwMMBAA0wIADDQQANPCAAw4DDwMQAxEAERIBGAAAAAAAAAIAAAAAAAABAAAAAAEAAAAAAAABAP0ABwAAAAEAAAAAAQAAAAAAAP4FAAAAAAIAAAAAAAAAAAEAAAAAAQD+AAYTAAAAAAMAAAECACKjAAAA/wAEAAAAAABvAQAAMAEAugEAAACpAQEAMAEAPAIAAAD/AQAAAAAAADABAOkDAAAA/wEDAAAAAABvAgQAMAIBmQUAAABvAgYAMAIBxQcAAABvAggAMAIBEAkAAAAwAQAhCgAAAKkBAAAwAQDCCwAAAMABDAASAAAAMAEA6Q0AAACCAAIADgMTAxQDFQMWAxcDGAMZAxoDGwMIAwcDHAYAAxIBAAEAARgAAAACAAABAAACAAAAAwABAAABAAABAAD9AAYAAAIAAAAaAQAAAAABzmNgLD4Et0vQKp9tYtOkKr57d1j8pwot

-- https://lua.expert/
local t = {
	Name = "Vintage Connie",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Blink = "rbxassetid://90299781994020",
		Hurt = "rbxassetid://121613651890481",
		Normal = "rbxassetid://93259414601902"
	},
	USE_SKIN_MODEL = false
}

function t.ApplySkin(p1) --[[ ApplySkin | Line: 17 | Upvalues: t (copy) ]]
	local v1 = Color3.fromRGB(207, 207, 207)

	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") then
			v.TextureID = t.FaceTextures.Normal
			v.Color = v1
		end
	end

	p1:SetAttribute("AlternateColor", (ColorSequence.new({ ColorSequenceKeypoint.new(0, v1), ColorSequenceKeypoint.new(1, v1) })))

	for k, v in pairs(p1.HumanoidRootPart:GetDescendants()) do
		if v:IsA("Light") then
			v.Color = v1
		end
	end
end

return t