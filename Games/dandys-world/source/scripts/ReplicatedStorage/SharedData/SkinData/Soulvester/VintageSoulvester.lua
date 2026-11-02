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
-- CQMaBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRBBIdW1hbm9pZFJvb3RQYXJ0DkZpbmRGaXJzdENoaWxkCVRvb25MaWdodApFeHRyYUxpZ2h0ClBvaW50TGlnaHQGQ29sb3IzB2Zyb21SR0IFQ29sb3IJQXBwbHlTa2luElZpbnRhZ2UgU291bHZlc3RlcgROYW1lB01hc3RlcnkTT3ZlcndyaXRlQW5pbWF0aW9ucxxyYnhhc3NldGlkOi8vMTExOTM0NDYyMDkxNzAyHHJieGFzc2V0aWQ6Ly8xMDgwNTY3NDQ4NDczMjIFQmxpbmsccmJ4YXNzZXRpZDovLzEwODEwNTM0NzUyMjI4OQRIdXJ0DlVTRV9TS0lOX01PREVMAAIKAQEAAAYDAAAFAQdEpAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEMAG8IAwC8BgX+BAAAAJ8GAwIOBgcA+wYAAE0GBiEFAAAATQYGEAYAAAAwBgWEBwAAAG4B8/8CAAAAbwMIALwBAAMJAAAAnwEDAlICAQAOAgQAbwQKALwCAQMJAAAAnwIDAlIDAQAOAwQAbwULALwDAQMJAAAAnwMDAlIEAgAOBAQAbwYMALwEAgMJAAAAnwQDAlIFAwAOBQQAbwcMALwFAwMJAAAAnwUDAg4ECACkBg8AADjQgIwH/wCMCP8AjAn/AJ8GBAIwBgSkEAAAAA4FCACkBg8AADjQgIwH/wCMCP8AjAn/AJ8GBAIwBgWkEAAAAIIAAQARAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOBAA40IADDwAREAEYAAAAAAAAAAEAAAAAAQAAAAAAAP4ABgAAAAEAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAIBAAAAAAAAAAIBAAAAAAAAAAMTAAAAAAMAAAECACKjAAAA/wAEAAAAAABvAQAAMAEAugEAAACpAQEAMAEAPAIAAAD/AQAAAAAAADABAOkDAAAA/wEDAAAAAABvAgQAMAIBEAUAAABvAgYAMAIBmQcAAABvAggAMAIBxQkAAAAwAQAhCgAAAKkBAAAwAQDCCwAAAMABDAASAAAAMAEA6Q0AAACCAAIADgMRAxIDEwMUAxUDBgMWAxcDGAMZAwUDGgYAAxABAAEAARgAAAACAAABAAACAAAAAwABAAABAAABAAD9AAYAAAIAAAAZAQAAAAABPW9W3ZowY4GDKx/BDtN2NE13QakPqzzc

-- https://lua.expert/
local t = {
	Name = "Vintage Soulvester",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Normal = "rbxassetid://111934462091702",
		Blink = "rbxassetid://108056744847322",
		Hurt = "rbxassetid://108105347522289"
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

	if v3 then
		v3.Color = Color3.fromRGB(255, 255, 255)
	end

	if not v4 then
		return
	end

	v4.Color = Color3.fromRGB(255, 255, 255)
end

return t