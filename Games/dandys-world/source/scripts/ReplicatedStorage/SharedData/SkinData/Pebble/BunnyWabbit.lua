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
-- CQNNCUFwcGx5U2tpbghIdW1hbm9pZAxXYWl0Rm9yQ2hpbGQQSHVtYW5vaWRSb290UGFydARTaXplAVkJSGlwSGVpZ2h0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UFUGFydHMPUG9vZlBlYmJsZVNraW5zBUNsb25lBkNvbG9yMwdmcm9tUkdCBUNvbG9yCVR3ZWVuSW5mbwNuZXcERW51bQtFYXNpbmdTdHlsZQRRdWFkD0Vhc2luZ0RpcmVjdGlvbgJJbgdFbGFzdGljA091dAl3b3Jrc3BhY2UGUGFyZW50CEFuY2hvcmVkCkNhbkNvbGxpZGUIQ2FuUXVlcnkKQ2FzdFNoYWRvdwhDYW5Ub3VjaAtQcmltYXJ5UGFydAhQb3NpdGlvbgdWZWN0b3IzB0FkZEl0ZW0GQ3JlYXRlBFBsYXkMVHJhbnNwYXJlbmN5CFJvdGF0aW9uClVzZUFiaWxpdHkGRGVicmlzCkdldFNlcnZpY2UMVHdlZW5TZXJ2aWNlDEJ1bm55IFdhYmJpdAROYW1lBlBlYmJsZQlUb3dlck5hbWUSTm8gZGVzY3JpcHRpb24geWV0C0Rlc2NyaXB0aW9uB01hc3RlcnkEQ29zdAdyZXF1aXJlClNoYXJlZERhdGEMUmVsZWFzZVRpbWVzDUVhc3RlcjIwMjZfVzEHVW5sb2NrcwZFYXN0ZXILSG9saWRheVNraW4ccmJ4YXNzZXRpZDovLzEzOTQyMjA5ODIwNjEzMgNSdW4ccmJ4YXNzZXRpZDovLzExNzUzNTg3MDIxOTgwNQRXYWxrHHJieGFzc2V0aWQ6Ly8xMDcxMTUwNDI0MTczMDYESWRsZRxyYnhhc3NldGlkOi8vMTE3NDkzOTIyMDAxMzUzBVF1aXJrHHJieGFzc2V0aWQ6Ly8xMzA0MjQxNDQwNjY4MTYGRGVjb2RlE092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzcxNzc5MzA1MDIyMTcwBk5vcm1hbBxyYnhhc3NldGlkOi8vMTMzODY5ODA4NzIwOTQ4BUJsaW5rG3JieGFzc2V0aWQ6Ly85NDU2NjcyMDI3ODYxMARIdXJ0DEZhY2VUZXh0dXJlcw5VU0VfU0tJTl9NT0RFTAADAQEAAAAGAwAABQEHAYIAAQAAACMBARgAJQAAAAAOAQIAAAcA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

-- https://lua.expert/
local Debris = game:GetService("Debris")

game:GetService("ReplicatedStorage")

local TweenService = game:GetService("TweenService")

return {
	Name = "Bunny Wabbit",
	TowerName = "Pebble",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W1,
	Easter = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://139422098206132",
		Walk = "rbxassetid://117535870219805",
		Idle = "rbxassetid://107115042417306",
		Quirk = "rbxassetid://117493922001353",
		Decode = "rbxassetid://130424144066816"
	},
	FaceTextures = {
		Normal = "rbxassetid://71779305022170",
		Blink = "rbxassetid://133869808720948",
		Hurt = "rbxassetid://94566720278610"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 35 ]] end,
	UseAbility = function(p1) --[[ UseAbility | Line: 39 | Upvalues: Debris (copy), TweenService (copy) ]]
		local Humanoid = p1:WaitForChild("Humanoid")
		local v1 = p1:WaitForChild("HumanoidRootPart").Size.Y / 2 + Humanoid.HipHeight
		local v2 = game.ReplicatedStorage:WaitForChild("Parts"):WaitForChild("PoofPebbleSkins"):Clone()

		v2.Color = Color3.fromRGB(243, 201, 254)
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
}