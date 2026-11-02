--credit to leon games studio
local t = {}
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)

local function profileBegin(p1) --[[ profileBegin | Line: 28 ]]
	debug.profilebegin("Controllers/WeatherController/Lightning/" .. p1)
end

local function profileEnd() --[[ profileEnd | Line: 32 ]]
	debug.profileend()
end

local v1 = false
local t2 = {}
local v2 = nil
local v3 = nil
local t3 = {}
local v4 = 0
local CurrentCamera = workspace.CurrentCamera
local v5 = Random.new()
local Rain = game.SoundService.WeatherSFX.Rain

Rain.Looped = true

local Lightning = game.SoundService.WeatherSFX.Lightning
local v6 = RaycastParams.new()

v6.FilterDescendantsInstances = { workspace.Terrain, workspace }
v6.FilterType = Enum.RaycastFilterType.Include

local LightningEffect = Instance.new("ColorCorrectionEffect")

LightningEffect.Name = "LightningEffect"
LightningEffect.Parent = Lighting

local LightningEffects = Instance.new("Folder")

LightningEffects.Name = "LightningEffects"
LightningEffects.Parent = workspace

local StormRainDrops = Instance.new("Folder")

StormRainDrops.Name = "StormRainDrops"
StormRainDrops.Parent = workspace

local StormSplashes = Instance.new("Folder")

StormSplashes.Name = "StormSplashes"
StormSplashes.Parent = workspace

local function createDropTemplate() --[[ createDropTemplate | Line: 84 ]]
	local RainDrop = Instance.new("Part")

	RainDrop.Name = "RainDrop"
	RainDrop.Size = Vector3.new(0.12, 2.8, 0.12)
	RainDrop.Material = Enum.Material.Neon
	RainDrop.Color = Color3.fromRGB(100, 150, 255)
	RainDrop.Anchored = true
	RainDrop.CanCollide = false
	RainDrop.CastShadow = false
	RainDrop.Transparency = 0.2

	return RainDrop
end

local function createSplashTemplate() --[[ createSplashTemplate | Line: 97 ]]
	local Splash = Instance.new("Part")

	Splash.Name = "Splash"
	Splash.Size = Vector3.new(0.1, 0.1, 0.1)
	Splash.Material = Enum.Material.Neon
	Splash.Color = Color3.fromRGB(120, 170, 255)
	Splash.Anchored = false
	Splash.CanCollide = false
	Splash.CastShadow = false
	Splash.Transparency = 0.3
	Splash.Shape = Enum.PartType.Ball

	return Splash
end

local RainDrop = Instance.new("Part")

RainDrop.Name = "RainDrop"
RainDrop.Size = Vector3.new(0.12, 2.8, 0.12)
RainDrop.Material = Enum.Material.Neon
RainDrop.Color = Color3.fromRGB(100, 150, 255)
RainDrop.Anchored = true
RainDrop.CanCollide = false
RainDrop.CastShadow = false
RainDrop.Transparency = 0.2

local v7 = RainDrop
local v8 = createSplashTemplate()
local t4 = {}
local v9 = 0

local function getDrop() --[[ getDrop | Line: 118 | Upvalues: v9 (ref), t4 (copy), v7 (copy) ]]
	if v9 > 0 then
		local v1 = t4[v9]

		t4[v9] = nil
		v9 = v9 - 1

		return v1
	end

	return v7:Clone()
end

local function returnDrop(p1) --[[ returnDrop | Line: 128 | Upvalues: v9 (ref), t4 (copy) ]]
	p1.Parent = nil
	v9 = v9 + 1
	t4[v9] = p1
end

local t5 = {}
local v10 = 0

local function getSplash() --[[ getSplash | Line: 138 | Upvalues: v10 (ref), t5 (copy), v8 (copy) ]]
	if v10 > 0 then
		local v1 = t5[v10]

		t5[v10] = nil
		v10 = v10 - 1

		return v1
	end

	return v8:Clone()
end

local function returnSplash(p1) --[[ returnSplash | Line: 148 | Upvalues: v10 (ref), t5 (copy) ]]
	p1.Parent = nil
	p1.Anchored = true
	v10 = v10 + 1
	t5[v10] = p1
