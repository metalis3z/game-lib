-- Outil d'édition (pas utilisé en jeu) : passe « relief » sur l'inventaire et l'index, d'après le kit Figma « 01 UI Kit - 3D blocks ».
--   * inventaire : fenêtre opaque à bandeau orange, cartes à la couleur de la rareté avec rayons, photos des animaux sans voile gris
--   * index : rayons qui tournent sur les cartes et dans le panneau de droite, panneau à la couleur de la rareté
--   * boutons aux dégradés de deux teintes (jaune vers bleu) ramenés à une seule teinte
-- Les noms attendus par les scripts sont gardés. Les originaux sont dans ServerStorage.Gui_Before3Dv2.
-- return function() -> rapport.
local ServerStorage = game:GetService("ServerStorage")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local rgb = Color3.fromRGB
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local RAYS = "rbxassetid://81911207340002"

local function new(class, props, parent)
	local i = Instance.new(class)
	for k, v in props do i[k] = v end
	i.Parent = parent
	return i
end
local function patch(src, a, b)
	local i, j = src:find(a, 1, true)
	assert(i, "anchor not found: " .. a:sub(1, 70))
	assert(not src:find(a, j + 1, true), "anchor not unique: " .. a:sub(1, 70))
	return src:sub(1, i - 1) .. b .. src:sub(j + 1)
end
local function clear(parent, names) -- enlève les anciens éléments de décor portant ces noms
	for _, c in parent:GetChildren() do
		if table.find(names, c.Name) then c:Destroy() end
	end
end
-- un seul contour noir de 3 px sur un bloc (les doublons sont retirés), et 3 px de plus en bas
local function outline(block, lip)
	local kept
	for _, c in block:GetChildren() do
		if c:IsA("UIStroke") then
			if kept then c:Destroy() else kept = c end
		end
	end
	kept = kept or new("UIStroke", {}, block)
	kept.Name, kept.Thickness, kept.Color, kept.ApplyStrokeMode = "Outline", 3, BLACK, Enum.ApplyStrokeMode.Border
	clear(block, {"Lip"})
	if lip ~= 0 then
		new("Frame", {Name = "Lip", BackgroundColor3 = BLACK, BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, lip or 3), ZIndex = block.ZIndex}, block)
	end
