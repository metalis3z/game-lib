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
-- CQNICUFwcGx5U2tpbghQb3NpdGlvbghwYXJhYm9sYQVjaGFzZQRnYW1lBkRlYnJpcwpHZXRTZXJ2aWNlEVJlcGxpY2F0ZWRTdG9yYWdlB3JlcXVpcmUFUGFydHMNUmVuZGVyTW9kdWxlcw1TcHJvdXRDdXBjYWtlCE1vdmVtZW50B0N1cGNha2UFQ2xvbmUHQWRkSXRlbQl3b3Jrc3BhY2UGUGFyZW50B0NvbG9yXzEHQ29sb3JfMgdDb2xvcl8zB0NvbG9yXzQGQ29sb3IzB2Zyb21SR0IIQmFzZVBhcnQDSXNBBUNvbG9yBVRyYWlsDkZpbmRGaXJzdENoaWxkB0VuYWJsZWQNQ29sb3JTZXF1ZW5jZQNuZXcVQ29sb3JTZXF1ZW5jZUtleXBvaW50CVNtb2tlUGFydAlIZWFydFBhcnQMVHJhbnNwYXJlbmN5BEVtaXQDRWF0BFBsYXkKVXNlQWJpbGl0eRBUZW5kZXJoZWFydCBCZWFyBE5hbWUGc2NyaXB0CVJvYnV4Q29zdAxHZXRBdHRyaWJ1dGUIRGF0ZVRpbWURZnJvbVVuaXZlcnNhbFRpbWUHVW5sb2NrcwlQcm9kdWN0SWQGUl9oYW5kDVJpZ2h0SGFuZEJvbmUccmJ4YXNzZXRpZDovLzEwNzIwNTI3NTQzNjc2NANSdW4ccmJ4YXNzZXRpZDovLzEwMDAyMTk3MTgwMjQ5NgRXYWxrHHJieGFzc2V0aWQ6Ly8xMDU5NTUwMzA1NTA2MDIESWRsZRtyYnhhc3NldGlkOi8vNzIzNTc0OTg0OTExMzUFUXVpcmsbcmJ4YXNzZXRpZDovLzk1NDUzODQ3ODcwNTMwBkRlY29kZRtyYnhhc3NldGlkOi8vOTE1NjQyODcwMzM5OTIHQWJpbGl0eRNPdmVyd3JpdGVBbmltYXRpb25zHHJieGFzc2V0aWQ6Ly8xMzEwODMyMDAyMDI0OTEGTm9ybWFsG3JieGFzc2V0aWQ6Ly83NjczODkwNTA5NDc3MAVCbGluaxxyYnhhc3NldGlkOi8vMTM4NTQ2MjM2NDQyNzEyBEh1cnQMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMAAQBAQAAAAYDAAAFAQcBggABAAAAHAEBGAAeAAAAAAkAAwAAAA/7AAAATQAAOwAAAAD7AQEA+wICAE0CAkgB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

-- https://lua.expert/
return {
	Name = "Tenderheart Bear",
	RobuxCost = script:GetAttribute("RobuxCost") or -1,
	Unlocks = DateTime.fromUniversalTime(2026, 5, 26, 19, 0, 0),
	ProductId = 3576327394,
	RightHandBone = "R_hand",
	OverwriteAnimations = {
		Run = "rbxassetid://107205275436764",
		Walk = "rbxassetid://100021971802496",
		Idle = "rbxassetid://105955030550602",
		Quirk = "rbxassetid://72357498491135",
		Decode = "rbxassetid://95453847870530",
		Ability = "rbxassetid://91564287033992"
	},
	FaceTextures = {
		Normal = "rbxassetid://131083200202491",
		Blink = "rbxassetid://76738905094770",
		Hurt = "rbxassetid://138546236442712"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 28 ]] end,
	UseAbility = function(p1, p2, p3, p4) --[[ UseAbility | Line: 32 ]]
		local Debris = game:GetService("Debris")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Movement = require(ReplicatedStorage.Parts.RenderModules.SproutCupcake.Movement)
		local v1 = ReplicatedStorage.Parts.RenderModules.SproutCupcake.Cupcake:Clone()

		Debris:AddItem(v1, 2)
		v1.Parent = workspace
		v1.Position = p3.Position

		local t = {
			Color_1 = Color3.fromRGB(190, 70, 80),
			Color_2 = Color3.fromRGB(211, 166, 25),
			Color_3 = Color3.fromRGB(149, 187, 153),
			Color_4 = Color3.fromRGB(221, 143, 153)
		}

		if v1:IsA("BasePart") then
			v1.Color = t.Color_1
		end

		if v1:FindFirstChild("Trail") then
			v1.Trail.Enabled = true
			v1.Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, t.Color_1), ColorSequenceKeypoint.new(1, t.Color_3) })
		end

		if v1:FindFirstChild("SmokePart") then
			v1.SmokePart.Enabled = true
			v1.SmokePart.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, t.Color_2), ColorSequenceKeypoint.new(1, t.Color_4) })
		end

		if v1:FindFirstChild("HeartPart") then
			v1.HeartPart.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, t.Color_1), ColorSequenceKeypoint.new(1, t.Color_3) })
		end

		local function chase() --[[ chase | Line: 84 | Upvalues: v1 (copy), p4 (copy), Movement (copy) ]]
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