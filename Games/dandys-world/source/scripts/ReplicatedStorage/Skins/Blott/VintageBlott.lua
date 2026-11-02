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
-- CQMYBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRtyYnhhc3NldGlkOi8vODAzOTg5MDMyMjMzNTEJVGV4dHVyZUlEBE5hbWUITGVmdEZvb3QJUmlnaHRGb290AAZDb2xvcjMDbmV3BUNvbG9yBkNvbmZpZwxXYWl0Rm9yQ2hpbGQLSHVydFRleHR1cmUbcmJ4YXNzZXRpZDovLzg1MjU1NzA5MzgyNDA3B1RleHR1cmUNTm9ybWFsVGV4dHVyZQxCbGlua1RleHR1cmUccmJ4YXNzZXRpZDovLzEwMjQ0MjUxNDMwNDU5NQlBcHBseVNraW4MVmludGFnZSBCbG90B01hc3RlcnkAAgoBAAAAAD6kAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXARsAbwgDALwGBf4EAAAAnwYDAg4GAwBvBgUAMAYFhAYAAABNBgW6BwAAAPAGBQAIAAAATQYFugcAAADwBgwACQAAgG8GCgAwBgWEBgAAAKQGDQAAMLCAjAcAAIwIAACMCQAAnwYEAjAGBaQOAAAAbgHk/wIAAABvAw8AvAEA0xAAAACfAQMCbwQRALwCAdMQAAAAnwIDAm8DEgAwAwJPEwAAAG8FFAC8AwHTEAAAAJ8DAwJvBhUAvAQB0xAAAACfBAMCbwUFADAFA08TAAAAbwUWADAFBE8TAAAAggABABcDAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAQAMLCAAw0DDgMPAxADEQMSAxMDFAMVAAYWARgAAAAAAAAAAQAAAAABAAAEAAAAAAAAAAEAAAEAAAAAAAAA+AANAAAAAQAAAAIAAAIAAAABAAAAAgAAAQAAAQcAAAAAAgAAAQIADaMAAAD/AAMAAAAAAG8BAAAwAQC6AQAAAKkBAQAwAQA8AgAAAMABAwAwAQDpBAAAAIIAAgAFAxcDBwMYBgADFgEAAQABGAAAAAIAAAEAAAIAABoBAAAAAAGfcGLnfNKvuBdgDbBaaml072h1k620COY=

-- https://lua.expert/
return {
	Name = "Vintage Blot",
	Mastery = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://80398903223351"
			end

			if v.Name == "LeftFoot" or v.Name == "RightFoot" then
				v.TextureID = ""
				v.Color = Color3.new(0/255, 0/255, 0/255)
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://85255709382407"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://80398903223351"
		BlinkTexture.Texture = "rbxassetid://102442514304595"
	end
}