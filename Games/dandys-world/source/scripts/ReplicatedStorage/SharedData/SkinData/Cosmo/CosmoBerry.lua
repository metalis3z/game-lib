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
-- CQNCCUFwcGx5U2tpbghQb3NpdGlvbghwYXJhYm9sYQVjaGFzZQRnYW1lBkRlYnJpcwpHZXRTZXJ2aWNlEVJlcGxpY2F0ZWRTdG9yYWdlB3JlcXVpcmUFUGFydHMNUmVuZGVyTW9kdWxlcwtDb3Ntb0Nvb2tpZQhNb3ZlbWVudAZDb29raWUFQ2xvbmUHQWRkSXRlbQl3b3Jrc3BhY2UGUGFyZW50CEJhc2VQYXJ0A0lzQQZDb2xvcjMHZnJvbVJHQgVDb2xvcgVUcmFpbA5GaW5kRmlyc3RDaGlsZAdFbmFibGVkDUNvbG9yU2VxdWVuY2UDbmV3FUNvbG9yU2VxdWVuY2VLZXlwb2ludAlTbW9rZVBhcnQJSGVhcnRQYXJ0DFRyYW5zcGFyZW5jeQRFbWl0A0VhdARQbGF5ClVzZUFiaWxpdHkKQmVycnkgUm9sbAROYW1lBENvc3QKRGFuZHlTdG9yZRtyYnhhc3NldGlkOi8vOTg4NzQ2ODY2MTc1MTUHQWJpbGl0eRxyYnhhc3NldGlkOi8vMTE5Njk5Mzg2NzI4Mjk0BkRlY29kZRtyYnhhc3NldGlkOi8vOTcwOTk1MjQzNDMzMTYESWRsZRtyYnhhc3NldGlkOi8vNzE3MDEzNTk5NTUyNTkFUXVpcmsbcmJ4YXNzZXRpZDovLzcxNTg0NDA1MDM3NzMwA1J1bhtyYnhhc3NldGlkOi8vOTU1OTc1NTgzMDU4NDIEV2FsaxNPdmVyd3JpdGVBbmltYXRpb25zHHJieGFzc2V0aWQ6Ly8xMjg4OTAzNDUzNTA1MTEGTm9ybWFsHHJieGFzc2V0aWQ6Ly8xMDQzODU2MDMxOTM3OTMFQmxpbmsbcmJ4YXNzZXRpZDovLzg0Nzg0NDE5Nzk2NDg5BEh1cnQMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMBmhlYWQueA1SaWdodEhhbmRCb25lBkNGcmFtZQZBbmdsZXMRTGF0Y2hlZEJvbmVPZmZzZXQABAEBAAAABgMAAAUBBwGCAAEAAAAaAQEYAB4AAAAACQADAAAAD/sAAABNAAA7AAAAAPsBAQD7AgIATQICSAEAAAD7AwAAUgQAAFIFAQCMBhQAjAcZAG8IAgCfAgcBggABAAMDAgMDAgAAAAAAAOA/AE4EARgAAAABBQAAAAAAAAAAAAFP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

-- https://lua.expert/
return {
	Name = "Berry Roll",
	Cost = 600,
	DandyStore = true,
	OverwriteAnimations = {
		Ability = "rbxassetid://98874686617515",
		Decode = "rbxassetid://119699386728294",
		Idle = "rbxassetid://97099524343316",
		Quirk = "rbxassetid://71701359955259",
		Run = "rbxassetid://71584405037730",
		Walk = "rbxassetid://95597558305842"
	},
	FaceTextures = {
		Normal = "rbxassetid://128890345350511",
		Blink = "rbxassetid://104385603193793",
		Hurt = "rbxassetid://84784419796489"
	},
	USE_SKIN_MODEL = true,
	RightHandBone = "head.x",
	LatchedBoneOffset = CFrame.new(1.4, 2.8, -0.3) * CFrame.Angles(1.5707963267948966, -1.0471975511965976, 0),
	ApplySkin = function(p1) --[[ ApplySkin | Line: 26 ]] end,
	UseAbility = function(p1, p2, p3, p4) --[[ UseAbility | Line: 32 ]]
		local Debris = game:GetService("Debris")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Movement = require(ReplicatedStorage.Parts.RenderModules.CosmoCookie.Movement)
		local v1 = ReplicatedStorage.Parts.RenderModules.CosmoCookie.Cookie:Clone()

		Debris:AddItem(v1, 2)
		v1.Parent = workspace
		v1.Position = p3.Position

		if v1:IsA("BasePart") then
			v1.Color = Color3.fromRGB(255, 102, 153)
		end

		if v1:FindFirstChild("Trail") then
			v1.Trail.Enabled = true
			v1.Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 51, 102)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 153, 204)) })
		end

		if v1:FindFirstChild("SmokePart") then
			v1.SmokePart.Enabled = true
			v1.SmokePart.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 102, 153)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 204, 229)) })
		end

		if v1:FindFirstChild("HeartPart") then
			v1.HeartPart.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 51, 102)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 153, 204)) })
		end

		local function chase() --[[ chase | Line: 78 | Upvalues: v1 (copy), p4 (copy), Movement (copy) ]]
			Movement.parabola(v1, v1.Position, p4, 20, 25, 0.5)
		end

		Movement.parabola(v1, v1.Position, p4, 20, 25, 0.5)

		if not v1 then
			return
		end

		v1.SmokePart.Enabled = false
		v1.Transparency = 1
		v1.HeartPart:Emit(10)

		if not v1:FindFirstChild("Eat") then
			return
		end

		v1.Eat:Play()
	end
}