end

local function createSplash(p1) --[[ createSplash | Line: 156 | Upvalues: v10 (ref), t5 (copy), v8 (copy), StormSplashes (copy), v5 (copy), TweenService (copy) ]]
	for i = 1, 3 do
		local v1

		if v10 > 0 then
			local v2 = t5[v10]

			t5[v10] = nil
			v10 = v10 - 1
			v1 = v2
		else
			v1 = v8:Clone()
		end

		v1.CFrame = CFrame.new(p1)
		v1.Anchored = false
		v1.Parent = StormSplashes

		local v3 = v5:NextNumber(0, 6.283185307179586)
		local v4 = v5:NextNumber(7.5, 15)
		local v52 = v5:NextNumber(4.5, 9)
		local v6 = math.cos(v3) * v4

		v1.AssemblyLinearVelocity = Vector3.new(v6, v52, math.sin(v3) * v4)
		task.delay(0.3, function() --[[ Line: 177 | Upvalues: TweenService (ref), v1 (copy), v10 (ref), t5 (ref) ]]
			local v12 = TweenService:Create(v1, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
				Transparency = 1
			})

			v12:Play()
			v12.Completed:Once(function() --[[ Line: 181 | Upvalues: v1 (ref), v10 (ref), t5 (ref) ]]
				v1.Transparency = 0.3

				local v12 = v1

				v12.Parent = nil
				v12.Anchored = true
				v10 = v10 + 1
				t5[v10] = v12
			end)
		end)
	end
end

local function getSpawnPosition() --[[ getSpawnPosition | Line: 189 | Upvalues: CurrentCamera (copy), v5 (copy) ]]
	local Position = CurrentCamera.CFrame.Position
	local v1 = v5:NextNumber(0, 6.283185307179586)
	local v2 = v5:NextNumber(5, 130)
	local v3 = Position.X + math.cos(v1) * v2
	local v4 = Position.Z + math.sin(v1) * v2

	return v3, Position.Y + v5:NextNumber(50, 90), v4
end

local function spawnDrop() --[[ spawnDrop | Line: 201 | Upvalues: v4 (ref), getSpawnPosition (copy), v6 (copy), v9 (ref), t4 (copy), v7 (copy), StormRainDrops (copy), t3 (copy) ]]
	if v4 >= 100 then
		return
	end

	local v1, v2, v3 = getSpawnPosition()

	if workspace:Raycast(Vector3.new(v1, v2, v3), Vector3.new(0, 100, 0), v6) then
		return
	end

	local v5

	if v9 > 0 then
		local v62 = t4[v9]

		t4[v9] = nil
		v9 = v9 - 1
		v5 = v62
	else
		v5 = v7:Clone()
	end

	v5.CFrame = CFrame.new(v1, v2, v3)
	v5.Parent = StormRainDrops
	v4 = v4 + 1
	t3[v4] = {
		part = v5,
		x = v1,
		y = v2,
		z = v3,
		startY = v2
	}
end

local function spawnBatch() --[[ spawnBatch | Line: 223 | Upvalues: spawnDrop (copy) ]]
	debug.profilebegin("Controllers/WeatherController/Lightning/spawnBatch")
	spawnDrop()
	spawnDrop()
	spawnDrop()
	spawnDrop()
	spawnDrop()
	spawnDrop()
	debug.profileend()
end

