--credit to prince games studio
local t = {}
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local NotificationController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController)
local FieldOfViewController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController)
local LightingController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController)
local Bloodmoon = ReplicatedStorage.Assets:WaitForChild("Bloodmoon")
local t2 = {
	Brightness = 3,
	EnvironmentDiffuseScale = 1,
	ClockTime = 3.1,
	Ambient = Color3.fromRGB(115, 45, 45),
	ColorShift_Bottom = Color3.fromRGB(171, 34, 34),
	ColorShift_Top = Color3.fromRGB(250, 19, 19),
	OutdoorAmbient = Color3.fromRGB(180, 54, 54)
}
local v1 = Color3.fromRGB(255, 20, 20)
local v2 = Color3.fromRGB(200, 40, 40)
local LaserBeam = SoundService:WaitForChild("SFX"):WaitForChild("LaserBeam")
local v3 = Color3.fromRGB(255, 30, 30)
local t3 = {
	Color3.fromRGB(255, 10, 10),
	Color3.fromRGB(220, 0, 0),
	Color3.fromRGB(180, 10, 10),
	Color3.fromRGB(255, 30, 20),
	Color3.fromRGB(150, 0, 0),
	Color3.fromRGB(255, 50, 30)
}
local Bloodmoon2 = SoundService:WaitForChild("MusicTracks"):WaitForChild("Bloodmoon")
local v4 = false
local v5 = nil
local v6 = nil
local v7 = 0
local v8 = 0
local v9 = 0
local v10 = 0
local v11 = 0
local v12 = 0
local t4 = {}
local CurrentCamera = workspace.CurrentCamera
local v13 = Random.new()
local BloodmoonFlash = Instance.new("ColorCorrectionEffect")

BloodmoonFlash.Name = "BloodmoonFlash"
BloodmoonFlash.Brightness = 0
BloodmoonFlash.Parent = Lighting

local BloodmoonBeams = Instance.new("Folder")

BloodmoonBeams.Name = "BloodmoonBeams"
BloodmoonBeams.Parent = workspace

local function getStartPart() --[[ getStartPart | Line: 134 | Upvalues: v5 (ref) ]]
	if v5 then
		return v5:FindFirstChild("START_PART")
	end

	return nil
end

local function getHitPointsPart() --[[ getHitPointsPart | Line: 139 | Upvalues: v5 (ref) ]]
	if v5 then
		return v5:FindFirstChild("HIT_POINTS")
	end

	return nil
end

local function getRandomHitOnPart(p1) --[[ getRandomHitOnPart | Line: 144 | Upvalues: v13 (copy) ]]
	local Size = p1.Size

	return p1.CFrame:PointToWorldSpace((Vector3.new(v13:NextNumber(-Size.X / 2, Size.X / 2), v13:NextNumber(-Size.Y / 2, Size.Y / 2), v13:NextNumber(-Size.Z / 2, Size.Z / 2))))
end

local function getMaxLoudness() --[[ getMaxLoudness | Line: 154 | Upvalues: Bloodmoon2 (copy) ]]
	local v1 = 0

	for v2, v3 in Bloodmoon2:GetChildren() do
		if v3:IsA("Sound") and (v3.IsPlaying and v1 < v3.PlaybackLoudness) then
			v1 = v3.PlaybackLoudness
		end
	end

	return v1
end

local function getBeamRate(p1) --[[ getBeamRate | Line: 166 ]]
	if p1 >= 170 then
		return 0.04
	end

	if p1 >= 130 then
		return (p1 - 130) / 40 * -0.07999999999999999 + 0.12
	end

	if p1 >= 80 then
		return (p1 - 80) / 50 * -0.28 + 0.4
	end

	if p1 >= 40 then
		return (p1 - 40) / 40 * -1.1 + 1.5
	end

	return 1.5
end

