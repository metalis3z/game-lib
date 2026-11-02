--credit to leon games studio
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local Signal = require(ReplicatedStorage.ClientModules.Signal)
local FieldOfViewController = require(script.Parent.FieldOfViewController)
local ImpactTouch = game.SoundService.SFX.ImpactTouch

Signal.new()

local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local v1 = false
local v2 = nil
local v3 = nil
local v4 = 0
local v5 = 0
local v6 = 0
local v7 = nil
local v8 = OverlapParams.new()

v8.FilterType = Enum.RaycastFilterType.Include
v8.FilterDescendantsInstances = {}

local function rebuildOverlapFilter() --[[ rebuildOverlapFilter | Line: 49 | Upvalues: Players (copy), v8 (copy) ]]
	local t = {}

	for v1, v2 in Players:GetPlayers() do
		if v2.Character then
			table.insert(t, v2.Character)
		end
	end

	v8.FilterDescendantsInstances = t
end

Players.PlayerAdded:Connect(rebuildOverlapFilter)
Players.PlayerRemoving:Connect(rebuildOverlapFilter)
task.spawn(function() --[[ Line: 62 | Upvalues: rebuildOverlapFilter (copy) ]]
	while true do
		rebuildOverlapFilter()
		task.wait(5)
	end
end)
function t.GetPlantFromFruit(p1, p2) --[[ GetPlantFromFruit | Line: 69 ]]
	local v1 = p2.Parent

	if not v1 or v1 and v1.Name ~= "Fruits" then
		return
	end

	return v1.Parent
