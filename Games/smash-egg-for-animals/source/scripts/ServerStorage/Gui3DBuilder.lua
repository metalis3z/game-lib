-- Outil d'édition (pas utilisé en jeu) : refait les fenêtres « Offline Money » et « Settings » de StarterGui d'après les maquettes
-- Figma du créateur (fichier « gui my game »).
-- Le style : corps sombre, bandeau de titre en dégradé avec deux reflets en biais, textes blancs à gros contour noir, et sur
-- chaque bloc un contour noir de 3 px doublé en bas (6 px) pour l'effet 3D. Aucun coin arrondi.
-- Les noms attendus par OfflineHandler et SettingsHandler sont gardés. Les originaux sont dans ServerStorage.Gui_Before3D.
-- return function() -> rapport.
local ServerStorage = game:GetService("ServerStorage")
local StarterGui = game:GetService("StarterGui")

local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local ITALIC = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic)
local STUDS = "rbxassetid://7447638591"
local MONEY = "rbxassetid://70666404213952"
local rgb = Color3.fromRGB
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)

local function new(class, props, parent)
	local i = Instance.new(class)
	for k, v in props do i[k] = v end
	i.Parent = parent
	return i
end

-- contour noir de 3 px, et 3 px de plus en bas : le bloc a l'air posé en relief
local function outline(block, lip)
	new("UIStroke", {Name = "Outline", Thickness = 3, Color = BLACK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, block)
	new("Frame", {Name = "Lip", BackgroundColor3 = BLACK, BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, lip or 3), ZIndex = block.ZIndex}, block)
end
-- dégradé clair en haut, soutenu en bas
local function shade(block, top, bottom)
	block.BackgroundColor3 = WHITE
	new("UIGradient", {Name = "Shade", Rotation = 90, Color = ColorSequence.new(top, bottom)}, block)
end
-- studs discrets et deux reflets en biais, découpés au bord du bloc
local function gloss(block)
	local clip = new("Frame", {Name = "Gloss", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ClipsDescendants = true, ZIndex = block.ZIndex}, block)
	new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(36, 36), ImageTransparency = 0.86, ZIndex = block.ZIndex}, clip)
	for _, band in {{0.6, 0.07}, {0.72, 0.035}} do
		new("Frame", {Name = "Shine", BackgroundColor3 = WHITE, BackgroundTransparency = 0.78, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(band[1], 0.5),
			Size = UDim2.new(band[2], 0, 3, 0), Rotation = 24, ZIndex = block.ZIndex}, clip)
	end
end
local function text(parent, name, str, position, size, props)
	local l = new("TextLabel", {Name = name, BackgroundTransparency = 1, Position = position, Size = size, FontFace = FONT, Text = str, TextScaled = true, TextColor3 = WHITE, ZIndex = parent.ZIndex + 1}, parent)
	new("UIStroke", {Thickness = 3, Color = BLACK}, l)
	for k, v in props or {} do l[k] = v end
	return l
end
local function button(parent, name, position, size, top, bottom, label)
	local b = new("TextButton", {Name = name, Position = position, Size = size, BorderSizePixel = 0, Text = "", AutoButtonColor = false, ZIndex = parent.ZIndex + 1}, parent)
	shade(b, top, bottom)
	outline(b)
	gloss(b)
	if label then text(b, "Label", label, UDim2.fromScale(0.06, 0.14), UDim2.fromScale(0.88, 0.68)) end
	return b
end

local function offline()
	local main = StarterGui.OfflineGui.Dim.Main
	for _, c in main:GetChildren() do
		if c.Name ~= "Fit" then c:Destroy() end
	end
	main.Size = UDim2.fromOffset(540, 380)
	main.BackgroundColor3, main.BackgroundTransparency, main.BorderSizePixel = rgb(40, 46, 34), 0.08, 0
	main.ClipsDescendants = false
	outline(main)
	new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(40, 40), ImageTransparency = 0.93}, main)
	local header = new("Frame", {Name = "Header", BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 66), ZIndex = 2}, main)
	shade(header, rgb(190, 255, 60), rgb(40, 214, 50))
	outline(header)
	gloss(header)
	text(header, "Welcome", "Offline Money", UDim2.fromOffset(18, 11), UDim2.new(0.8, 0, 0, 42), {TextXAlignment = Enum.TextXAlignment.Left})
	text(main, "Earned", "You earned:", UDim2.new(0, 20, 0, 82), UDim2.new(1, -40, 0, 40), {FontFace = ITALIC})
	text(main, "Away", "You were offline for 0s.", UDim2.new(0, 20, 0, 124), UDim2.new(1, -40, 0, 18), {TextColor3 = rgb(214, 230, 200)}).UIStroke.Thickness = 2
	new("ImageLabel", {Name = "Icon", BackgroundTransparency = 1, Image = MONEY, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 138), Size = UDim2.fromOffset(170, 150)}, main)
	text(main, "Amount", "$0", UDim2.new(0, 20, 0, 178), UDim2.new(1, -40, 0, 70), {TextColor3 = rgb(120, 255, 70), ZIndex = 3}).UIStroke.Thickness = 5
	button(main, "Ok", UDim2.new(0, 18, 1, -84), UDim2.new(0.56, -27, 0, 64), rgb(200, 255, 70), rgb(60, 200, 40), "Claim")
	local double = button(main, "Double", UDim2.new(0.56, 9, 1, -84), UDim2.new(0.44, -27, 0, 64), rgb(240, 110, 255), rgb(170, 40, 220), "Double it!")
	text(double, "Tag", "2x", UDim2.new(1, -44, 0, -24), UDim2.fromOffset(62, 40), {FontFace = ITALIC, TextColor3 = rgb(244, 130, 255), Rotation = 14, ZIndex = 4})
	return "OfflineGui rebuilt (" .. #main:GetDescendants() .. " instances)"
