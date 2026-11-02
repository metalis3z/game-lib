-- Relief des boutons de tout le jeu. Un bouton « maison » (fond en dégradé + contour noir) reçoit ici :
--   * un filet clair à l'intérieur, qui fait ressortir sa couleur
--   * une bande plus foncée de sa couleur en bas de la face (l'épaisseur du bouton)
-- Le script s'occupe aussi des contours (toujours carrés) et des fenêtres (fond à 0,3, une seule ouverte à la fois) : voir plus bas.
-- Rien n'est ajouté aux boutons qui ont déjà leur relief (enfant "Lip"), ni à ceux marqués de l'attribut NoPolish ou NoFx.
-- Attribut NoInner : pas de filet clair.
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local BLACK, WHITE = Color3.new(0, 0, 0), Color3.new(1, 1, 1)
local done = setmetatable({}, {__mode = "k"})

local function borderStroke(button)
	for _, c in button:GetChildren() do
		if c:IsA("UIStroke") and c.Enabled and (c.ApplyStrokeMode == Enum.ApplyStrokeMode.Border or c.Name == "Outline") then return c end
	end
end

local function setup(button)
	if done[button] or not button:IsA("GuiButton") then return end
	if button:GetAttribute("NoPolish") or button:GetAttribute("NoFx") or button:FindFirstChild("Lip") then return end
	if button.BackgroundTransparency > 0.5 then return end
	if button:FindFirstAncestor("HotbarGui") then return end -- les cases de la barre du bas restent plates (une bande noire dessous faisait un trait)
	local gradient = button:FindFirstChildOfClass("UIGradient")
	local stroke = borderStroke(button)
	if not gradient or not stroke then return end
	done[button] = true
	local thickness = math.max(2, math.floor(stroke.Thickness + 0.5))

	-- le bas du bouton : une bande de la même couleur, plus foncée (un voile gris posé sur le bas de la face), comme l'épaisseur
	-- d'une touche. Elle est dans le bouton : son contour noir l'entoure avec le reste.
	if not button:FindFirstChild("Edge3D") and button.AbsoluteSize.Y >= 26 then
		local edge = Instance.new("Frame")
		edge.Name = "Edge3D"
		edge.BorderSizePixel = 0
		edge.BackgroundColor3 = BLACK
		edge.BackgroundTransparency = 0.72
		edge.AnchorPoint = Vector2.new(0, 1)
		edge.Position = UDim2.fromScale(0, 1)
		edge.Size = UDim2.new(1, 0, 0, math.clamp(math.floor(button.AbsoluteSize.Y * 0.13 + 0.5), 4, 7))
		edge.ZIndex = button.ZIndex
		edge.Parent = button
	end

	if not (button:FindFirstChild("Inner3D") or button:FindFirstChild("Inner") or button:FindFirstChild("FxStitch") or button:GetAttribute("NoInner")) and button.AbsoluteSize.Y >= 30 then
		local inner = Instance.new("Frame")
		inner.Name = "Inner3D"
		inner.BackgroundTransparency = 1
		inner.Position = UDim2.fromOffset(thickness, thickness)
		inner.Size = UDim2.new(1, -2 * thickness, 1, -2 * thickness)
		inner.ZIndex = button.ZIndex
		local line = Instance.new("UIStroke")
		line.Thickness = 2
		line.Color = WHITE
		line.Transparency = 0.58
		line.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		line.Parent = inner
		inner.Parent = button
	end
end

-- Contours carrés : par défaut un UIStroke arrondit ses coins. Tous les contours de cadre (pas ceux des textes) ont des angles vifs.
local function square(stroke)
	if stroke.ApplyStrokeMode == Enum.ApplyStrokeMode.Border or (stroke.Parent and not stroke.Parent:IsA("TextLabel") and not stroke.Parent:IsA("TextButton") and not stroke.Parent:IsA("TextBox")) then
		stroke.LineJoinMode = Enum.LineJoinMode.Miter
	end
end

---------------------------------------------------------------- fenêtres
-- Une fenêtre = un cadre nommé Main, Window ou Panel, posé directement dans un ScreenGui, fermé au départ et prévu pour faire au
-- moins 320 x 220. Deux règles pour toutes :
--   * son fond sombre est à 0,3 de transparence (le bandeau, les lignes et les boutons posés dessus restent pleins)
--   * une seule fenêtre ouverte à la fois : en ouvrir une ferme celle qui l'était
local WINDOW_NAMES = {Main = true, Window = true, Panel = true}
local BODY_TRANSPARENCY = 0.3
local windows = setmetatable({}, {__mode = "k"})
local function watchWindow(frame)
	if windows[frame] or not WINDOW_NAMES[frame.Name] or not frame:IsA("Frame") then return end
	local layer = frame.Parent
	if not layer or not layer:IsA("ScreenGui") then return end
	local size = frame.Size
	local around = workspace.CurrentCamera.ViewportSize
	local wide = math.max(frame.AbsoluteSize.X, size.X.Scale * around.X + size.X.Offset)
	local tall = math.max(frame.AbsoluteSize.Y, size.Y.Scale * around.Y + size.Y.Offset)
	if wide < 320 or tall < 220 then return end
	if frame.Visible and layer.Enabled then return end -- toujours affiché : ce n'est pas une fenêtre, c'est un bout de l'interface
	windows[frame] = true
	local function body()
		if frame:GetAttribute("SolidWindow") then return end -- fenêtre voulue opaque (panneau admin, panneau créateur) : on n'y touche pas
		if frame.BackgroundTransparency < BODY_TRANSPARENCY then frame.BackgroundTransparency = BODY_TRANSPARENCY end
	end
	body()
	frame:GetPropertyChangedSignal("BackgroundTransparency"):Connect(body)
	frame:GetPropertyChangedSignal("Visible"):Connect(function()
		if not frame.Visible or not layer.Enabled then return end
		for other in windows do
			local otherLayer = other.Parent
			if other ~= frame and other.Visible and otherLayer and otherLayer:IsA("ScreenGui") and otherLayer.Enabled then other.Visible = false end
		end
	end)
end

local function check(instance)
	if instance:IsA("UIStroke") then task.defer(square, instance) end
	if instance:IsA("Frame") and WINDOW_NAMES[instance.Name] then task.defer(watchWindow, instance) end
	if instance:IsA("GuiButton") then
		task.defer(setup, instance)
	elseif (instance:IsA("UIGradient") or instance:IsA("UIStroke")) and instance.Parent and instance.Parent:IsA("GuiButton") then
		task.defer(setup, instance.Parent) -- le dégradé ou le contour est arrivé après le bouton
	end
end
for _, d in playerGui:GetDescendants() do check(d) end
playerGui.DescendantAdded:Connect(check)
