-- Bouton DROP : quand on porte un animal (attribut Carrying > 0), la barre, l'inventaire et les boutons du HUD s'effacent
-- et un grand bouton rouge DROP apparaît en bas de l'écran (même style que les boutons Shop / Index : face dégradée,
-- studs, lèvre noire en relief, texte Montserrat). Clic, touche G / Retour arrière ou bouton X de la manette :
-- l'animal est posé au sol (remote DropPet). Quand on ne porte plus rien, le HUD revient.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(eggSystem:WaitForChild("EggConfig"))
local petTemplates = eggSystem:WaitForChild("Pets")
local dropRemote = eggSystem:WaitForChild("Remotes"):WaitForChild("DropPet")

local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local STUDS = "rbxassetid://7447638591"
local BEVEL = "rbxassetid://136393561370347"
local INK = Color3.fromRGB(39, 12, 16)
local W, H = 320, 92 -- taille du bouton (rectangle)
local FACE_DROP = 7 -- épaisseur de la lèvre en relief sous la face
-- interfaces cachées pendant qu'on porte un animal
local HIDE = {"HotbarGui", "InventoryButtonGui", "PetInventoryGui", "left bottom", "SettingsGui", "IndexGui", "ShopGui",
	"CodeGui", "HammerGui", "TopBarGui", "GardenPanelGui", "HotbarDragGui"}

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end

---------------------------------------------------------------- construction
local gui = new("ScreenGui", {Name = "DropGui", ResetOnSpawn = false, DisplayOrder = 12, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Enabled = true}, playerGui)
-- le cadre porte la mise à l'échelle de l'écran (UIScaler) ; le bouton a sa propre UIScale pour le survol
local holder = new("Frame", {Name = "Holder", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -26), Size = UDim2.fromOffset(W, H),
	BackgroundTransparency = 1, Visible = false}, gui)
CollectionService:AddTag(holder, "AutoScale")

local button = new("TextButton", {Name = "Drop", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1, Text = "", AutoButtonColor = false, Selectable = true}, holder)
local pop = new("UIScale", {Scale = 1}, button)

-- ombre douce sous le bouton
new("Frame", {Name = "Shadow", Position = UDim2.fromOffset(5, 9), Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.new(0, 0, 0),
	BackgroundTransparency = 0.6, BorderSizePixel = 0, ZIndex = 0}, button)
-- lèvre en relief (le dessous du bouton), rouge sombre
local lip = new("Frame", {Name = "Lip", Position = UDim2.fromOffset(0, FACE_DROP), Size = UDim2.new(1, 0, 1, -FACE_DROP), BackgroundColor3 = Color3.fromRGB(120, 14, 26),
	BorderSizePixel = 0, ZIndex = 1}, button)
new("UIStroke", {Thickness = 3, Color = INK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, lip)

-- la face
local face = new("Frame", {Name = "Face", Position = UDim2.fromOffset(0, 0), Size = UDim2.new(1, 0, 1, -FACE_DROP), BackgroundColor3 = Color3.new(1, 1, 1),
	BorderSizePixel = 0, ZIndex = 2, ClipsDescendants = true}, button)
new("UIGradient", {Name = "Shade", Rotation = 90, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 118, 104)),
	ColorSequenceKeypoint.new(0.55, Color3.fromRGB(238, 52, 56)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 22, 40))})}, face)
local faceStroke = new("UIStroke", {Thickness = 3, Color = INK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, face)
local studs = new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile,
	TileSize = UDim2.fromOffset(34, 34), ImageColor3 = Color3.new(1, 1, 1), ImageTransparency = 0.78, ZIndex = 2}, face)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(Color3.fromRGB(255, 210, 200), Color3.fromRGB(255, 120, 120))}, studs)
new("ImageLabel", {Name = "Bevel", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1),
	Image = BEVEL, ImageTransparency = 0.55, ZIndex = 3}, face)
-- reflet en haut et ombre en bas de la face (effet bombé)
new("Frame", {Name = "Gloss", Size = UDim2.new(1, 0, 0.42, 0), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.82, BorderSizePixel = 0, ZIndex = 3}, face)
new("Frame", {Name = "Edge3D", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 6), BackgroundColor3 = Color3.new(0, 0, 0),
	BackgroundTransparency = 0.72, BorderSizePixel = 0, ZIndex = 3}, face)
