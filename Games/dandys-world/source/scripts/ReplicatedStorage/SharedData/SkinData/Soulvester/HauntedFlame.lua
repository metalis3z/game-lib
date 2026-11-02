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
-- CQMmEEh1bWFub2lkUm9vdFBhcnQORmluZEZpcnN0Q2hpbGQJVG9vbkxpZ2h0CkV4dHJhTGlnaHQKUG9pbnRMaWdodAZDb2xvcjMHZnJvbVJHQgVDb2xvcglBcHBseVNraW4NSGF1bnRlZCBGbGFtZQROYW1lClNvdWx2ZXN0ZXIJVG93ZXJOYW1lEk5vIGRlc2NyaXB0aW9uIHlldAtEZXNjcmlwdGlvbgdNYXN0ZXJ5BENvc3QJSGFsbG93ZWVuC0hvbGlkYXlTa2luHHJieGFzc2V0aWQ6Ly8xMzMyNTM2Nzg1NzY5MzcDUnVuG3JieGFzc2V0aWQ6Ly83MDUyMDIzODAwODk2MQRXYWxrG3JieGFzc2V0aWQ6Ly84NzYxOTU1NTQ5MDA5OQRJZGxlG3JieGFzc2V0aWQ6Ly85ODM4MTc4OTUxMzY5MwVRdWlyaxxyYnhhc3NldGlkOi8vMTA5MjEzMzg1NTIwMDUzBkRlY29kZRNPdmVyd3JpdGVBbmltYXRpb25zG3JieGFzc2V0aWQ6Ly83NTM4NzEwMTEwMzI4OAZOb3JtYWwccmJ4YXNzZXRpZDovLzExOTg1MzQ3MzM1MzExMQVCbGluaxxyYnhhc3NldGlkOi8vMTI4MjQzOTcyMzI1ODQxBEh1cnQMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMAAIKAQAAAAYDAAAFAQcvbwMAALwBAAMBAAAAnwEDAlICAQAOAgQAbwQCALwCAQMBAAAAnwIDAlIDAQAOAwQAbwUDALwDAQMBAAAAnwMDAlIEAgAOBAQAbwYEALwEAgMBAAAAnwQDAlIFAwAOBQQAbwcEALwFAwMBAAAAnwUDAg4ECACkBgcAABhQgIwH8ACMCNIAjAn1AJ8GBAIwBgSkCAAAAA4FCACkBgcAABhQgIwH8ACMCNIAjAn1AJ8GBAIwBgWkCAAAAIIAAQAJAwEDAgMDAwQDBQMGAwcEABhQgAMIAB4JARgAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAgEAAAAAAAAAAgEAAAAAAAAAAyAAAAAAAwAAAQIAP6MAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCHAwAAAG8BBAAwAQDiBQAAAKkBAAAwAQA8BgAAAIwBWAIwAQAjBwAAAKkBAQAwAQBpCAAAAKkBAQAwAQC8CQAAAP8BBAAAAAAAbwIKADACARYLAAAAbwIMADACAZ8NAAAAbwIOADACAZIPAAAAbwIQADACAXgRAAAAbwISADACAe4TAAAAMAEA6RQAAAD/AQMAAAAAAG8CFQAwAgEQFgAAAG8CFwAwAgGZGAAAAG8CGQAwAgHFGgAAADABACEbAAAAqQEBADABAMIcAAAAwAEdADABAOkeAAAAggACAB8DCgMLAwwDDQMOAw8DEAMRAxIDEwMUAxUDFgMXAxgDGQMaAxsDHAMdAx4DHwMgAyEDIgMjAyQDJQMmBgADCQEAAQABGAAAAAIAAAEAAAEAAAEAAAIAAAMAAAEAAAIAAQAAAQAAAQAAAQAAAQAA+wAIAAEAAAEAAAEAAP0ABgAAAgAAEQEAAAAAAaXgZMDQYHMO3rSqBIHEK4PV+HO0lyQOwQ==

-- https://lua.expert/
return {
	Name = "Haunted Flame",
	TowerName = "Soulvester",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Halloween = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://133253678576937",
		Walk = "rbxassetid://70520238008961",
		Idle = "rbxassetid://87619555490099",
		Quirk = "rbxassetid://98381789513693",
		Decode = "rbxassetid://109213385520053"
	},
	FaceTextures = {
		Normal = "rbxassetid://75387101103288",
		Blink = "rbxassetid://119853473353111",
		Hurt = "rbxassetid://128243972325841"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 30 ]]
		local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
		local v1 = if HumanoidRootPart then HumanoidRootPart:FindFirstChild("ToonLight") else HumanoidRootPart
		local v2 = if HumanoidRootPart then HumanoidRootPart:FindFirstChild("ExtraLight") else HumanoidRootPart
		local v3 = if v1 then v1:FindFirstChild("PointLight") else v1
		local v4 = if v2 then v2:FindFirstChild("PointLight") else v2

		if v3 then
			v3.Color = Color3.fromRGB(240, 210, 245)
		end

		if not v4 then
			return
		end

		v4.Color = Color3.fromRGB(240, 210, 245)
	end
}