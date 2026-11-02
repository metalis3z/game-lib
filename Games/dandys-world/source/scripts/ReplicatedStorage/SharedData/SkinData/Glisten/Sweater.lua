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
-- CQNYCUFwcGx5U2tpbgZDRnJhbWUGQW5nbGVzD1BhcnRpY2xlRW1pdHRlcgRFbWl0CVR3ZWVuSW5mbwNuZXcERW51bQtFYXNpbmdTdHlsZQdFbGFzdGljD0Vhc2luZ0RpcmVjdGlvbgNPdXQEU2l6ZQxUcmFuc3BhcmVuY3kGQ3JlYXRlBFBsYXkEUXVhZAJJbglDb21wbGV0ZWQEV2FpdAZMaW5lYXIFSW5PdXQEdGFzawR3YWl0BVBhdXNlB0Rlc3Ryb3kNR2xpc3Rlbk1pcnJvcgVDbG9uZQRIZWFkDkZpbmRGaXJzdENoaWxkCE1lc2hQYXJ0A0lzQQlUZXh0dXJlSUQGQ29sb3IzB2Zyb21SR0IFQ29sb3IBWAFZAVoHVmVjdG9yMwl3b3Jrc3BhY2UGUGFyZW50CEFuY2hvcmVkCkNhbkNvbGxpZGUIQ2FuUXVlcnkKQ2FzdFNoYWRvdwhDYW5Ub3VjaAhQb3NpdGlvbgVzcGF3bgdBZGRJdGVtDENyZWF0ZU1pcnJvcgVQYXJ0cw1SZW5kZXJNb2R1bGVzDUdsaXN0ZW5Qb3J0YWwLR2xpc3RlblBvb2YLR2xpc3RlbkRhc2gJTWFnbml0dWRlClVzZUFiaWxpdHkMQ296eSBTd2VhdGVyBE5hbWUEQ29zdApEYW5keVN0b3JlHHJieGFzc2V0aWQ6Ly8xMjMwNTc4ODIzOTE1NDcEV2FsaxxyYnhhc3NldGlkOi8vMTM5Mjg0NDkxNTMzNzI0A1J1bhtyYnhhc3NldGlkOi8vOTE3NzY0MjMzMzc5MDYFUXVpcmsccmJ4YXNzZXRpZDovLzEwMjEwMTE5MDkyNzUzOQRJZGxlHHJieGFzc2V0aWQ6Ly8xMTM5MzkwNTc4NjA4NDUGRGVjb2RlHHJieGFzc2V0aWQ6Ly8xMzMxMTE1MTU5MTc5MzQHQWJpbGl0eRNPdmVyd3JpdGVBbmltYXRpb25zHHJieGFzc2V0aWQ6Ly8xMzkxMDUzMDU3MzQ3OTkGTm9ybWFsHHJieGFzc2V0aWQ6Ly8xMDM2NDExNjk3NzMyMzMFQmxpbmsbcmJ4YXNzZXRpZDovLzk4MzM5MjQ4NjE2Njk3BEh1cnQMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMBGdhbWUGRGVicmlzCkdldFNlcnZpY2URUmVwbGlj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

-- https://lua.expert/
local t = {
	Name = "Cozy Sweater",
	Cost = 600,
	DandyStore = true,
	OverwriteAnimations = {
		Walk = "rbxassetid://123057882391547",
		Run = "rbxassetid://139284491533724",
		Quirk = "rbxassetid://91776423337906",
		Idle = "rbxassetid://102101190927539",
		Decode = "rbxassetid://113939057860845",
		Ability = "rbxassetid://133111515917934"
	},
	FaceTextures = {
		Normal = "rbxassetid://139105305734799",
		Blink = "rbxassetid://103641169773233",
		Hurt = "rbxassetid://98339248616697"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 24 ]] end
}
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

