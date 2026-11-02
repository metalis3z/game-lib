--credit to prince games studio
local t = {}
local RunService = game:GetService("RunService")
local Animation = Instance.new("Animation")

Animation.AnimationId = "rbxassetid://135730555305951"

local Animation2 = Instance.new("Animation")

Animation2.AnimationId = "rbxassetid://122089498992842"

local Animation3 = Instance.new("Animation")

Animation3.AnimationId = "rbxassetid://78251601659765"

local FreezeInspect = script.Parent.FreezeInspect

FreezeInspect.Parent = nil
function t.Run(p1) --[[ Run | Line: 22 | Upvalues: FreezeInspect (copy), RunService (copy), Animation (copy), Animation2 (copy), Animation3 (copy) ]]
	local Plot = p1.Plot
	local PlayerModel = p1.PlayerModel
	local Camera = p1.Camera
	local Trove = p1.Trove

	if not (PlayerModel and p1.PlayerHumanoid) then
		return
	end

	local v1 = FreezeInspect:Clone()

	Trove:Add(v1)

	local Player1 = PlayerModel:Clone()

	Player1.PrimaryPart = Player1.HumanoidRootPart
	Player1:PivotTo(v1.Player1:GetPivot())
	Player1.Parent = v1

	local v2 = v1.Player1["Freeze Ray"]:Clone()

	v2.Parent = Player1
	v1.Player1:Destroy()

	local WeldConstraint = Instance.new("WeldConstraint")

	WeldConstraint.Part0 = v2.Handle
	WeldConstraint.Part1 = Player1["Right Arm"]
	WeldConstraint.Parent = Player1
	Player1.Name = "Player1"
	v1.Parent = workspace.Terrain
	Camera.CameraType = Enum.CameraType.Scriptable

	local v3 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 66 | Upvalues: v1 (copy), Camera (copy) ]]
		if v1.Parent then
			workspace.CurrentCamera.CFrame = v1.Camera.Camera.CFrame
			Camera.FieldOfView = 35
		end
	end)

	Trove:Add(v3)
	game:GetService("ContentProvider"):PreloadAsync({ Animation, Animation2, Animation3 })

	local v4 = script.FadeIn:Clone()

	v4.Parent = game.Players.LocalPlayer.PlayerGui
	v4.Frame.BackgroundTransparency = 0
	Trove:Add(v4)

	repeat
		task.wait(0.25)
	until game:GetService("ContentProvider").RequestQueueSize == 0

	if not v1.Parent then
		return
	end

	local v5 = Player1.Humanoid.Animator:LoadAnimation(Animation)
	local v6 = v1.Player2.Humanoid.Animator:LoadAnimation(Animation2)
	local v7 = v1.Camera.AnimationController.Animator:LoadAnimation(Animation3)
	local t2 = {}

	workspace.CurrentCamera.FieldOfView = 35

	local v8 = nil

	p1:ApplyRandomFriendAppearance(v1.Player2, nil, true)

	if v1.Parent then
		local function CreateProjectile() --[[ CreateProjectile | Line: 109 ]]
			local FreezeRayShot = Instance.new("Part")

			FreezeRayShot.Name = "FreezeRayShot"
			FreezeRayShot.Color = Color3.fromRGB(100, 180, 255)
			FreezeRayShot.Material = Enum.Material.Neon
			FreezeRayShot.Shape = Enum.PartType.Block
			FreezeRayShot.Size = Vector3.new(0.3, 0.3, 3)
			FreezeRayShot.TopSurface = Enum.SurfaceType.Smooth
			FreezeRayShot.BottomSurface = Enum.SurfaceType.Smooth
			FreezeRayShot.CanCollide = false
			FreezeRayShot.Anchored = true
			FreezeRayShot.Locked = true
			FreezeRayShot.CastShadow = false

			local PointLight = Instance.new("PointLight")

			PointLight.Color = Color3.fromRGB(100, 180, 255)
			PointLight.Brightness = 1
			PointLight.Range = 8
			PointLight.Parent = FreezeRayShot

			local SelectionBox = Instance.new("SelectionBox")

			SelectionBox.Adornee = FreezeRayShot
			SelectionBox.Color = BrickColor.new("Toothpaste")
			SelectionBox.Parent = FreezeRayShot

			return FreezeRayShot
		end

		table.insert(t2, v7:GetMarkerReachedSignal("ChargeGun"):Connect(function() --[[ Line: 140 | Upvalues: v2 (copy) ]]
			for v1, v22 in v2.EmissivePart:GetChildren() do
				if v22:IsA("SurfaceAppearance") then
					game.TweenService:Create(v22, TweenInfo.new(0.3), {
						EmissiveStrength = 4
					}):Play()
					task.delay(0.3, function() --[[ Line: 145 | Upvalues: v22 (copy) ]]
						if not v22 then
							return
						end

						game.TweenService:Create(v22, TweenInfo.new(0.2), {
							EmissiveStrength = 3
						}):Play()
					end)

					continue
				end

				if v22:IsA("ParticleEmitter") then
					v22:Emit(v22:GetAttribute("EmitCount") or 1)
					v22.Enabled = true
				end
			end

			game.TweenService:Create(v2.Ice.SurfaceAppearance, TweenInfo.new(0.3), {
				EmissiveStrength = 4
			}):Play()
			task.delay(0.3, function() --[[ Line: 160 | Upvalues: v2 (ref) ]]
				if not (v2:FindFirstChild("Ice") and v2.Ice:FindFirstChild("SurfaceAppearance")) then
					return
				end

				game.TweenService:Create(v2.Ice.SurfaceAppearance, TweenInfo.new(0.2), {
					EmissiveStrength = 3
				}):Play()
			end)
		end))
		table.insert(t2, v7:GetMarkerReachedSignal("Fire"):Connect(function() --[[ Line: 169 | Upvalues: v2 (copy), v1 (copy), CreateProjectile (copy) ]]
			for v12, v22 in v2:GetDescendants() do
				if v22:IsA("SurfaceAppearance") then
					game.TweenService:Create(v22, TweenInfo.new(0.3), {
						EmissiveStrength = 4
					}):Play()
					task.delay(0.3, function() --[[ Line: 174 | Upvalues: v22 (copy) ]]
						if not v22 then
							return
						end

						game.TweenService:Create(v22, TweenInfo.new(0.2), {
							EmissiveStrength = 3
						}):Play()
					end)
				end
			end

			local v3 = game.SoundService.SFX.FreezeRay:Clone()

			v3.TimePosition = 0.1
			v3:Play()
			v3.Parent = v2.Handle
			game.Debris:AddItem(v3, 3)

			for v4, v5 in v2.Nozzle.Attachment:GetChildren() do
				v5:Emit(v5:GetAttribute("EmitCount") or 1)
			end

			local v7 = CFrame.new(v2.Nozzle.CFrame.Position, v1.Player2.Torso.Position)
			local v8 = CreateProjectile()

			v8.CFrame = v7 + v7.LookVector * 1.5
			v8.Parent = v1
			game.Debris:AddItem(v8, 0.15)

			local v9 = 0

			task.spawn(function() --[[ Line: 208 | Upvalues: v9 (ref), v8 (copy) ]]
				while v9 < 0.15 and v8 do
					local v1 = game:GetService("RunService").Heartbeat:Wait()

					v9 = v9 + v1

					local v2 = v8

					v2.CFrame = v2.CFrame * CFrame.new(0, 0, -120 * v1)
				end
			end)
		end))
		table.insert(t2, v7:GetMarkerReachedSignal("Freeze"):Connect(function() --[[ Line: 218 | Upvalues: v8 (ref), v1 (copy) ]]
			v8 = game.ReplicatedStorage.Assets.Ice_Part:Clone()
			v8.CFrame = CFrame.new(v1.Player2.Torso.Position)

			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = v8
			WeldConstraint.Part1 = v1.Player2.Torso
			WeldConstraint.Parent = v8
			v8.Transparency = 0

			local v12 = game.SoundService.SFX.Freeze:Clone()

			v12.Parent = v8
			v12.TimePosition = 0
			v12.PlaybackSpeed = 1 + math.random(-15, 15) / 100
			v12.Playing = true
			game.Debris:AddItem(v12, v12.TimeLength * v12.PlaybackSpeed)
			v8.Parent = v1

			local v2 = script.Highlight:Clone()

			v2.Parent = v8
			v2.Enabled = true
			v2.Adornee = v8
			game.TweenService:Create(v2, TweenInfo.new(0.1), {
				FillTransparency = 1,
				OutlineTransparency = 1
			}):Play()
			game.Debris:AddItem(v2, 0.1)
			task.delay(0.1, function() --[[ Line: 248 | Upvalues: v8 (ref) ]]
				game.TweenService:Create(v8, TweenInfo.new(0.1), {
					Transparency = 0.4
				}):Play()
			end)

			for v3, v4 in v8:GetChildren() do
				if v4:IsA("ParticleEmitter") then
					v4:Emit(v4:GetAttribute("EmitCount") or 0)

					continue
				end

				if v4:IsA("PointLight") then
					game.TweenService:Create(v4, TweenInfo.new(0.1), {
						Brightness = 6
					}):Play()
					task.delay(0.3, function() --[[ Line: 258 | Upvalues: v4 (copy) ]]
						game.TweenService:Create(v4, TweenInfo.new(0.1), {
							Brightness = 1
						}):Play()
					end)
				end
			end
		end))
		table.insert(t2, v7:GetMarkerReachedSignal("PowerDown"):Connect(function() --[[ Line: 267 | Upvalues: v2 (copy) ]]
			for v1, v22 in v2:GetDescendants() do
				if v22:IsA("SurfaceAppearance") then
					game.TweenService:Create(v22, TweenInfo.new(1), {
						EmissiveStrength = 0
					}):Play()
				end
			end
		end))
		table.insert(t2, v7:GetMarkerReachedSignal("Start"):Connect(function() --[[ Line: 280 | Upvalues: v2 (copy), v4 (copy), v8 (ref) ]]
			for v1, v22 in v2:GetDescendants() do
				if v22:IsA("ParticleEmitter") then
					v22:Clear()
				end
			end

			v2.EmissivePart.SurfaceAppearance.EmissiveStrength = 0
			v2.Ice.SurfaceAppearance.EmissiveStrength = 0
			game.TweenService:Create(v4.Frame, TweenInfo.new(0.3), {
				BackgroundTransparency = 1
			}):Play()

			if not v8 then
				return
			end

			v8:Destroy()
		end))
		table.insert(t2, v7:GetMarkerReachedSignal("FadeOut"):Connect(function() --[[ Line: 299 | Upvalues: v4 (copy) ]]
			game.TweenService:Create(v4.Frame, TweenInfo.new(0.3), {
				BackgroundTransparency = 0
			}):Play()
		end))
		v5.Looped = true
		v6.Looped = true
		v7.Looped = true
		v5:Play()
		v6:Play()
		v7:Play()
		Camera.FieldOfView = 25
		Trove:Add(function() --[[ Line: 317 | Upvalues: v8 (ref), v4 (copy), v3 (ref), v5 (copy), v7 (copy), v6 (copy) ]]
			if v8 then
				v8:Destroy()
			end

			if v4 then
				v4:Destroy()
			end

			if v3 then
				v3:Disconnect()
			end

			if v5 then
				v5:Stop()
				v5:Destroy()
			end

			if v7 then
				v7:Stop()
				v7:Destroy()
			end

			if not v6 then
				return
			end

			v6:Stop()
			v6:Destroy()
		end)
	end
end

return t