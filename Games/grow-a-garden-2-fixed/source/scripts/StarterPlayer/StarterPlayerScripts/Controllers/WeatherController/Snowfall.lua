--credit to prince games studio
local t = {}
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local Baseplate = game.Workspace.Baseplate
local Grass = game.Workspace.Map.Middle.Grass
local t2 = {}

PhysicalProperties.new(0.919, 0.01, 0.15, 100, 1)

local v1 = Color3.fromRGB(255, 255, 255)
local NotificationController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController)
local Snowfall = ReplicatedStorage.Assets:WaitForChild("Snowfall")
local t3 = {
	Brightness = 2,
	EnvironmentDiffuseScale = 1,
	ClockTime = 0,
	Ambient = Color3.fromRGB(57, 121, 131),
	ColorShift_Bottom = Color3.fromRGB(35, 135, 171),
	ColorShift_Top = Color3.fromRGB(59, 158, 250),
	OutdoorAmbient = Color3.fromRGB(74, 139, 180)
}
local v2 = Color3.fromRGB(100, 200, 255)
local v3 = Color3.fromRGB(60, 150, 220)
local LaserBeam = SoundService:WaitForChild("SFX"):WaitForChild("LaserBeam")
local v4 = Color3.fromRGB(120, 210, 255)
local t4 = {
	Color3.fromRGB(100, 200, 255),
	Color3.fromRGB(150, 220, 255),
	Color3.fromRGB(60, 170, 240),
	Color3.fromRGB(180, 230, 255),
	Color3.fromRGB(40, 140, 220),
	Color3.fromRGB(200, 240, 255)
}
local Snowfall2 = SoundService:WaitForChild("MusicTracks"):WaitForChild("Snowfall")
local v5 = false
local t5 = {}
local v6 = nil
local v7 = nil
local v8 = 0
local v9 = 0
local v10 = 0
local v11 = 0
local t6 = {}
local CurrentCamera = workspace.CurrentCamera
local v12 = Random.new()
local BlizzardBeams = Instance.new("Folder")

BlizzardBeams.Name = "BlizzardBeams"
BlizzardBeams.Parent = workspace

local function getStartPart() --[[ getStartPart | Line: 160 | Upvalues: v6 (ref) ]]
	if v6 then
		return v6:FindFirstChild("START_PART")
	end

	return nil
end

local function getHitPointsPart() --[[ getHitPointsPart | Line: 165 | Upvalues: v6 (ref) ]]
	if v6 then
		return v6:FindFirstChild("HIT_POINTS")
	end

	return nil
end

local function getRandomHitOnPart(p1) --[[ getRandomHitOnPart | Line: 170 | Upvalues: v12 (copy) ]]
	local Size = p1.Size

	return p1.CFrame:PointToWorldSpace((Vector3.new(v12:NextNumber(-Size.X / 2, Size.X / 2), v12:NextNumber(-Size.Y / 2, Size.Y / 2), v12:NextNumber(-Size.Z / 2, Size.Z / 2))))
end

local function getMaxLoudness() --[[ getMaxLoudness | Line: 180 | Upvalues: Snowfall2 (copy) ]]
	local v1 = 0

	for v2, v3 in Snowfall2:GetChildren() do
		if v3:IsA("Sound") and (v3.IsPlaying and v1 < v3.PlaybackLoudness) then
			v1 = v3.PlaybackLoudness
		end
	end

	return v1
end

local function getBeamRate(p1) --[[ getBeamRate | Line: 192 ]]
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

