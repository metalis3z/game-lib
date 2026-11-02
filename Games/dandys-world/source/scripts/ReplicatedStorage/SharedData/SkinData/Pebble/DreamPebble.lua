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
-- CQNGCUFwcGx5U2tpbgR0YXNrBHdhaXQFQ29sb3IGQ29sb3IzB2Zyb21SR0IGQ3JlYXRlBFBsYXkJQ29tcGxldGVkBFdhaXQISHVtYW5vaWQMV2FpdEZvckNoaWxkEEh1bWFub2lkUm9vdFBhcnQEU2l6ZQFZCUhpcEhlaWdodARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlBVBhcnRzBFBvb2YFQ2xvbmUJVHdlZW5JbmZvA25ldwRFbnVtC0Vhc2luZ1N0eWxlBFF1YWQPRWFzaW5nRGlyZWN0aW9uAkluB0VsYXN0aWMDT3V0CXdvcmtzcGFjZQZQYXJlbnQIQW5jaG9yZWQKQ2FuQ29sbGlkZQhDYW5RdWVyeQpDYXN0U2hhZG93CENhblRvdWNoC1ByaW1hcnlQYXJ0CFBvc2l0aW9uB1ZlY3RvcjMHQWRkSXRlbQVzcGF3bgxUcmFuc3BhcmVuY3kIUm90YXRpb24KVXNlQWJpbGl0eRFDb2xsZWN0aW9uU2VydmljZQpHZXRTZXJ2aWNlEFN0YXItVGltZSBQZWJibGUETmFtZRxyYnhhc3NldGlkOi8vMTA4NjIxMTg4NzEzMjY1BFdhbGsbcmJ4YXNzZXRpZDovLzk0OTI1MDg0ODA3NDk0BElkbGUccmJ4YXNzZXRpZDovLzEzMDEyNDEyNTg2NTI4MAZEZWNvZGUbcmJ4YXNzZXRpZDovLzgyMDc4NTIxOTI1NDU4A1J1bhtyYnhhc3NldGlkOi8vODE2ODYyNDQzNzg0NDgFUXVpcmsTT3ZlcndyaXRlQW5pbWF0aW9ucxtyYnhhc3NldGlkOi8vOTQxMTg2MTA5NjQ1NTIGTm9ybWFsHHJieGFzc2V0aWQ6Ly8xMzI3NjYwNDMxNTA3NjkFQmxpbmsbcmJ4YXNzZXRpZDovLzcxMzQyODAyNzcwODMzBEh1cnQMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMDFR3ZWVuU2VydmljZQZEZWJyaXMABAEBAAAABgMAAAUBBwGCAAEAAAAWAQEYABoAAAAACgADAAAAM6QAAgAABACAbwEDAJ8AAgH7AAAA+wIBAPsDAgDiBAUApAUIAAAcYICMBrMAjAezAIwIswCfBQQCMAUEpAQAAAC8AACWCQAAAJ8ABQK8AQDuCgAAAJ8BAgFNAQAYCwAA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

-- https://lua.expert/
game:GetService("CollectionService")

local t = {
	Name = "Star-Time Pebble",
	OverwriteAnimations = {
		Walk = "rbxassetid://108621188713265",
		Idle = "rbxassetid://94925084807494",
		Decode = "rbxassetid://130124125865280",
		Run = "rbxassetid://82078521925458",
		Quirk = "rbxassetid://81686244378448"
	},
	FaceTextures = {
		Normal = "rbxassetid://94118610964552",
		Blink = "rbxassetid://132766043150769",
		Hurt = "rbxassetid://71342802770833"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 22 ]] end
}
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

function t.UseAbility(p1) --[[ UseAbility | Line: 31 | Upvalues: Debris (copy), TweenService (copy) ]]
	local Humanoid = p1:WaitForChild("Humanoid")
	local v1 = p1:WaitForChild("HumanoidRootPart").Size.Y / 2 + Humanoid.HipHeight
	local v2 = game.ReplicatedStorage:WaitForChild("Parts"):WaitForChild("Poof"):Clone()

	TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false)

	local v3 = TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false)
	local v4 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false)
	local v5 = TweenInfo.new(0.33, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false)

	v2.Parent = workspace
	v2.Anchored = true
	v2.CanCollide = false
	v2.CanQuery = false
	v2.CastShadow = false
	v2.CanTouch = false
	v2.Size = Vector3.new(0, 0.25, 0)
	v2.Position = p1.PrimaryPart.Position + Vector3.new(0, -v1, 0)
	Debris:AddItem(v2, 5)
	task.spawn(function() --[[ Line: 81 | Upvalues: TweenService (ref), v2 (copy), v5 (copy) ]]
		task.wait(0.1)

		local v1 = TweenService:Create(v2, v5, {
			Color = Color3.fromRGB(179, 179, 179)
		})

		v1:Play()
		v1.Completed:Wait()

		local v22 = TweenService:Create(v2, v5, {
			Color = Color3.fromRGB(157, 141, 83)
		})

		v22:Play()
		v22.Completed:Wait()
	end)
	TweenService:Create(v2, v3, {
		Size = Vector3.new(45, 0.25, 45)
	}):Play()
	TweenService:Create(v2, v4, {
		Transparency = 1,
		Rotation = Vector3.new(0, 2.740167, 0)
	}):Play()
end

return t