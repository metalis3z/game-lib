--credit to prince games studio
local t = {}
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local rad = math.rad
local tan = math.tan
local min = math.min
local clock = os.clock
local CurrentCamera = workspace.CurrentCamera

local function profileBegin(p1) --[[ profileBegin | Line: 27 ]]
	debug.profilebegin("Controllers/WeatherController/Rain/" .. p1)
end

local function profileEnd() --[[ profileEnd | Line: 31 ]]
	debug.profileend()
end

local t2 = {}
local v1 = 0
local v2 = false
local v3 = nil
local v4 = nil
local v5 = Random.new()
local v6 = RaycastParams.new()

v6.FilterDescendantsInstances = { workspace.Terrain, workspace }
v6.FilterType = Enum.RaycastFilterType.Include
game:GetService("TweenService")
TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

local Rain = game.SoundService.WeatherSFX.Rain

Rain.Looped = true

local t3 = {}
local RainEffect = Instance.new("ColorCorrectionEffect")

RainEffect.Name = "RainEffect"
RainEffect.Parent = Lighting

local RainDrops = Instance.new("Folder")

RainDrops.Name = "RainDrops"
RainDrops.Parent = workspace

local RainSplashes = Instance.new("Folder")

RainSplashes.Name = "RainSplashes"
RainSplashes.Parent = workspace

local function createDropTemplate() --[[ createDropTemplate | Line: 79 ]]
	local RainDrop = Instance.new("Part")

	RainDrop.Name = "RainDrop"
	RainDrop.Size = Vector3.new(0.16, 2.4, 0.16)
	RainDrop.Material = Enum.Material.Neon
	RainDrop.Color = Color3.fromRGB(100, 150, 255)
	RainDrop.Anchored = true
	RainDrop.CanCollide = false
	RainDrop.CastShadow = false
	RainDrop.Transparency = 0.2

	return RainDrop
end

local function createSplashTemplate() --[[ createSplashTemplate | Line: 93 ]]
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
RainDrop.Size = Vector3.new(0.16, 2.4, 0.16)
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

local function getDrop() --[[ getDrop | Line: 114 | Upvalues: v9 (ref), t4 (copy), v7 (copy) ]]
	if v9 > 0 then
		local v1 = t4[v9]

		t4[v9] = nil
		v9 = v9 - 1

		return v1
	end

	return v7:Clone()
end

local function returnDrop(p1) --[[ returnDrop | Line: 124 | Upvalues: v9 (ref), t4 (copy) ]]
	p1.Parent = nil
	v9 = v9 + 1
	t4[v9] = p1
end

local t5 = {}
local v10 = 0

local function getSplash() --[[ getSplash | Line: 134 | Upvalues: v10 (ref), t5 (copy), v8 (copy) ]]
	if v10 > 0 then
		local v1 = t5[v10]

		t5[v10] = nil
		v10 = v10 - 1

		return v1
	end

	return v8:Clone()
end

local function returnSplash(p1) --[[ returnSplash | Line: 144 | Upvalues: v10 (ref), t5 (copy) ]]
	p1.Parent = nil
	p1.Anchored = true
	v10 = v10 + 1
	t5[v10] = p1
end