local function renderLoop(p1) --[[ renderLoop | Line: 231 | Upvalues: v4 (ref), CurrentCamera (copy), t3 (copy), v9 (ref), t4 (copy), v6 (copy) ]]
	debug.profilebegin("Controllers/WeatherController/Lightning/renderLoop")

	if v4 == 0 then
		debug.profileend()

		return
	end

	local Y = CurrentCamera.CFrame.Position.Y

	debug.profilebegin("Controllers/WeatherController/Lightning/renderLoop/iterateDrops")

	local count = 1
	local v1 = 90 * p1
	local t = {}
	local t2 = {}
	local count2 = 0

	while count <= v4 do
		local v2 = t3[count]
		local v3 = v2.y - v1

		v2.y = v3

		if (if v2.startY - v3 > 200 then true else false) or (if v3 < Y - 50 then true else false) then
			local part = v2.part

			part.Parent = nil
			v9 = v9 + 1
			t4[v9] = part
			t3[count] = t3[v4]
			t3[v4] = nil
			v4 = v4 - 1
		else
			if (count + math.floor(os.clock() * 60)) % 3 == 0 then
				debug.profilebegin("Controllers/WeatherController/Lightning/renderLoop/raycastGround")

				if workspace:Raycast(Vector3.new(v2.x, v3, v2.z), Vector3.new(0, -2, 0), v6) then
					local part = v2.part

					part.Parent = nil
					v9 = v9 + 1
					t4[v9] = part
					t3[count] = t3[v4]
					t3[v4] = nil
					v4 = v4 - 1
					debug.profileend()

					continue
				end

				debug.profileend()
			end

			count2 = count2 + 1
			t[count2] = v2.part
			t2[count2] = CFrame.new(v2.x, v3, v2.z)
			count = count + 1
		end
	end

	debug.profileend()

	if not (count2 > 0) then
		debug.profileend()

		return
	end

	debug.profilebegin("Controllers/WeatherController/Lightning/renderLoop/BulkMoveTo")
	workspace:BulkMoveTo(t, t2, Enum.BulkMoveMode.FireCFrameChanged)
	debug.profileend()
	debug.profileend()
end

