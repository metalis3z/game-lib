-- UIKit : le style des fenêtres du jeu (copié de CodeGui) pour que les nouvelles interfaces (Guide, Trade...)
-- aient exactement le même look : panneau blanc à studs, bandeau de titre coloré, croix rouge, boutons à studs.
local StarterGui = game:GetService("StarterGui")

local M = {}
local STUDS = "rbxassetid://7447638591"
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
M.FONT = FONT
M.INK = Color3.fromRGB(0, 0, 0)
M.DARK = Color3.fromRGB(27, 42, 53)

local rgb = Color3.fromRGB
-- dégradés des boutons / bandeaux (haut -> bas)
M.COLORS = {
	green = {rgb(130, 240, 90), rgb(40, 190, 60)},
	red = {rgb(255, 110, 110), rgb(196, 0, 26)},
	orange = {rgb(255, 214, 95), rgb(78, 176, 245)},
	blue = {rgb(110, 205, 255), rgb(40, 120, 230)},
	purple = {rgb(161, 210, 255), rgb(77, 157, 230)},
	grey = {rgb(210, 214, 225), rgb(140, 145, 165)},
	yellow = {rgb(255, 240, 120), rgb(255, 190, 40)},
}
-- bandeaux de titre (gauche -> centre -> droite), comme le bandeau vert de Codes
M.HEADERS = {
	green = {rgb(59, 235, 19), rgb(214, 249, 59)},
	blue = {rgb(30, 140, 255), rgb(120, 220, 255)},
	orange = {rgb(55, 182, 255), rgb(255, 210, 70)},
	purple = {rgb(78, 162, 240), rgb(161, 210, 255)},
}

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
M.new = new

function M.corner(p) return new("UICorner", {CornerRadius = UDim.new(0, 2)}, p) end
function M.outline(p, t) return new("UIStroke", {Name = "Outline", Thickness = t or 3, Color = M.INK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, p) end
function M.textStroke(p, t) return new("UIStroke", {Name = "TextStroke", Thickness = t or 3.5, Color = M.INK}, p) end

-- texture de studs par-dessus un cadre
function M.studs(p, tile)
	local s = new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile,
		TileSize = UDim2.fromOffset(tile or 28, tile or 28), ImageTransparency = 0.2, ZIndex = p.ZIndex}, p)
	M.corner(s)
	return s
end

-- fond blanc à studs (comme les fenêtres)
function M.surface(frame, tile)
	frame.BackgroundColor3 = Color3.new(1, 1, 1)
	frame.BackgroundTransparency = 0
	M.corner(frame)
	new("UIGradient", {Name = "Shade", Rotation = 90, Color = ColorSequence.new(rgb(255, 255, 255), rgb(225, 227, 237))}, frame)
	M.studs(frame, tile)
	return frame
end

-- texte blanc contour noir (Montserrat Heavy), comme partout dans le jeu
function M.text(parent, props)
	local strokeSize = props.Stroke
	props.Stroke = nil
	props.BackgroundTransparency = 1
	props.FontFace = props.FontFace or FONT
	props.TextScaled = true
	props.TextColor3 = props.TextColor3 or Color3.new(1, 1, 1)
	local l = new("TextLabel", props, parent)
	if strokeSize ~= false then M.textStroke(l, strokeSize or 3.5) end
	return l
end

-- bouton à studs en dégradé (comme "Redeem")
function M.button(parent, label, color, props)
	local c = M.COLORS[color] or M.COLORS.orange
	props = props or {}
	props.BackgroundColor3 = Color3.new(1, 1, 1)
	props.FontFace = FONT
	props.Text = label
	props.TextScaled = true
	props.TextColor3 = Color3.new(1, 1, 1)
	props.AutoButtonColor = true
	local b = new("TextButton", props, parent)
	M.corner(b)
	M.outline(b, 3)
	new("UIGradient", {Name = "Shade", Rotation = 90, Color = ColorSequence.new(c[1], c[2])}, b)
	M.studs(b, 26)
	M.textStroke(b, 4)
	new("UIPadding", {PaddingTop = UDim.new(0.2, 0), PaddingBottom = UDim.new(0.2, 0), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}, b)
	return b
end

-- change la couleur d'un bouton créé avec M.button
function M.recolor(b, color)
	local c = M.COLORS[color]
	local shade = b:FindFirstChild("Shade")
	if c and shade then shade.Color = ColorSequence.new(c[1], c[2]) end
end

-- croix rouge de fermeture (copie de celle de Codes si elle existe)
function M.close(parent)
	local template
	pcall(function() template = StarterGui.CodeGui.Main.Header.Close end)
	local b
	if template then
		b = template:Clone()
		for _, s in b:GetDescendants() do if s:IsA("LuaSourceContainer") then s:Destroy() end end
	else
		b = M.button(parent, "X", "red", {Size = UDim2.fromOffset(44, 44)})
	end
	b.Name = "Close"
	b.AnchorPoint = Vector2.new(1, 0.5)
	b.Position = UDim2.new(1, -9, 0.5, 0)
	b.Size = UDim2.fromOffset(44, 44)
	b.Parent = parent
	return b
end

-- zone de texte à studs (comme le champ de Codes)
function M.input(parent, props)
	props.BackgroundColor3 = Color3.new(1, 1, 1)
	props.FontFace = FONT
	props.TextScaled = true
	props.TextColor3 = M.DARK
	props.ClearTextOnFocus = false
	local box = new("TextBox", props, parent)
	M.corner(box)
	M.outline(box, 3)
	M.studs(box, 26)
	new("UIPadding", {PaddingTop = UDim.new(0.2, 0), PaddingBottom = UDim.new(0.2, 0), PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14)}, box)
	return box
end

-- fenêtre complète : panneau à studs + bandeau de titre coloré + croix. Le contenu commence à y = 78.
function M.window(parent, name, size, title, headerColor)
	local w = new("Frame", {Name = name, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.47), Size = size, Visible = false}, parent)
	M.surface(w, 28)
	new("UIStroke", {Thickness = 4, Color = M.INK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, w)
	local header = new("Frame", {Name = "Header", Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 58), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 2}, w)
	M.corner(header)
	M.outline(header, 3)
	local hc = M.HEADERS[headerColor] or M.HEADERS.green
	new("UIGradient", {Name = "Shade", Rotation = 0, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, hc[1]), ColorSequenceKeypoint.new(0.5, hc[2]), ColorSequenceKeypoint.new(1, hc[1])})}, header)
	M.studs(header, 28)
	local titleLabel = M.text(header, {Name = "Title", Position = UDim2.fromOffset(16, 9), Size = UDim2.new(1, -80, 1, -18), Text = title, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3, Stroke = 4.5})
	local close = M.close(header)
	close.ZIndex = 3
	for _, d in close:GetDescendants() do if d:IsA("GuiObject") then d.ZIndex = 4 end end
	-- s'adapte aux petits écrans
	local scale = new("UIScale", {}, w)
	local function fit()
		local vp = workspace.CurrentCamera.ViewportSize
		scale.Scale = math.clamp(math.min((vp.X - 24) / size.X.Offset, (vp.Y - 24) / size.Y.Offset), 0.4, 1)
	end
	fit()
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fit)
	return w, header, titleLabel, close, scale
end

-- encadré intérieur (cartes, panneaux) : blanc à studs, contour noir
function M.box(parent, props, strokeColor)
	local f = new("Frame", props, parent)
	M.surface(f, 24)
	new("UIStroke", {Name = "Outline", Thickness = 3, Color = strokeColor or M.INK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, f)
	return f
end

return M
