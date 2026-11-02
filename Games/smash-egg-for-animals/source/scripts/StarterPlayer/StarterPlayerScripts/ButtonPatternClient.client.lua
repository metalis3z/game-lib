-- ButtonPatternClient : le motif "studs" du jeu (rbxassetid://82096270344702) posé, très discret, sur les BOUTONS des menus.
--   * un bouton qui a déjà un motif (ImageLabel "Studs" / "Pattern" en mosaïque) : on y met la nouvelle image
--   * sinon on ajoute une mosaïque par-dessus le fond du bouton (ou par-dessus sa face, pour les boutons transparents
--     dont la couleur est dans un Frame "Face")
--   * la mosaïque se répète : sur un bouton long, le motif revient plusieurs fois au lieu d'être étiré
--   * sur les cartes avec une photo 3D d'animal (Index, fusion, barre du bas), le motif passe derrière l'animal
--   * pas touchés : l'inventaire et les réglages (fenêtres + boutons d'ouverture), les curseurs,
--     les boutons invisibles ou minuscules, les menus 3D
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local IMAGE = "rbxassetid://82096270344702"
local TRANSPARENCY = 0.65 -- discret mais bien visible
-- pas de motif : l'inventaire et les réglages (leurs fenêtres et leurs boutons d'ouverture)
local SKIP_GUIS = {PetInventoryGui = true, SettingsGui = true, InventoryButtonGui = true, TopBarGui = true, HotbarDragGui = true, Freecam = true}
local OLD_PATTERNS = {Studs = true, Pattern = true}

-- taille d'une tuile (4 x 4 studs) : à peu près la hauteur du bouton, pour que les studs soient bien visibles sans être
-- énormes ; un petit bouton garde des studs lisibles, un grand bouton (ou un bouton carré) ne reçoit pas de studs géants
local function tileFor(gui)
	local size = gui.AbsoluteSize
	local short = math.min(size.X, size.Y)
	local side = math.clamp(short * 1.15, 40, 112)
	return UDim2.fromOffset(side, side)
end

-- la couleur affichée d'une surface : son fond, multiplié par la couleur du haut de son dégradé
local function shown(surface)
	local c = surface.BackgroundColor3
	local g = surface:FindFirstChildOfClass("UIGradient")
	if g then
		local top = g.Color.Keypoints[1].Value
		c = Color3.new(c.R * top.R, c.G * top.G, c.B * top.B)
	end
	return c
end
-- sur un bouton clair, le motif (lui-même clair) ne se voyait pas : on l'assombrit un peu
local function tint(label, surface)
	local c = shown(surface)
	local lum = 0.299 * c.R + 0.587 * c.G + 0.114 * c.B
	local want = lum > 0.72 and Color3.fromRGB(120, 132, 165) or Color3.new(1, 1, 1)
	if label.ImageColor3 ~= want then label.ImageColor3 = want end
	label.ImageTransparency = lum > 0.72 and 0.55 or TRANSPARENCY
end
local function follow(target, label)
	label.TileSize = tileFor(target)
	target:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if label.Parent then label.TileSize = tileFor(target) end
	end)
end

local function skipped(button)
	local screen = button:FindFirstAncestorWhichIsA("LayerCollector")
	if not screen or not screen:IsA("ScreenGui") or SKIP_GUIS[screen.Name] then return true end
	if button.Name == "Bar" or button:FindFirstChild("Knob") then return true end -- curseurs
	return false
end

local function apply(button)
	if button:GetAttribute("StudPattern") or skipped(button) then return end
	-- un motif déjà là (sur le bouton ou sur sa face) : on y met la nouvelle image au lieu d'en empiler un deuxième
	local face = button:FindFirstChild("Face")
	for _, holder in {button, face} do
		if holder and holder:IsA("GuiObject") then
			for _, child in holder:GetChildren() do
				if child:IsA("ImageLabel") and OLD_PATTERNS[child.Name] then
					button:SetAttribute("StudPattern", true)
					child.Image = IMAGE
					child.ScaleType = Enum.ScaleType.Tile
					child.ImageTransparency = TRANSPARENCY
					tint(child, holder)
					follow(holder, child)
					-- certains menus cachent leur motif (onglets non choisis du panneau admin) : il reste toujours visible
					child.Visible = true
					child:GetPropertyChangedSignal("Visible"):Connect(function() if not child.Visible then child.Visible = true end end)
					child:GetPropertyChangedSignal("ImageColor3"):Connect(function() task.defer(tint, child, holder) end)
					return
				end
			end
		end
	end
	-- la surface colorée : le bouton lui-même, ou sa face s'il est transparent
	local surface = button
	if button.BackgroundTransparency > 0.5 then
		surface = button:FindFirstChild("Face")
		if not surface or not surface:IsA("GuiObject") or surface.BackgroundTransparency > 0.5 then return end
		if surface:FindFirstChild("StudPattern") then return end
	end
	local size = button.AbsoluteSize
	if size.X > 0 and (size.Y < 24 or size.X < 24) then return end
	button:SetAttribute("StudPattern", true)
	local label = Instance.new("ImageLabel")
	label.Name = "StudPattern"
	label.BackgroundTransparency = 1
	label.Image = IMAGE
	label.ImageTransparency = TRANSPARENCY
	label.ScaleType = Enum.ScaleType.Tile
	label.Size = UDim2.fromScale(1, 1)
	label.ZIndex = surface.ZIndex
	label.Active = false
	label.Interactable = false
	local corner = surface:FindFirstChildOfClass("UICorner")
	if corner then corner:Clone().Parent = label end
	tint(label, surface)
	follow(surface, label)
	label.Parent = surface
	-- carte avec une photo 3D (Index, fusion, barre du bas) : le motif reste DERRIÈRE l'animal
	for _, child in surface:GetChildren() do
		if child:IsA("ViewportFrame") and child.ZIndex <= label.ZIndex then child.ZIndex = label.ZIndex + 1 end
	end
end

local function scan(root)
	for _, d in root:GetDescendants() do
		if d:IsA("GuiButton") then task.defer(apply, d) end
	end
end
playerGui.DescendantAdded:Connect(function(d)
	if d:IsA("GuiButton") then
		task.delay(0.1, function() if d.Parent then apply(d) end end) -- (laisser le temps aux scripts de finir le bouton)
	end
end)
scan(playerGui)
-- certains menus construisent leurs boutons tard (ou les recréent) : un passage de rattrapage
task.delay(5, function() scan(playerGui) end)
task.delay(15, function() scan(playerGui) end)