end
function t.UpdateAppearance(p1, p2, p3) --[[ UpdateAppearance | Line: 76 | Upvalues: TweenService (copy), ReplicatedStorage (copy), CollectionService (copy) ]]
	if p3 then
		local function applySwell(p1) --[[ applySwell | Line: 81 | Upvalues: TweenService (ref) ]]
			if p1:HasTag("PoisonIvySwell") then
				return false
			end

			p1:AddTag("PoisonIvySwell")

			if not p1:GetAttribute("originalSize") then
				p1:SetAttribute("originalSize", p1.Size)
			end

			if not p1:GetAttribute("originalColor") then
				p1:SetAttribute("originalColor", p1.Color)
			end

			local v1 = Random.new():NextNumber(1.1, 1.3)

			TweenService:Create(p1, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Size = p1.Size * v1,
				Color = Color3.new(0.737255, 0.184314, 0.184314)
			}):Play()

			return true
		end

		local t = {}
		local count = 0

		for v1, v2 in p2:GetChildren() do
			if v2:IsA("Part") and (not v2:IsA("Part") or v2.Transparency == 0) then
				table.insert(t, v2)

				local Part = Instance.new("Part")

				Part.Parent = p2
				Part.Shape = Enum.PartType.Ball
				Part.Size = Vector3.new(0.01, 0.01, 0.01)
				Part.Position = v2.Position + Vector3.new(v2.Size.X / 2.5, 0, Random.new():NextNumber(-v2.Size.Z / 2.5, v2.Size.Z / 2.5))
				Part.Color = Color3.fromRGB(255, 17, 21)
				Part.Anchored = false
				Part.CanCollide = false
				Part.CanQuery = false
				TweenService:Create(Part, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Size = Vector3.new(1, 1, 1) * Random.new():NextNumber(0.35, 0.75)
				}):Play()

				local WeldConstraint = Instance.new("WeldConstraint")

				WeldConstraint.Parent = Part
				WeldConstraint.Part0 = Part
				WeldConstraint.Part1 = v2
				Part:AddTag("PoisonIvyAppearance")

				if math.random(1, 3) == 1 and applySwell(v2) then
					count = count + 1
				end
			end
		end

		if count == 0 and #t > 0 then
			applySwell(t[math.random(1, #t)])
		end

		local PoisonIvyVFX = ReplicatedStorage.Assets.VFX.StatusVFX:FindFirstChild("PoisonIvyVFX")

		if PoisonIvyVFX == nil then
			return
		end

		for v7, v8 in PoisonIvyVFX:GetChildren() do
			local v9 = v8:Clone()

			v9.Parent = p2:FindFirstChild("Torso") or p2.PrimaryPart
			v9.Enabled = true
			v9:AddTag("PoisonIvyAppearance")
		end
	else
		for v11, v12 in CollectionService:GetTagged("PoisonIvyAppearance") do
			if v12:IsDescendantOf(p2) then
				v12:RemoveTag("PoisonIvyAppearance")

				if v12:IsA("ParticleEmitter") then
					v12.Enabled = false
					game.Debris:AddItem(v12, 1)

					continue
				end

				if v12:IsA("BasePart") then
					TweenService:Create(v12, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
						Size = Vector3.new(0.01, 0.01, 0.01)
					}):Play()
					game.Debris:AddItem(v12, 0.15)
				end
			end
		end

		for v13, v14 in CollectionService:GetTagged("PoisonIvySwell") do
			if v14:IsDescendantOf(p2) then
				v14:RemoveTag("PoisonIvySwell")

				if v14:GetAttribute("originalSize") and v14:GetAttribute("originalColor") then
					TweenService:Create(v14, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
						Size = v14:GetAttribute("originalSize"),
						Color = v14:GetAttribute("originalColor")
					}):Play()
				end
			end
		end
	end
end
function t.StartLocalPlayerEffects(p1) --[[ StartLocalPlayerEffects | Line: 189 | Upvalues: v1 (ref), v4 (ref), v5 (ref), v7 (ref), LocalPlayer (copy), v3 (ref), v2 (ref), RunService (copy), v6 (ref), FieldOfViewController (copy) ]]
	if v1 then
		return
	end

	v1 = true
	v4 = tick()
	v5 = 0
	v7 = nil

	local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

	if PlayerGui then
		v3 = Instance.new("ScreenGui")
		v3.Name = "PoisonIvyScreenEffect"
		v3.IgnoreGuiInset = true
		v3.ResetOnSpawn = false
		v3.DisplayOrder = 1000
		v3.Parent = PlayerGui

		local RedFlash = Instance.new("Frame")

		RedFlash.Name = "RedFlash"
		RedFlash.Size = UDim2.fromScale(1, 1)
		RedFlash.BackgroundColor3 = Color3.fromRGB(255, 55, 55)
		RedFlash.BackgroundTransparency = 1
		RedFlash.BorderSizePixel = 0
		RedFlash.ZIndex = 10
		RedFlash.Parent = v3
		v2 = RunService.RenderStepped:Connect(function() --[[ Line: 217 | Upvalues: v4 (ref), LocalPlayer (ref), v3 (ref), RedFlash (copy), v6 (ref), FieldOfViewController (ref), v5 (ref) ]]
			local v1 = tick() - v4
			local Character = LocalPlayer.Character
			local v2 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

			if v2 then
				local v32 = math.sin(v1 * 4) * 0.3 + math.sin(v1 * 7.3) * 0.1

				v2.CameraOffset = Vector3.new(v32, math.cos(v1 * 5.2) * 0.3 + math.sin(v1 * 9.1) * 0.08, 0)
			end

			if v3 and RedFlash.Parent then
				RedFlash.BackgroundTransparency = 0.95 - math.max(0, (math.sin(v1 * 2.5))) ^ 3 * 0.28
			end

			local v62 = math.sin(v1 * 1.8) * 15 + -35

			v6 = v62
			FieldOfViewController:SetAdjuster(v62, false)

			if not (v2 and (v2.Health > 0 and v1 - v5 >= 1)) then
				return
			end

			v5 = v1
			v2:TakeDamage(1)
		end)
	end
end
function t.StopLocalPlayerEffects(p1) --[[ StopLocalPlayerEffects | Line: 253 | Upvalues: v1 (ref), v2 (ref), LocalPlayer (copy), TweenService (copy), v7 (ref), v6 (ref), FieldOfViewController (copy), v3 (ref), Debris (copy) ]]
	if not v1 then
		return
	end

	v1 = false

	if v2 then
		v2:Disconnect()
		v2 = nil
	end

	local Character = LocalPlayer.Character

	if Character then
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		if Humanoid then
			TweenService:Create(Humanoid, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				CameraOffset = Vector3.new(0, 0, 0)
			}):Play()
		end
	end

	local t = {}

	v7 = t

	local v12 = v6

	task.spawn(function() --[[ Line: 279 | Upvalues: v7 (ref), t (copy), FieldOfViewController (ref), v12 (copy), v6 (ref) ]]
		local v1 = tick()

		while v7 == t do
			local v3 = math.min((tick() - v1) / 0.5, 1)

			FieldOfViewController:SetAdjuster(v12 * (1 - (1 - (1 - v3) ^ 3)), false)

			if v3 >= 1 then
				FieldOfViewController:SetAdjuster(0, false)
				v7 = nil
				v6 = 0

				return
			end

			task.wait()
		end
	end)

	if not v3 then
		return
	end

	local v22 = v3

	v3 = nil

	local RedFlash = v22:FindFirstChild("RedFlash")

	if RedFlash then
		local v32 = TweenInfo.new(0.5)
		local v4 = TweenService:Create(RedFlash, v32, {
			BackgroundTransparency = 1
		})

		v4:Play()
		Debris:AddItem(v4, v32.Time)
		v4.Completed:Connect(function() --[[ Line: 315 | Upvalues: v22 (copy) ]]
			v22:Destroy()
		end)

		return
	end

	v22:Destroy()