function t.UseAbility(p1, p2, p3, p4, p5, p6, p7) --[[ UseAbility | Line: 32 | Upvalues: ReplicatedStorage (copy), TweenService (copy), Debris (copy) ]]
	local GlistenPortal = ReplicatedStorage.Parts.RenderModules.GlistenPortal

	local function CreateMirror(p12, p2) --[[ CreateMirror | Line: 36 | Upvalues: GlistenPortal (copy), p1 (copy), p6 (copy), TweenService (ref), Debris (ref) ]]
		local v1 = GlistenPortal.GlistenMirror:Clone()
		local Head = p1:FindFirstChild("Head")

		if Head and Head:IsA("MeshPart") then
			v1.TextureID = Head.TextureID
			v1.Color = Color3.fromRGB(10, 51, 93)
		end

		v1.Transparency = 1
		TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false)

		local v2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false)
		local Size = v1.Size

		v1.Size = Vector3.new(Size.X * 0.8, Size.Y * 0.8, Size.Z * 0.8)
		v1.Parent = workspace
		v1.Anchored = true
		v1.CanCollide = false
		v1.CanQuery = false
		v1.CastShadow = false
		v1.CanTouch = false
		v1.Position = p12.Position + Vector3.new(0, -p6 + v1.Size.Y / 2 + 0.25, 0)
		task.spawn(function() --[[ Line: 75 | Upvalues: v1 (copy), TweenService (ref), Size (copy), v2 (copy) ]]
			local t = {
				CFrame = v1.CFrame * CFrame.Angles(0, 2.7401669256310974, 0)
			}

			v1.ParticleEmitter:Emit(10)
			TweenService:Create(v1, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false), {
				Transparency = 0,
				Size = Size
			}):Play()

			local v12 = TweenService:Create(v1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0), t)

			v12:Play()
			v12.Completed:Wait()

			local v22 = TweenService:Create(v1, v2, {
				Size = Vector3.new(0, 0, 0),
				Transparency = 1
			})

			v22:Play()
			TweenService:Create(v1, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0), {
				CFrame = v1.CFrame * CFrame.Angles(0, 3.12413936106985, 0)
			}):Play()
			task.wait(1)
			v22:Pause()
			v22:Destroy()
		end)
		Debris:AddItem(v1, 2)
	end

	local v1 = GlistenPortal.GlistenPoof:Clone()

	TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false)

	local v2 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false)

	CreateMirror(p4)
	CreateMirror(p3.CFrame)
	v1.Parent = workspace
	v1.Anchored = true
	v1.CanCollide = false
	v1.CanQuery = false
	v1.CastShadow = false
	v1.CanTouch = false
	v1.Size = Vector3.new(0, 0.25, 0)
	v1.Position = p4.Position + Vector3.new(0, -p6 + 0.25, 0)
	Debris:AddItem(v1, 3)

	local v3 = GlistenPortal.GlistenDash:Clone()

	v3.Parent = workspace

	local Position = p3.Position

	v3.Size = Vector3.new(v3.Size.X, v3.Size.Y, (p3.Position - p4.Position).Magnitude)

	local v4 = CFrame.new(0, 0, -(p3.Position - p4.Position).Magnitude / 2)

	v3.CFrame = CFrame.new(p4.Position, p3.Position) * v4
	v3.Anchored = true
	v3.CanCollide = false
	v3.CanQuery = false
	v3.CanTouch = false

	local v5 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
	local v6 = TweenService
	local t = {
		Transparency = 1
	}

	t.Size = Vector3.new(v3.Size.X, v3.Size.Y * 1.5, (p3.Position - p4.Position).Magnitude)
	v6:Create(v3, v5, t):Play()
	Debris:AddItem(v3, 3)
	TweenService:Create(v1, v2, {
		Size = Vector3.new(25, 0.25, 25),
		Transparency = 1,
		CFrame = v1.CFrame * CFrame.new(0, 0.25, 0) * CFrame.Angles(0, 2.7401669256310974, 0)
	}):Play()

	local v8 = GlistenPortal.GlistenPoof:Clone()

	TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false)

	local v9 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false)

	v8.Parent = workspace
	v8.Anchored = true
	v8.CanCollide = false
	v8.CanQuery = false
	v8.CastShadow = false
	v8.CanTouch = false
	v8.Size = Vector3.new(0, 0.25, 0)
	v8.Position = p3.CFrame.Position + Vector3.new(0, -p7 + 0.25, 0)
	Debris:AddItem(v8, 3)
	TweenService:Create(v8, v9, {
		Size = Vector3.new(25, 0.25, 25),
		Transparency = 1,
		CFrame = v8.CFrame * CFrame.new(0, 0.25, 0) * CFrame.Angles(0, 2.7401669256310974, 0)
	}):Play()
end

return t