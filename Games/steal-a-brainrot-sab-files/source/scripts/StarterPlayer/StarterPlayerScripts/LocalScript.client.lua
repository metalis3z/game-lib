-- ============================================================
-- LoadingScreen.lua
-- LocalScript à placer directement dans ReplicatedFirst
-- Écran de chargement animé pour "Steal a Harder"
-- ============================================================

local ReplicatedFirst = game:GetService("ReplicatedFirst")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")

-- On empêche l'écran de chargement par défaut de Roblox de s'afficher
ReplicatedFirst:RemoveDefaultLoadingScreenAsync()

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================================
-- CRÉATION DE L'INTERFACE
-- ============================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingScreen"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.Parent = playerGui

-- Fond
local background = Instance.new("Frame")
background.Size = UDim2.fromScale(1, 1)
background.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
background.BorderSizePixel = 0
background.Parent = screenGui

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 10, 35)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 10, 16)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 5, 30)),
})
gradient.Rotation = 45
gradient.Parent = background

-- ============================================================
-- PARTICULES FLOTTANTES (effet décoratif)
-- ============================================================

local particleColors = {
	Color3.fromRGB(255, 85, 180),
	Color3.fromRGB(120, 90, 255),
	Color3.fromRGB(90, 200, 255),
}

local function spawnParticle()
	local particle = Instance.new("Frame")
	local size = math.random(4, 10)
	particle.Size = UDim2.fromOffset(size, size)
	particle.Position = UDim2.fromScale(math.random(0, 100) / 100, 1.05)
	particle.BackgroundColor3 = particleColors[math.random(1, #particleColors)]
	particle.BackgroundTransparency = 0.3
	particle.BorderSizePixel = 0
	particle.ZIndex = 1
	particle.Parent = background

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = particle

	local duration = math.random(4, 8)
	local targetY = -0.1
	local targetX = particle.Position.X.Scale + (math.random(-15, 15) / 100)

	local tween = TweenService:Create(particle, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
		Position = UDim2.fromScale(targetX, targetY),
		BackgroundTransparency = 1,
	})
	tween:Play()
	tween.Completed:Connect(function()
		particle:Destroy()
	end)
end

local particleSpawner = task.spawn(function()
	while screenGui.Parent do
		spawnParticle()
		task.wait(0.15)
	end
end)

-- ============================================================
-- TITRE
-- ============================================================

local titleContainer = Instance.new("Frame")
titleContainer.Size = UDim2.fromScale(1, 0.3)
titleContainer.Position = UDim2.fromScale(0, 0.32)
titleContainer.BackgroundTransparency = 1
titleContainer.Parent = background

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.fromScale(1, 0.35)
subTitle.BackgroundTransparency = 1
subTitle.Text = "BIENVENUE SUR"
subTitle.TextColor3 = Color3.fromRGB(200, 200, 210)
subTitle.Font = Enum.Font.GothamMedium
subTitle.TextScaled = true
subTitle.TextTransparency = 1
subTitle.Parent = titleContainer

local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.fromScale(1, 0.6)
mainTitle.Position = UDim2.fromScale(0, 0.35)
mainTitle.BackgroundTransparency = 1
mainTitle.Text = "STEAL A HARDER !"
mainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainTitle.Font = Enum.Font.GothamBlack
mainTitle.TextScaled = true
mainTitle.TextTransparency = 1
mainTitle.Parent = titleContainer

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 200)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 120, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 255)),
})
titleGradient.Parent = mainTitle

local titleStroke = Instance.new("UIStroke")
titleStroke.Thickness = 2
titleStroke.Color = Color3.fromRGB(0, 0, 0)
titleStroke.Transparency = 0.5
titleStroke.Parent = mainTitle

-- Anim titre : apparition + léger scale
mainTitle.Position = UDim2.new(0, 0, 0.4, 0)
TweenService:Create(subTitle, TweenInfo.new(0.6, Enum.EasingStyle.Quad), { TextTransparency = 0 }):Play()
task.wait(0.15)
TweenService:Create(mainTitle, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	TextTransparency = 0,
	Position = UDim2.fromScale(0, 0.35),
}):Play()

