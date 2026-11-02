-- Met à l'échelle les interfaces selon la taille de l'écran, pour qu'elles aient les mêmes proportions
-- sur PC, tablette et mobile. Trois façons d'y inscrire une interface :
--   1. lui donner le tag "AutoScale" (CollectionService)                       -> un UIScale "AutoScale" est posé dedans
--   2. l'écrire dans EXTRA ci-dessous (interfaces créées par d'autres scripts)  -> même chose, sans toucher à leur script
--   3. écrire son ScreenGui dans WHOLE_GUI                                      -> un UIScale est posé dans le ScreenGui entier
--      (pour un bouton posé seul, qui a déjà son UIScale d'effet de survol : un objet n'écoute qu'un seul UIScale)
--   4. AUTOMATIQUE : tout élément posé directement dans un ScreenGui, dessiné en pixels (taille en offset ou automatique),
--      qui ne se met pas déjà à l'échelle lui-même (pas d'UIScale à lui) est pris en charge tout seul. Un bouton seul
--      (qui reçoit l'UIScale de survol d'UIEffects) est réduit en recalculant ses tailles en pixels.
-- Attribut "ScaleMult" sur un élément : multiplie son échelle (ex. 0.77 = 1,3 fois plus petit).
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local TAG = "AutoScale"
local DESIGN_SIZE = Vector2.new(1280, 760) -- taille d'écran pour laquelle les interfaces ont été dessinées
local MIN_SCALE, MAX_SCALE = 0.4, 1.4

local EXTRA = { -- ScreenGui = {noms des éléments à mettre à l'échelle} ; "*" = tous ses éléments
	TradeGui = {"Toast", "Invites"},
	UpdateGui = {"*"},
	CodeRedeemGui = {"*"},
	SeedPlantingGui = {"*"},
	EggPlacementGui = {"*"},
	Countdown = {"Container"},
	LuckEventGui = {"Luck"},
	CodeGui = {"Main"},
	EventStackGui = {"Stack"},
}
local WHOLE_GUI = {ClotureInteractGui = true}

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

local function getScale()
	local viewport = camera.ViewportSize
	return math.clamp(math.min(viewport.X / DESIGN_SIZE.X, viewport.Y / DESIGN_SIZE.Y), MIN_SCALE, MAX_SCALE)
end

local function apply(instance)
	if not instance:IsDescendantOf(playerGui) then return end
	local scale = instance:FindFirstChild("AutoScale")
	if not scale then
		for _, other in instance:GetChildren() do -- un objet n'écoute qu'un seul UIScale : s'il en a déjà un, on n'en ajoute pas
			if other:IsA("UIScale") then return end
		end
		scale = Instance.new("UIScale")
		scale.Name = "AutoScale"
		scale.Parent = instance
	end
	scale.Scale = getScale() * (instance:GetAttribute("ScaleMult") or 1)
end

local function applyAll()
	for _, instance in CollectionService:GetTagged(TAG) do apply(instance) end
end

CollectionService:GetInstanceAddedSignal(TAG):Connect(apply)
camera:GetPropertyChangedSignal("ViewportSize"):Connect(applyAll)
applyAll()

-- interfaces de la liste EXTRA et WHOLE_GUI, dès qu'elles existent
local function enroll(gui)
	if not gui:IsA("ScreenGui") then return end
	if WHOLE_GUI[gui.Name] then CollectionService:AddTag(gui, TAG) end
	local names = EXTRA[gui.Name]
	if not names then return end
	local function child(c)
		if not c:IsA("GuiObject") then return end
		if names[1] == "*" or table.find(names, c.Name) then CollectionService:AddTag(c, TAG) end
	end
	for _, c in gui:GetChildren() do child(c) end
	gui.ChildAdded:Connect(child)
end
for _, gui in playerGui:GetChildren() do enroll(gui) end
playerGui.ChildAdded:Connect(enroll)

---------------------------------------------------------------- 4. AUTOMATIQUE : toutes les autres interfaces
local SKIP_GUI = { -- plein écran / effets / admin : on n'y touche pas
	AdminPanelGui = true, HackerEventGui = true, HackerIntro = true, AdminThrowGui = true, RunAlertGui = true, BossAlertGui = true,
	Freecam = true, TouchGui = true, BubbleChat = true, Chat = true,
}
local pixelButtons = {} -- [bouton] = true : réduits en recalculant leurs tailles

local function isFullScreen(o) return o.Size.X.Scale >= 0.9 and o.Size.Y.Scale >= 0.9 end
local function pixelSized(o) return o.Size.X.Offset > 0 or o.Size.Y.Offset > 0 or o.AutomaticSize ~= Enum.AutomaticSize.None end
local function scaledUDim2(u, s) return UDim2.new(u.X.Scale, u.X.Offset * s, u.Y.Scale, u.Y.Offset * s) end

-- bouton posé seul : on réduit ses tailles / positions en pixels, ses textes et ses contours (valeurs d'origine gardées)
local function scalePixels(o, s)
	local function one(x)
		if x:IsA("GuiObject") then
			if x:GetAttribute("PxSize") == nil then x:SetAttribute("PxSize", x.Size) end
			x.Size = scaledUDim2(x:GetAttribute("PxSize"), s)
			if x ~= o then
				if x:GetAttribute("PxPos") == nil then x:SetAttribute("PxPos", x.Position) end
				x.Position = scaledUDim2(x:GetAttribute("PxPos"), s)
			end
			if (x:IsA("TextLabel") or x:IsA("TextButton") or x:IsA("TextBox")) and not x.TextScaled then
				if x:GetAttribute("PxText") == nil then x:SetAttribute("PxText", x.TextSize) end
				x.TextSize = math.max(8, math.floor(x:GetAttribute("PxText") * s + 0.5))
			end
		elseif x:IsA("UIStroke") then
			if x:GetAttribute("PxThick") == nil then x:SetAttribute("PxThick", x.Thickness) end
			x.Thickness = x:GetAttribute("PxThick") * s
		end
	end
	one(o)
	for _, d in o:GetDescendants() do one(d) end
end

local function autoEnroll(o)
	if not o:IsA("GuiObject") or not o.Parent then return end
	if CollectionService:HasTag(o, TAG) or pixelButtons[o] then return end
	if isFullScreen(o) or not pixelSized(o) then return end
	for _, c in o:GetChildren() do
		if c:IsA("UIScale") and c.Name ~= "FxScale" then return end -- il se met déjà à l'échelle tout seul
	end
	if o:IsA("GuiButton") then
		pixelButtons[o] = true
		scalePixels(o, getScale())
	else
		CollectionService:AddTag(o, TAG)
	end
end

local function watchGui(gui)
	if not gui:IsA("ScreenGui") or SKIP_GUI[gui.Name] or WHOLE_GUI[gui.Name] or EXTRA[gui.Name] then return end
	local function consider(c)
		-- on laisse au script qui crée l'élément le temps de poser sa taille et son éventuel UIScale
		task.delay(0.5, function() if c.Parent == gui then autoEnroll(c) end end)
	end
	for _, c in gui:GetChildren() do consider(c) end
	gui.ChildAdded:Connect(consider)
end
for _, gui in playerGui:GetChildren() do watchGui(gui) end
playerGui.ChildAdded:Connect(watchGui)

camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	local s = getScale()
	for button in pixelButtons do
		if button.Parent then scalePixels(button, s) else pixelButtons[button] = nil end
	end
end)