end
-- filet clair à l'intérieur du bloc : c'est lui qui fait ressortir la couleur
local function inner(block, transparency, z)
	clear(block, {"Inner"})
	local f = new("Frame", {Name = "Inner", BackgroundTransparency = 1, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6), ZIndex = z or block.ZIndex}, block)
	new("UIStroke", {Thickness = 2, Color = WHITE, Transparency = transparency or 0.55, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, f)
	return f
end
local function shade(block, top, bottom)
	local g = block:FindFirstChild("Shade") or new("UIGradient", {Name = "Shade"}, block)
	g.Rotation = 90
	g.Color = ColorSequence.new(top, bottom)
	block.BackgroundColor3 = WHITE
	return g
end

local function portrait()
	local module = ReplicatedStorage.EggSystem.PetPortrait
	local s = module.Source
	if s:find("Portrait.RarityColors", 1, true) then return "PetPortrait: colours already there" end
	s = patch(s, "\nreturn Portrait", [[

-- couleurs des cartes par rareté : {clair (haut), soutenu (bas)}
local rgb = Color3.fromRGB
Portrait.RarityColors = {
	Common = {rgb(190, 250, 40), rgb(120, 215, 0)},
	Uncommon = {rgb(40, 240, 150), rgb(0, 185, 110)},
	Rare = {rgb(40, 185, 255), rgb(0, 125, 235)},
	Epic = {rgb(190, 70, 255), rgb(130, 20, 215)},
	Legendary = {rgb(255, 225, 40), rgb(245, 170, 0)},
	Mythic = {rgb(255, 100, 140), rgb(225, 30, 80)},
	Secret = {rgb(110, 110, 132), rgb(40, 40, 58)},
	Ancient = {rgb(170, 230, 90), rgb(90, 150, 40)},
	OG = {rgb(255, 215, 80), rgb(235, 130, 20)},
	Divine = {rgb(255, 250, 210), rgb(240, 200, 90)},
	Prismatic = {rgb(255, 130, 220), rgb(110, 90, 255)},
	Exclusive = {rgb(255, 250, 220), rgb(255, 196, 60)},
}

return Portrait]])
	assert(loadstring(s))
	module.Source = s
	return "PetPortrait: RarityColors added"
end

local function inventory()
	local gui = StarterGui.PetInventoryGui
	local main, handler = gui.Main, gui.InventoryHandler
	-- fenêtre : corps sombre opaque, contour noir 3 doublé en bas
	main.BackgroundTransparency = 0.04
	shade(main, rgb(58, 62, 84), rgb(34, 36, 52))
	outline(main, 4)
	-- bandeau orange sur toute la largeur
	local header = main.Header
	header.Position, header.Size = UDim2.fromOffset(0, 0), UDim2.new(1, 0, 0, 72)
	header.BackgroundTransparency = 0
	shade(header, rgb(255, 210, 76), rgb(255, 120, 22))
	outline(header, 3)
	inner(header, 0.45, 1)
	local shine = header:FindFirstChild("Shine")
	if shine then shine.Visible = true end
	header.Title.Position, header.Title.Size = UDim2.fromOffset(20, 6), UDim2.fromOffset(330, 38)
	header.Title.TextXAlignment = Enum.TextXAlignment.Left
	header.Counter.Position, header.Counter.Size = UDim2.fromOffset(22, 46), UDim2.fromOffset(430, 18)
	header.Counter.TextXAlignment = Enum.TextXAlignment.Left
	header.Counter.TextColor3 = rgb(255, 246, 196)
	local close = header.Close
	close.AnchorPoint, close.Position, close.Size = Vector2.new(1, 0.5), UDim2.new(1, -12, 0.5, -1), UDim2.fromOffset(54, 48)
	local search = header.Search
	search.AnchorPoint, search.Position, search.Size = Vector2.new(1, 0.5), UDim2.new(1, -78, 0.5, -1), UDim2.fromOffset(230, 40)
	search.BackgroundColor3, search.BackgroundTransparency = rgb(60, 32, 10), 0.15
	outline(search, 0)
	-- le puits des cartes
	local grid = main.Grid
	grid.Position, grid.Size = UDim2.fromOffset(14, 88), UDim2.new(1, -28, 1, -160)
	grid.BackgroundColor3, grid.BackgroundTransparency = rgb(22, 24, 34), 0.25
	for _, c in grid:GetChildren() do if c:IsA("UIGradient") then c:Destroy() end end
	outline(grid, 0)
	local layout = grid:FindFirstChildOfClass("UIGridLayout")
	layout.CellSize, layout.CellPadding = UDim2.fromOffset(128, 158), UDim2.fromOffset(10, 12)
	local pad = grid:FindFirstChildOfClass("UIPadding")
	if pad then pad.PaddingTop, pad.PaddingBottom, pad.PaddingLeft, pad.PaddingRight = UDim.new(0, 10), UDim.new(0, 12), UDim.new(0, 10), UDim.new(0, 10) end
	-- pied : aide à gauche, Delete et Place Best à droite
	local hint = main.Hint
	hint.Position, hint.Size = UDim2.new(0, 18, 1, -58), UDim2.new(1, -430, 0, 40)
	hint.TextWrapped, hint.TextXAlignment = true, Enum.TextXAlignment.Left
	hint.TextColor3 = rgb(214, 220, 240)
	hint.TextScaled = true
	if not hint:FindFirstChildOfClass("UITextSizeConstraint") then new("UITextSizeConstraint", {MaxTextSize = 15, MinTextSize = 8}, hint) end
	local best = main.PlaceBest
	best.AnchorPoint, best.Position, best.Size = Vector2.new(1, 1), UDim2.new(1, -14, 1, -16), UDim2.fromOffset(200, 46)
	shade(best, rgb(196, 255, 70), rgb(52, 200, 40))
	local delete = main.Delete
	delete.AnchorPoint, delete.Position, delete.Size = Vector2.new(1, 1), UDim2.new(1, -228, 1, -16), UDim2.fromOffset(160, 46)

	-- carte : couleur de la rareté, rayons derrière l'animal, photo sans voile, bandeau sombre pour le poids
	local slot = handler.SlotTemplate
	slot.BackgroundTransparency = 0
	slot.BackgroundColor3 = WHITE
	slot.ClipsDescendants = false
	shade(slot, rgb(150, 154, 170), rgb(84, 88, 104))
	outline(slot, 3)
	clear(slot, {"RaysClip", "Strip", "Inner", "Studs"})
	local clip = new("Frame", {Name = "RaysClip", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ClipsDescendants = true, ZIndex = 1}, slot)
	new("ImageLabel", {Name = "Rays", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(1.7, 1.7),
		SizeConstraint = Enum.SizeConstraint.RelativeXX, Image = RAYS, ImageColor3 = WHITE, ImageTransparency = 0.45, ZIndex = 1}, clip)
	local view = slot.View
	for _, c in view:GetChildren() do if c:IsA("UIGradient") or c:IsA("UIStroke") then c:Destroy() end end -- le dégradé posé sur la photo grisait l'animal
	view.BackgroundTransparency = 1
	view.ImageColor3, view.ImageTransparency = WHITE, 0
	view.Position, view.Size, view.ZIndex = UDim2.fromOffset(6, 36), UDim2.new(1, -12, 1, -62), 2
	slot.PetName.Position, slot.PetName.Size, slot.PetName.ZIndex = UDim2.fromOffset(4, 4), UDim2.new(1, -8, 0, 18), 4
	slot.PetName.TextColor3 = WHITE -- (une mutation lui donne sa couleur ; le vert d'avant ne se lisait pas sur les cartes vertes)
	slot.Rarity.Position, slot.Rarity.Size, slot.Rarity.ZIndex = UDim2.fromOffset(6, 22), UDim2.new(1, -12, 0, 13), 4
	for _, c in slot.Rarity:GetChildren() do if c:IsA("UIGradient") then c:Destroy() end end
	new("Frame", {Name = "Strip", BackgroundColor3 = BLACK, BackgroundTransparency = 0.45, BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, -24), Size = UDim2.new(1, 0, 0, 24), ZIndex = 3}, slot)
	slot.Kg.Position, slot.Kg.Size, slot.Kg.ZIndex = UDim2.new(0, 4, 1, -20), UDim2.new(1, -8, 0, 15), 4
	slot.Placed.ZIndex = 5
	inner(slot, 0.5, 3)

	-- le script : couleur de la carte selon la rareté (le nom de la rareté n'a plus son dégradé animé, illisible sur la couleur)
	local s = handler.Source
	if not s:find("Portrait.RarityColors", 1, true) then
		s = patch(s, "local Portrait = require(system:WaitForChild(\"PetPortrait\")) -- même cadrage que dans les autres fenêtres\nlocal function fillViewport",
			"local Portrait = require(system:WaitForChild(\"PetPortrait\")) -- même cadrage que dans les autres fenêtres\nlocal function fillViewport")
		s = patch(s, "\tlocal gradientColor = Config.Gradients[item.Rarity]\n\tif gradientColor then\n\t\tslot.Rarity.UIGradient.Color = gradientColor\n\t\tslot.Rarity.UIGradient.Enabled = true\n\t\tCollectionService:AddTag(slot.Rarity.UIGradient, \"AnimatedGradient\")\n\tend\n",
			"\t-- la carte prend la couleur de la rareté (clair en haut, soutenu en bas), comme dans l'index\n\tlocal colors = Portrait.RarityColors[item.Rarity] or Portrait.RarityColors.Common\n\tslot.Shade.Color = ColorSequence.new(colors[1], colors[2])\n\tslot.Rarity.TextColor3 = colors[1]:Lerp(Color3.new(1, 1, 1), 0.65)\n")
		assert(loadstring(s))
		handler.Source = s
	end
	-- CardStuds : les studs des cartes, et maintenant les rayons qui tournent
	local studs = gui.CardStuds
	local c = studs.Source
	if not c:find("Rays", 1, true) then
		c = c .. [[

-- les rayons derrière chaque animal tournent lentement (seulement quand la fenêtre est ouverte)
local main = script.Parent:WaitForChild("Main")
game:GetService("RunService").RenderStepped:Connect(function()
	if not main.Visible then return end
	local angle = (os.clock() * 16) % 360
	for _, card in grid:GetChildren() do
		local clip = card:FindFirstChild("RaysClip")
		local rays = clip and clip:FindFirstChild("Rays")
		if rays then rays.Rotation = angle end
	end
end)
]]
		assert(loadstring(c))
		studs.Source = c
	end
	return "Inventory restyled"
end

local function index()
	local gui = StarterGui.IndexGui
	local main, handler = gui.Main, gui.IndexHandler
	outline(main, 4)
	local detail = main.Body.Side.Detail
	detail.ClipsDescendants = true
	local s = handler.Source
	if not s:find("spinning", 1, true) then
		s = patch(s, "local cards, sections, total = {}, {}, 0\n",
			"local cards, sections, total = {}, {}, 0\nlocal spinning = {} -- les éclats de rayons, qui tournent quand la fenêtre est ouverte\n"
			.. "-- panneau de droite : rayons derrière l'animal choisi, et le panneau prend la couleur de sa rareté\n"
			.. "local detailRays = Portrait.rays(detail, WHITE, 0.4, 2)\ndetailRays.Position, detailRays.Size, detailRays.Visible = UDim2.fromScale(0.5, 0.46), UDim2.fromScale(1.5, 1.5), false\ntable.insert(spinning, detailRays)\n"
			.. "local detailShade = detail:FindFirstChildOfClass(\"UIGradient\")\nlocal DETAIL_IDLE = detailShade.Color\n")
		s = patch(s, "\tdetail.Paw.Visible = entry == nil\n\tdetail.View.Visible = entry ~= nil\n",
			"\tdetail.Paw.Visible = entry == nil\n\tdetail.View.Visible = entry ~= nil\n\tdetailRays.Visible = entry ~= nil\n"
			.. "\tlocal tint = entry and (RARITY_COLORS[entry.Info.Rarity] or RARITY_COLORS.Common)\n\tdetailShade.Color = tint and ColorSequence.new(tint[1], tint[2]:Lerp(BLACK, 0.3)) or DETAIL_IDLE\n")
		s = patch(s, "\t\tPortrait.rays(card, WHITE, 0.5, 3) -- éclat de lumière derrière l'animal\n",
			"\t\ttable.insert(spinning, Portrait.rays(card, WHITE, 0.45, 3)) -- éclat de lumière derrière l'animal\n")
		s = patch(s, "player:GetAttributeChangedSignal(\"PetIndex\"):Connect(refresh)\n",
			"game:GetService(\"RunService\").RenderStepped:Connect(function()\n\tif not main.Visible then return end\n\tlocal angle = (os.clock() * 16) % 360\n\tfor _, rays in spinning do rays.Rotation = angle end\nend)\n\n"
			.. "player:GetAttributeChangedSignal(\"PetIndex\"):Connect(refresh)\n")
		assert(loadstring(s))
		handler.Source = s
	end
	return "Index: spinning rays + coloured detail panel"
end

-- boutons dont le dégradé passe d'une teinte à une autre (jaune -> bleu) : ramenés à une seule teinte, claire en haut
local function gradients()
	local fixed = {}
	for _, g in StarterGui:GetDescendants() do
		if g:IsA("UIGradient") and g.Name == "Shade" and g.Parent and g.Parent:IsA("GuiObject") then
			local keys = g.Color.Keypoints
			local a, b = keys[1].Value, keys[#keys].Value
			local ha, sa = a:ToHSV()
			local hb, sb = b:ToHSV()
			local gap = math.abs(ha - hb)
			gap = math.min(gap, 1 - gap)
			if sa > 0.3 and sb > 0.3 and gap > 0.18 then
				g.Color = ColorSequence.new(rgb(255, 238, 112), rgb(250, 168, 16)) -- jaune vers orange
				table.insert(fixed, g.Parent:GetFullName())
			end
		end
	end
	-- le bord du bouton Shop suit sa nouvelle couleur
	local shop = StarterGui:FindFirstChild("left bottom") and StarterGui["left bottom"].Holder:FindFirstChild("ShopButton")
	if shop and shop:FindFirstChild("Lip") then shop.Lip.BackgroundColor3 = rgb(176, 104, 8) end
	return #fixed .. " two-hue gradients fixed: " .. table.concat(fixed, ", ")
end

return function()
	if not ServerStorage:FindFirstChild("Gui_Before3Dv2") then
		local backup = Instance.new("Folder")
		backup.Name = "Gui_Before3Dv2"
		for _, name in {"PetInventoryGui", "IndexGui", "left bottom", "HotbarGui", "CodeGui"} do
			local copy = StarterGui[name]:Clone()
			for _, d in copy:GetDescendants() do if d:IsA("BaseScript") then d.Disabled = true end end
			copy.Parent = backup
		end
		ReplicatedStorage.EggSystem.PetPortrait:Clone().Parent = backup
		backup.Parent = ServerStorage
	end
	return table.concat({portrait(), inventory(), index(), gradients()}, "\n")
end
