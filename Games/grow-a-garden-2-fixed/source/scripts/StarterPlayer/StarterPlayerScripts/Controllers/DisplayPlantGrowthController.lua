--credit to quartz games studio
local t = {}
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)
local Fruits2 = ReplicatedStorage.Assets.Fruits

SoundService:FindFirstChild("MusicTracks")

local t2 = {}

t2.Normal = SoundService:FindFirstChild("SFX") and SoundService.SFX:FindFirstChild("OfflineGrowthNormal")
t2.Intense = SoundService:FindFirstChild("SFX") and SoundService.SFX:FindFirstChild("OfflineGrowthIntense")

local t3 = {}
local t4 = {}
local t5 = {}

for v3, v4 in ReplicatedStorage.PlantGenerationModules.Plants:GetChildren() do
	if v4:IsA("ModuleScript") then
		t3[v4.Name] = require(v4)
	end
end

for v5, v6 in ReplicatedStorage.PlantGenerationModules.Fruits:GetChildren() do
	if v6:IsA("ModuleScript") then
		t4[v6.Name] = require(v6)
	end
end

for v7, v8 in SeedData do
	t5[v8.SeedName] = v8
end

local function StartGrowthSound(p1) --[[ StartGrowthSound | Line: 86 | Upvalues: t2 (copy), TweenService (copy) ]]
	local v2 = t2[if p1 then "Intense" else "Normal"]

	if v2 then
		v2.Looped = true
		v2.Volume = 0
		v2:Stop()
		v2:Play()

		local v3 = TweenService:Create(v2, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Volume = 2
		})

		v3:Play()

		return v2, v3
	end

	return nil, nil
end

local function StopGrowthSound(p1, p2) --[[ StopGrowthSound | Line: 115 | Upvalues: TweenService (copy) ]]
	if p1 then
		p1.Looped = false

		local v1 = TweenService:Create(p1, TweenInfo.new(p2 or 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Volume = 0
		})

		v1:Play()
		v1.Completed:Once(function() --[[ Line: 132 | Upvalues: p1 (copy) ]]
			if not (p1.Volume <= 0.01) then
				return
			end

			p1:Stop()
			p1.Volume = 2
		end)
	end
end

local function TweenAge(p1, p2, p3, p4, p5, p6, p7, p8) --[[ TweenAge | Line: 141 | Upvalues: TweenService (copy), RunService (copy) ]]
	if p4 <= 0 then
		p1:SetAttribute("Age", p3)

		if not p8 then
			return true
		end

		p8(p3, 1)

		return true
	end

	local v1 = os.clock()

	while p1.Parent do
		if p7 and p7() then
			break
		end

		local v3 = math.clamp((os.clock() - v1) / p4, 0, 1)
		local v4 = TweenService:GetValue(v3, p5, p6)
		local v5 = p2 + (p3 - p2) * v4

		p1:SetAttribute("Age", v5)

		if p8 then
			p8(v5, v4)
		end

		if v3 >= 0.5 then
			return true
		end

		RunService.Heartbeat:Wait()
	end

	return false
end