local function createSplash(p1) --[[ createSplash | Line: 152 | Upvalues: v10 (ref), t5 (copy), v8 (copy), RainSplashes (copy), v5 (copy), TweenService (copy) ]]
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
		v1.Parent = RainSplashes

		local v3 = v5:NextNumber(0, 6.283185307179586)
		local v4 = v5:NextNumber(7.5, 15)
		local v52 = v5:NextNumber(4.5, 9)
		local v6 = math.cos(v3) * v4

		v1.AssemblyLinearVelocity = Vector3.new(v6, v52, math.sin(v3) * v4)
		task.delay(0.3, function() --[[ Line: 173 | Upvalues: TweenService (ref), v1 (copy), v10 (ref), t5 (ref) ]]
			local v12 = TweenService:Create(v1, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
				Transparency = 1
			})

			v12:Play()
			v12.Completed:Once(function() --[[ Line: 177 | Upvalues: v1 (ref), v10 (ref), t5 (ref) ]]
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

local function getSpawnPosition() --[[ getSpawnPosition | Line: 188 | Upvalues: CurrentCamera (copy), v5 (copy) ]]
	local Position = CurrentCamera.CFrame.Position
	local v1 = v5:NextNumber(0, 6.283185307179586)
	local v2 = v5:NextNumber(5, 120)
	local v3 = Position.X + math.cos(v1) * v2
	local v4 = Position.Z + math.sin(v1) * v2

	return v3, Position.Y + v5:NextNumber(40, 80), v4
end

local function spawnDrop() --[[ spawnDrop | Line: 202 | Upvalues: v1 (ref), getSpawnPosition (copy), v6 (copy), v9 (ref), t4 (copy), v7 (copy), RainDrops (copy), t2 (copy) ]]
	if v1 >= 100 then
		return
	end

	local v12, v2, v3 = getSpawnPosition()

	if workspace:Raycast(Vector3.new(v12, v2, v3), Vector3.new(0, 100, 0), v6) then
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

	v5.CFrame = CFrame.new(v12, v2, v3)
	v5.Parent = RainDrops
	v1 = v1 + 1
	t2[v1] = {
		part = v5,
		x = v12,
		y = v2,
		z = v3,
		startY = v2
	}
end

local function spawnBatch() --[[ spawnBatch | Line: 226 | Upvalues: spawnDrop (copy) ]]
	debug.profilebegin("Controllers/WeatherController/Rain/spawnBatch")
	spawnDrop()
	spawnDrop()
	spawnDrop()
	spawnDrop()
	spawnDrop()
	spawnDrop()
	spawnDrop()
	debug.profileend()
end

local function renderLoop(p1) --[[ renderLoop | Line: 237 | Upvalues: v1 (ref), CurrentCamera (copy), t2 (copy), v9 (ref), t4 (copy), clock (copy), v6 (copy) ]]
	debug.profilebegin("Controllers/WeatherController/Rain/renderLoop")

	if v1 == 0 then
		debug.profileend()

		return
	end

	local Y = CurrentCamera.CFrame.Position.Y

	debug.profilebegin("Controllers/WeatherController/Rain/renderLoop/iterateDrops")

	local count = 1
	local v12 = 70 * p1
	local t = {}
	local t3 = {}
	local count2 = 0

	while count <= v1 do
		local v2 = t2[count]
		local v3 = v2.y - v12

		v2.y = v3

		if (if v2.startY - v3 > 200 then true else false) or (if v3 < Y - 50 then true else false) then
			local part = v2.part

			part.Parent = nil
			v9 = v9 + 1
			t4[v9] = part
			t2[count] = t2[v1]
			t2[v1] = nil
			v1 = v1 - 1
		else
			if (count + math.floor(clock() * 60)) % 3 == 0 then
				debug.profilebegin("Controllers/WeatherController/Rain/renderLoop/raycastGround")

				if workspace:Raycast(Vector3.new(v2.x, v3, v2.z), Vector3.new(0, -2, 0), v6) then
					local part = v2.part

					part.Parent = nil
					v9 = v9 + 1
					t4[v9] = part
					t2[count] = t2[v1]
					t2[v1] = nil
					v1 = v1 - 1
					debug.profileend()

					continue
				end

				debug.profileend()
			end

			count2 = count2 + 1
			t[count2] = v2.part
			t3[count2] = CFrame.new(v2.x, v3, v2.z)
			count = count + 1
		end
	end

	debug.profileend()

	if not (count2 > 0) then
		debug.profileend()

		return
	end

	debug.profilebegin("Controllers/WeatherController/Rain/renderLoop/BulkMoveTo")
	workspace:BulkMoveTo(t, t3, Enum.BulkMoveMode.FireCFrameChanged)
	debug.profileend()
	debug.profileend()
end

local function saveLighting() --[[ saveLighting | Line: 310 | Upvalues: t3 (copy), Lighting (copy) ]]
	t3.Brightness = Lighting.Brightness
	t3.Ambient = Lighting.Ambient
	t3.OutdoorAmbient = Lighting.OutdoorAmbient
	t3.FogEnd = Lighting.FogEnd
	t3.FogColor = Lighting.FogColor
	t3.ExposureCompensation = Lighting.ExposureCompensation
end

local function applyRainLighting() --[[ applyRainLighting | Line: 319 | Upvalues: TweenService (copy), Lighting (copy), t3 (copy), RainEffect (copy) ]]
	local v1 = TweenInfo.new(3, Enum.EasingStyle.Sine)

	TweenService:Create(Lighting, v1, {
		FogEnd = 350,
		ExposureCompensation = 0.3,
		Brightness = t3.Brightness * 0.7,
		Ambient = Color3.fromRGB(180, 190, 210),
		OutdoorAmbient = Color3.fromRGB(70, 75, 85),
		FogColor = Color3.fromRGB(140, 145, 155)
	}):Play()
	TweenService:Create(RainEffect, v1, {
		Brightness = 0.05,
		TintColor = Color3.fromRGB(210, 220, 240)
	}):Play()

	local Clouds = workspace.Terrain:FindFirstChild("Clouds")

	if Clouds == nil then
		local Clouds2 = Instance.new("Clouds", game.Workspace.Terrain)

		Clouds2.Density = 0
		Clouds2.Cover = 0
		Clouds = Clouds2
	end

	Clouds.Enabled = true
	TweenService:Create(Clouds, v1, {
		Cover = 0.85,
		Density = 0.15
	}):Play()
end

local function restoreLighting() --[[ restoreLighting | Line: 346 | Upvalues: TweenService (copy), Lighting (copy), t3 (copy), RainEffect (copy) ]]
	local v1 = TweenInfo.new(3, Enum.EasingStyle.Sine)

	TweenService:Create(Lighting, v1, {
		Brightness = t3.Brightness,
		Ambient = t3.Ambient,
		OutdoorAmbient = t3.OutdoorAmbient,
		FogEnd = t3.FogEnd,
		FogColor = t3.FogColor,
		ExposureCompensation = t3.ExposureCompensation
	}):Play()
	TweenService:Create(RainEffect, v1, {
		Brightness = 0,
		TintColor = Color3.fromRGB(255, 255, 255)
	}):Play()

	local Clouds = workspace.Terrain.Clouds

	TweenService:Create(Clouds, v1, {
		Cover = 0,
		Density = 0
	}):Play()
	task.delay(3, function() --[[ Line: 365 | Upvalues: Clouds (copy) ]]
		Clouds.Enabled = false
	end)
end

local function fadeInSFX() --[[ fadeInSFX | Line: 373 | Upvalues: Rain (copy), TweenService (copy) ]]
	Rain.Volume = 0
	Rain:Play()
	TweenService:Create(Rain, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Volume = 0.5
	}):Play()
