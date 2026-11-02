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
-- CQMaBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRBBIdW1hbm9pZFJvb3RQYXJ0DkZpbmRGaXJzdENoaWxkCVRvb25MaWdodApFeHRyYUxpZ2h0ClBvaW50TGlnaHQGQ29sb3IzB2Zyb21SR0IFQ29sb3IJQXBwbHlTa2luC1ZpbnRhZ2UgVmVlBE5hbWUHTWFzdGVyeRNPdmVyd3JpdGVBbmltYXRpb25zG3JieGFzc2V0aWQ6Ly85MTE5NzkyMDM1MTkxMAVCbGluaxtyYnhhc3NldGlkOi8vOTA0MDcxOTIyNzgwNjcESHVydBxyYnhhc3NldGlkOi8vMTI5NzUzMzM1ODE3MDEzDlVTRV9TS0lOX01PREVMAAIKAQEAAAA+pAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEMAG8IAwC8BgX+BAAAAJ8GAwIOBgcA+wYAAE0GBiEFAAAATQYGEAYAAAAwBgWEBwAAAG4B8/8CAAAAbwMIALwBAAMJAAAAnwEDAlICAQAOAgQAbwQKALwCAQMJAAAAnwIDAlIDAQAOAwQAbwULALwDAQMJAAAAnwMDAlIEAgAOBAQAbwYMALwEAgMJAAAAnwQDAlIFAwAOBQQAbwcMALwFAwMJAAAAnwUDAqQGDwAAONCAjAfPAIwIzwCMCc8AnwYEAg4EAgAwBgSkEAAAAA4FAgAwBgWkEAAAAIIAAQARAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOBAA40IADDwAREAEYAAAAAAAAAAEAAAAAAQAAAAAAAP4ABgAAAAEAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAIAAAAAAAIBAAIBAAMTAAAAAAMAAAECACKjAAAA/wAEAAAAAABvAQAAMAEAugEAAACpAQEAMAEAPAIAAAD/AQAAAAAAADABAOkDAAAA/wEDAAAAAABvAgQAMAIBmQUAAABvAgYAMAIBxQcAAABvAggAMAIBEAkAAAAwAQAhCgAAAKkBAAAwAQDCCwAAAMABDAASAAAAMAEA6Q0AAACCAAIADgMRAxIDEwMUAxUDFgMXAxgDGQMGAwUDGgYAAxABAAEAARgAAAACAAABAAACAAAAAwABAAABAAABAAD9AAYAAAIAAAAZAQAAAAABfckU2lT7lD5jHgDwpsmBAg3RA65PDX7b

-- https://lua.expert/
local t = {
	Name = "Vintage Vee",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Blink = "rbxassetid://91197920351910",
		Hurt = "rbxassetid://90407192278067",
		Normal = "rbxassetid://129753335817013"
	},
	USE_SKIN_MODEL = false
}

function t.ApplySkin(p1) --[[ ApplySkin | Line: 17 | Upvalues: t (copy) ]]
	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") then
			v.TextureID = t.FaceTextures.Normal
		end
	end

	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
	local v1 = if HumanoidRootPart then HumanoidRootPart:FindFirstChild("ToonLight") else HumanoidRootPart
	local v2 = if HumanoidRootPart then HumanoidRootPart:FindFirstChild("ExtraLight") else HumanoidRootPart
	local v3 = if v1 then v1:FindFirstChild("PointLight") else v1
	local v4 = if v2 then v2:FindFirstChild("PointLight") else v2
	local v5 = Color3.fromRGB(207, 207, 207)

	if v3 then
		v3.Color = v5
	end

	if not v4 then
		return
	end

	v4.Color = v5
end

return t