local function randomExplosionColor() --[[ randomExplosionColor | Line: 209 | Upvalues: t4 (copy), v12 (copy) ]]
	return t4[v12:NextInteger(1, #t4)]
end

local function lerpVector(p1, p2, p3) --[[ lerpVector | Line: 213 ]]
	return p1 + (p2 - p1) * p3
end

local function applyBlizzardToBaseplate() --[[ applyBlizzardToBaseplate | Line: 221 | Upvalues: t2 (copy), v1 (copy), RunService (copy), Baseplate (copy), Grass (copy) ]]
	local v12 = os.clock()
	local v2 = 0

	local function recolor(p1) --[[ recolor | Line: 228 | Upvalues: t2 (ref), v1 (ref), v2 (ref), v12 (ref), RunService (ref) ]]
		if not p1:IsA("BasePart") then
			return
		end

		t2[p1] = {
			Color = p1.Color
		}
		p1.Color = v1
		v2 = v2 + 1

		if not (v2 >= 50 and os.clock() - v12 >= 0.004) then
			return
		end

		RunService.Heartbeat:Wait()
		v12 = os.clock()
		v2 = 0
	end

	for v3, v4 in Baseplate:GetChildren() do
		recolor(v4)
	end

	for v5, v6 in Grass:GetDescendants() do
		recolor(v6)
	end
end

local function restoreBaseplate() --[[ restoreBaseplate | Line: 251 | Upvalues: t2 (copy) ]]
	for v1, v2 in t2 do
		if v1 and v1.Parent then
			v1.Color = v2.Color
		end
	end

	table.clear(t2)
end

local v13 = nil
local v14 = false

local function saveLighting() --[[ saveLighting | Line: 267 | Upvalues: v14 (ref), t5 (copy), Lighting (copy) ]]
	if not v14 then
		v14 = true
		t5.Ambient = Lighting.Ambient
		t5.Brightness = Lighting.Brightness
		t5.ColorShift_Bottom = Lighting.ColorShift_Bottom
		t5.ColorShift_Top = Lighting.ColorShift_Top
		t5.EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale
		t5.OutdoorAmbient = Lighting.OutdoorAmbient
		t5.ClockTime = Lighting.ClockTime
		t5.ExposureCompensation = Lighting.ExposureCompensation
	end
end

local function applyBlizzardLighting() --[[ applyBlizzardLighting | Line: 281 | Upvalues: v13 (ref), TweenService (copy), Lighting (copy), t3 (copy) ]]
	if v13 then
		v13:Cancel()
	end

	v13 = TweenService:Create(Lighting, TweenInfo.new(3, Enum.EasingStyle.Sine), {
		Ambient = t3.Ambient,
		Brightness = t3.Brightness,
		ColorShift_Bottom = t3.ColorShift_Bottom,
		ColorShift_Top = t3.ColorShift_Top,
		EnvironmentDiffuseScale = t3.EnvironmentDiffuseScale,
		OutdoorAmbient = t3.OutdoorAmbient,
		ClockTime = t3.ClockTime
	})
	v13:Play()
end

local function restoreLighting() --[[ restoreLighting | Line: 296 | Upvalues: v14 (ref), v13 (ref), TweenService (copy), Lighting (copy), t5 (copy) ]]
	if not v14 then
		return
	end

	if v13 then
		v13:Cancel()
	end

	v13 = TweenService:Create(Lighting, TweenInfo.new(3, Enum.EasingStyle.Sine), {
		Ambient = t5.Ambient,
		Brightness = t5.Brightness,
		ColorShift_Bottom = t5.ColorShift_Bottom,
		ColorShift_Top = t5.ColorShift_Top,
		EnvironmentDiffuseScale = t5.EnvironmentDiffuseScale,
		OutdoorAmbient = t5.OutdoorAmbient,
		ClockTime = t5.ClockTime
	})
	v13:Play()
	v14 = false
end

local function screenFlash() --[[ screenFlash | Line: 317 | Upvalues: TweenService (copy) ]]
	local v1 = os.clock()

	if not (v1 - lastFlashTime < 0.3) then
		lastFlashTime = v1
		colorCorrection.Brightness = FLASH_BRIGHTNESS
		colorCorrection.Saturation = -0.5
		colorCorrection.TintColor = Color3.fromRGB(180, 220, 255)
		TweenService:Create(colorCorrection, TweenInfo.new(FLASH_FADE_TIME, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Brightness = 0,
			Saturation = 0,
			TintColor = Color3.fromRGB(255, 255, 255)
		}):Play()
	end
end

local function spawnBlizzardModel() --[[ spawnBlizzardModel | Line: 338 | Upvalues: v6 (ref), Snowfall (copy), TweenService (copy) ]]
	if v6 then
		return
	end

	v6 = Snowfall:Clone()
	v6.Name = "ActiveBlizzard"

	local t = {}

	for v1, v2 in v6:GetDescendants() do
		if v2:IsA("BasePart") then
			if v2:GetAttribute("OGTransparency") == nil then
				v2:SetAttribute("OGTransparency", v2.Transparency)
			end

			v2.Transparency = 1
			table.insert(t, v2)
		end
	end

	v6.Parent = workspace

	local v3 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

	for v4, v5 in t do
		task.delay(v4 * 0.05, function() --[[ Line: 359 | Upvalues: v5 (copy), TweenService (ref), v3 (copy) ]]
			if not (v5 and v5.Parent) then
				return
			end

			TweenService:Create(v5, v3, {
				Transparency = v5:GetAttribute("OGTransparency")
			}):Play()
		end)
	end
end

local function removeBlizzardModel() --[[ removeBlizzardModel | Line: 367 | Upvalues: v6 (ref), TweenService (copy) ]]
	if not v6 then
		return
	end

	local t = {}

	for v1, v2 in v6:GetDescendants() do
		if v2:IsA("BasePart") then
			table.insert(t, v2)
		end
	end

	local v3 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In)

	for v4, v5 in t do
		TweenService:Create(v5, v3, {
			Transparency = 1
		}):Play()
	end

	local v62 = v6

	v6 = nil
	task.delay(2.1, function() --[[ Line: 384 | Upvalues: v62 (copy) ]]
		if not (v62 and v62.Parent) then
			return
		end

		v62:Destroy()
	end)
end

local function spawnExplosion(p1) --[[ spawnExplosion | Line: 395 | Upvalues: t4 (copy), v12 (copy), BlizzardBeams (copy), TweenService (copy) ]]
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
		Part.Color = t4[v12:NextInteger(1, #t4)]
		Part.Transparency = 0
		Part.Parent = BlizzardBeams

		local v2 = 120 * (0.8 + v12:NextNumber() * 0.4)
		local v3 = v12:NextNumber(10, 25)

		Part.AssemblyLinearVelocity = Vector3.new(math.cos(v1) * v2, v3, math.sin(v1) * v2)
		Part.AssemblyAngularVelocity = Vector3.new(v12:NextNumber(-10, 10), v12:NextNumber(-10, 10), v12:NextNumber(-10, 10))
		TweenService:Create(Part, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Transparency = 1,
			Size = Vector3.new(0.3, 0.1, 0.3)
		}):Play()
		task.delay(1.1, function() --[[ Line: 431 | Upvalues: Part (copy) ]]
			Part:Destroy()
		end)
	end

	for j = 1, 10 do
		local Part = Instance.new("Part")

		Part.Size = Vector3.new(2, 2, 2) + Vector3.new(3, 3, 3) * v12:NextNumber(0, 1)
		Part.Position = p1 + Vector3.new(v12:NextNumber(-2, 2), v12:NextNumber(0, 3), v12:NextNumber(-2, 2))
		Part.Anchored = false
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.CastShadow = false
		Part.Material = Enum.Material.Neon
		Part.Color = t4[v12:NextInteger(1, #t4)]
		Part.Transparency = 0
		Part.Parent = BlizzardBeams

		local v122 = v12:NextNumber(0, 6.283185307179586)
		local v13 = 80 * (0.5 + v12:NextNumber() * 0.5)

		Part.AssemblyLinearVelocity = Vector3.new(math.cos(v122) * v13, 80 * (0.6 + v12:NextNumber() * 0.8), math.sin(v122) * v13)
		Part.AssemblyAngularVelocity = Vector3.new(v12:NextNumber(-15, 15), v12:NextNumber(-15, 15), v12:NextNumber(-15, 15))
		TweenService:Create(Part, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Transparency = 1,
			Size = Vector3.new(0.2, 0.2, 0.2)
		}):Play()
		task.delay(1.3, function() --[[ Line: 475 | Upvalues: Part (copy) ]]
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
	Part.Color = Color3.fromRGB(150, 220, 255)
	Part.Transparency = 0
	Part.Parent = BlizzardBeams
	TweenService:Create(Part, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = Vector3.new(100, 100, 100),
		Transparency = 1
	}):Play()
	task.delay(0.35, function() --[[ Line: 501 | Upvalues: Part (copy) ]]
		Part:Destroy()
	end)
end

local function positionBeamSegment(p1, p2, p3, p4) --[[ positionBeamSegment | Line: 510 ]]
	local Magnitude = (p3 - p2).Magnitude

	p1.Size = Vector3.new(p4, p4, Magnitude)
	p1.CFrame = CFrame.lookAt(p2, p3) * CFrame.new(0, 0, -Magnitude / 2)
end

local function createBeamPart(p1, p2) --[[ createBeamPart | Line: 516 | Upvalues: BlizzardBeams (copy) ]]
	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.CastShadow = false
	Part.Material = Enum.Material.Neon
	Part.Color = p2
	Part.Transparency = 1
	Part.Parent = BlizzardBeams

	return Part
end

local function fireBeam(p1) --[[ fireBeam | Line: 530 | Upvalues: v6 (ref), v2 (copy), BlizzardBeams (copy), v3 (copy), v4 (copy), v12 (copy), t6 (ref), LaserBeam (copy), TweenService (copy), spawnExplosion (copy), LocalPlayer (copy) ]]
	local v1 = if v6 then v6:FindFirstChild("START_PART") else nil

	if not v1 then
		return
	end

	local Position = v1.Position
	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.CastShadow = false
	Part.Material = Enum.Material.Neon
	Part.Color = v2
	Part.Transparency = 1
	Part.Parent = BlizzardBeams

	local v32 = Part
	local Part2 = Instance.new("Part")

	Part2.Anchored = true
	Part2.CanCollide = false
	Part2.CanQuery = false
	Part2.CanTouch = false
	Part2.CastShadow = false
	Part2.Material = Enum.Material.Neon
	Part2.Color = v3
	Part2.Transparency = 1
	Part2.Parent = BlizzardBeams

	local v5 = Part2
	local v62 = p1 + Vector3.new(0, -15, 0)
	local Magnitude = (v62 - Position).Magnitude

	v32.Size = Vector3.new(30, 30, Magnitude)
	v32.CFrame = CFrame.lookAt(Position, v62) * CFrame.new(0, 0, -Magnitude / 2)

	local Magnitude2 = (v62 - Position).Magnitude

	v5.Size = Vector3.new(45, 45, Magnitude2)
	v5.CFrame = CFrame.lookAt(Position, v62) * CFrame.new(0, 0, -Magnitude2 / 2)

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
	Part3.Color = v4
	Part3.Transparency = 1
	Part3.Parent = BlizzardBeams

	local t = {
		alive = true,
		beam = v32,
		glow = v5,
		startPos = Position,
		hitPos = p1,
		birthTime = os.clock(),
		seedX = v12:NextNumber(0, 100),
		seedZ = v12:NextNumber(0, 100)
	}
	local v7 = t6

	table.insert(v7, t)

	local v8 = LaserBeam:Clone()

	v8.Volume = 8
	v8.RollOffMaxDistance = 300
	v8.RollOffMinDistance = 20
	v8.Parent = v1
	v8:Play()
	v8.Ended:Once(function() --[[ Line: 579 | Upvalues: v8 (copy) ]]
		v8:Destroy()
	end)

	local Part4 = Instance.new("Part")

	Part4.Size = Vector3.new(1, 1, 1)
	Part4.Position = p1
	Part4.Anchored = true
	Part4.CanCollide = false
	Part4.CanQuery = false
	Part4.CanTouch = false
	Part4.Transparency = 1
	Part4.Parent = BlizzardBeams

	local v9 = LaserBeam:Clone()

	v9.Volume = 7
	v9.PlaybackSpeed = 0.6 + v12:NextNumber() * 0.5
	v9.RollOffMaxDistance = 200
	v9.RollOffMinDistance = 15
	v9.Parent = Part4
	v9:Play()
	v9.Ended:Once(function() --[[ Line: 601 | Upvalues: Part4 (copy) ]]
		Part4:Destroy()
	end)

	local v10 = TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	TweenService:Create(v32, v10, {
		Transparency = 0
	}):Play()
	TweenService:Create(v5, v10, {
		Transparency = 0.5
	}):Play()
	TweenService:Create(Part3, v10, {
		Transparency = 0.1
	}):Play()
	task.delay(0.06, function() --[[ Line: 612 | Upvalues: TweenService (ref), Part3 (copy), spawnExplosion (ref), p1 (copy) ]]
		TweenService:Create(Part3, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = Vector3.new(12, 12, 12),
			Transparency = 0.5
		}):Play()
		spawnExplosion(p1)
	end)
	task.delay(0.31, function() --[[ Line: 623 | Upvalues: TweenService (ref), v32 (copy), v5 (copy), Part3 (copy), t (copy), t6 (ref) ]]
		local v1 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In)

		TweenService:Create(v32, v1, {
			Transparency = 1
		}):Play()
		TweenService:Create(v5, v1, {
			Transparency = 1
		}):Play()
		TweenService:Create(Part3, v1, {
			Transparency = 1
		}):Play()
		task.delay(0.4, function() --[[ Line: 629 | Upvalues: t (ref) ]]
			t.alive = false
		end)
		task.delay(0.9, function() --[[ Line: 633 | Upvalues: v32 (ref), v5 (ref), Part3 (ref), t6 (ref), t (ref) ]]
			v32:Destroy()
			v5:Destroy()
			Part3:Destroy()

			for i = #t6, 1, -1 do
				if t6[i] == t then
					table.remove(t6, i)

					return
				end
			end
		end)
	end)

	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	local Magnitude3 = (HumanoidRootPart.Position - p1).Magnitude

	if not (Magnitude3 <= 25) then
		return
	end

	local v11 = 1 - Magnitude3 / 25
	local v122 = 120 * v11 * v11
	local v13 = HumanoidRootPart.Position - p1
	local v14 = Vector3.new(v13.X, 0, v13.Z)
	local v15 = if v14.Magnitude > 0.1 then v14.Unit else Vector3.new(v12:NextNumber(-1, 1), 0, v12:NextNumber(-1, 1)).Unit

	HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(v15.X * v122 * 0.5, v122, v15.Z * v122 * 0.5)
end

local function updateBeamWiggles(p1) --[[ updateBeamWiggles | Line: 679 | Upvalues: t6 (ref) ]]
	for v1, v2 in t6 do
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

local function startUpdateLoop() --[[ startUpdateLoop | Line: 705 | Upvalues: v7 (ref), v10 (ref), v11 (ref), RunService (copy), v9 (ref), getMaxLoudness (copy), v6 (ref), getRandomHitOnPart (copy), fireBeam (copy), updateBeamWiggles (copy) ]]
	if not v7 then
		v10 = os.clock()
		v11 = os.clock()
		lastFlashTime = 0
		v7 = RunService.RenderStepped:Connect(function(p13) --[[ Line: 713 | Upvalues: v9 (ref), getMaxLoudness (ref), v11 (ref), v10 (ref), v6 (ref), getRandomHitOnPart (ref), fireBeam (ref), updateBeamWiggles (ref) ]]
			debug.profilebegin("Controllers/WeatherController/Snowfall/RenderStepped")

			local v1 = os.clock()

			v9 = getMaxLoudness()

			if v1 - v11 >= 0.5 then
				v11 = v1
			end

			local v2 = v9

			if (if v2 >= 170 then 0.04 elseif v2 >= 130 then (v2 - 130) / 40 * -0.07999999999999999 + 0.12 elseif v2 >= 80 then (v2 - 80) / 50 * -0.28 + 0.4 elseif v2 >= 40 then (v2 - 40) / 40 * -1.1 + 1.5 else 1.5) <= v1 - v10 then
				v10 = v1

				local v4 = if v6 then v6:FindFirstChild("HIT_POINTS") else nil

				if v4 then
					fireBeam((getRandomHitOnPart(v4)))
				end
			end

			local _ = math.clamp((v9 - 40) / 130, 0, 1) * 15

			updateBeamWiggles(v1)
			debug.profileend()
		end)
	end
end

local function stopUpdateLoop() --[[ stopUpdateLoop | Line: 758 | Upvalues: v7 (ref), v8 (ref), t6 (ref) ]]
	if v7 then
		v7:Disconnect()
		v7 = nil
	end

	v8 = 0
	t6 = {}
end

function t.StartWeather() --[[ StartWeather | Line: 771 | Upvalues: v5 (ref), NotificationController (copy), v14 (ref), t5 (copy), Lighting (copy), applyBlizzardLighting (copy), applyBlizzardToBaseplate (copy), spawnBlizzardModel (copy), v7 (ref), v10 (ref), v11 (ref), RunService (copy), v9 (ref), getMaxLoudness (copy), v6 (ref), getRandomHitOnPart (copy), fireBeam (copy), updateBeamWiggles (copy) ]]
	if v5 then
		return
	end

	v5 = true
	NotificationController:CreateNotification("A blizzard is approaching... \226\157\132\239\184\143")

	if not v14 then
		v14 = true
		t5.Ambient = Lighting.Ambient
		t5.Brightness = Lighting.Brightness
		t5.ColorShift_Bottom = Lighting.ColorShift_Bottom
		t5.ColorShift_Top = Lighting.ColorShift_Top
		t5.EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale
		t5.OutdoorAmbient = Lighting.OutdoorAmbient
		t5.ClockTime = Lighting.ClockTime
		t5.ExposureCompensation = Lighting.ExposureCompensation
	end

	applyBlizzardLighting()
	applyBlizzardToBaseplate()
	spawnBlizzardModel()

	if not v7 then
		v10 = os.clock()
		v11 = os.clock()
		lastFlashTime = 0
		v7 = RunService.RenderStepped:Connect(function(p13) --[[ Line: 713 | Upvalues: v9 (ref), getMaxLoudness (ref), v11 (ref), v10 (ref), v6 (ref), getRandomHitOnPart (ref), fireBeam (ref), updateBeamWiggles (ref) ]]
			debug.profilebegin("Controllers/WeatherController/Snowfall/RenderStepped")

			local v1 = os.clock()

			v9 = getMaxLoudness()

			if v1 - v11 >= 0.5 then
				v11 = v1
			end

			local v2 = v9

			if (if v2 >= 170 then 0.04 elseif v2 >= 130 then (v2 - 130) / 40 * -0.07999999999999999 + 0.12 elseif v2 >= 80 then (v2 - 80) / 50 * -0.28 + 0.4 elseif v2 >= 40 then (v2 - 40) / 40 * -1.1 + 1.5 else 1.5) <= v1 - v10 then
				v10 = v1

				local v4 = if v6 then v6:FindFirstChild("HIT_POINTS") else nil

				if v4 then
					fireBeam((getRandomHitOnPart(v4)))
				end
			end

			local _ = math.clamp((v9 - 40) / 130, 0, 1) * 15

			updateBeamWiggles(v1)
			debug.profileend()
		end)
	end
end
function t.EndWeather() --[[ EndWeather | Line: 783 | Upvalues: v5 (ref), restoreLighting (copy), t2 (copy), removeBlizzardModel (copy), v7 (ref), v8 (ref), t6 (ref), BlizzardBeams (copy) ]]
	if not v5 then
		return
	end

	v5 = false
	restoreLighting()

	for v1, v2 in t2 do
		if v1 and v1.Parent then
			v1.Color = v2.Color
		end
	end

	table.clear(t2)
	removeBlizzardModel()

	if v7 then
		v7:Disconnect()
		v7 = nil
	end

	v8 = 0
	t6 = {}
	task.delay(1.3, function() --[[ Line: 792 | Upvalues: BlizzardBeams (ref) ]]
		for v1, v2 in BlizzardBeams:GetChildren() do
			v2:Destroy()
		end
	end)
end
Networking.WeatherEffects.BlizzardStart.OnClientEvent:Connect(function() --[[ Line: 803 | Upvalues: t (copy) ]]
	t.StartWeather()
end)
Networking.WeatherEffects.BlizzardEnd.OnClientEvent:Connect(function() --[[ Line: 807 | Upvalues: t (copy) ]]
	t.EndWeather()
end)
Networking.WeatherEffects.BlizzardBeam.OnClientEvent:Connect(function(p1) --[[ Line: 812 | Upvalues: v5 (ref), fireBeam (copy) ]]
	if not v5 then
		return
	end

	fireBeam(p1)
end)

return t