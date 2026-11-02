-- Plantes posées : pousse progressive, minuteurs, effets de plantation et de récolte
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local system = ReplicatedStorage:WaitForChild("PlantSystem")
local Config = require(system:WaitForChild("PlantConfig"))
local remotes = system:WaitForChild("Remotes")

local player = Players.LocalPlayer
local placedPlants = workspace:WaitForChild("PlacedPlants")

local SPARKLE_TEXTURE = "rbxasset://textures/particles/sparkles_main.dds"
local GROW_REFRESH = 0.15
local SCALE_STEP = 0.01     -- on ne redimensionne que si la taille a changé d'au moins 1 %
local PLANT_FX_WINDOW = 3   -- on ne rejoue pas l'effet pour une plante plantée il y a longtemps
local READY_COLOR = Color3.fromRGB(110, 255, 130)
local DIRT_COLOR = Color3.fromRGB(150, 104, 66)
local MONEY_COLOR = Color3.fromRGB(130, 255, 120)
local POPUP_TIME = 1.2

---------------------------------------------------------------- effets (locaux au joueur)
local fxFolder = Instance.new("Folder")
fxFolder.Name = "PlantFx"
fxFolder.Parent = workspace

local function fxPart(size, cframe)
	local part = Instance.new("Part")
	part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.CastShadow = true, false, false, false, false
	part.Size = size
	part.CFrame = cframe
	part.Parent = fxFolder
	return part
end

local function burst(position, sequence, count, speed, size)
	local part = fxPart(Vector3.new(0.5, 0.5, 0.5), CFrame.new(position))
	part.Transparency = 1
	local emitter = Instance.new("ParticleEmitter")
	emitter.Texture = SPARKLE_TEXTURE
	emitter.Rate = 0
	emitter.Lifetime = NumberRange.new(0.5, 1)
	emitter.Speed = NumberRange.new(speed * 0.5, speed)
	emitter.SpreadAngle = Vector2.new(180, 180)
	emitter.Drag = 2
	emitter.Size = NumberSequence.new(size, 0)
	emitter.Color = sequence
	emitter.LightEmission = 0.7
	emitter.Parent = part
	emitter:Emit(count)
	Debris:AddItem(part, 2)
end

local function ring(position, color, fromSize, toSize, duration)
	local part = fxPart(Vector3.new(0.2, fromSize, fromSize), CFrame.new(position) * CFrame.Angles(0, 0, math.pi / 2))
	part.Shape = Enum.PartType.Cylinder
	part.Material = Enum.Material.Neon
	part.Color = color
	part.Transparency = 0.3
	TweenService:Create(part, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{Size = Vector3.new(0.2, toSize, toSize), Transparency = 1}):Play()
	Debris:AddItem(part, duration + 0.1)
end

local function beam(position, color, height, width, duration)
	local part = fxPart(Vector3.new(height, width, width), CFrame.new(position + Vector3.new(0, height / 2, 0)) * CFrame.Angles(0, 0, math.pi / 2))
	part.Shape = Enum.PartType.Cylinder
	part.Material = Enum.Material.Neon
	part.Color = color
	part.Transparency = 0.35
	TweenService:Create(part, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{Size = Vector3.new(height, 0.1, 0.1), Transparency = 1}):Play()
	Debris:AddItem(part, duration + 0.1)
end

local function flash(model, color, duration)
	local highlight = Instance.new("Highlight")
	highlight.Adornee = model
	highlight.FillColor = color
	highlight.FillTransparency = 0.05
	highlight.OutlineColor = color
	highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	highlight.Parent = fxFolder
	TweenService:Create(highlight, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{FillTransparency = 1, OutlineTransparency = 1}):Play()
	Debris:AddItem(highlight, duration + 0.1)
end