local function randomExplosionColor() --[[ randomExplosionColor | Line: 183 | Upvalues: t3 (copy), v13 (copy) ]]
	return t3[v13:NextInteger(1, #t3)]
end

local function lerpVector(p1, p2, p3) --[[ lerpVector | Line: 187 ]]
	return p1 + (p2 - p1) * p3
end

local function screenFlash() --[[ screenFlash | Line: 195 | Upvalues: v12 (ref), BloodmoonFlash (copy), TweenService (copy) ]]
	local v1 = os.clock()

	if not (v1 - v12 < 0.3) then
		v12 = v1
		BloodmoonFlash.Brightness = 2
		BloodmoonFlash.Saturation = -0.3
		TweenService:Create(BloodmoonFlash, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Brightness = 0,
			Saturation = 0
		}):Play()
	end
end

local function spawnBloodmoonModel() --[[ spawnBloodmoonModel | Line: 214 | Upvalues: v5 (ref), Bloodmoon (copy), TweenService (copy) ]]
	if v5 then
		return
	end

	v5 = Bloodmoon:Clone()
	v5.Name = "ActiveBloodmoon"

	local t = {}

	for v1, v2 in v5:GetDescendants() do
		if v2:IsA("BasePart") then
			if v2:GetAttribute("OGTransparency") == nil then
				v2:SetAttribute("OGTransparency", v2.Transparency)
			end

			v2.Transparency = 1
			table.insert(t, v2)
		end
	end

	v5.Parent = workspace

	local v3 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

	for v4, v52 in t do
		task.delay(v4 * 0.05, function() --[[ Line: 235 | Upvalues: v52 (copy), TweenService (ref), v3 (copy) ]]
			if not (v52 and v52.Parent) then
				return
			end

			TweenService:Create(v52, v3, {
				Transparency = v52:GetAttribute("OGTransparency")
			}):Play()
		end)
	end
end

local function removeBloodmoonModel() --[[ removeBloodmoonModel | Line: 243 | Upvalues: v5 (ref), TweenService (copy) ]]
	if not v5 then
		return
	end

	local t = {}

	for v1, v2 in v5:GetDescendants() do
		if v2:IsA("BasePart") then
			table.insert(t, v2)
		end
	end

	local v3 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In)

	for v4, v52 in t do
		TweenService:Create(v52, v3, {
			Transparency = 1
		}):Play()
	end

	local v6 = v5

	v5 = nil
	task.delay(2.1, function() --[[ Line: 260 | Upvalues: v6 (copy) ]]
		if not (v6 and v6.Parent) then
			return
		end

		v6:Destroy()
	end)
end

