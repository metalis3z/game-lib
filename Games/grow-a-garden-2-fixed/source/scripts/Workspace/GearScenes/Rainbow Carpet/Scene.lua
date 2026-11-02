--credit to leon games studio
local t = {}
local RunService = game:GetService("RunService")
local Animation = Instance.new("Animation")

Animation.AnimationId = "rbxassetid://75792485351006"

local Animation2 = Instance.new("Animation")

Animation2.AnimationId = "rbxassetid://87423183153900"

local Animation3 = Instance.new("Animation")

Animation3.AnimationId = "rbxassetid://101031181300796"

local CarpetInspect = script.Parent.CarpetInspect

CarpetInspect.Parent = nil
function t.Run(p1) --[[ Run | Line: 20 | Upvalues: CarpetInspect (copy), RunService (copy), Animation (copy), Animation2 (copy), Animation3 (copy) ]]
	local Plot = p1.Plot
	local PlayerModel = p1.PlayerModel
	local Camera = p1.Camera
	local Trove = p1.Trove

	if not (PlayerModel and p1.PlayerHumanoid) then
		return
	end

	local v1 = CarpetInspect:Clone()

	Trove:Add(v1)

	local Player = PlayerModel:Clone()

	Player.PrimaryPart = Player.HumanoidRootPart
	Player:PivotTo(v1.Player:GetPivot())
	Player.Parent = v1
	v1.Player:Destroy()
	Player.Name = "Player"
	v1.Parent = workspace.Terrain
	Camera.CameraType = Enum.CameraType.Scriptable

	local v2 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 67 | Upvalues: v1 (copy), Camera (copy) ]]
		if v1.Parent then
			workspace.CurrentCamera.CFrame = v1.Camera.Camera.CFrame
			Camera.FieldOfView = 35
		end
	end)

	Trove:Add(v2)
	v1.Carpet:FindFirstChildOfClass("AnimationController")
	game:GetService("ContentProvider"):PreloadAsync({ Animation, Animation2, Animation3 })

	local v3 = script.FadeIn:Clone()

	v3.Parent = game.Players.LocalPlayer.PlayerGui
	v3.Frame.BackgroundTransparency = 0
	Trove:Add(v3)

	repeat
		task.wait(0.25)
	until game:GetService("ContentProvider").RequestQueueSize == 0

	if v1.Parent then
		local v4 = Player.Humanoid.Animator:LoadAnimation(Animation)
		local v5 = v1.Carpet.AnimationController.Animator:LoadAnimation(Animation2)
		local v6 = v1.Camera.AnimationController.Animator:LoadAnimation(Animation3)
		local t2 = {}

		workspace.CurrentCamera.FieldOfView = 35
		table.insert(t2, v6:GetMarkerReachedSignal("Clearup"):Connect(function() --[[ Line: 102 | Upvalues: v3 (copy) ]]
			game.TweenService:Create(v3.Frame, TweenInfo.new(0.3), {
				BackgroundTransparency = 1
			}):Play()
		end))
		table.insert(t2, v6:GetMarkerReachedSignal("TurnOffFaceCamera"):Connect(function() --[[ Line: 112 | Upvalues: v1 (copy) ]]
			for v12, v2 in v1.Carpet.Carpet.Bone:GetDescendants() do
				if v2:IsA("Trail") then
					v2.FaceCamera = false
				end
			end
		end))
		table.insert(t2, v6:GetMarkerReachedSignal("Start"):Connect(function() --[[ Line: 124 | Upvalues: v1 (copy) ]]
			for v12, v2 in v1.Carpet.Carpet.Bone:GetDescendants() do
				if v2:IsA("Trail") then
					v2.FaceCamera = true
					v2.Enabled = true

					continue
				end

				if v2:IsA("ParticleEmitter") then
					v2:Clear()
					v2.Enabled = true
				end
			end
		end))
		table.insert(t2, v6:GetMarkerReachedSignal("FadeOut"):Connect(function() --[[ Line: 138 | Upvalues: v3 (copy), v1 (copy) ]]
			game.TweenService:Create(v3.Frame, TweenInfo.new(0.3), {
				BackgroundTransparency = 0
			}):Play()

			for v12, v2 in v1.Carpet.Carpet.Bone:GetDescendants() do
				if v2:IsA("Trail") then
					v2.Enabled = false

					continue
				end

				if v2:IsA("ParticleEmitter") then
					v2.Enabled = false
				end
			end
		end))
		v4.Looped = true
		v5.Looped = true
		v6.Looped = true
		v4:Play()
		v5:Play()
		v6:Play()
		Camera.FieldOfView = 25
		Trove:Add(function() --[[ Line: 162 | Upvalues: v3 (copy), v2 (ref), v4 (copy), v6 (copy), v5 (copy) ]]
			if v3 then
				v3:Destroy()
			end

			if v2 then
				v2:Disconnect()
			end

			if v4 then
				v4:Stop()
				v4:Destroy()
			end

			if v6 then
				v6:Stop()
				v6:Destroy()
			end

			if not v5 then
				return
			end

			v5:Stop()
			v5:Destroy()
		end)
	end
end

return t