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
-- CQNMEEh1bWFub2lkUm9vdFBhcnQJVG9vbkxpZ2h0DkZpbmRGaXJzdENoaWxkClBvaW50TGlnaHQGQ29sb3IzB2Zyb21SR0IFQ29sb3IJQXBwbHlTa2luCEh1bWFub2lkDFdhaXRGb3JDaGlsZAZDb25maWcKTW9kdWxlTmFtZQRTaXplAVkJSGlwSGVpZ2h0BVBhcnRzCUFzdHJvUG9vZgVDbG9uZQlUd2VlbkluZm8DbmV3BEVudW0LRWFzaW5nU3R5bGUEUXVhZA9FYXNpbmdEaXJlY3Rpb24CSW4DT3V0CXdvcmtzcGFjZQZQYXJlbnQIQW5jaG9yZWQKQ2FuQ29sbGlkZQhDYW5RdWVyeQpDYXN0U2hhZG93CENhblRvdWNoC1ByaW1hcnlQYXJ0CFBvc2l0aW9uB1ZlY3RvcjMHQWRkSXRlbQxUcmFuc3BhcmVuY3kIUm90YXRpb24GQ3JlYXRlBFBsYXkKVXNlQWJpbGl0eQRnYW1lBkRlYnJpcwpHZXRTZXJ2aWNlEVJlcGxpY2F0ZWRTdG9yYWdlDFR3ZWVuU2VydmljZQ1TY2FybGV0IE5pZ2h0BE5hbWUFQXN0cm8JVG93ZXJOYW1lEk5vIGRlc2NyaXB0aW9uIHlldAtEZXNjcmlwdGlvbgdNYXN0ZXJ5BENvc3QJSGFsbG93ZWVuC0hvbGlkYXlTa2luG3JieGFzc2V0aWQ6Ly84MjYwMDU0NDAwMTI0OAZEZWNvZGUccmJ4YXNzZXRpZDovLzExMjYwMjkwNTc1MjAxNQRJZGxlG3JieGFzc2V0aWQ6Ly84Mjc2NzYxOTkyMTY1NAVRdWlyaxtyYnhhc3NldGlkOi8vNzU4NTYwMjI1MzI3MzYDUnVuG3JieGFzc2V0aWQ6Ly85OTgzMDU2MTEyMzIzNwRXYWxrE092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzc4MzkwOTMxMjYyNzE2BUJsaW5rHHJieGFzc2V0aWQ6Ly8xMjExODEzMDgwODg1MDEESHVydBxyYnhhc3NldGlkOi8vMTIyMDI5MzcyOTUwNjk4Bk5vcm1hbAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAwYBAAAABgMAAAUBBxZNAQBmAAAAAG8DAQC8AQEDAgAAAJ8BAwIOAQ4ATQEAZgAAAABNAQFsAQAAAE0BATkDAAAApAIGAAAUQICMA8gAjAQyAIwFMgCfAgQCMAIBpAcAAACCAAEACAMBAwIDAwMEAwUDBgQAFECAAwcAIggBGAAAAAAAAAABAAAAAAAAAAAAAAAAAAMkAAAAAA8BAwAABwAAAQgLVQFxbwMAALwBANMBAAAAnwEDAm8EAgC8AgDTAQAAAJ8CAwJvBQMAvAMA0wEAAACfAwMCbwYEALwEA9MBAAAAnwQDAk0HAi8GAAAATQcHeAcAAAA+BgcFTQcBFwgAAABDBQYH+wYAAE0GBi8JAAAATQYGPgoAAAC8BgY6CwAAAJ8GAgKkBw4AADTAgIwIBQCkCRIAEUDwwKQKFQAUTPDAjAsAAKkMAACfBwYCpAgOAAA0wICMCQEApAoSABFA8MCkCxcAFkzwwIwMAACpDQAAnwgGAqQJGQAAAIBBMAkGJBoAAACpCQEAMAkGRRsAAACpCQAAMAkG0xwAAACpCQAAMAkGYh0AAACpCQAAMAkGPh4AAACpCQAAMAkG9h8AAABvCSAAMAkGLwYAAABNCgCbIQAAAE0KCjsiAAAAjAwAADkNBQCMDgAATDYAAqQLJAAANDCCnwsEAkMJCgswCQY7IgAAAKQJJwAAmFCCjAr/AIwLVwCMDFcAnwkEAjAJBqQoAAAA+wkBAFILBgCMDAUAvAkJeCkAAACfCQQB+wkCAFILBgBSDAgA4g0vALwJCZYwAAAAnwkFArwKCe4xAAAAnwoCAYIAAQAyAwkDCgMBAwsDDAIAAAAAAAAAQAMNAw4DDwMQAxEDEgMTAxQEADTAgAMVAxYDFwQRQPDAAxgDGQQUTPDAAxoEFkzwwAMbBAAAgEEDHAMdAx4DHwMgAyEHAAAAAAAAgD4AAAAAAAAAAAMiAyMDJAQANDCCAwUDBgQAmFCCAwcDJQcAAHBCAACAPgAAcEIAAAAAAyYCAAAAAAAA8D8DJwcAAAAA5V4vQAAAAAAAAAAACAMGKgAAACssAAAALS4AAAADKAMpACoqARgAAAAAAgAAAAIAAAACAAAAAgAAAAAAAAACAAAAAAAAAAIAAQEAAQABAfsIAAEBAAEAAQH7CQAAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAAAAAAAAAAAAAAAAQAAAAAAAAABAAAAAAABAAAAAAAAAQAAAiwAAAAABgAAAQIAV6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwKkAgEAAAAAQG8EBQC8AgIWAwAAAJ8CAwL/AwUAAAAAAG8EBgAwBAO6BwAAAG8ECAAwBAOHCQAAAG8ECgAwBAPiCwAAAKkEAAAwBAM8DAAAAIwEWAIwBAMjDQAAAKkEAQAwBANpDgAAAKkEAQAwBAO8DwAAAP8EBAAAAAAAbwUQADAFBO4RAAAAbwUSADAFBJITAAAAbwUUADAFBHgVAAAAbwUWADAFBBYXAAAAbwUYADAFBJ8ZAAAAMAQD6RoAAAD/BAMAAAAAAG8FGwAwBQSZHAAAAG8FHQAwBQTFHgAAAG8FHwAwBQQQIAAAADAEAyEhAAAAqQQBADAEA8IiAAAAwAQjADAEA+kkAAAAwAQlABIAAQASAAAAEgACADAEA7ImAAAAggMCACcDKwQAAABAAywDLQMuAy8DMAMxAzIDMwM0AzUDNgM3AzgDOQM6AzsDPAM9Az4DPwNAA0EDQgNDA0QDRQNGA0cDSANJA0oDSwNMBgADCAYBAyoCAAEBAAEYAAAAAAAAAAEAAAAAAAEAAAAAAAIAAgAAAQAAAQAAAQAAAgAAAwAAAQAAAgABAAABAAABAAABAAABAAD7AAgAAQAAAQAAAQAA/QAGAAACAAAIAAAAAAAuAQAAAAACUOm2ZC3wNNQjk47TmsK9QiDxoRBiLdxl