end

local function fadeOutSFX() --[[ fadeOutSFX | Line: 381 | Upvalues: TweenService (copy), Rain (copy) ]]
	local v1 = TweenService:Create(Rain, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Volume = 0
	})

	v1:Play()
	v1.Completed:Once(function() --[[ Line: 385 | Upvalues: Rain (ref) ]]
		Rain:Stop()
	end)
end

function t.StartWeather() --[[ StartWeather | Line: 393 | Upvalues: v2 (ref), t3 (copy), Lighting (copy), applyRainLighting (copy), fadeInSFX (copy), v3 (ref), RunService (copy), renderLoop (copy), v4 (ref), spawnBatch (copy) ]]
	if not v2 then
		v2 = true
		t3.Brightness = Lighting.Brightness
		t3.Ambient = Lighting.Ambient
		t3.OutdoorAmbient = Lighting.OutdoorAmbient
		t3.FogEnd = Lighting.FogEnd
		t3.FogColor = Lighting.FogColor
		t3.ExposureCompensation = Lighting.ExposureCompensation
		applyRainLighting()
		fadeInSFX()
		v3 = RunService.RenderStepped:Connect(renderLoop)
		v4 = task.spawn(function() --[[ Line: 405 | Upvalues: v2 (ref), spawnBatch (ref) ]]
			while v2 do
				spawnBatch()
				task.wait(0.01)
			end
		end)
	end
end
function t.EndWeather() --[[ EndWeather | Line: 413 | Upvalues: v2 (ref), restoreLighting (copy), fadeOutSFX (copy), v3 (ref), v1 (ref), t2 (copy), v9 (ref), t4 (copy) ]]
	if v2 then
		v2 = false
		restoreLighting()
		fadeOutSFX()
		task.delay(4, function() --[[ Line: 421 | Upvalues: v3 (ref), v1 (ref), t2 (ref), v9 (ref), t4 (ref) ]]
			if v3 then
				v3:Disconnect()
				v3 = nil
			end

			for i = 1, v1 do
				if t2[i] then
					local part = t2[i].part

					part.Parent = nil
					v9 = v9 + 1
					t4[v9] = part
					t2[i] = nil
				end
			end

			v1 = 0
		end)
	end
end

return t