end

local function settings()
	local main = StarterGui.SettingsGui.Main
	for _, c in main:GetChildren() do
		if c.Name ~= "Fit" then c:Destroy() end
	end
	main.Size = UDim2.fromOffset(480, 312)
	main.BackgroundColor3, main.BackgroundTransparency, main.BorderSizePixel = rgb(44, 40, 52), 0.06, 0
	main.ClipsDescendants = false
	outline(main)
	new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(40, 40), ImageTransparency = 0.93}, main)
	local header = new("Frame", {Name = "Header", BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 72), ZIndex = 2}, main)
	shade(header, WHITE, rgb(196, 200, 222))
	outline(header)
	gloss(header)
	text(header, "Title", "Settings", UDim2.fromOffset(18, 9), UDim2.new(0.7, 0, 0, 52), {TextXAlignment = Enum.TextXAlignment.Left})
	local close = button(header, "Close", UDim2.new(1, -12, 0.5, -2), UDim2.fromOffset(56, 50), rgb(255, 80, 70), rgb(190, 10, 20), "X")
	close.AnchorPoint = Vector2.new(1, 0.5)
	for i, row in {{"Music", "Music", "Background music!"}, {"Sfx", "Sound effects", "Volume of the sound effects!"}} do
		local frame = new("Frame", {Name = row[1], BackgroundColor3 = rgb(64, 62, 72), BorderSizePixel = 0, Position = UDim2.new(0, 14, 0, 90 + (i - 1) * 108), Size = UDim2.new(1, -28, 0, 90), ZIndex = 2}, main)
		outline(frame, 2)
		text(frame, "TextLabel", row[2], UDim2.fromOffset(14, 12), UDim2.new(0.46, -14, 0, 34), {TextXAlignment = Enum.TextXAlignment.Left})
		text(frame, "Hint", row[3], UDim2.fromOffset(14, 52), UDim2.new(0.46, -14, 0, 18), {TextXAlignment = Enum.TextXAlignment.Left}).UIStroke.Thickness = 2
		text(frame, "Value", "100%", UDim2.new(0.5, 0, 0, 8), UDim2.new(0.5, -18, 0, 22), {TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = rgb(255, 226, 90)}).UIStroke.Thickness = 2.5
		-- curseur : piste sombre, remplissage jaune, bouton carré
		local bar = new("TextButton", {Name = "Bar", BackgroundColor3 = rgb(30, 28, 36), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0, 46), Size = UDim2.new(0.5, -30, 0, 18), Text = "", AutoButtonColor = false, ZIndex = 3}, frame)
		bar:SetAttribute("NoFx", true) -- pas d'effet de bouton (UIEffects) sur une piste de curseur
		outline(bar, 2)
		local fill = new("Frame", {Name = "Fill", BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 3}, bar)
		shade(fill, rgb(255, 232, 80), rgb(250, 170, 0))
		local knob = new("Frame", {Name = "Knob", BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(24, 32), ZIndex = 4}, bar)
		shade(knob, rgb(255, 236, 100), rgb(250, 176, 10))
		outline(knob)
	end
	return "SettingsGui rebuilt (" .. #main:GetDescendants() .. " instances)"
end

return function()
	if not ServerStorage:FindFirstChild("Gui_Before3D") then
		local backup = Instance.new("Folder")
		backup.Name = "Gui_Before3D"
		StarterGui.OfflineGui:Clone().Parent = backup
		StarterGui.SettingsGui:Clone().Parent = backup
		backup.Parent = ServerStorage
	end
	return offline() .. "\n" .. settings()
end