-- https://lua.expert/
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

return {
	Name = "Scarlet Night",
	TowerName = "Astro",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Halloween = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Decode = "rbxassetid://82600544001248",
		Idle = "rbxassetid://112602905752015",
		Quirk = "rbxassetid://82767619921654",
		Run = "rbxassetid://75856022532736",
		Walk = "rbxassetid://99830561123237"
	},
	FaceTextures = {
		Blink = "rbxassetid://78390931262716",
		Hurt = "rbxassetid://121181308088501",
		Normal = "rbxassetid://122029372950698"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 34 ]]
		if not p1.HumanoidRootPart:FindFirstChild("ToonLight") then
			return
		end

		p1.HumanoidRootPart.ToonLight.PointLight.Color = Color3.fromRGB(200, 50, 50)
	end,
	UseAbility = function(p1) --[[ UseAbility | Line: 42 | Upvalues: ReplicatedStorage (copy), Debris (copy), TweenService (copy) ]]
		local Humanoid = p1:WaitForChild("Humanoid")
		local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")

		p1:WaitForChild("Config"):WaitForChild("ModuleName")

		local v2 = ReplicatedStorage.Parts.AstroPoof:Clone()

		TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false)

		local v3 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false)

		v2.Parent = workspace
		v2.Anchored = true
		v2.CanCollide = false
		v2.CanQuery = false
		v2.CastShadow = false
		v2.CanTouch = false
		v2.Size = Vector3.new(0, 0.25, 0)
		v2.Position = p1.PrimaryPart.Position + Vector3.new(0, -(HumanoidRootPart.Size.Y / 2 + Humanoid.HipHeight), 0)
		v2.Color = Color3.fromRGB(255, 87, 87)
		Debris:AddItem(v2, 5)
		TweenService:Create(v2, v3, {
			Size = Vector3.new(60, 0.25, 60),
			Transparency = 1,
			Rotation = Vector3.new(0, 2.740167, 0)
		}):Play()
	end
}