---------------------------------------------------------------- plantation : terre qui vole, gros effet si la plante a une mutation
local function onPlanted(plant)
	local plantedAt = plant:GetAttribute("JustPlanted")
	if not plantedAt or workspace:GetServerTimeNow() - plantedAt > PLANT_FX_WINDOW then return end
	local position = plant:GetPivot().Position
	burst(position + Vector3.new(0, 0.3, 0), ColorSequence.new(DIRT_COLOR), 14, 6, 0.5)
	ring(position + Vector3.new(0, 0.15, 0), Color3.new(1, 1, 1), 1, 5, 0.45)

	local mutationName = plant:GetAttribute("Mutation")
	local mutation = mutationName and EggConfig.GetMutation(mutationName)
	if mutation then
		local color = mutation.Color or Color3.fromRGB(255, 120, 210)
		local sequence = mutation.Color and ColorSequence.new(Color3.new(1, 1, 1), mutation.Color) or EggConfig.Gradients[mutationName]
		flash(plant, color, 1.4)
		beam(position, color, 24, 2.4, 1.1)
		ring(position + Vector3.new(0, 0.2, 0), color, 1, 10, 0.8)
		burst(position + Vector3.new(0, 1, 0), sequence, 70, 14, 0.9)
	end
end

placedPlants.ChildAdded:Connect(function(plant) task.defer(onPlanted, plant) end)

---------------------------------------------------------------- récolte : étincelles + nom de la plante qui monte (value = nom de la plante récoltée)
remotes:WaitForChild("Harvested").OnClientEvent:Connect(function(position, value, color)
	burst(position + Vector3.new(0, 1, 0), ColorSequence.new(Color3.new(1, 1, 1), color), 30, 10, 0.7)
	ring(position + Vector3.new(0, 0.15, 0), color, 1, 6, 0.5)

	local anchor = fxPart(Vector3.new(0.2, 0.2, 0.2), CFrame.new(position + Vector3.new(0, 2.5, 0)))
	anchor.Transparency = 1
	local billboard = Instance.new("BillboardGui")
	billboard.AlwaysOnTop = true
	billboard.LightInfluence = 0
	billboard.Size = UDim2.new(6, 0, 1.6, 0)
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	label.Text = "+1 " .. tostring(value)
	label.TextScaled = true
	label.TextColor3 = MONEY_COLOR
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.new(0, 0, 0)
	stroke.Thickness = 2.5
	stroke.Parent = label
	label.Parent = billboard
	billboard.Parent = anchor
	local info = TweenInfo.new(POPUP_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(anchor, info, {CFrame = anchor.CFrame + Vector3.new(0, 4, 0)}):Play()
	TweenService:Create(label, info, {TextTransparency = 1}):Play()
	TweenService:Create(stroke, info, {Transparency = 1}):Play()
	Debris:AddItem(anchor, POPUP_TIME + 0.1)
end)

---------------------------------------------------------------- pousse + minuteurs
task.spawn(function()
	while true do
		local now = workspace:GetServerTimeNow()
		for _, plant in placedPlants:GetChildren() do
			local plantedAt, readyAt, fullScale = plant:GetAttribute("PlantedAt"), plant:GetAttribute("ReadyAt"), plant:GetAttribute("FullScale")
			if plantedAt and readyAt and fullScale and plant.PrimaryPart then
				local progress = math.clamp((now - plantedAt) / math.max(readyAt - plantedAt, 0.01), 0, 1)
				local eased = 1 - (1 - progress) ^ 2
				local scale = fullScale * (Config.StartScale + (1 - Config.StartScale) * eased)
				if math.abs(plant:GetScale() - scale) > scale * SCALE_STEP then
					plant:ScaleTo(scale) -- le pivot est au sol : la plante grandit sans s'enfoncer
				end
				local label = plant:FindFirstChild("Timer", true)
				if label then
					local remaining = readyAt - now
					if remaining > 0 then
						label.Text = EggConfig.FormatTime(remaining)
						label.TextColor3 = Color3.new(1, 1, 1)
					else
						label.Text = "Ready!"
						label.TextColor3 = READY_COLOR
					end
				end
			end
		end
		task.wait(GROW_REFRESH)
	end
end)
