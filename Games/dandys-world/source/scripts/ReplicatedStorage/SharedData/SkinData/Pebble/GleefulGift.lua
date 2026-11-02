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
-- CQNLCUFwcGx5U2tpbghIdW1hbm9pZAxXYWl0Rm9yQ2hpbGQQSHVtYW5vaWRSb290UGFydARTaXplAVkJSGlwSGVpZ2h0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UFUGFydHMPUG9vZlBlYmJsZVNraW5zBUNsb25lBkNvbG9yMwdmcm9tUkdCBUNvbG9yCVR3ZWVuSW5mbwNuZXcERW51bQtFYXNpbmdTdHlsZQRRdWFkD0Vhc2luZ0RpcmVjdGlvbgJJbgdFbGFzdGljA091dAl3b3Jrc3BhY2UGUGFyZW50CEFuY2hvcmVkCkNhbkNvbGxpZGUIQ2FuUXVlcnkKQ2FzdFNoYWRvdwhDYW5Ub3VjaAtQcmltYXJ5UGFydAhQb3NpdGlvbgdWZWN0b3IzB0FkZEl0ZW0GQ3JlYXRlBFBsYXkMVHJhbnNwYXJlbmN5CFJvdGF0aW9uClVzZUFiaWxpdHkMR2xlZWZ1bCBHaWZ0BE5hbWUGUGViYmxlCVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQRDb3N0CERhdGVUaW1lEWZyb21Vbml2ZXJzYWxUaW1lB1VubG9ja3MJQ2hyaXN0bWFzC0hvbGlkYXlTa2luG3JieGFzc2V0aWQ6Ly83MTAwOTgyOTY3Mjc4NwNSdW4ccmJ4YXNzZXRpZDovLzEyNDE1NTY4MTIyODY4NQRXYWxrHHJieGFzc2V0aWQ6Ly8xMDA4MzQ3NTg3ODA0MzcESWRsZRtyYnhhc3NldGlkOi8vODc3ODQ4OTgzMTcxMTYFUXVpcmsccmJ4YXNzZXRpZDovLzEyMjk3NDc5OTk5ODA1MwZEZWNvZGUTT3ZlcndyaXRlQW5pbWF0aW9ucxtyYnhhc3NldGlkOi8vNzEwOTIyNjE1OTUxMjgGTm9ybWFsHHJieGFzc2V0aWQ6Ly8xMjc5ODEyMzg1NjAyMzcFQmxpbmsbcmJ4YXNzZXRpZDovLzk1NjIyODQ2MzIyMzk2BEh1cnQMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMDFR3ZWVuU2VydmljZQpHZXRTZXJ2aWNlBkRlYnJpcwADAQEAAAAGAwAABQEHAYIAAQAAAB8BARgAIwAAAAAOAQIAAAcAAAEICmYBhAFvAwAAvAEA0wEAAACfAQMCbwQCALwCANMBAAAAnwIDAk0FAi8EAAAATQUFeAUAAAA+BAUDTQUBFwYAAABDAwQFpAQIAAAAcEBNBAQ/CQAAAG8GCgC8BATTAQAAAJ8EAwJvBgsAvAQE0wEAAACfBAMCvAQEOgwAAACfBAICpAUPAAA40ICMBjQAjAeBAIwIMwCfBQQCMAUEpBAAAACkBRMAAEgQgYwGBQCkBxcAFlRAwaQIGgAZYEDBjAkAAKkKAACfBQYCpAYTAABIEIGMBwEApAgcABtUQMGkCR4AHWBAwYwKAACpCwAAnwYGAqQHEwAASBCBjAgBAKQJFwAWVEDBpAoeAB1gQMGMCwAAqQwAAJ8HBgKkCCAAAADwQTAIBCQhAAAAqQgBADAIBEUiAAAAqQgAADAIBNMjAAAAqQgAADAIBGIkAAAAqQgAADAIBD4lAAAAqQgAADAIBPYmAAAAbwgnADAIBC8EAAAATQkAmygAAABNCQk7KQAAAIwLAAA5DAMAjA0AAEw2AAKkCisAAEiggp8KBAJDCAkKMAgEOykAAAD7CAAAUgoEAIwLBQC8CAh4LAAAAJ8IBAH7CAEAUgoEAFILBgDiDC4AvAgIli8AAACfCAUCvAkI7jAAAACfCQIB+wkBAFILBABSDAcA4g01ALwJCZYvAAAAnwkFArwKCe4wAAAAnwoCAYIAAQA2AwIDAwMEAgAAAAAAAABAAwUDBgMHAwgEAABwQAMJAwoDCwMMAw0DDgQAONCAAw8DEAMRBABIEIEDEgMTAxQEFlRAwQMVAxYEGWBAwQMXBBtUQMEDGAQdYEDBAxkEAADwQQMaAxsDHAMdAx4DHwcAAAAAAACAPgAAAAAAAAAAAyADIQMiBABIoIIDIwcAADRCAACAPgAANEIAAAAACAEELQAAAAMkAyUDJgIAAAAAAADwPwMnBwAAAADlXi9AAAAAAAAAAAAIAjEyAAAAMzQAAAAAKCgBGAAAAAACAAAAAgAAAAAAAAACAAAAAAAAAAAAAAAAAAABAAAAAAAAAAEAAQEAAQABAfsIAAEBAAEAAQH7CAABAQABAAEB+wgAAAABAAABAAABAAABAAABAAABAAABAAAAAAAAAAAAAAAAAAEAAAAAAAEAAAAAAAABAAABAAAAAAAAAQAAASoAAAAACAAAAQIAW6MAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCHAwAAAG8BBAAwAQDiBQAAAKkBAAAwAQA8BgAAAIwBWAIwAQAjBwAAAKQBCgAAJICAjALpB4wDDACMBBMAjAUUAIwGAACMBwAAnwEHAjABAFELAAAAqQEBADABAK0MAAAAqQEBADABALwNAAAA/wEEAAAAAABvAg4AMAIBFg8AAABvAhAAMAIBnxEAAABvAhIAMAIBkhMAAABvAhQAMAIBeBUAAABvAhYAMAIB7hcAAAAwAQDpGAAAAP8BAwAAAAAAbwIZADACARAaAAAAbwIbADACAZkcAAAAbwIdADACAcUeAAAAMAEAIR8AAACpAQEAMAEAwiAAAADAASEAMAEA6SIAAACkASQAAAAwQm8DJQC8AQEWJgAAAJ8BAwKkAiQAAAAwQm8EJwC8AgIWJgAAAJ8CAwLAAygAEgACABIAAQAwAwCyKQAAAIIAAgAqAykDKgMrAywDLQMuAy8DMAMxAzIEACSAgAMzAzQDNQM2AzcDOAM5AzoDOwM8Az0DPgM/A0ADQQNCA0MDRANFA0YDRwNIBgADAQMIBAAAMEIDSQNKA0sGAQMoAgABAQABGAAAAAIAAAEAAAEAAAEAAAIAAAEAAAAAAAAAAAAAAwAAAQAAAgABAAABAAABAAABAAABAAD7AAgAAQAAAQAAAQAA/QAGAAACAAAGAAAAAAABAAAAAAACAAAAADEBAAAAAAIQAqBkz9+0VmmyxZoSVUYGYBq3ECLGymU=

