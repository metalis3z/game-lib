-- Lave vivante (pièces taguées "Lava") : la surface coule et pulse, des bulles gonflent et éclatent,
-- des braises et de la fumée montent. Les effets n'apparaissent qu'autour du joueur.
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local RANGE = 260
local rng = Random.new()
local folder = Instance.new("Folder")
folder.Name = "LavaFx"
folder.Parent = workspace

-- un émetteur de braises et de fumée qui suit la caméra, posé à la surface
local emitterPart = Instance.new("Part")
emitterPart.Anchored, emitterPart.CanCollide, emitterPart.CanQuery, emitterPart.CanTouch = true, false, false, false
emitterPart.Transparency = 1
emitterPart.Size = Vector3.new(260, 1, 180)
emitterPart.Parent = folder
local function seq(a, b) return NumberSequence.new({NumberSequenceKeypoint.new(0, a), NumberSequenceKeypoint.new(1, b)}) end
local embers = Instance.new("ParticleEmitter")
embers.Texture = "rbxasset://textures/particles/sparkles_main.dds"
embers.Rate, embers.Lifetime, embers.Speed = 0, NumberRange.new(2, 4), NumberRange.new(5, 14)
embers.EmissionDirection = Enum.NormalId.Top
embers.SpreadAngle = Vector2.new(20, 20)
embers.Size = seq(1.1, 0)
embers.Color = ColorSequence.new(Color3.fromRGB(255, 220, 110), Color3.fromRGB(255, 80, 20))
embers.LightEmission = 1
embers.Acceleration = Vector3.new(0, 4, 0)
embers.Parent = emitterPart
local smoke = Instance.new("ParticleEmitter")
smoke.Texture = "rbxassetid://13346862770"
smoke.FlipbookLayout, smoke.FlipbookMode = Enum.ParticleFlipbookLayout.Grid4x4, Enum.ParticleFlipbookMode.OneShot
smoke.Rate, smoke.Lifetime, smoke.Speed = 0, NumberRange.new(4, 6), NumberRange.new(3, 6)
smoke.EmissionDirection = Enum.NormalId.Top
smoke.Size = seq(8, 22)
smoke.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 0.7), NumberSequenceKeypoint.new(1, 1)})
smoke.Color = ColorSequence.new(Color3.fromRGB(70, 44, 36), Color3.fromRGB(24, 18, 18))
smoke.Parent = emitterPart

local function nearest(position)
	local best, distance
	for _, lava in CollectionService:GetTagged("Lava") do
		if lava:IsA("BasePart") then
			local r = lava.CFrame:PointToObjectSpace(position)
			local clamped = Vector3.new(math.clamp(r.X, -lava.Size.X / 2, lava.Size.X / 2), lava.Size.Y / 2, math.clamp(r.Z, -lava.Size.Z / 2, lava.Size.Z / 2))
			local d = (lava.CFrame:PointToWorldSpace(clamped) - position).Magnitude
			if not best or d < distance then best, distance = lava, d end
		end
	end
	return best, distance
end

local function bubble(lava, around)
	local r = lava.CFrame:PointToObjectSpace(around)
	local x = math.clamp(r.X + rng:NextNumber(-130, 130), -lava.Size.X / 2 + 4, lava.Size.X / 2 - 4)
	local z = rng:NextNumber(-lava.Size.Z / 2 + 4, lava.Size.Z / 2 - 4)
	local size = rng:NextNumber(3, 9)
	local part = Instance.new("Part")
	part.Shape = Enum.PartType.Ball
	part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.CastShadow = true, false, false, false, false
	part.Material = Enum.Material.Neon
	part.Color = Color3.fromRGB(255, rng:NextInteger(90, 150), 20)
	part.Size = Vector3.one * 0.5
	part.Position = lava.CFrame:PointToWorldSpace(Vector3.new(x, lava.Size.Y / 2 - 0.3, z))
	part.Parent = folder
	local grow = TweenService:Create(part, TweenInfo.new(rng:NextNumber(0.9, 1.6), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = Vector3.one * size})
	grow:Play()
	grow.Completed:Connect(function() -- elle éclate
		TweenService:Create(part, TweenInfo.new(0.18), {Size = Vector3.one * size * 1.5, Transparency = 1}):Play()
		Debris:AddItem(part, 0.2)
	end)
end

local timer = 0
RunService.RenderStepped:Connect(function(dt)
	local t = os.clock()
	local camera = workspace.CurrentCamera
	local lava, distance = nearest(camera.CFrame.Position)
	-- la surface coule et pulse (toutes les pièces)
	local glow = 0.5 + 0.5 * math.sin(t * 1.3)
	for _, part in CollectionService:GetTagged("Lava") do
		if part:IsA("BasePart") then
			part.Color = Color3.fromRGB(235, 80, 20):Lerp(Color3.fromRGB(255, 150, 40), glow)
			local layer = part:FindFirstChild("LavaGlow")
			if layer then layer.Transparency = 0.72 + 0.1 * math.sin(t * 0.9 + part.Position.X * 0.01) end
			local texture = part:FindFirstChildOfClass("Texture")
			if texture then
				texture.OffsetStudsU = (t * 4) % math.max(texture.StudsPerTileU, 1)
				texture.OffsetStudsV = (math.sin(t * 0.4) * 3) % math.max(texture.StudsPerTileV, 1)
			end
		end
	end
	local near = lava ~= nil and distance < RANGE
	embers.Rate = near and 45 or 0
	smoke.Rate = near and 7 or 0
	if not near then return end
	local r = lava.CFrame:PointToObjectSpace(camera.CFrame.Position)
	emitterPart.CFrame = lava.CFrame * CFrame.new(math.clamp(r.X, -lava.Size.X / 2, lava.Size.X / 2), lava.Size.Y / 2, 0)
	timer -= dt
	if timer <= 0 then
		timer = rng:NextNumber(0.08, 0.2)
		bubble(lava, camera.CFrame.Position)
	end
end)
