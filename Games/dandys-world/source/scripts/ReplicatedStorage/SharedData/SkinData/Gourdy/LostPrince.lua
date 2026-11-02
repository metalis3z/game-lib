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
-- CQNOCUFwcGx5U2tpbghIdW1hbm9pZAxXYWl0Rm9yQ2hpbGQQSHVtYW5vaWRSb290UGFydARTaXplAVkJSGlwSGVpZ2h0BVBhcnRzCWdvdXJkeUFPRQ5GaW5kRmlyc3RDaGlsZAR3YXJuM2dvdXJkeUFPRSBtZXNoIG5vdCBmb3VuZCBpbiBSZXBsaWNhdGVkU3RvcmFnZS5QYXJ0cwVDbG9uZQl3b3Jrc3BhY2UGUGFyZW50CEFuY2hvcmVkCkNhbkNvbGxpZGUIQ2FuUXVlcnkKQ2FzdFNoYWRvdwhDYW5Ub3VjaAZDb2xvcjMHZnJvbVJHQgVDb2xvcgxUcmFuc3BhcmVuY3kGQ0ZyYW1lA25ldwhQb3NpdGlvbgdWZWN0b3IzB1Bpdm90VG8JVHdlZW5JbmZvBEVudW0LRWFzaW5nU3R5bGUFQ3ViaWMGQW5nbGVzBkNyZWF0ZQRQbGF5B0FkZEl0ZW0KVXNlQWJpbGl0eQRnYW1lBkRlYnJpcwpHZXRTZXJ2aWNlEVJlcGxpY2F0ZWRTdG9yYWdlDFR3ZWVuU2VydmljZQtMb3N0IFByaW5jZQROYW1lBkdvdXJkeQlUb3dlck5hbWUSTm8gZGVzY3JpcHRpb24geWV0C0Rlc2NyaXB0aW9uB01hc3RlcnkEQ29zdA1IYWxsb3dlZW4yMDI1DFJlcXVpcmVtZW50MQRDb2luDFJlcXVpcmVtZW50MglIYWxsb3dlZW4LSG9saWRheVNraW4ccmJ4YXNzZXRpZDovLzEyNTI1NzQ3MDEyMzYwNgNSdW4ccmJ4YXNzZXRpZDovLzExNTU3MDQzMzAzMjM3NQRXYWxrG3JieGFzc2V0aWQ6Ly83Mjg5OTMzNzY5OTQwOARJZGxlG3JieGFzc2V0aWQ6Ly84ODA0NzkyMTgxMzcwMQVRdWlyaxxyYnhhc3NldGlkOi8vMTI2MTQzMDUxOTYwNDAyB0FiaWxpdHkccmJ4YXNzZXRpZDovLzExNjU5MzIwMzk5MTM0NQZEZWNvZGUTT3ZlcndyaXRlQW5pbWF0aW9ucxtyYnhhc3NldGlkOi8vNzQxNDQxNjI0NTUxMjMGTm9ybWFsHHJieGFzc2V0aWQ6Ly8xMTkwNTkzNzQ0NzI3ODMFQmxpbmsbcmJ4YXNzZXRpZDovLzg0NDI1NjgzMDE0OTc5BEh1cnQM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

-- https://lua.expert/
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

return {
	Name = "Lost Prince",
	TowerName = "Gourdy",
	Description = "No description yet",
	Mastery = false,
	Cost = 1200,
	Requirement1 = { "Halloween2025", 1200 },
	Requirement2 = { "Coin", 1200 },
	Halloween = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://125257470123606",
		Walk = "rbxassetid://115570433032375",
		Idle = "rbxassetid://72899337699408",
		Quirk = "rbxassetid://88047921813701",
		Ability = "rbxassetid://126143051960402",
		Decode = "rbxassetid://116593203991345"
	},
	FaceTextures = {
		Normal = "rbxassetid://74144162455123",
		Blink = "rbxassetid://119059374472783",
		Hurt = "rbxassetid://84425683014979"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 38 ]] end,
	UseAbility = function(p1) --[[ UseAbility | Line: 44 | Upvalues: ReplicatedStorage (copy), TweenService (copy), Debris (copy) ]]
		local Humanoid = p1:WaitForChild("Humanoid")
		local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")
		local v1 = HumanoidRootPart.Size.Y / 2 + Humanoid.HipHeight
		local gourdyAOE = ReplicatedStorage.Parts:FindFirstChild("gourdyAOE")

		if gourdyAOE then
			local v2 = gourdyAOE:Clone()

			v2.Parent = workspace
			v2.Anchored = true
			v2.CanCollide = false
			v2.CanQuery = false
			v2.CastShadow = false
			v2.CanTouch = false
			v2.Color = Color3.fromRGB(124, 121, 118)
			v2.Transparency = 0.2
			v2:PivotTo((CFrame.new(HumanoidRootPart.Position + Vector3.new(0, -v1 + 0.2, 0))))
			TweenService:Create(v2, TweenInfo.new(1.33, Enum.EasingStyle.Cubic), {
				Size = Vector3.new(19.27, 0.25, 20.0785),
				Transparency = 1,
				CFrame = v2.CFrame * CFrame.Angles(0, -0.7853981633974483, 0)
			}):Play()
			Debris:AddItem(v2, 3)
		else
			warn("gourdyAOE mesh not found in ReplicatedStorage.Parts")
		end
	end
}