function t.GrowFruits(p1, p2, p3) --[[ GrowFruits | Line: 200 | Upvalues: t4 (copy), Fruits2 (copy), RunService (copy), TweenAge (copy) ]]
	local v1 = p3 or {}
	local v2 = v1.duration or 6
	local v3 = v1.seed or 0
	local v4 = v1.sizeMultiplier or 1
	local v5 = v1.easingStyle or Enum.EasingStyle.Sine
	local v6 = v1.easingDirection or Enum.EasingDirection.InOut
	local _cancelled = v1._cancelled
	local onComplete = v1.onComplete
	local v7 = t4[p1]

	if not v7 then
		return
	end

	local v8 = Fruits2:FindFirstChild(p1)

	if not v8 then
		return
	end

	local Fruits = p2:FindFirstChild("Fruits")

	if not Fruits then
		Fruits = Instance.new("Folder")
		Fruits.Name = "Fruits"
		Fruits.Parent = p2
	end

	local FruitSpawnLocations = p2:FindFirstChild("FruitSpawnLocations")

	if not FruitSpawnLocations then
		return
	end

	local v9 = v7.GrowData and v7.GrowData.MaxAge or 100
	local t = {}

	for v10, v11 in FruitSpawnLocations:GetChildren() do
		if v11:IsA("BasePart") then
			if _cancelled and _cancelled() then
				break
			end

			local function f12() --[[ Line: 249 | Upvalues: v8 (copy), v10 (copy), v9 (copy), v4 (copy), v11 (copy), v7 (copy), v3 (copy), RunService (ref), _cancelled (copy), Fruits (ref), TweenAge (ref), v2 (copy), v5 (copy), v6 (copy) ]]
				local v1 = v8:Clone()

				v1.Name = ("DisplayFruit_%d"):format(v10)
				v1:SetAttribute("Age", 0)
				v1:SetAttribute("MaxAge", v9)
				v1:SetAttribute("SizeMulti", v4)
				v1:PivotTo(v11.CFrame)
				v7.InitFruit(v1, v3 + v10, v4)

				repeat
					RunService.Heartbeat:Wait()
				until v1:HasTag("InitializationComplete") or _cancelled and _cancelled()

				if not (_cancelled and _cancelled()) then
					v7.BeginFruitGrowth(v1)
					v1.Parent = Fruits
					TweenAge(v1, 0, v9, v2, v5, v6, nil)

					if not (_cancelled and _cancelled()) then
						return
					end
				end

				v1:Destroy()
			end

			table.insert(t, f12)
		end
	end

	local v13 = 0

	for v14, v15 in t do
		task.spawn(function() --[[ Line: 289 | Upvalues: v15 (copy), v13 (ref) ]]
			v15()
			v13 = v13 + 1
		end)
	end

	while v13 < #t do
		RunService.Heartbeat:Wait()
	end

	if not onComplete then
		return
	end

	onComplete()