end
function t.ScheduleAppearanceRemoval(p1, p2) --[[ ScheduleAppearanceRemoval | Line: 324 | Upvalues: t4 (copy), t (copy), LocalPlayer (copy) ]]
	if p2.Character then
		local t2 = {}

		t4[p2] = t2
		task.delay(Random.new():NextNumber(7, 11), function() --[[ Line: 334 | Upvalues: t4 (ref), p2 (copy), t2 (copy), t (ref), LocalPlayer (ref) ]]
			if t4[p2] ~= t2 then
				return
			end

			t4[p2] = nil

			if p2.Character then
				t:UpdateAppearance(p2.Character, false)
			end

			if p2 ~= LocalPlayer then
				return
			end

			t:StopLocalPlayerEffects()
		end)
	end
end
function t.RegisterPoisonObject(p1, p2) --[[ RegisterPoisonObject | Line: 351 | Upvalues: t2 (copy) ]]
	table.insert(t2, {
		Object = p2
	})
end
function t.UnregisterPoisonObject(p1, p2) --[[ UnregisterPoisonObject | Line: 357 | Upvalues: t2 (copy) ]]
	for v1, v2 in t2 do
		if v2.Object == p2 then
			table.remove(t2, v1)

			return
		end
	end
end
function t.GetTouchingParts(p1, p2) --[[ GetTouchingParts | Line: 366 | Upvalues: Players (copy), v8 (copy), t (copy), LocalPlayer (copy), t3 (copy), t4 (copy), ImpactTouch (copy), Networking (copy) ]]
	local Position = p2.Position
	local v1 = false

	for v2, v3 in Players:GetPlayers() do
		local Character = v3.Character
		local v4 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

		if v4 and (v4.Position - Position).Magnitude < 30 then
			v1 = true

			break
		end
	end

	if not v1 then
		return
	end

	local v5 = workspace:GetPartsInPart(p2, v8)

	if #v5 == 0 then
		return
	end

	local t2 = {}

	for v6, v7 in v5 do
		if v7.Parent then
			local v82 = v7:FindFirstAncestorWhichIsA("Model")
			local v9 = if v82 then Players:GetPlayerFromCharacter(v82) else nil

			if v9 then
				local v10 = t:GetPlantFromFruit(p2.Parent)

				if v10 then
					local v11 = v10:GetAttribute("UserId")

					if v11 and (not v11 or v11 ~= LocalPlayer.UserId) then
						table.insert(t2, v9)

						if not table.find(t3, v9) then
							local v12 = if t4[v9] == nil then false else true

							t4[v9] = nil
							table.insert(t3, v9)

							if not v12 then
								t:UpdateAppearance(v9.Character, true)
							end

							if v9 == LocalPlayer then
								t:StartLocalPlayerEffects()
							end

							ImpactTouch.PlaybackSpeed = 1 + math.random(-15, 15) / 100
							ImpactTouch.TimePosition = 0
							ImpactTouch.Playing = true

							local v14 = p2.Parent and p2.Parent:GetAttribute("FruitId") or nil

							if v14 then
								Networking.PoisonIvyService.TouchBegan:Fire(v9.Character, v14)
							end
						end
					end
				end
			end
		end
	end

	return t2
end
function t.Routine(p1) --[[ Routine | Line: 429 | Upvalues: t2 (copy), t (copy), Players (copy), t3 (copy), Networking (copy) ]]
	local t4 = {}

	for v1, v2 in t2 do
		local v3 = t:GetTouchingParts(v2.Object)

		if v3 and (not v3 or #v3 ~= 0) then
			table.move(v3, 1, #v3, #t4 + 1, t4)
		end
	end

	for v4, v5 in Players:GetPlayers() do
		if not table.find(t4, v5) then
			local v6 = table.find(t3, v5)

			if v6 then
				table.remove(t3, v6)
				t:ScheduleAppearanceRemoval(v5)
				Networking.PoisonIvyService.TouchEnded:Fire(v5.Character)
			end
		end
	end
end
function t.Init(p1) --[[ Init | Line: 453 | Upvalues: CollectionService (copy), t (copy) ]]
	for v1, v2 in CollectionService:GetTagged("PoisonIvy") do
		t:RegisterPoisonObject(v2)
	end

	CollectionService:GetInstanceAddedSignal("PoisonIvy"):Connect(function(p1) --[[ Line: 458 | Upvalues: t (ref) ]]
		t:RegisterPoisonObject(p1)
	end)
	CollectionService:GetInstanceRemovedSignal("PoisonIvy"):Connect(function(p1) --[[ Line: 462 | Upvalues: t (ref) ]]
		t:UnregisterPoisonObject(p1)
	end)
	task.spawn(function() --[[ Line: 466 | Upvalues: t (ref) ]]
		while true do
			t:Routine()
			task.wait(0.5)
		end
	end)
end

return t