local function playLightningStrikeSFX(p1) --[[ playLightningStrikeSFX | Line: 298 | Upvalues: Lightning (copy), v5 (copy), LightningEffects (copy) ]]
	local v1 = Lightning:GetChildren()

	if #v1 == 0 then
		return
	end

	local v2 = v1[v5:NextInteger(1, #v1)]

	if v2:IsA("Sound") then
		local LightningSFXPart = Instance.new("Part")

		LightningSFXPart.Name = "LightningSFXPart"
		LightningSFXPart.Size = Vector3.new(1, 1, 1)
		LightningSFXPart.Position = p1
		LightningSFXPart.Anchored = true
		LightningSFXPart.CanCollide = false
		LightningSFXPart.Transparency = 1
		LightningSFXPart.Parent = LightningEffects

		local v3 = v2:Clone()

		v3.Volume = 2
		v3.RollOffMaxDistance = 7000
		v3.RollOffMinDistance = 10
		v3.Parent = LightningSFXPart
		v3:Play()
		v3.Ended:Once(function() --[[ Line: 325 | Upvalues: LightningSFXPart (copy) ]]
			LightningSFXPart:Destroy()
		end)
		task.delay(v3.TimeLength + 1, function() --[[ Line: 330 | Upvalues: LightningSFXPart (copy) ]]
			if not LightningSFXPart.Parent then
				return
			end

			LightningSFXPart:Destroy()
		end)
	end
end

local function createBoltSegment(p1, p2, p3) --[[ createBoltSegment | Line: 339 | Upvalues: LightningEffects (copy) ]]
	local LightningBolt = Instance.new("Part")

	LightningBolt.Name = "LightningBolt"
	LightningBolt.Anchored = true
	LightningBolt.CanCollide = false
	LightningBolt.CastShadow = false
	LightningBolt.Material = Enum.Material.Neon
	LightningBolt.Color = Color3.fromRGB(235, 245, 255)
	LightningBolt.Transparency = 1

	local Magnitude = (p2 - p1).Magnitude

	LightningBolt.Size = Vector3.new(p3, p3, Magnitude)
	LightningBolt.CFrame = CFrame.lookAt(p1, p2) * CFrame.new(0, 0, -Magnitude / 2)
	LightningBolt.Parent = LightningEffects

	return LightningBolt
end

local function createBoltGlow(p1, p2, p3) --[[ createBoltGlow | Line: 358 | Upvalues: LightningEffects (copy) ]]
	local LightningGlow = Instance.new("Part")

	LightningGlow.Name = "LightningGlow"
	LightningGlow.Anchored = true
	LightningGlow.CanCollide = false
	LightningGlow.CastShadow = false
	LightningGlow.Material = Enum.Material.Neon
	LightningGlow.Color = Color3.fromRGB(180, 200, 255)
	LightningGlow.Transparency = 1

	local Magnitude = (p2 - p1).Magnitude

	LightningGlow.Size = Vector3.new(p3 * 3, p3 * 3, Magnitude)
	LightningGlow.CFrame = CFrame.lookAt(p1, p2) * CFrame.new(0, 0, -Magnitude / 2)
	LightningGlow.Parent = LightningEffects

	return LightningGlow
end

local function createLightningBolt(p1) --[[ createLightningBolt | Line: 376 | Upvalues: v5 (copy), createBoltSegment (copy), createBoltGlow (copy), LightningEffects (copy) ]]
	local v1 = p1 + Vector3.new(0, 150, 0)
	local t = {}

	for i = 1, 10 do
		local v2
		local v3 = i / 10
		local v52 = (1 - v3) * 0.7

		v2 = if i == 10 then p1 else Vector3.new(p1.X + v5:NextNumber(-10, 10) * v52, p1.Y + (1 - v3) * 150, p1.Z + v5:NextNumber(-10, 10) * v52)

		local v11 = 2.5 - v3 * 1

		table.insert(t, (createBoltSegment(v1, v2, v11)))
		table.insert(t, (createBoltGlow(v1, v2, v11)))

		if i > 2 and (i < 8 and v5:NextNumber() > 0.65) then
			local v17 = v2 + Vector3.new(v5:NextNumber(-18, 18), v5:NextNumber(-30, -10), v5:NextNumber(-18, 18))
			local v18 = createBoltSegment(v2, v17, 0.8)
			local v19 = createBoltGlow(v2, v17, 0.8)

			table.insert(t, v18)
			table.insert(t, v19)
			v1 = v2

			continue
		end

		v1 = v2
	end

	local StrikeGlow = Instance.new("Part")

	StrikeGlow.Name = "StrikeGlow"
	StrikeGlow.Shape = Enum.PartType.Ball
	StrikeGlow.Size = Vector3.new(3, 3, 3)
	StrikeGlow.Position = p1
	StrikeGlow.Anchored = true
	StrikeGlow.CanCollide = false
	StrikeGlow.CastShadow = false
	StrikeGlow.Material = Enum.Material.Neon
	StrikeGlow.Color = Color3.fromRGB(235, 245, 255)
	StrikeGlow.Transparency = 1
	StrikeGlow.Parent = LightningEffects
	table.insert(t, StrikeGlow)

	local OuterStrikeGlow = Instance.new("Part")

	OuterStrikeGlow.Name = "OuterStrikeGlow"
	OuterStrikeGlow.Shape = Enum.PartType.Ball
	OuterStrikeGlow.Size = Vector3.new(6, 6, 6)
	OuterStrikeGlow.Position = p1
	OuterStrikeGlow.Anchored = true
	OuterStrikeGlow.CanCollide = false
	OuterStrikeGlow.CastShadow = false
	OuterStrikeGlow.Material = Enum.Material.Neon
	OuterStrikeGlow.Color = Color3.fromRGB(180, 200, 255)
	OuterStrikeGlow.Transparency = 1
	OuterStrikeGlow.Parent = LightningEffects
	table.insert(t, OuterStrikeGlow)

	return t
end

local function screenFlash() --[[ screenFlash | Line: 460 | Upvalues: LightningEffect (copy), TweenService (copy) ]]
	LightningEffect.Brightness = 2.5
	LightningEffect.Contrast = 0.15
	LightningEffect.Saturation = -0.3
	TweenService:Create(LightningEffect, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
		Brightness = 0,
		Contrast = 0,
		Saturation = 0
	}):Play()
end

local function onLightningStrike(p1) --[[ onLightningStrike | Line: 475 | Upvalues: createLightningBolt (copy), playLightningStrikeSFX (copy), TweenService (copy), v1 (ref), screenFlash (copy), LightningEffect (copy) ]]
	local v12 = createLightningBolt(p1)

	playLightningStrikeSFX(p1)

	local v2 = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	for v3, v4 in v12 do
		if v4.Name == "LightningBolt" then
			TweenService:Create(v4, v2, {
				Transparency = 0
			}):Play()

			continue
		end

		if v4.Name == "LightningGlow" then
			TweenService:Create(v4, v2, {
				Transparency = 0.6
			}):Play()

			continue
		end

		if v4.Name == "StrikeGlow" then
			TweenService:Create(v4, v2, {
				Transparency = 0
			}):Play()

			continue
		end

		if v4.Name == "OuterStrikeGlow" then
			TweenService:Create(v4, v2, {
				Transparency = 0.4
			}):Play()
		end
	end

	task.delay(0.03, function() --[[ Line: 496 | Upvalues: v1 (ref), screenFlash (ref) ]]
		if v1 then
			screenFlash()
		end
	end)
	task.delay(0.1, function() --[[ Line: 502 | Upvalues: v12 (copy), TweenService (ref) ]]
		for v1, v2 in v12 do
			if v2.Name == "StrikeGlow" then
				TweenService:Create(v2, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = Vector3.new(15, 15, 15),
					Transparency = 0.6
				}):Play()

				continue
			end

			if v2.Name == "OuterStrikeGlow" then
				TweenService:Create(v2, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = Vector3.new(25, 25, 25),
					Transparency = 0.8
				}):Play()
			end
		end
	end)
	task.delay(0.3, function() --[[ Line: 521 | Upvalues: v12 (copy), TweenService (ref) ]]
		local v1 = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

		for v2, v3 in v12 do
			TweenService:Create(v3, v1, {
				Transparency = 1
			}):Play()
		end

		task.delay(0.65, function() --[[ Line: 527 | Upvalues: v12 (ref) ]]
			for v1, v2 in v12 do
				v2:Destroy()
			end
		end)
	end)
	task.delay(0.5, function() --[[ Line: 535 | Upvalues: v1 (ref), LightningEffect (ref), TweenService (ref) ]]
		if v1 then
			LightningEffect.Brightness = 0.4
			TweenService:Create(LightningEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				Brightness = 0
			}):Play()
		end
	end)