end
require(game.ReplicatedStorage.SharedModules.PlantSizeMultipliers)
function t.GrowPlant(p1, p2) --[[ GrowPlant | Line: 311 | Upvalues: t5 (copy), t3 (copy), RunService (copy), StartGrowthSound (copy), TweenAge (copy), StopGrowthSound (copy), t (copy), UserInputService (copy) ]]
	local v2 = p2 or {}
	local parent = v2.parent
	local v3 = v2.position or Vector3.new(0, 0, 0)
	local v4 = v2.seed or 0
	local _ = v2.sizeMultiplier or 1
	local v5 = v2.duration or 6
	local v6 = v2.startAge or 0
	local endAge = v2.endAge
	local v7 = v2.easingStyle or Enum.EasingStyle.Sine
	local v8 = v2.easingDirection or Enum.EasingDirection.InOut
	local v9 = if v2.playSound == false then false else true
	local v10 = v2.intense or false
	local onStep = v2.onStep
	local onComplete = v2.onComplete
	local onCancelled = v2.onCancelled

	assert(parent, "Parent is required")

	local v11 = false

	local function IsCancelled() --[[ IsCancelled | Line: 340 | Upvalues: v11 (ref) ]]
		return v11
	end

	local v12 = t5[p1]

	assert(v12, ("No seed data found for \'%s\'"):format(p1))

	local v13 = t3[p1]

	assert(v13, ("No generation module found for \'%s\'"):format(p1))

	local v14 = v12.PlantModel:Clone()

	v14:SetAttribute("SeedName", p1)
	v14:SetAttribute("MaxAge", v12.MaxAge or 1)
	v14:SetAttribute("Age", v6)
	v14:PivotTo(CFrame.new(v3))
	v14.Parent = parent

	local t2 = {}
	local v15 = true

	local function HidePart(p1) --[[ HidePart | Line: 367 | Upvalues: v15 (ref), t2 (ref) ]]
		if not v15 then
			return
		end

		if not p1:IsA("BasePart") then
			return
		end

		t2[p1] = p1.Transparency
		p1.Transparency = 1
	end

	for v16, v17 in v14:GetDescendants() do
		if v15 and v17:IsA("BasePart") then
			t2[v17] = v17.Transparency
			v17.Transparency = 1
		end
	end

	local v18 = v14.DescendantAdded:Connect(function(p1) --[[ Line: 379 | Upvalues: v15 (ref), t2 (ref) ]]
		if not v15 then
			return
		end

		if not p1:IsA("BasePart") then
			return
		end

		t2[p1] = p1.Transparency
		p1.Transparency = 1
	end)
	local camera = v2.camera
	local v19, v20, v21, v22, v23

	if camera then
		v19 = camera.CameraType
		v20 = camera.CameraSubject
		v21 = camera.CFrame
		v22 = camera.FieldOfView
		camera.CameraType = Enum.CameraType.Scriptable

		local v24 = camera.CFrame

		v23 = RunService.Heartbeat:Connect(function() --[[ Line: 405 | Upvalues: camera (copy), v24 (copy) ]]
			camera.CameraType = Enum.CameraType.Scriptable
			camera.CFrame = v24
		end)
	else
		v23 = nil
		v22 = nil
		v19 = nil
		v20 = nil
		v21 = nil
	end

	local function GetModelBounds() --[[ GetModelBounds | Line: 412 | Upvalues: v14 (copy) ]]
		local Rig = v14:FindFirstChild("Rig")

		if Rig then
			Rig.Parent = nil

			local ok, result, result2 = pcall(function() --[[ Line: 419 | Upvalues: v14 (ref) ]]
				return v14:GetBoundingBox()
			end)

			Rig.Parent = v14

			return ok, result, result2
		end

		return pcall(function() --[[ Line: 427 | Upvalues: v14 (ref) ]]
			return v14:GetBoundingBox()
		end)
	end

	local v25 = nil
	local v27 = math.clamp(math.random(1, 3), 1, 3)

	task.spawn(function() --[[ Line: 442 | Upvalues: v13 (copy), v14 (copy), v4 (copy), v27 (ref), RunService (ref), v11 (ref), v23 (ref), v15 (ref), v18 (copy), v6 (copy), t2 (ref), endAge (ref), v25 (ref), v9 (copy), StartGrowthSound (ref), v10 (copy), camera (copy), GetModelBounds (copy), TweenAge (ref), v5 (copy), v7 (copy), v8 (copy), IsCancelled (copy), onStep (copy), StopGrowthSound (ref), v2 (ref), t (ref), p1 (copy), UserInputService (ref), v22 (ref), onComplete (copy), onCancelled (copy) ]]
		v13.InitPlant(v14, v4, v27)

		repeat
			RunService.Heartbeat:Wait()
		until v14:HasTag("InitializationComplete") or v11

		v15 = false

		if v11 then
			if v23 then
				v23:Disconnect()
				v23 = nil
			end

			v18:Disconnect()
			v14:Destroy()
		else
			v13.BeginPlantGrowth(v14)
			v18:Disconnect()
			v14:SetAttribute("Age", v6)

			for v1, v24 in t2 do
				if v1 and v1.Parent then
					v1.Transparency = v24
				end
			end

			t2 = nil

			if endAge == nil then
				endAge = v14:GetAttribute("MaxAge") or 1
			end

			v25 = if v9 then StartGrowthSound(v10) or nil else nil

			local Position = v14:GetPivot().Position
			local v42 = camera.CFrame.Position - Position
			local v72 = Vector3.new(-v42.X, 0, -v42.Z)
			local Highlight = Instance.new("Highlight")

			Highlight.FillColor = Color3.fromRGB(255, 255, 255)
			Highlight.FillTransparency = 1
			Highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
			Highlight.OutlineTransparency = 0.75
			Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
			Highlight.Parent = v14

			if v72.Magnitude < 0.01 then
				v72 = Vector3.new(0, 0, -1)
			end

			local Unit = v72.Unit
			local Unit2 = Unit:Cross(Vector3.new(0, 1, 0)).Unit
			local v82 = Position + Unit * 10
			local v92 = 7
			local v102 = 0
			local v112 = 24
			local v12 = camera.CFrame

			local function SmoothAlpha(p1, p2) --[[ SmoothAlpha | Line: 534 ]]
				return 1 - math.exp(-p1 * math.max(p2, 1 / 60))
			end

			local function CalculateTargetCameraCFrame(p1, p2, p3, p4) --[[ CalculateTargetCameraCFrame | Line: 538 | Upvalues: GetModelBounds (ref), Position (copy), camera (ref), v82 (ref), v92 (ref), v102 (ref), v112 (ref), Unit (ref), Unit2 (copy) ]]
				local v1 = 5
				local v2 = 0
				local v3, v4, v5 = GetModelBounds()

				if v3 and (v4 and v5) then
					v1, v2 = math.max(v1, v5.Magnitude * 0.5), math.max(v2, v5.Y * 0.35)
				end

				local v12 = math.rad(camera.FieldOfView * 0.5)
				local v13 = math.max(v1, 5) * 1.4
				local v16 = math.clamp(v13 / math.tan((math.max(v12, 0.1))) + 8, 20, 58)

				v82 = v82:Lerp(v3 and v4 and v4.Position or Position, 1 - math.exp(math.max(p4, 1 / 60) * -0.6))
				v92 = v92 + (v13 - v92) * (1 - math.exp(math.max(p4, 1 / 60) * -0.4))
				v102 = v102 + (v2 - v102) * (1 - math.exp(math.max(p4, 1 / 60) * -0.5))
				v112 = v112 + (v16 - v112) * (1 - math.exp(math.max(p4, 1 / 60) * -0.4))

				local Unit3 = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), math.sin(p3 * 0.55) * 0.075):VectorToWorldSpace(Unit).Unit
				local v29 = Unit2 * (math.sin(p3 * 0.55 * 0.6) * 1.25)
				local v31 = math.clamp(p1 * 5 + 5 + v102 * 0.12, 4, 12)
				local v33 = math.clamp(1.2 - v102 * 0.08, 0.35, 1.2)

				return CFrame.new(v82 - Unit3 * v112 + Vector3.new(0, v31, 0) + v29, v82 + Vector3.new(0, v33, 0))
			end

			local v132 = false
			local v142 = false
			local v152 = os.clock()
			local v16 = 0

			task.spawn(function() --[[ Line: 585 | Upvalues: TweenAge (ref), v14 (ref), v6 (ref), endAge (ref), v5 (ref), v7 (ref), v8 (ref), IsCancelled (ref), onStep (ref), v142 (ref), v132 (ref) ]]
				local v1 = TweenAge(v14, v6, endAge, v5, v7, v8, IsCancelled, onStep)

				v142 = not v1

				if v1 then
					v14:SetAttribute("Age", endAge)
				end

				v132 = true
			end)

			if camera then
				if v23 then
					v23:Disconnect()
					v23 = nil
				end

				local v17 = CalculateTargetCameraCFrame(0, 0, 0, 1 / 60)

				camera.CFrame = v17
				v12 = v17

				while not v132 and (not v11 and v14.Parent) do
					local v182 = os.clock() - v152
					local v20 = math.clamp(v182 / v5, 0, 1)

					camera.CameraType = Enum.CameraType.Scriptable

					local v222 = v12:Lerp(CalculateTargetCameraCFrame(v20 < 0.5 and v20 * 2 * v20 or 1 - (v20 * -2 + 2) ^ 3 / 2, v20, v182, v16), (math.clamp(((1 - v20) * 0.45 + 0.55) * 0.8 * v16, 0, 0.12)))

					camera.CFrame = v222
					v16, v12 = RunService.Heartbeat:Wait(), v222
				end
			end

			while not v132 do
				RunService.Heartbeat:Wait()
			end

			local v24 = not v142

			if camera and v24 then
				StopGrowthSound(v25, 1.5)

				local v252 = v2.idleDuration or 3
				local v26 = os.clock()

				task.spawn(function() --[[ Line: 656 | Upvalues: t (ref), p1 (ref), v14 (ref), v2 (ref), v5 (ref), v4 (ref), v27 (ref), v7 (ref), v8 (ref), IsCancelled (ref) ]]
					local t2 = {}

					t2.duration = v2.fruitDuration or v5
					t2.seed = v4
					t2.sizeMultiplier = v27
					t2.easingStyle = v7
					t2.easingDirection = v8
					t2._cancelled = IsCancelled
					t.GrowFruits(p1, v14, t2)
				end)

				local v272, v28, _ = GetModelBounds()
				local v29 = v272 and v28 and v28.Position or v14:GetPivot().Position
				local v30 = 0
				local v31 = 0
				local v32 = false
				local v33 = os.clock()
				local v34 = UserInputService:GetMouseLocation()
				local v35 = 0
				local v36 = os.clock()
				local t3 = {}
				local v37 = nil
				local v38 = UserInputService.InputChanged:Connect(function(p1) --[[ Line: 691 | Upvalues: v35 (ref), v36 (ref), t3 (ref), v37 (ref), v32 (ref), UserInputService (ref), v34 (ref), v30 (ref), v31 (ref), v33 (ref) ]]
					if p1.UserInputType == Enum.UserInputType.MouseWheel then
						v35 = math.max(v35 + p1.Position.Z * 4, -8)
						v36 = os.clock()

						return
					end

					if p1.UserInputType == Enum.UserInputType.Touch then
						t3[p1] = p1.Position

						local t = {}

						for v2, v3 in t3 do
							table.insert(t, v3)
						end

						if #t == 2 then
							local Magnitude = (t[1] - t[2]).Magnitude

							if v37 ~= nil then
								v35 = math.max(v35 + (Magnitude - v37) * 0.18, -8)
								v36 = os.clock()
							end

							v37 = Magnitude

							return
						end

						v37 = nil
					end

					if not v32 then
						return
					end

					if p1.UserInputType == Enum.UserInputType.MouseMovement or p1.UserInputType == Enum.UserInputType.Touch then
						local v5 = UserInputService:GetMouseLocation()
						local v6 = v5 - v34

						v34 = v5
						v30 = v30 - v6.X * 0.4
						v31 = math.clamp(v31 - v6.Y * 0.4, -30, 30)
						v33 = os.clock()
					end
				end)
				local v39 = UserInputService.InputBegan:Connect(function(p1) --[[ Line: 736 | Upvalues: t3 (ref), v32 (ref), v33 (ref), v34 (ref), UserInputService (ref) ]]
					if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Touch then
						return
					end

					t3[p1] = p1.Position
					v32 = true
					v33 = os.clock()
					v34 = UserInputService:GetMouseLocation()
				end)
				local v40 = UserInputService.InputEnded:Connect(function(p1) --[[ Line: 745 | Upvalues: t3 (ref), v37 (ref), v32 (ref) ]]
					if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Touch then
						return
					end

					t3[p1] = nil
					v37 = nil

					local v1 = false

					for v2 in t3 do
						v1 = true

						break
					end

					if v1 then
						return
					end

					v32 = false
				end)
				local v41 = false

				while not (v11 or v11) do
					local v422 = os.clock() - v26
					local v43 = math.clamp(v422 / 2, 0, 1)
					local v44 = os.clock() - v152

					if not v32 then
						math.clamp((v422 - 2) / math.max(v252, 0.001), 0, 1)
					end

					if os.clock() - v36 >= 2.5 then
						v35 = v35 * (1 - (1 - math.exp(v16 * -2.5)))
					end

					v35 = math.clamp(v35, -8, 22)

					local v48 = math.clamp(v35 + 0, -8, 40)

					camera.FieldOfView = v22

					if not v32 and os.clock() - v33 >= 2 then
						local v49 = 1 - math.exp(v16 * -3.5)

						v30 = v30 * (1 - v49)
						v31 = v31 * (1 - v49)
					end

					if not v41 and 2 + v252 <= v422 then
						v41 = true

						if onComplete then
							task.spawn(function() --[[ Line: 807 | Upvalues: onComplete (ref), v14 (ref) ]]
								onComplete(v14)
							end)
						end
					end

					local v50 = CalculateTargetCameraCFrame(1, 1, v44, v16)
					local v522 = v50:Lerp(CFrame.new(v50.Position + (v29 - v50.Position).Unit * v48 + Vector3.new(0, -1.25, 0), v29 + Vector3.new(0, 0.55, 0)), v43)

					if math.abs(v30) > 0.001 or math.abs(v31) > 0.001 then
						v522 = CFrame.new((CFrame.new(v29) * CFrame.Angles(0, math.rad(v30), 0) * CFrame.Angles(math.rad(v31), 0, 0) * CFrame.new(v522.Position - v29)).Position, v29 + Vector3.new(0, 0.55, 0))
					end

					local v57 = v12:Lerp(v522, (math.clamp(v16 * 3.2, 0, 0.1)))

					camera.CFrame = v57
					v12, v16 = v57, RunService.Heartbeat:Wait()
				end

				v38:Disconnect()
				v39:Disconnect()
				v40:Disconnect()
				t3 = {}
				v37 = nil
			end

			if v24 then
				if onComplete then
					onComplete(v14)
				end
			elseif onCancelled then
				onCancelled(v14)
			end
		end
	end)

	return function(p1) --[[ Line: 867 | Upvalues: v11 (ref), StopGrowthSound (ref), v25 (ref), v15 (ref), v18 (copy), v23 (ref), camera (copy), v19 (ref), v20 (ref), v22 (ref), v21 (ref) ]]
		v11 = true
		StopGrowthSound(v25, 1.5)
		v15 = false

		if v18 then
			v18:Disconnect()
		end

		if v23 then
			v23:Disconnect()
			v23 = nil
		end

		if p1 or not camera then
			return
		end

		camera.CameraType = v19
		camera.CameraSubject = v20
		camera.FieldOfView = v22
		camera.CFrame = v21
	end
end

return t