-- éclat lumineux qui balaie la face de temps en temps
local sweep = new("Frame", {Name = "Sweep", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(-0.3, 0.5), Size = UDim2.new(0, 46, 2, 0), Rotation = 18,
	BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.55, BorderSizePixel = 0, ZIndex = 4}, face)
new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1)})}, sweep)

-- case de gauche : l'animal porté, en 3D
local slot = new("Frame", {Name = "PetSlot", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(66, 66),
	BackgroundColor3 = Color3.fromRGB(110, 10, 24), BackgroundTransparency = 0.35, BorderSizePixel = 0, ZIndex = 5}, face)
new("UIStroke", {Thickness = 3, Color = INK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, slot)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(150, 150, 150))}, slot)
local view = new("ViewportFrame", {Name = "View", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 6, Ambient = Color3.fromRGB(200, 200, 200),
	LightColor = Color3.fromRGB(255, 245, 230), LightDirection = Vector3.new(-1, -1, -1)}, slot)

-- textes
local title = new("TextLabel", {Name = "Title", BackgroundTransparency = 1, Position = UDim2.new(0, 90, 0, 6), Size = UDim2.new(1, -150, 0.56, 0), Text = "DROP",
	FontFace = FONT, TextScaled = true, TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6}, face)
new("UIStroke", {Thickness = 3, Color = INK, ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual}, title)
local sub = new("TextLabel", {Name = "Pet", BackgroundTransparency = 1, Position = UDim2.new(0, 91, 0.58, 0), Size = UDim2.new(1, -150, 0.28, 0), Text = "",
	FontFace = FONT, TextScaled = true, TextColor3 = Color3.fromRGB(255, 226, 214), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6}, face)
new("UIStroke", {Thickness = 2, Color = INK, ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual}, sub)

-- touche clavier (PC) : petite plaque « G » à droite
local key = new("Frame", {Name = "Key", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = UDim2.fromOffset(40, 40),
	BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, ZIndex = 6}, face)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(205, 208, 220))}, key)
new("UIStroke", {Thickness = 3, Color = INK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, key)
new("Frame", {Name = "Edge3D", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 4), BackgroundColor3 = Color3.new(0, 0, 0),
	BackgroundTransparency = 0.75, BorderSizePixel = 0, ZIndex = 7}, key)
local keyLabel = new("TextLabel", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = "G", FontFace = FONT, TextScaled = true,
	TextColor3 = Color3.fromRGB(196, 22, 40), ZIndex = 8}, key)
new("UIPadding", {PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6)}, keyLabel)

local function refreshKeyHint()
	local pad = UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled
	key.Visible = UserInputService.KeyboardEnabled or pad
	keyLabel.Text = (pad and "X") or "G"
	local right = key.Visible and 150 or 104
	title.Size = UDim2.new(1, -right, 0.56, 0)
	sub.Size = UDim2.new(1, -right, 0.28, 0)
end
refreshKeyHint()
UserInputService.LastInputTypeChanged:Connect(refreshKeyHint)

---------------------------------------------------------------- animal affiché dans la case
local shownPet
local function showPet()
	local name = player:GetAttribute("CarryPet")
	local kg = player:GetAttribute("CarryPetKg")
	local info = name and Config.Pets[name]
	sub.Text = info and (string.upper(info.Name) .. (kg and ("  ·  " .. Config.FormatKg(kg)) or "")) or "Put it on the ground"
	if shownPet == name then return end
	shownPet = name
	view:ClearAllChildren()
	local template = name and petTemplates:FindFirstChild(name)
	if not template then return end
	local model = template:Clone()
	model:PivotTo(CFrame.new())
	model.Parent = view
	local cf, size = model:GetBoundingBox()
	local camera = Instance.new("Camera")
	camera.FieldOfView = 40
	local distance = math.max(size.X, size.Y, size.Z) * 1.55
	camera.CFrame = CFrame.lookAt(cf.Position + Vector3.new(0.5, 0.3, 1).Unit * distance, cf.Position)
	camera.Parent = view
	view.CurrentCamera = camera
end