local function spawnExplosion(p1) --[[ spawnExplosion | Line: 271 | Upvalues: t3 (copy), v13 (copy), BloodmoonBeams (copy), TweenService (copy) ]]
	for i = 1, 16 do
		local v1 = i / 16 * math.pi * 2
		local Part = Instance.new("Part")

		Part.Size = Vector3.new(5, 0.8, 5)
		Part.CFrame = CFrame.new(p1) * CFrame.Angles(0, v1, 0)
		Part.Anchored = false
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.CastShadow = false
		Part.Material = Enum.Material.Neon
		Part.Color = t3[v13:NextInteger(1, #t3)]
		Part.Transparency = 0
		Part.Parent = BloodmoonBeams

		local v2 = 120 * (0.8 + v13:NextNumber() * 0.4)
		local v3 = v13:NextNumber(10, 25)

		Part.AssemblyLinearVelocity = Vector3.new(math.cos(v1) * v2, v3, math.sin(v1) * v2)
		Part.AssemblyAngularVelocity = Vector3.new(v13:NextNumber(-10, 10), v13:NextNumber(-10, 10), v13:NextNumber(-10, 10))
		TweenService:Create(Part, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Transparency = 1,
			Size = Vector3.new(0.3, 0.1, 0.3)
		}):Play()
		task.delay(1.1, function() --[[ Line: 306 | Upvalues: Part (copy) ]]
			Part:Destroy()
		end)
	end

	for j = 1, 10 do
		local Part = Instance.new("Part")

		Part.Size = Vector3.new(2, 2, 2) + Vector3.new(3, 3, 3) * v13:NextNumber(0, 1)
		Part.Position = p1 + Vector3.new(v13:NextNumber(-2, 2), v13:NextNumber(0, 3), v13:NextNumber(-2, 2))
		Part.Anchored = false
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.CastShadow = false
		Part.Material = Enum.Material.Neon
		Part.Color = t3[v13:NextInteger(1, #t3)]
		Part.Transparency = 0
		Part.Parent = BloodmoonBeams

		local v12 = v13:NextNumber(0, 6.283185307179586)
		local v132 = 80 * (0.5 + v13:NextNumber() * 0.5)

		Part.AssemblyLinearVelocity = Vector3.new(math.cos(v12) * v132, 80 * (0.6 + v13:NextNumber() * 0.8), math.sin(v12) * v132)
		Part.AssemblyAngularVelocity = Vector3.new(v13:NextNumber(-15, 15), v13:NextNumber(-15, 15), v13:NextNumber(-15, 15))
		TweenService:Create(Part, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Transparency = 1,
			Size = Vector3.new(0.2, 0.2, 0.2)
		}):Play()
		task.delay(1.3, function() --[[ Line: 349 | Upvalues: Part (copy) ]]
			Part:Destroy()
		end)
	end

	local Part = Instance.new("Part")

	Part.Shape = Enum.PartType.Ball
	Part.Size = Vector3.new(17, 17, 17)
	Part.Position = p1
	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.CastShadow = false
	Part.Material = Enum.Material.Neon
	Part.Color = Color3.fromRGB(255, 0, 0)
	Part.Transparency = 0
	Part.Parent = BloodmoonBeams
	TweenService:Create(Part, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = Vector3.new(100, 100, 100),
		Transparency = 1
	}):Play()
	task.delay(0.35, function() --[[ Line: 374 | Upvalues: Part (copy) ]]
		Part:Destroy()
	end)
end

local function positionBeamSegment(p1, p2, p3, p4) --[[ positionBeamSegment | Line: 383 ]]
	local Magnitude = (p3 - p2).Magnitude

	p1.Size = Vector3.new(p4, p4, Magnitude)
	p1.CFrame = CFrame.lookAt(p2, p3) * CFrame.new(0, 0, -Magnitude / 2)
end

local function createBeamPart(p1, p2) --[[ createBeamPart | Line: 389 | Upvalues: BloodmoonBeams (copy) ]]
	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.CastShadow = false
	Part.Material = Enum.Material.Neon
	Part.Color = p2
	Part.Transparency = 1
	Part.Parent = BloodmoonBeams

	return Part
end

local function fireBeam(p1) --[[ fireBeam | Line: 403 | Upvalues: v5 (ref), v1 (copy), BloodmoonBeams (copy), v2 (copy), v3 (copy), v13 (copy), t4 (ref), LaserBeam (copy), TweenService (copy), Debris (copy), spawnExplosion (copy), v9 (ref), CurrentCamera (copy), v8 (ref), v7 (ref), LocalPlayer (copy), screenFlash (copy) ]]
	local v12 = if v5 then v5:FindFirstChild("START_PART") else nil

	if not v12 then
		return
	end

	local Position = v12.Position
	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.CastShadow = false
	Part.Material = Enum.Material.Neon
	Part.Color = v1
	Part.Transparency = 1
	Part.Parent = BloodmoonBeams

	local v32 = Part
	local Part2 = Instance.new("Part")

	Part2.Anchored = true
	Part2.CanCollide = false
	Part2.CanQuery = false
	Part2.CanTouch = false
	Part2.CastShadow = false
	Part2.Material = Enum.Material.Neon
	Part2.Color = v2
	Part2.Transparency = 1
	Part2.Parent = BloodmoonBeams

	local v52 = Part2
	local v6 = p1 + Vector3.new(0, -15, 0)
	local Magnitude = (v6 - Position).Magnitude

	v32.Size = Vector3.new(30, 30, Magnitude)
	v32.CFrame = CFrame.lookAt(Position, v6) * CFrame.new(0, 0, -Magnitude / 2)

	local Magnitude2 = (v6 - Position).Magnitude

	v52.Size = Vector3.new(45, 45, Magnitude2)
	v52.CFrame = CFrame.lookAt(Position, v6) * CFrame.new(0, 0, -Magnitude2 / 2)

	local Part3 = Instance.new("Part")

	Part3.Shape = Enum.PartType.Ball
	Part3.Size = Vector3.new(3, 3, 3)
	Part3.Position = p1
	Part3.Anchored = true
	Part3.CanCollide = false
	Part3.CanQuery = false
	Part3.CanTouch = false
	Part3.CastShadow = false
	Part3.Material = Enum.Material.Neon
	Part3.Color = v3
	Part3.Transparency = 1
	Part3.Parent = BloodmoonBeams

	local t = {
		alive = true,
		beam = v32,
		glow = v52,
		startPos = Position,
		hitPos = p1,
		birthTime = os.clock(),
		seedX = v13:NextNumber(0, 100),
		seedZ = v13:NextNumber(0, 100)
	}
	local v72 = t4

	table.insert(v72, t)

	local v82 = LaserBeam:Clone()

	v82.Volume = 8
	v82.RollOffMaxDistance = 300
	v82.RollOffMinDistance = 20
	v82.Parent = v12
	v82:Play()
	v82.Ended:Once(function() --[[ Line: 448 | Upvalues: v82 (copy) ]]
		v82:Destroy()
	end)

	local Part4 = Instance.new("Part")

	Part4.Size = Vector3.new(1, 1, 1)
	Part4.Position = p1
	Part4.Anchored = true
	Part4.CanCollide = false
	Part4.CanQuery = false
	Part4.CanTouch = false
	Part4.Transparency = 1
	Part4.Parent = BloodmoonBeams

	local v92 = LaserBeam:Clone()

	v92.Volume = 7
	v92.PlaybackSpeed = 0.6 + v13:NextNumber() * 0.5
	v92.RollOffMaxDistance = 200
	v92.RollOffMinDistance = 15
	v92.Parent = Part4
	v92:Play()
	v92.Ended:Once(function() --[[ Line: 469 | Upvalues: Part4 (copy) ]]
		Part4:Destroy()
	end)

	local v10 = TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v11 = TweenService:Create(v32, v10, {
		Transparency = 0
	})

	v11:Play()
	Debris:AddItem(v11, v10.Time)

	local v122 = TweenService:Create(v52, v10, {
		Transparency = 0.5
	})

	v122:Play()
	Debris:AddItem(v122, v10.Time)

	local v132 = TweenService:Create(Part3, v10, {
		Transparency = 0.1
	})

	v132:Play()
	Debris:AddItem(v132, v10.Time)
	task.delay(0.06, function() --[[ Line: 485 | Upvalues: TweenService (ref), Part3 (copy), Debris (ref), spawnExplosion (ref), p1 (copy) ]]
		local v1 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v2 = TweenService:Create(Part3, v1, {
			Size = Vector3.new(12, 12, 12),
			Transparency = 0.5
		})

		v2:Play()
		Debris:AddItem(v2, v1.Time)
		spawnExplosion(p1)
	end)
	task.delay(0.31, function() --[[ Line: 496 | Upvalues: TweenService (ref), v32 (copy), Debris (ref), v52 (copy), Part3 (copy), t (copy), t4 (ref) ]]
		local v1 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
		local v2 = TweenService:Create(v32, v1, {
			Transparency = 1
		})

		v2:Play()
		Debris:AddItem(v2, v1.Time)

		local v3 = TweenService:Create(v52, v1, {
			Transparency = 1
		})

		v3:Play()
		Debris:AddItem(v3, v1.Time)

		local v4 = TweenService:Create(Part3, v1, {
			Transparency = 1
		})

		v4:Play()
		Debris:AddItem(v4, v1.Time)
		task.delay(0.4, function() --[[ Line: 508 | Upvalues: t (ref) ]]
			t.alive = false
		end)
		task.delay(0.9, function() --[[ Line: 512 | Upvalues: v32 (ref), v52 (ref), Part3 (ref), t4 (ref), t (ref) ]]
			v32:Destroy()
			v52:Destroy()
			Part3:Destroy()

			for i = #t4, 1, -1 do
				if t4[i] == t then
					table.remove(t4, i)

					return
				end
			end
		end)
	end)

	local v15 = math.clamp(v9 / 170, 0, 1) * 2.2 + 0.8
	local Magnitude3 = (CurrentCamera.CFrame.Position - p1).Magnitude

	if Magnitude3 <= 60 then
		local v16 = 1 - Magnitude3 / 60

		v8 = math.max(v8, v15 * v16 * v16)
		v7 = os.clock() + 0.3
	end

	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not (HumanoidRootPart and (HumanoidRootPart.Position - p1).Magnitude <= 50) then
		return
	end

	screenFlash()
end

local function updateBeamWiggles(p1) --[[ updateBeamWiggles | Line: 552 | Upvalues: t4 (ref) ]]
	for v1, v2 in t4 do
		if v2.alive and (v2.beam.Parent and v2.glow.Parent) then
			local v3 = (p1 - v2.birthTime) * 12
			local v5 = math.sin(v3 + v2.seedX) * 8
			local v7 = math.cos(v3 * 0.7 + v2.seedZ) * 8
			local v12 = v2.startPos + Vector3.new(math.sin(v3 * 1.3 + v2.seedX + 2) * 2, 0, math.cos(v3 * 0.9 + v2.seedZ + 2) * 2)
			local v13 = v2.hitPos + Vector3.new(v5, -15, v7)
			local beam = v2.beam
			local Magnitude = (v13 - v12).Magnitude

			beam.Size = Vector3.new(30, 30, Magnitude)
			beam.CFrame = CFrame.lookAt(v12, v13) * CFrame.new(0, 0, -Magnitude / 2)

			local glow = v2.glow
			local Magnitude2 = (v13 - v12).Magnitude

			glow.Size = Vector3.new(45, 45, Magnitude2)
			glow.CFrame = CFrame.lookAt(v12, v13) * CFrame.new(0, 0, -Magnitude2 / 2)
		end
	end
end

local function startUpdateLoop() --[[ startUpdateLoop | Line: 578 | Upvalues: v6 (ref), v10 (ref), v11 (ref), v12 (ref), RunService (copy), v9 (ref), getMaxLoudness (copy), screenFlash (copy), FieldOfViewController (copy), updateBeamWiggles (copy), v7 (ref), v8 (ref), CurrentCamera (copy) ]]
	if not v6 then
		v10 = os.clock()
		v11 = os.clock()
		v12 = 0
		v6 = RunService.RenderStepped:Connect(function(p13) --[[ Line: 585 | Upvalues: v9 (ref), getMaxLoudness (ref), v11 (ref), screenFlash (ref), FieldOfViewController (ref), updateBeamWiggles (ref), v7 (ref), v8 (ref), CurrentCamera (ref) ]]
			local v1 = os.clock()

			v9 = getMaxLoudness()

			if v1 - v11 >= 0.5 then
				v11 = v1
			end

			if v9 >= 170 then
				screenFlash()
			end

			FieldOfViewController:SetAdjuster(math.clamp((v9 - 40) / 130, 0, 1) * 15)
			updateBeamWiggles(v1)

			if not (v1 < v7 and v8 > 0) then
				return
			end

			local v3 = v8 * ((v7 - v1) / 0.3)
			local v4 = math.sin(v1 * 30 * 6.28) * v3
			local v5 = math.cos(v1 * 30 * 4.17) * v3

			CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(v4, v5, math.sin(v1 * 30 * 5.23 + 1) * v3 * 0.5)
		end)
	end
end

local function stopUpdateLoop() --[[ stopUpdateLoop | Line: 621 | Upvalues: v6 (ref), v8 (ref), t4 (ref), FieldOfViewController (copy) ]]
	if v6 then
		v6:Disconnect()
		v6 = nil
	end

	v8 = 0
	t4 = {}
	FieldOfViewController:ClearAdjuster()
end

function t.Start(p1, p2, p3) --[[ Start | Line: 635 | Upvalues: v4 (ref), NotificationController (copy), LightingController (copy), t2 (copy), spawnBloodmoonModel (copy), v6 (ref), v10 (ref), v11 (ref), v12 (ref), RunService (copy), v9 (ref), getMaxLoudness (copy), screenFlash (copy), FieldOfViewController (copy), updateBeamWiggles (copy), v7 (ref), v8 (ref), CurrentCamera (copy) ]]
	if v4 then
		return
	end

	v4 = true
	NotificationController:CreateNotification("A blood moon is rising...")
	LightingController:TransitionTo(t2)
	spawnBloodmoonModel()

	if not v6 then
		v10 = os.clock()
		v11 = os.clock()
		v12 = 0
		v6 = RunService.RenderStepped:Connect(function(p13) --[[ Line: 585 | Upvalues: v9 (ref), getMaxLoudness (ref), v11 (ref), screenFlash (ref), FieldOfViewController (ref), updateBeamWiggles (ref), v7 (ref), v8 (ref), CurrentCamera (ref) ]]
			local v1 = os.clock()

			v9 = getMaxLoudness()

			if v1 - v11 >= 0.5 then
				v11 = v1
			end

			if v9 >= 170 then
				screenFlash()
			end

			FieldOfViewController:SetAdjuster(math.clamp((v9 - 40) / 130, 0, 1) * 15)
			updateBeamWiggles(v1)

			if not (v1 < v7 and v8 > 0) then
				return
			end

			local v3 = v8 * ((v7 - v1) / 0.3)
			local v4 = math.sin(v1 * 30 * 6.28) * v3
			local v5 = math.cos(v1 * 30 * 4.17) * v3

			CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(v4, v5, math.sin(v1 * 30 * 5.23 + 1) * v3 * 0.5)
		end)
	end
end
function t.End(p1) --[[ End | Line: 645 | Upvalues: v4 (ref), TweenService (copy), BloodmoonFlash (copy), removeBloodmoonModel (copy), v6 (ref), v8 (ref), t4 (ref), FieldOfViewController (copy), BloodmoonBeams (copy) ]]
	if not v4 then
		return
	end

	v4 = false
	TweenService:Create(BloodmoonFlash, TweenInfo.new(1, Enum.EasingStyle.Sine), {
		Brightness = 0,
		Contrast = 0,
		Saturation = 0
	}):Play()
	removeBloodmoonModel()

	if v6 then
		v6:Disconnect()
		v6 = nil
	end

	v8 = 0
	t4 = {}
	FieldOfViewController:ClearAdjuster()
	task.delay(1.3, function() --[[ Line: 659 | Upvalues: BloodmoonBeams (ref) ]]
		for v1, v2 in BloodmoonBeams:GetChildren() do
			v2:Destroy()
		end
	end)
end
Networking.WeatherEffects.BloodmoonBeam.OnClientEvent:Connect(function(p1) --[[ Line: 670 | Upvalues: v4 (ref), fireBeam (copy) ]]
	if not v4 then
		return
	end

	fireBeam(p1)
end)

return t