-- Pulsation douce et continue du titre
task.spawn(function()
	while screenGui.Parent do
		TweenService:Create(mainTitle, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			TextTransparency = 0.15,
		}):Play()
		task.wait(1.2)
		TweenService:Create(mainTitle, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			TextTransparency = 0,
		}):Play()
		task.wait(1.2)
	end
end)

-- ============================================================
-- BARRE DE CHARGEMENT (en bas)
-- ============================================================

local barOuter = Instance.new("Frame")
barOuter.Size = UDim2.fromScale(0.5, 0.025)
barOuter.AnchorPoint = Vector2.new(0.5, 1)
barOuter.Position = UDim2.fromScale(0.5, 0.92)
barOuter.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
barOuter.BorderSizePixel = 0
barOuter.Parent = background

local barOuterCorner = Instance.new("UICorner")
barOuterCorner.CornerRadius = UDim.new(1, 0)
barOuterCorner.Parent = barOuter

local barStroke = Instance.new("UIStroke")
barStroke.Color = Color3.fromRGB(80, 80, 100)
barStroke.Thickness = 1
barStroke.Transparency = 0.4
barStroke.Parent = barOuter

local barFill = Instance.new("Frame")
barFill.Size = UDim2.fromScale(0, 1)
barFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barOuter

local barFillCorner = Instance.new("UICorner")
barFillCorner.CornerRadius = UDim.new(1, 0)
barFillCorner.Parent = barFill

local barFillGradient = Instance.new("UIGradient")
barFillGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 200)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 255)),
})
barFillGradient.Parent = barFill

-- Petit halo lumineux qui suit le bout de la barre
local glow = Instance.new("Frame")
glow.Size = UDim2.fromOffset(14, 14)
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glow.BackgroundTransparency = 0.5
glow.ZIndex = 2
glow.Parent = barOuter
local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(1, 0)
glowCorner.Parent = glow

-- Texte pourcentage
local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.fromScale(0.5, 0.03)
percentLabel.AnchorPoint = Vector2.new(0.5, 0)
percentLabel.Position = UDim2.fromScale(0.5, 0.935)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "Chargement... 0%"
percentLabel.TextColor3 = Color3.fromRGB(190, 190, 200)
percentLabel.Font = Enum.Font.GothamMedium
percentLabel.TextScaled = true
percentLabel.Parent = background

-- ============================================================
-- CHARGEMENT RÉEL DES ASSETS
-- ============================================================

local assetsToLoad = game:GetDescendants()
local totalAssets = #assetsToLoad
local loadedCount = 0

local function updateBar(alpha)
	TweenService:Create(barFill, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
		Size = UDim2.fromScale(alpha, 1),
	}):Play()
	glow.Position = UDim2.fromScale(alpha, 0.5)
	percentLabel.Text = string.format("Chargement... %d%%", math.floor(alpha * 100))
end

task.spawn(function()
	ContentProvider:PreloadAsync(assetsToLoad, function()
		loadedCount += 1
		updateBar(loadedCount / totalAssets)
	end)
end)

-- On attend que tout soit vraiment chargé (avec un minimum de temps pour que l'anim soit belle)
local startTime = os.clock()
while loadedCount < totalAssets and os.clock() - startTime < 15 do
	RunService.Heartbeat:Wait()
end

-- On force la barre à 100%
updateBar(1)
task.wait(0.5)

-- ============================================================
-- SORTIE (fade out)
-- ============================================================

local fadeInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

TweenService:Create(mainTitle, fadeInfo, { TextTransparency = 1 }):Play()
TweenService:Create(subTitle, fadeInfo, { TextTransparency = 1 }):Play()
TweenService:Create(percentLabel, fadeInfo, { TextTransparency = 1 }):Play()
TweenService:Create(barOuter, fadeInfo, { BackgroundTransparency = 1 }):Play()
TweenService:Create(barFill, fadeInfo, { BackgroundTransparency = 1 }):Play()
TweenService:Create(glow, fadeInfo, { BackgroundTransparency = 1 }):Play()
TweenService:Create(barStroke, fadeInfo, { Transparency = 1 }):Play()

task.wait(0.3)
TweenService:Create(background, fadeInfo, { BackgroundTransparency = 1 }):Play()

task.wait(0.7)
screenGui:Destroy()