---------------------------------------------------------------- appui : la face s'enfonce dans la lèvre
local pressed, hovering = false, false
local function setFace(down)
	TweenService:Create(face, TweenInfo.new(0.07, Enum.EasingStyle.Quad), {Position = UDim2.fromOffset(0, down and FACE_DROP - 2 or 0)}):Play()
end
local function setHover(on)
	hovering = on
	TweenService:Create(pop, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Scale = on and 1.05 or 1}):Play()
end
button.MouseEnter:Connect(function() setHover(true) end)
button.MouseLeave:Connect(function() setHover(false) if pressed then pressed = false setFace(false) end end)
button.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then pressed = true setFace(true) end
end)
button.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then pressed = false setFace(false) end
end)

local lastFire = 0
local function drop()
	if not holder.Visible or os.clock() - lastFire < 0.35 then return end
	lastFire = os.clock()
	setFace(true)
	task.delay(0.09, function() if not pressed then setFace(false) end end)
	pop.Scale = 0.92
	TweenService:Create(pop, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = hovering and 1.05 or 1}):Play()
	dropRemote:FireServer()
end
button.Activated:Connect(drop)
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.G or input.KeyCode == Enum.KeyCode.Backspace or input.KeyCode == Enum.KeyCode.ButtonX then drop() end
end)

---------------------------------------------------------------- HUD caché / bouton visible selon ce qu'on porte
local saved = {} -- [ScreenGui] = Enabled d'avant
local function hideHud()
	for _, name in HIDE do
		local other = playerGui:FindFirstChild(name)
		if other and other:IsA("ScreenGui") then
			if saved[other] == nil then saved[other] = other.Enabled end
			if other.Enabled then other.Enabled = false end
		end
	end
end
local function restoreHud()
	for other, enabled in saved do
		if other.Parent then other.Enabled = enabled end
	end
	table.clear(saved)
end

local showing = false
local appear
local function setShown(on)
	if on == showing then return end
	showing = on
	if appear then appear:Cancel() end
	if on then
		hideHud()
		showPet()
		holder.Visible = true
		holder.Position = UDim2.new(0.5, 0, 1, 90)
		pop.Scale = 0.6
		appear = TweenService:Create(holder, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 1, -26)})
		appear:Play()
		TweenService:Create(pop, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	else
		pressed, hovering = false, false
		setFace(false)
		appear = TweenService:Create(holder, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 1, 110)})
		appear:Play()
		appear.Completed:Connect(function(state)
			if state == Enum.PlaybackState.Completed and not showing then holder.Visible = false end
		end)
		restoreHud()
	end
end

local function refresh()
	setShown((player:GetAttribute("Carrying") or 0) > 0)
	if showing then showPet() end
end
player:GetAttributeChangedSignal("Carrying"):Connect(refresh)
player:GetAttributeChangedSignal("CarryPet"):Connect(refresh)
player:GetAttributeChangedSignal("CarryPetKg"):Connect(refresh)
player.CharacterAdded:Connect(function() task.defer(refresh) end)
refresh()

-- une interface de la liste qui apparaît ou se rallume pendant qu'on porte (créée par un autre script) est recachée
playerGui.ChildAdded:Connect(function(child)
	if showing and table.find(HIDE, child.Name) then task.defer(hideHud) end
end)

---------------------------------------------------------------- vie du bouton : il respire doucement et un reflet le balaie
local t0 = os.clock()
RunService.RenderStepped:Connect(function()
	if not holder.Visible then return end
	local t = os.clock() - t0
	-- contour qui pulse du noir au rouge clair
	local k = (math.sin(t * 4) + 1) / 2
	faceStroke.Color = INK:Lerp(Color3.fromRGB(255, 170, 160), k * 0.35)
	-- reflet : traverse la face en 0,6 s toutes les 2,2 s
	local cycle = t % 2.2
	sweep.Position = UDim2.fromScale(cycle < 0.6 and (-0.2 + cycle / 0.6 * 1.4) or -0.3, 0.5)
	-- l'animal tourne dans sa case
	local camera = view.CurrentCamera
	local model = view:FindFirstChildOfClass("Model")
	if camera and model then model:PivotTo(CFrame.Angles(0, t * 1.2, 0)) end
end)