end

local function getOrCreateClouds() --[[ getOrCreateClouds | Line: 545 ]]
	local Clouds = workspace.Terrain:FindFirstChildOfClass("Clouds")

	if not Clouds then
		local Clouds2 = Instance.new("Clouds")

		Clouds2.Cover = 0
		Clouds2.Density = 0
		Clouds2.Color = Color3.fromRGB(255, 255, 255)
		Clouds2.Enabled = false
		Clouds2.Parent = workspace.Terrain
		Clouds = Clouds2
	end

	return Clouds
end

local function saveLighting() --[[ saveLighting | Line: 558 | Upvalues: t2 (copy), Lighting (copy) ]]
	t2.Brightness = Lighting.Brightness
	t2.Ambient = Lighting.Ambient
	t2.OutdoorAmbient = Lighting.OutdoorAmbient
	t2.FogEnd = Lighting.FogEnd
	t2.FogColor = Lighting.FogColor
	t2.ExposureCompensation = Lighting.ExposureCompensation
end

local function applyStormLighting() --[[ applyStormLighting | Line: 567 | Upvalues: TweenService (copy), Lighting (copy), t2 (copy), getOrCreateClouds (copy) ]]
	local v1 = TweenInfo.new(4, Enum.EasingStyle.Sine)

	TweenService:Create(Lighting, v1, {
		FogEnd = 300,
		ExposureCompensation = 0.2,
		Brightness = t2.Brightness * 0.4,
		Ambient = Color3.fromRGB(90, 95, 115),
		OutdoorAmbient = Color3.fromRGB(40, 45, 60),
		FogColor = Color3.fromRGB(70, 75, 90)
	}):Play()

	local v2 = getOrCreateClouds()

	v2.Enabled = true
	TweenService:Create(v2, v1, {
		Cover = 1,
		Density = 0.35
	}):Play()
end

