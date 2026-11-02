-- Reference copy for study. Game: Smash Egg For Animals (smash-egg-for-animals)
-- Original: StarterPlayer/StarterPlayerScripts/RunAlertClient.client.lua
-- What it does: Full-screen "RUN!" warning driven by a player attribute: red flash, pulsing gradient screen edges, heartbeat-scaled text; fades out when the attribute clears.

-- Alerte RUN : dès qu'on porte un animal (attribut Carrying > 0, EggZoneServer), un gros "RUN!" rouge apparaît en haut
-- de l'écran avec un flash rouge et un contour d'écran rouge qui pulse. Disparaît quand on ne porte plus rien.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local RED = Color3.fromRGB(255, 35, 35)

local gui = Instance.new("ScreenGui")
gui.Name = "RunAlertGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 50
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Enabled = false

-- contour rouge de l'écran (4 bords en dégradé vers l'intérieur)
local edges = {}
local function edge(size, pos, anchor, rotation)
	local f = Instance.new("Frame")
	f.BorderSizePixel = 0
	f.BackgroundColor3 = RED
	f.Size, f.Position, f.AnchorPoint = size, pos, anchor
	local g = Instance.new("UIGradient")
	g.Rotation = rotation
	g.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
	g.Parent = f
	f.Parent = gui
	table.insert(edges, f)
end
edge(UDim2.new(1, 0, 0.2, 0), UDim2.new(0, 0, 0, 0), Vector2.new(0, 0), 90)
edge(UDim2.new(1, 0, 0.2, 0), UDim2.new(0, 0, 1, 0), Vector2.new(0, 1), -90)
edge(UDim2.new(0.14, 0, 1, 0), UDim2.new(0, 0, 0, 0), Vector2.new(0, 0), 0)
edge(UDim2.new(0.14, 0, 1, 0), UDim2.new(1, 0, 0, 0), Vector2.new(1, 0), 180)

-- flash plein écran au moment où on prend l'animal
local flash = Instance.new("Frame")
flash.BorderSizePixel = 0
flash.BackgroundColor3 = RED
flash.BackgroundTransparency = 1
flash.Size = UDim2.fromScale(1, 1)
flash.Parent = gui

-- texte RUN! en haut
local holder = Instance.new("Frame")
holder.BackgroundTransparency = 1
holder.AnchorPoint = Vector2.new(0.5, 0)
holder.Position = UDim2.new(0.5, 0, 0.07, 0)
holder.Size = UDim2.new(0.5, 0, 0.16, 0)
holder.Parent = gui
local scale = Instance.new("UIScale")
scale.Parent = holder

local label = Instance.new("TextLabel")
label.BackgroundTransparency = 1
label.Size = UDim2.new(1, 0, 0.72, 0)
label.Font = Enum.Font.FredokaOne
label.Text = "RUN!"
label.TextScaled = true
label.TextColor3 = RED
label.Parent = holder
local maxSize = Instance.new("UITextSizeConstraint")
maxSize.MaxTextSize = 96
maxSize.Parent = label
local stroke = Instance.new("UIStroke")
stroke.Thickness = 4
stroke.Color = Color3.fromRGB(55, 0, 0)
stroke.Parent = label

local sub = Instance.new("TextLabel")
sub.BackgroundTransparency = 1
sub.Position = UDim2.new(0, 0, 0.72, 0)
sub.Size = UDim2.new(1, 0, 0.28, 0)
sub.Font = Enum.Font.FredokaOne
sub.Text = "Back to the safe zone!"
sub.TextScaled = true
sub.TextColor3 = Color3.new(1, 1, 1)
sub.Parent = holder
local subMax = Instance.new("UITextSizeConstraint")
subMax.MaxTextSize = 30
subMax.Parent = sub
local subStroke = Instance.new("UIStroke")
subStroke.Thickness = 2.5
subStroke.Color = Color3.fromRGB(55, 0, 0)
subStroke.Parent = sub

gui.Parent = player:WaitForChild("PlayerGui")

local active = false
local fade = 0 -- 0..1 : visibilité globale (apparition / disparition)
local clock = 0

local function show()
	if active then return end
	active = true
	gui.Enabled = true
	clock = 0
	scale.Scale = 2.4
	TweenService:Create(scale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	flash.BackgroundTransparency = 0.45
	TweenService:Create(flash, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
end

local function hide()
	active = false
end

RunService.RenderStepped:Connect(function(dt)
	if not gui.Enabled then return end
	clock += dt
	fade = active and math.min(1, fade + dt / 0.15) or math.max(0, fade - dt / 0.3)
	if fade <= 0 and not active then
		gui.Enabled = false
		return
	end
	local pulse = 0.5 + 0.5 * math.sin(clock * 7) -- 0..1
	-- texte qui bat comme un cœur et clignote entre rouge vif et rouge foncé
	if active and clock > 0.35 then scale.Scale = 1 + 0.07 * pulse end
	label.TextColor3 = RED:Lerp(Color3.fromRGB(255, 120, 120), pulse)
	local textT = 1 - fade
	label.TextTransparency, sub.TextTransparency = textT, textT
	stroke.Transparency, subStroke.Transparency = textT, textT
	-- contour d'écran rouge qui pulse
	local edgeT = 1 - fade * (0.35 + 0.35 * pulse)
	for _, f in edges do f.BackgroundTransparency = edgeT end
end)

local function refresh()
	if (player:GetAttribute("Carrying") or 0) > 0 then show() else hide() end
end
player:GetAttributeChangedSignal("Carrying"):Connect(refresh)
refresh()