-- https://lua.expert/
local t = {
	Name = "Gleeful Gift",
	TowerName = "Pebble",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Unlocks = DateTime.fromUniversalTime(2025, 12, 19, 20, 0, 0),
	Christmas = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://71009829672787",
		Walk = "rbxassetid://124155681228685",
		Idle = "rbxassetid://100834758780437",
		Quirk = "rbxassetid://87784898317116",
		Decode = "rbxassetid://122974799998053"
	},
	FaceTextures = {
		Normal = "rbxassetid://71092261595128",
		Blink = "rbxassetid://127981238560237",
		Hurt = "rbxassetid://95622846322396"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 31 ]] end
}
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

function t.UseAbility(p1) --[[ UseAbility | Line: 40 | Upvalues: Debris (copy), TweenService (copy) ]]
	local Humanoid = p1:WaitForChild("Humanoid")
	local v1 = p1:WaitForChild("HumanoidRootPart").Size.Y / 2 + Humanoid.HipHeight
	local v2 = game.ReplicatedStorage:WaitForChild("Parts"):WaitForChild("PoofPebbleSkins"):Clone()

	v2.Color = Color3.fromRGB(52, 129, 51)
	TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false)

	local v3 = TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false)
	local v4 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false)

	v2.Parent = workspace
	v2.Anchored = true
	v2.CanCollide = false
	v2.CanQuery = false
	v2.CastShadow = false
	v2.CanTouch = false
	v2.Size = Vector3.new(0, 0.25, 0)
	v2.Position = p1.PrimaryPart.Position + Vector3.new(0, -v1, 0)
	Debris:AddItem(v2, 5)
	TweenService:Create(v2, v3, {
		Size = Vector3.new(45, 0.25, 45)
	}):Play()
	TweenService:Create(v2, v4, {
		Transparency = 1,
		Rotation = Vector3.new(0, 2.740167, 0)
	}):Play()
end

return t