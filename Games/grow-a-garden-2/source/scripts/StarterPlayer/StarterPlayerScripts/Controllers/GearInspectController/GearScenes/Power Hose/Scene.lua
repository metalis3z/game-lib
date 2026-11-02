--credit to prince games studio
local t = {}
local RunService = game:GetService("RunService")
local Animation = Instance.new("Animation")

Animation.AnimationId = "rbxassetid://138104000436087"

local Animation2 = Instance.new("Animation")

Animation2.AnimationId = "rbxassetid://138515525183427"

local Animation3 = Instance.new("Animation")

Animation3.AnimationId = "rbxassetid://133966457537427"

local HoseInspect = script.Parent.HoseInspect

HoseInspect.Parent = nil
function t.Run(p1) --[[ Run | Line: 24 | Upvalues: HoseInspect (copy), RunService (copy), Animation (copy), Animation2 (copy), Animation3 (copy) ]]
	local Plot = p1.Plot
	local PlayerModel = p1.PlayerModel
	local Camera = p1.Camera
	local Trove = p1.Trove

	if not (PlayerModel and p1.PlayerHumanoid) then
		return
	end

	local v1 = HoseInspect:Clone()

	Trove:Add(v1)

	local Player1 = PlayerModel:Clone()

	Player1.PrimaryPart = Player1.HumanoidRootPart
	Player1:PivotTo(v1.Player1:GetPivot())
	Player1.Parent = v1

	local v2 = v1.Player1["Power Hose"]:Clone()

	v2.Parent = Player1

	local v3 = v1.Player1.PowerWasherBack:Clone()

	v3.Parent = Player1
	v3:SetPrimaryPartCFrame(Player1.Torso.CFrame)
	v1.Player1:Destroy()

	local WeldConstraint = Instance.new("WeldConstraint")

	WeldConstraint.Part0 = v2.Handle
	WeldConstraint.Part1 = Player1["Right Arm"]
	WeldConstraint.Parent = Player1

	local WeldConstraint2 = Instance.new("WeldConstraint")

	WeldConstraint2.Part0 = v3.Prim
	WeldConstraint2.Part1 = Player1.Torso
	WeldConstraint2.Parent = Player1
	Player1.Name = "Player1"
	v1.Parent = workspace.Terrain
	Camera.CameraType = Enum.CameraType.Scriptable

	local v4 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 78 | Upvalues: v1 (copy), Camera (copy) ]]
		if v1.Parent then
			workspace.CurrentCamera.CFrame = v1.Camera.Camera.CFrame
			Camera.FieldOfView = 35
		end
	end)

	Trove:Add(v4)
	game:GetService("ContentProvider"):PreloadAsync({ Animation, Animation2, Animation3 })

	local v5 = script.FadeIn:Clone()

	v5.Parent = game.Players.LocalPlayer.PlayerGui
	v5.Frame.BackgroundTransparency = 0
	Trove:Add(v5)

	repeat
		task.wait(0.25)
	until game:GetService("ContentProvider").RequestQueueSize == 0

	if v1.Parent then
		local v6 = Player1.Humanoid.Animator:LoadAnimation(Animation)
		local v7 = v1.Player2.Humanoid.Animator:LoadAnimation(Animation2)
		local v8 = v1.Camera.AnimationController.Animator:LoadAnimation(Animation3)
		local t2 = {}

		workspace.CurrentCamera.FieldOfView = 20
		p1:ApplyRandomFriendAppearance(v1.Player2, nil, true)

		if v1.Parent then
			local v9 = nil
			local v10 = nil
			local v11 = nil

			local function ReplaceWithManipulableWeld(p1, p2, p3) --[[ ReplaceWithManipulableWeld | Line: 128 ]]
				local v1 = p3.CFrame:Inverse() * p2.CFrame

				p1:Destroy()

				local PowerHose_WaterWeld = Instance.new("Weld")

				PowerHose_WaterWeld.Name = "PowerHose_WaterWeld"
				PowerHose_WaterWeld.Part0 = p3
				PowerHose_WaterWeld.Part1 = p2
				PowerHose_WaterWeld.C0 = v1
				PowerHose_WaterWeld.C1 = CFrame.new()
				PowerHose_WaterWeld.Parent = p1.Parent

				return PowerHose_WaterWeld, v1, CFrame.new()
			end

			local function FindWeldForWater(p1) --[[ FindWeldForWater | Line: 149 ]]
				local t = {}
				local v1 = p1.Parent

				if v1 then
					local Prim = v1:FindFirstChild("Prim")

					if Prim then
						table.insert(t, Prim)
					end
				end

				table.insert(t, p1)

				if v1 then
					table.insert(t, v1)
				end

				local v2 = p1:FindFirstAncestorWhichIsA("Model")

				if v2 then
					table.insert(t, v2)
				end

				for v3, v4 in t do
					for v6, v7 in (v4 == p1 or v4 == v1) and v4:GetChildren() or v4:GetDescendants() do
						if v7:IsA("WeldConstraint") then
							if v7.Part0 == p1 then
								return v7, v7.Part1
							end

							if v7.Part1 == p1 then
								return v7, v7.Part0
							end
						end

						if v7:IsA("JointInstance") and (v7.Part0 == p1 or v7.Part1 == p1) then
							return v7, v7.Part0 == p1 and v7.Part1 or v7.Part0
						end
					end
				end

				return nil, nil
			end

			local Water = v3:FindFirstChild("Water")
			local Size = Water.Size
			local v12, v13 = FindWeldForWater(Water)

			if v12 then
				local _ = v12.Parent

				if v12:IsA("WeldConstraint") then
					local v14, v15, v16 = ReplaceWithManipulableWeld(v12, Water, v13)

					v9 = v14
					v10 = v15
					v11 = v16
				elseif v12:IsA("JointInstance") then
					v10 = v12.C0
					v11 = v12.C1
					v9 = v12
				end
			end

			local function SetWaterLevel(p1, p2, p3, p4, p5) --[[ SetWaterLevel | Line: 215 | Upvalues: Water (copy) ]]
				local v2 = math.max(p2.Y * math.clamp(p5, 0, 1), 0.001)

				Water.Size = Vector3.new(p2.X, v2, p2.Z)

				if not p1 then
					return
				end

				p1.C0 = p3 * CFrame.new(0, -((p2.Y - v2) / 2), 0)
			end

			local v17 = v9
			local v18 = Size
			local v19 = v10
			local v21 = math.max(v18.Y * 1, 0.001)

			Water.Size = Vector3.new(v18.X, v21, v18.Z)

			local v22 = (v18.Y - v21) / 2
			local v23, v24, v25, v26, v27, v28, v29

			if v17 then
				v17.C0 = v19 * CFrame.new(0, -v22, 0)
			end

			v23 = nil
			v24 = v8:GetMarkerReachedSignal("Start")
			v25 = function() --[[ Line: 239 | Upvalues: v23 (ref), v5 (copy), v2 (copy), v9 (ref), Size (ref), v10 (ref), v11 (ref), Water (copy) ]]
				if v23 then
					v23:Destroy()
				end

				game.TweenService:Create(v5.Frame, TweenInfo.new(0.3), {
					BackgroundTransparency = 1
				}):Play()

				for v1, v22 in v2.Nozzle.VFX:GetChildren() do
					v22.Enabled = false
					v22:Clear()
				end

				local v3 = v9
				local v4 = Size
				local v7 = math.max(v4.Y * 1, 0.001)

				Water.Size = Vector3.new(v4.X, v7, v4.Z)

				if not v3 then
					return
				end

				v3.C0 = v10 * CFrame.new(0, -((v4.Y - v7) / 2), 0)
			end
			table.insert(t2, v24:Connect(v25))
			v26 = v8:GetMarkerReachedSignal("Fire")
			v27 = function() --[[ Line: 254 | Upvalues: v2 (copy), v23 (ref), v8 (copy), v9 (ref), Size (ref), v10 (ref), v11 (ref), Water (copy) ]]
				for v1, v22 in v2.Nozzle.VFX:GetChildren() do
					v22:Emit(v22:GetAttribute("EmitCount") or 3)
					v22.Enabled = true
				end

				v23 = game.SoundService.SFX.PowerHose:Clone()
				v23.Parent = v2.Nozzle
				v23.TimePosition = 0
				v23.PlaybackSpeed = 1 + math.random(-15, 15) / 100
				v23.Playing = true
				game.Debris:AddItem(v23, v23.TimeLength * v23.PlaybackSpeed)
				task.spawn(function() --[[ Line: 271 | Upvalues: v8 (ref), v9 (ref), Size (ref), v10 (ref), v11 (ref), Water (ref) ]]
					local sum = 0

					while v8 and sum < 3 do
						sum = sum + game:GetService("RunService").Heartbeat:Wait()

						local v1 = v9
						local v2 = Size
						local v3 = v10
						local v6 = math.max(v2.Y * math.clamp(1 - math.clamp(sum / 3, 0, 1), 0, 1), 0.001)

						Water.Size = Vector3.new(v2.X, v6, v2.Z)

						local v82 = (v2.Y - v6) / 2

						if v1 then
							v1.C0 = v3 * CFrame.new(0, -v82, 0)
						end
					end
				end)
			end
			table.insert(t2, v26:Connect(v27))
			v28 = v8:GetMarkerReachedSignal("OffScreenTurnOff")
			table.insert(t2, v28:Connect(function() --[[ Line: 287 | Upvalues: v2 (copy) ]]
				for v1, v22 in v2.Nozzle.VFX:GetChildren() do
					v22.Enabled = false
				end
			end))
			v29 = v8:GetMarkerReachedSignal("FadeOut")
			table.insert(t2, v29:Connect(function() --[[ Line: 292 | Upvalues: v5 (copy) ]]
				game.TweenService:Create(v5.Frame, TweenInfo.new(0.3), {
					BackgroundTransparency = 0
				}):Play()
			end))
			v6.Looped = true
			v7.Looped = true
			v8.Looped = true
			v6:Play()
			v7:Play()
			v8:Play()
			Camera.FieldOfView = 20
			Trove:Add(function() --[[ Line: 311 | Upvalues: v5 (copy), v4 (ref), v6 (copy), v8 (copy), v7 (copy) ]]
				if v5 then
					v5:Destroy()
				end

				if v4 then
					v4:Disconnect()
				end

				if v6 then
					v6:Stop()
					v6:Destroy()
				end

				if v8 then
					v8:Stop()
					v8:Destroy()
				end

				if not v7 then
					return
				end

				v7:Stop()
				v7:Destroy()
			end)
		end
	end
end

return t