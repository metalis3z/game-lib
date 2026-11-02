-- Écran de chargement : l'affiche du jeu au centre pendant 10 secondes, puis un flash blanc qui s'efface
-- pendant que la caméra descend du ciel jusqu'au joueur.
local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")

local DURATION = 10
local POSTER = "rbxassetid://88021759115044"
local STUD = "rbxassetid://7447638591"
local MONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local TIPS = {"Run on your treadmill to gain speed!", "Break eggs with your hammer!", "Grab the animal and run back to the safe zone!", "Watch out for the zone guardians!", "Upgrade your treadmill to gain speed faster!", "Bigger eggs hatch bigger animals!"}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
ReplicatedFirst:RemoveDefaultLoadingScreen()

local gui = Instance.new("ScreenGui")
gui.Name = "LoadingGui"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 1000
gui.Parent = playerGui

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local back = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Active = true}, gui)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(Color3.fromRGB(70, 190, 255), Color3.fromRGB(20, 90, 220))}, back)
local studs = new("ImageLabel", {BackgroundTransparency = 1, Size = UDim2.new(1, 120, 1, 120), Position = UDim2.fromOffset(-60, -60), Image = STUD, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(60, 60),
	ImageTransparency = 0.82, ImageColor3 = Color3.new(1, 1, 1)}, back)
-- l'affiche du jeu, au centre, dans un cadre blanc à contour noir
local frame = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.44), Size = UDim2.fromScale(0.62, 0.62), SizeConstraint = Enum.SizeConstraint.RelativeYY,
	BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0}, back)
new("UIStroke", {Thickness = 6, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, frame)
local poster = new("ImageLabel", {Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -16, 1, -16), BackgroundColor3 = Color3.fromRGB(60, 170, 250), BorderSizePixel = 0, Image = POSTER, ScaleType = Enum.ScaleType.Crop}, frame)
local scale = new("UIScale", {Scale = 0.7}, frame)
-- barre de progression
local bar = new("Frame", {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.fromScale(0.44, 0.045), BackgroundColor3 = Color3.fromRGB(20, 40, 90), BorderSizePixel = 0}, back)
new("UIStroke", {Thickness = 5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, bar)
local fill = new("Frame", {Size = UDim2.fromScale(0, 1), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, ClipsDescendants = true}, bar)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(Color3.fromRGB(255, 236, 90), Color3.fromRGB(255, 140, 20))}, fill)
new("ImageLabel", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUD, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(26, 26), ImageTransparency = 0.2, ImageColor3 = Color3.fromRGB(255, 190, 50)}, fill)
local function text(str, y, height, thickness)
	local l = new("TextLabel", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, y), Size = UDim2.fromScale(0.8, height), FontFace = MONT, Text = str, TextScaled = true, TextColor3 = Color3.new(1, 1, 1)}, back)
	new("UIStroke", {Thickness = thickness}, l)
	return l
end
local percent = text("0%", 0.805, 0.035, 3)
percent.ZIndex = 3
local loading = text("Loading...", 0.855, 0.045, 4)
local tip = text(TIPS[1], 0.915, 0.035, 3)
tip.TextColor3 = Color3.fromRGB(255, 236, 120)
-- voile blanc pour le flash de fin
local white = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 10}, gui)

task.spawn(function() pcall(function() ContentProvider:PreloadAsync({poster}) end) end)
TweenService:Create(scale, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()

-- 10 secondes : la barre avance, l'affiche respire, les studs défilent, les conseils changent
local start = os.clock()
while os.clock() - start < DURATION do
	local elapsed = os.clock() - start
	local k = elapsed / DURATION
	fill.Size = UDim2.fromScale(k, 1)
	percent.Text = math.floor(k * 100) .. "%"
	loading.Text = "Loading" .. string.rep(".", math.floor(elapsed * 2) % 4)
	tip.Text = TIPS[math.floor(elapsed / 2.5) % #TIPS + 1]
	frame.Rotation = math.sin(elapsed * 1.4) * 1.5
	if elapsed > 0.7 then scale.Scale = 1 + math.sin(elapsed * 2.2) * 0.015 end
	studs.Position = UDim2.fromOffset(-60 + (elapsed * 14) % 60, -60 + (elapsed * 14) % 60)
	RunService.RenderStepped:Wait()
end
fill.Size = UDim2.fromScale(1, 1)
percent.Text = "100%"

-- flash blanc, puis il s'efface pendant que la caméra descend du ciel jusqu'au joueur
local flashIn = TweenService:Create(white, TweenInfo.new(0.35), {BackgroundTransparency = 0})
flashIn:Play()
flashIn.Completed:Wait()
back:Destroy()

local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart", 10)
local camera = workspace.CurrentCamera
if hrp then
	camera.CameraType = Enum.CameraType.Scriptable
	local finish = CFrame.lookAt((hrp.CFrame * CFrame.new(0, 7, 16)).Position, hrp.Position + Vector3.new(0, 2, 0))
	camera.CFrame = CFrame.lookAt(hrp.Position + Vector3.new(0, 220, 60), hrp.Position)
	TweenService:Create(white, TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
	local dive = TweenService:Create(camera, TweenInfo.new(3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {CFrame = finish})
	dive:Play()
	dive.Completed:Wait()
	camera.CameraType = Enum.CameraType.Custom
else
	TweenService:Create(white, TweenInfo.new(1.2), {BackgroundTransparency = 1}):Play()
	task.wait(1.2)
end
task.wait(0.3)
gui:Destroy()