local function restoreLighting() --[[ restoreLighting | Line: 584 | Upvalues: TweenService (copy), Lighting (copy), t2 (copy), LightningEffect (copy), getOrCreateClouds (copy), v1 (ref) ]]
	local v12 = TweenInfo.new(4, Enum.EasingStyle.Sine)

	TweenService:Create(Lighting, v12, {
		Brightness = t2.Brightness,
		Ambient = t2.Ambient,
		OutdoorAmbient = t2.OutdoorAmbient,
		FogEnd = t2.FogEnd,
		FogColor = t2.FogColor,
		ExposureCompensation = t2.ExposureCompensation
	}):Play()
	TweenService:Create(LightningEffect, v12, {
		Brightness = 0,
		Contrast = 0,
		Saturation = 0
	}):Play()

	local v2 = getOrCreateClouds()

	TweenService:Create(v2, v12, {
		Cover = 0,
		Density = 0
	}):Play()
	task.delay(4, function() --[[ Line: 604 | Upvalues: v1 (ref), v2 (copy) ]]
		if v1 then
			return
		end

		v2.Enabled = false
	end)
end

local function fadeInAmbience() --[[ fadeInAmbience | Line: 613 | Upvalues: Rain (copy), TweenService (copy) ]]
	Rain.Volume = 0
	Rain:Play()
	TweenService:Create(Rain, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Volume = 0.5
	}):Play()
end

local function fadeOutAmbience() --[[ fadeOutAmbience | Line: 621 | Upvalues: TweenService (copy), Rain (copy) ]]
	local v1 = TweenService:Create(Rain, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Volume = 0
	})

	v1:Play()
	v1.Completed:Once(function() --[[ Line: 625 | Upvalues: Rain (ref) ]]
		Rain:Stop()
	end)
end

function t.StartWeather() --[[ StartWeather | Line: 632 | Upvalues: v1 (ref), t2 (copy), Lighting (copy), applyStormLighting (copy), fadeInAmbience (copy), v2 (ref), RunService (copy), renderLoop (copy), v3 (ref), spawnBatch (copy) ]]
	if not v1 then
		v1 = true
		t2.Brightness = Lighting.Brightness
		t2.Ambient = Lighting.Ambient
		t2.OutdoorAmbient = Lighting.OutdoorAmbient
		t2.FogEnd = Lighting.FogEnd
		t2.FogColor = Lighting.FogColor
		t2.ExposureCompensation = Lighting.ExposureCompensation
		applyStormLighting()
		fadeInAmbience()
		v2 = RunService.RenderStepped:Connect(renderLoop)
		v3 = task.spawn(function() --[[ Line: 642 | Upvalues: v1 (ref), spawnBatch (ref) ]]
			while v1 do
				spawnBatch()
				task.wait(0.015)
			end
		end)
	end
end
function t.EndWeather() --[[ EndWeather | Line: 650 | Upvalues: v1 (ref), LightningEffect (copy), restoreLighting (copy), fadeOutAmbience (copy), v2 (ref), v4 (ref), t3 (copy), v9 (ref), t4 (copy), LightningEffects (copy) ]]
	if v1 then
		v1 = false
		LightningEffect.Brightness = 0
		LightningEffect.Contrast = 0
		LightningEffect.Saturation = 0
		restoreLighting()
		fadeOutAmbience()
		task.delay(4, function() --[[ Line: 661 | Upvalues: v2 (ref), v4 (ref), t3 (ref), v9 (ref), t4 (ref), LightningEffects (ref) ]]
			if v2 then
				v2:Disconnect()
				v2 = nil
			end

			for i = 1, v4 do
				if t3[i] then
					local part = t3[i].part

					part.Parent = nil
					v9 = v9 + 1
					t4[v9] = part
					t3[i] = nil
				end
			end

			v4 = 0

			for v1, v22 in LightningEffects:GetChildren() do
				v22:Destroy()
			end
		end)
	end
end
Networking.WeatherEffects.LightningStart.OnClientEvent:Connect(function() --[[ Line: 682 | Upvalues: t (copy) ]]
	t.StartWeather()
end)
Networking.WeatherEffects.LightningEnd.OnClientEvent:Connect(function() --[[ Line: 686 | Upvalues: t (copy) ]]
	t.EndWeather()
end)
Networking.WeatherEffects.LightningStrike.OnClientEvent:Connect(function(p1) --[[ Line: 690 | Upvalues: v1 (ref), onLightningStrike (copy) ]]
	if not v1 then
		return
	end

	onLightningStrike(p1)
end)

return t