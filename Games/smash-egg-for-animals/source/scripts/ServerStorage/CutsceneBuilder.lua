-- Outil d'édition (pas utilisé en jeu) : construit le décor de la cutscene "Dev Studio" en studs.
-- Repère local : origine = centre du sol de la pièce ; +X = vers la porte et le balcon (et la map), bureaux au fond (-X).
-- Résultat : un Model "Set" avec des pièces repères invisibles (SeatK, SeatR, KeyboardK, TowerK, Door, OutK...) lues par le client.
local M = {}
local rad = math.rad
local function rgb(r, g, b) return Color3.fromRGB(r, g, b) end

local model, origin
local function part(name, size, cf, color, o)
	o = o or {}
	local p = Instance.new(o.Wedge and "WedgePart" or "Part")
	p.Name = name
	p.Size = size
	p.CFrame = origin * (typeof(cf) == "Vector3" and CFrame.new(cf) or cf)
	p.Color = color
	p.Material = o.Neon and Enum.Material.Neon or (o.Material or Enum.Material.Plastic)
	p.Transparency = o.Transparency or 0
	p.TopSurface = o.Studs == false and Enum.SurfaceType.Smooth or Enum.SurfaceType.Studs
	p.BottomSurface = Enum.SurfaceType.Smooth
	p.Anchored = true
	p.CanCollide, p.CanQuery, p.CanTouch = false, false, false
	p.CastShadow = not o.Neon and o.Shadow ~= false
	if o.Tag then game:GetService("CollectionService"):AddTag(p, o.Tag) end
	p.Parent = o.Parent or model
	return p
end
local function marker(name, cf)
	local p = part(name, Vector3.new(0.4, 0.4, 0.4), cf, rgb(255, 0, 255), {Transparency = 1, Studs = false, Shadow = false})
	return p
end
-- face avant (-Z de la pièce) tournée vers la direction dir (dans le repère local)
local function facing(pos, dir) return CFrame.lookAt(pos, pos + dir) end

---------------------------------------------------------------- écrans façon Roblox Studio
local FONT = Font.new("rbxasset://fonts/families/SourceSansPro.json")
local FONT_B = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold)
local CODE = Font.new("rbxasset://fonts/families/RobotoMono.json")
local function ui(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function txt(parent, text, pos, size, color, font, align, rich)
	return ui("TextLabel", {BackgroundTransparency = 1, Position = pos, Size = size, Text = text, TextColor3 = color or rgb(220, 220, 220), FontFace = font or FONT, TextScaled = true,
		TextXAlignment = align or Enum.TextXAlignment.Left, RichText = rich == true}, parent)
end
local function screenGui(p)
	return ui("SurfaceGui", {Face = Enum.NormalId.Front, PixelsPerStud = 60, LightInfluence = 0, Brightness = 1.6, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZOffset = 0}, p)
end

local CODE_K = {
	'<font color="#F86D7C">local</font> Dragon = <font color="#84D6F7">require</font>(script.DragonConfig)',
	'<font color="#F86D7C">local</font> Eggs = <font color="#84D6F7">workspace</font>.ZoneEggs',
	'',
	'<font color="#F86D7C">function</font> Dragon.<font color="#FDFBAC">Fly</font>(player, speed)',
	'    <font color="#F86D7C">local</font> dragon = Dragon.Get(player)',
	'    dragon.Speed = speed * <font color="#FFC600">2</font>',
	'    <font color="#F86D7C">if</font> dragon.Fire <font color="#F86D7C">then</font>',
	'        Eggs:<font color="#FDFBAC">Burn</font>(dragon, <font color="#ADF195">"Legendary"</font>)',
	'    <font color="#F86D7C">end</font>',
	'<font color="#F86D7C">end</font>',
	'',
	'<font color="#666666">-- TODO : new update tonight !!!</font>',
}
local CODE_R = {
	'<font color="#F86D7C">local</font> Halloween = {}',
	'Halloween.Pets = {<font color="#ADF195">"Pumpkin"</font>, <font color="#ADF195">"Ghost"</font>, <font color="#ADF195">"Bat"</font>}',
	'',
	'<font color="#F86D7C">for</font> _, pet <font color="#F86D7C">in</font> Halloween.Pets <font color="#F86D7C">do</font>',
	'    <font color="#84D6F7">print</font>(<font color="#ADF195">"Spawning "</font> .. pet)',
	'    Zone:<font color="#FDFBAC">Spawn</font>(pet, <font color="#FFC600">100</font>)',
	'<font color="#F86D7C">end</font>',
	'',
	'<font color="#F86D7C">return</font> Halloween',
}

-- grand écran : Roblox Studio (barre d'onglets, Explorer, éditeur de script ou vue 3D, Properties)
local function studioScreen(p, mode)
	local sg = screenGui(p)
	sg.Name = "Screen"
	local root = ui("Frame", {Name = "On", Size = UDim2.fromScale(1, 1), BackgroundColor3 = rgb(46, 46, 46), BorderSizePixel = 0}, sg)
	-- barre de titre + onglets
	local top = ui("Frame", {Size = UDim2.fromScale(1, 0.13), BackgroundColor3 = rgb(37, 37, 37), BorderSizePixel = 0}, root)
	txt(top, "FILE   HOME   MODEL   AVATAR   TEST   VIEW   PLUGINS", UDim2.fromScale(0.02, 0.05), UDim2.fromScale(0.75, 0.4), rgb(200, 200, 200), FONT_B)
	for i, c in {rgb(0, 162, 255), rgb(70, 200, 90), rgb(255, 170, 40), rgb(200, 90, 255), rgb(255, 80, 80), rgb(120, 120, 120)} do
		ui("Frame", {Position = UDim2.fromScale(0.02 + (i - 1) * 0.07, 0.52), Size = UDim2.fromScale(0.04, 0.4), BackgroundColor3 = c, BorderSizePixel = 0}, top)
	end
	txt(top, "Voler comme un dragon - Roblox Studio", UDim2.fromScale(0.6, 0.55), UDim2.fromScale(0.38, 0.35), rgb(160, 160, 160), FONT, Enum.TextXAlignment.Right)
	-- Explorer
	local ex = ui("Frame", {Position = UDim2.fromScale(0, 0.13), Size = UDim2.fromScale(0.2, 0.87), BackgroundColor3 = rgb(42, 42, 42), BorderSizePixel = 0}, root)
	txt(ex, "Explorer", UDim2.fromScale(0.05, 0.01), UDim2.fromScale(0.9, 0.07), rgb(240, 240, 240), FONT_B)
	for i, name in {"Workspace", "   Dragons", "   ZoneEggs", "   Halloween Zone", "Players", "Lighting", "ReplicatedStorage", "ServerScriptService", "   DragonServer", "   PetServer", "   EggZoneServer", "StarterGui"} do
		local row = txt(ex, name, UDim2.fromScale(0.06, 0.09 + i * 0.066), UDim2.fromScale(0.9, 0.055), rgb(205, 205, 205))
		if i == 9 or (mode == "Viewport" and i == 4) then
			row.BackgroundTransparency = 0
			row.BackgroundColor3 = rgb(0, 110, 200)
		end
	end
	-- Properties
	local pr = ui("Frame", {Position = UDim2.fromScale(0.8, 0.13), Size = UDim2.fromScale(0.2, 0.87), BackgroundColor3 = rgb(42, 42, 42), BorderSizePixel = 0}, root)
	txt(pr, "Properties", UDim2.fromScale(0.05, 0.01), UDim2.fromScale(0.9, 0.07), rgb(240, 240, 240), FONT_B)
	for i, name in {"Anchored     [x]", "BrickColor   Orange", "CanCollide   [ ]", "Material     Plastic", "Size         4, 1, 2", "Transparency 0"} do
		txt(pr, name, UDim2.fromScale(0.05, 0.1 + i * 0.07), UDim2.fromScale(0.92, 0.055), rgb(190, 190, 190), CODE)
	end
	-- centre
	local mid = ui("Frame", {Name = "Mid", Position = UDim2.fromScale(0.2, 0.13), Size = UDim2.fromScale(0.6, 0.87), BackgroundColor3 = rgb(30, 30, 30), BorderSizePixel = 0, ClipsDescendants = true}, root)
	if mode == "Viewport" then
		ui("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(120, 190, 255), rgb(210, 235, 255))}, ui("Frame", {Size = UDim2.fromScale(1, 0.62), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0}, mid))
		ui("Frame", {Position = UDim2.fromScale(0, 0.62), Size = UDim2.fromScale(1, 0.38), BackgroundColor3 = rgb(80, 170, 70), BorderSizePixel = 0}, mid)
		-- petites citrouilles et un dragon en blocs dans la vue 3D
		for i, x in {0.15, 0.3, 0.7, 0.85} do
			local pk = ui("Frame", {Position = UDim2.fromScale(x, 0.66 + (i % 2) * 0.08), Size = UDim2.fromScale(0.09, 0.12), BackgroundColor3 = rgb(255, 130, 20), BorderSizePixel = 0}, mid)
			ui("UICorner", {CornerRadius = UDim.new(0.4, 0)}, pk)
			ui("Frame", {Position = UDim2.fromScale(0.42, -0.2), Size = UDim2.fromScale(0.16, 0.25), BackgroundColor3 = rgb(90, 60, 30), BorderSizePixel = 0}, pk)
		end
		local body = ui("Frame", {Position = UDim2.fromScale(0.38, 0.4), Size = UDim2.fromScale(0.26, 0.2), BackgroundColor3 = rgb(220, 40, 40), BorderSizePixel = 0}, mid)
		ui("Frame", {Position = UDim2.fromScale(0.85, -0.55), Size = UDim2.fromScale(0.35, 0.6), BackgroundColor3 = rgb(220, 40, 40), BorderSizePixel = 0}, body)
		ui("Frame", {Position = UDim2.fromScale(0.2, -0.9), Size = UDim2.fromScale(0.5, 0.9), BackgroundColor3 = rgb(255, 200, 50), BorderSizePixel = 0, Rotation = -20}, body)
		local sel = ui("Frame", {Position = UDim2.fromScale(0.36, 0.2), Size = UDim2.fromScale(0.36, 0.44), BackgroundTransparency = 1}, mid)
		ui("UIStroke", {Color = rgb(0, 162, 255), Thickness = 4}, sel)
		txt(mid, "Halloween Zone - building...", UDim2.fromScale(0.02, 0.02), UDim2.fromScale(0.6, 0.07), rgb(30, 30, 60), FONT_B)
	else
		local tabs = ui("Frame", {Size = UDim2.fromScale(1, 0.07), BackgroundColor3 = rgb(37, 37, 37), BorderSizePixel = 0}, mid)
		txt(tabs, mode == "CodeR" and "  HalloweenConfig  x" or "  DragonServer  x", UDim2.fromScale(0, 0.1), UDim2.fromScale(0.4, 0.8), rgb(230, 230, 230), FONT_B)
		local lines = mode == "CodeR" and CODE_R or CODE_K
		for i, line in lines do
			txt(mid, tostring(i), UDim2.fromScale(0.01, 0.08 + (i - 1) * 0.072), UDim2.fromScale(0.05, 0.06), rgb(110, 110, 110), CODE, Enum.TextXAlignment.Right)
			local l = txt(mid, line, UDim2.fromScale(0.08, 0.08 + (i - 1) * 0.072), UDim2.fromScale(0.9, 0.06), rgb(212, 212, 212), CODE, Enum.TextXAlignment.Left, true)
			l.Name = "Line" .. i
			l.TextScaled = false
			l.TextWrapped = false
			l.TextSize = 11
		end
		local caret = ui("Frame", {Name = "Caret", Position = UDim2.fromScale(0.08, 0.08), Size = UDim2.new(0, 3, 0.06, 0), BackgroundColor3 = rgb(255, 255, 255), BorderSizePixel = 0}, mid)
	end
	-- écran éteint (affiché quand le PC grille)
	ui("Frame", {Name = "Off", Size = UDim2.fromScale(1, 1), BackgroundColor3 = rgb(5, 5, 8), BorderSizePixel = 0, Visible = false, ZIndex = 10}, sg)
	return sg
end

-- petit écran : Output ou chat d'équipe
local function sideScreen(p, mode)
	local sg = screenGui(p)
	sg.Name = "Screen"
	local root = ui("Frame", {Name = "On", Size = UDim2.fromScale(1, 1), BackgroundColor3 = rgb(35, 35, 40), BorderSizePixel = 0}, sg)
	local lines = mode == "Chat" and {
		{"rexydev1", "bro the halloween zone is ready", rgb(255, 120, 120)},
		{"kinoshi112", "nice!! I'm finishing the dragons", rgb(120, 200, 255)},
		{"Nono275er", "I'm bringing coffee for you guys", rgb(150, 255, 140)},
		{"rexydev1", "LEGEND", rgb(255, 120, 120)},
		{"kinoshi112", "don't spill it lol", rgb(120, 200, 255)},
	} or {
		{"Output", "", rgb(240, 240, 240)},
		{"", "[EggZoneServer] 140 eggs spawned", rgb(200, 200, 200)},
		{"", "[DragonServer] Dragon Lv.1 ready", rgb(200, 200, 200)},
		{"", "[PetServer] data saved (3 players)", rgb(200, 200, 200)},
		{"", "Warning: coffee level critical", rgb(255, 200, 60)},
		{"", "Spawning Pumpkin", rgb(200, 200, 200)},
	}
	txt(root, mode == "Chat" and "# dev-team" or "", UDim2.fromScale(0.04, 0.02), UDim2.fromScale(0.9, 0.1), rgb(240, 240, 240), FONT_B)
	for i, l in lines do
		local y = 0.12 + (i - 1) * 0.15
		if l[1] ~= "" and mode == "Chat" then
			txt(root, l[1], UDim2.fromScale(0.04, y), UDim2.fromScale(0.9, 0.06), l[3], FONT_B)
			txt(root, l[2], UDim2.fromScale(0.04, y + 0.065), UDim2.fromScale(0.9, 0.065), rgb(215, 215, 220))
		else
			txt(root, l[1] ~= "" and l[1] or l[2], UDim2.fromScale(0.04, y), UDim2.fromScale(0.92, 0.08), l[3], l[1] ~= "" and FONT_B or CODE)
		end
	end
	ui("Frame", {Name = "Off", Size = UDim2.fromScale(1, 1), BackgroundColor3 = rgb(5, 5, 8), BorderSizePixel = 0, Visible = false, ZIndex = 10}, sg)
end

---------------------------------------------------------------- un poste de travail
local function setup(z, tag, outer, codeMode)
	local BLACK, DARK = rgb(22, 22, 28), rgb(40, 40, 50)
	-- grand écran
	local scr = part("Screen" .. tag, Vector3.new(7.2, 4.1, 0.25), facing(Vector3.new(-20.3, 7.0, z), Vector3.new(1, 0, 0)), rgb(10, 10, 14), {Studs = false})
	studioScreen(scr, codeMode)
	part("Monitor", Vector3.new(7.7, 4.6, 0.4), facing(Vector3.new(-20.55, 7.0, z), Vector3.new(1, 0, 0)), BLACK)
	part("Monitor", Vector3.new(0.5, 2.0, 0.5), Vector3.new(-20.8, 4.6, z), DARK)
	part("Monitor", Vector3.new(2.2, 0.25, 1.6), Vector3.new(-20.6, 3.95, z), DARK)
	part("RGB", Vector3.new(0.12, 0.12, 7.5), Vector3.new(-20.85, 4.75, z), rgb(170, 60, 255), {Neon = true, Tag = "CutsceneRGB"})
	-- écran de côté (penché vers le joueur)
	local sideZ = z + outer * 6.1
	local dir = Vector3.new(1, 0, -outer * 0.45).Unit
	local side = part("Side" .. tag, Vector3.new(4.2, 2.7, 0.22), facing(Vector3.new(-19.9, 6.4, sideZ), dir), rgb(10, 10, 14), {Studs = false})
	sideScreen(side, tag == "K" and "Chat" or "Output")
	part("Monitor", Vector3.new(4.6, 3.1, 0.35), facing(Vector3.new(-20.1, 6.4, sideZ - outer * 0.08), dir), BLACK)
	part("Monitor", Vector3.new(0.4, 1.8, 0.4), Vector3.new(-20.4, 4.7, sideZ), DARK)
	part("Monitor", Vector3.new(1.6, 0.25, 1.3), Vector3.new(-20.3, 3.95, sideZ), DARK)
	-- clavier mécanique avec touches et rétroéclairage
	local kb = part("Keyboard" .. tag, Vector3.new(1.9, 0.3, 4.6), Vector3.new(-17.2, 4.0, z), rgb(28, 28, 34))
	part("RGB", Vector3.new(2.0, 0.08, 4.7), Vector3.new(-17.2, 3.84, z), rgb(0, 200, 255), {Neon = true, Tag = "CutsceneRGB"})
	for row = 0, 3 do
		for col = 0, 12 do
			local kz = z - 2.05 + col * 0.34
			local kx = -17.85 + row * 0.42
			if not (row == 3 and col >= 4 and col <= 8) then
				part("Key", Vector3.new(0.32, 0.18, 0.28), Vector3.new(kx, 4.24, kz), (row + col) % 5 == 0 and rgb(255, 80, 120) or rgb(52, 52, 64))
			end
		end
	end
	part("Key", Vector3.new(0.32, 0.18, 1.6), Vector3.new(-16.59, 4.24, z - 2.05 + 6 * 0.34), rgb(52, 52, 64)) -- barre d'espace
	marker("Keyboard" .. tag .. "Top", Vector3.new(-17.2, 4.4, z))
	-- tapis + souris
	local mz = z - outer * 3.4
	part("Pad", Vector3.new(2.6, 0.08, 2.4), Vector3.new(-17.2, 3.89, mz), rgb(30, 30, 40), {Studs = false})
	part("RGB", Vector3.new(2.7, 0.06, 2.5), Vector3.new(-17.2, 3.86, mz), rgb(255, 60, 200), {Neon = true, Tag = "CutsceneRGB"})
	part("Mouse", Vector3.new(0.9, 0.35, 0.55), Vector3.new(-17.0, 4.1, mz), rgb(20, 20, 26))
	part("RGB", Vector3.new(0.3, 0.1, 0.2), Vector3.new(-17.35, 4.29, mz), rgb(0, 255, 160), {Neon = true, Tag = "CutsceneRGB"})
	-- tour du PC gaming (vitre, ventilateurs RGB, carte graphique)
	local tz = z + outer * 10.4
	local tower = part("Tower" .. tag, Vector3.new(3.4, 5.6, 2.0), Vector3.new(-19.3, 6.65, tz), rgb(20, 20, 26))
	part("Glass", Vector3.new(3.0, 5.0, 0.1), Vector3.new(-19.2, 6.65, tz - outer * 1.02), rgb(120, 140, 170), {Transparency = 0.55, Studs = false})
	part("Inside", Vector3.new(2.8, 4.8, 0.1), Vector3.new(-19.4, 6.65, tz + outer * 0.6), rgb(30, 90, 50))
	part("GPU", Vector3.new(2.6, 0.6, 1.2), Vector3.new(-19.3, 5.7, tz), rgb(45, 45, 55))
	part("RGB", Vector3.new(2.4, 0.12, 0.1), Vector3.new(-19.3, 5.95, tz - outer * 0.62), rgb(255, 40, 120), {Neon = true, Tag = "CutsceneRGB"})
	for i, y in {7.9, 6.6} do -- ventilateurs : anneaux néon
		local c = Vector3.new(-17.62, y, tz)
		for k = 0, 3 do
			part("Fan", Vector3.new(0.1, 0.15, 1.2), CFrame.new(c) * CFrame.Angles(k * math.pi / 4, 0, 0) * CFrame.new(0, 0.55, 0), rgb(0, 220, 255), {Neon = true, Tag = "CutsceneRGB"})
			part("Fan", Vector3.new(0.1, 0.15, 1.2), CFrame.new(c) * CFrame.Angles(k * math.pi / 4, 0, 0) * CFrame.new(0, -0.55, 0), rgb(0, 220, 255), {Neon = true, Tag = "CutsceneRGB"})
		end
		part("Fan", Vector3.new(0.12, 0.35, 0.35), c, rgb(30, 30, 36))
	end
	part("RGB", Vector3.new(0.1, 5.2, 0.12), Vector3.new(-17.58, 6.65, tz + outer * 0.85), rgb(255, 120, 0), {Neon = true, Tag = "CutsceneRGB"})
	marker("Tower" .. tag .. "Top", Vector3.new(-19.3, 9.5, tz))
	-- casque sur son support, canette, post-it
	local hz = z + outer * 7.6
	part("Stand", Vector3.new(0.3, 2.2, 0.3), Vector3.new(-18.5, 5.0, hz), DARK)
	part("Headset", Vector3.new(0.5, 0.35, 1.8), Vector3.new(-18.5, 6.2, hz), rgb(30, 30, 36))
	for _, s in {-1, 1} do part("Headset", Vector3.new(0.7, 1.0, 0.45), Vector3.new(-18.5, 5.5, hz + s * 0.85), rgb(220, 40, 60)) end
	part("Can", Vector3.new(0.5, 0.9, 0.5), Vector3.new(-16.4, 4.3, z + outer * 5.2), rgb(40, 220, 90))
	part("Note", Vector3.new(0.05, 0.6, 0.6), Vector3.new(-20.2, 8.6, z + 3.0), rgb(255, 240, 90), {Studs = false})
	-- chaise gaming (rouge / noir) tournée vers l'écran
	local cx = -14.0
	local accent = tag == "K" and rgb(30, 140, 255) or rgb(230, 40, 50)
	-- partie qui pivote (assise, dossier, accoudoirs) : un Model "Swivel" que la cutscene fait tourner
	local swivel = Instance.new("Model")
	swivel.Name = "Swivel" .. tag
	swivel.Parent = model
	local so = {Parent = swivel}
	local function sp(size, cf, color, extra)
		local o = table.clone(so)
		for k, v in extra or {} do o[k] = v end
		return part("Chair", size, cf, color, o)
	end
	local BLACKC = rgb(25, 25, 30)
	sp(Vector3.new(3.2, 0.8, 3.2), Vector3.new(cx, 2.4, z), BLACKC)
	sp(Vector3.new(2.2, 0.82, 2.4), Vector3.new(cx, 2.42, z), accent)
	sp(Vector3.new(0.1, 0.84, 2.2), Vector3.new(cx - 0.6, 2.43, z), rgb(220, 220, 230), {Studs = false}) -- coutures
	sp(Vector3.new(0.1, 0.84, 2.2), Vector3.new(cx + 0.6, 2.43, z), rgb(220, 220, 230), {Studs = false})
	sp(Vector3.new(0.8, 2.6, 3.2), CFrame.new(cx + 1.75, 4.1, z) * CFrame.Angles(0, 0, rad(-8)), BLACKC)
	sp(Vector3.new(0.82, 2.0, 1.0), CFrame.new(cx + 1.75, 4.1, z) * CFrame.Angles(0, 0, rad(-8)), accent)
	for _, s in {-1, 1} do sp(Vector3.new(0.84, 2.3, 0.18), CFrame.new(cx + 1.75, 4.1, z + s * 1.25) * CFrame.Angles(0, 0, rad(-8)), accent) end
	sp(Vector3.new(0.9, 0.7, 1.6), CFrame.new(cx + 1.95, 3.5, z) * CFrame.Angles(0, 0, rad(-8)), rgb(240, 240, 240)) -- coussin lombaire
	for _, s in {-1, 1} do
		sp(Vector3.new(2.4, 0.3, 0.5), Vector3.new(cx + 0.2, 3.6, z + s * 1.75), BLACKC)
		sp(Vector3.new(0.4, 1.0, 0.4), Vector3.new(cx + 0.6, 3.0, z + s * 1.75), BLACKC)
	end
	local pivot = sp(Vector3.new(0.4, 0.4, 0.4), Vector3.new(cx, 2.4, z), rgb(255, 0, 255), {Transparency = 1, Studs = false})
	pivot.Name = "Pivot"
	swivel.PrimaryPart = pivot
	part("Chair", Vector3.new(0.6, 1.4, 0.6), Vector3.new(cx, 1.3, z), rgb(60, 60, 70))
	for k = 0, 4 do
		local a = k / 5 * math.pi * 2
		part("Chair", Vector3.new(2.0, 0.3, 0.4), CFrame.new(cx, 0.55, z) * CFrame.Angles(0, a, 0) * CFrame.new(1.0, 0, 0), rgb(25, 25, 30))
		part("Chair", Vector3.new(0.4, 0.4, 0.4), CFrame.new(cx, 0.2, z) * CFrame.Angles(0, a, 0) * CFrame.new(1.9, 0, 0), rgb(40, 40, 40))
	end
	marker("Seat" .. tag, CFrame.new(cx, 2.8, z) * CFrame.Angles(0, rad(90), 0)) -- regarde vers -X (l'écran)
	return kb, tower
end

---------------------------------------------------------------- la pièce complète
function M.Build(cframe)
	model = Instance.new("Model")
	model.Name = "Set"
	origin = cframe or CFrame.new()
	local WALL, WALL2, TRIM = rgb(34, 32, 46), rgb(44, 40, 60), rgb(20, 18, 28)

	-- île de roche flottante sous le studio et le balcon
	part("Rock", Vector3.new(66, 6, 44), Vector3.new(4, -3.4, 0), rgb(95, 90, 100))
	part("Rock", Vector3.new(56, 6, 36), Vector3.new(3, -8.4, 0), rgb(80, 76, 86))
	part("Rock", Vector3.new(40, 6, 26), Vector3.new(2, -13.4, 0), rgb(70, 66, 76))
	part("Rock", Vector3.new(22, 6, 14), Vector3.new(0, -18.4, 2), rgb(62, 58, 68))
	part("Grass", Vector3.new(66.2, 0.6, 44.2), Vector3.new(4, -0.5, 0), rgb(90, 170, 70))
	-- sol en parquet
	for i = 0, 15 do
		part("Floor", Vector3.new(44, 0.4, 2), Vector3.new(0, -0.2, -15 + i * 2), i % 2 == 0 and rgb(120, 80, 50) or rgb(105, 70, 44))
	end
	-- tapis
	part("Rug", Vector3.new(14, 0.12, 12), Vector3.new(-4, 0.06, 0), rgb(120, 50, 170))
	part("Rug", Vector3.new(12.4, 0.14, 10.4), Vector3.new(-4, 0.07, 0), rgb(70, 30, 110))
	-- murs
	part("Wall", Vector3.new(1, 14, 33), Vector3.new(-22.5, 7, 0), WALL)
	for _, s in {-1, 1} do part("Wall", Vector3.new(46, 14, 1), Vector3.new(0, 7, s * 16.5), WALL) end
	part("Wall", Vector3.new(1, 14, 12.5), Vector3.new(22.5, 7, -9.75), WALL)
	part("Wall", Vector3.new(1, 14, 12.5), Vector3.new(22.5, 7, 9.75), WALL)
	part("Wall", Vector3.new(1, 4.6, 7), Vector3.new(22.5, 11.7, 0), WALL)
	part("Ceiling", Vector3.new(46, 1, 34), Vector3.new(0, 14.5, 0), rgb(26, 24, 34))
	-- bandes LED RGB en bas et en haut des murs
	for _, y in {0.25, 13.8} do
		part("RGB", Vector3.new(0.15, 0.25, 32), Vector3.new(-21.95, y, 0), rgb(170, 60, 255), {Neon = true, Tag = "CutsceneRGB"})
		for _, s in {-1, 1} do part("RGB", Vector3.new(44, 0.25, 0.15), Vector3.new(0, y, s * 15.95), rgb(0, 200, 255), {Neon = true, Tag = "CutsceneRGB"}) end
	end
	-- mousse acoustique au mur du fond
	for iy = 0, 2 do
		for iz = -6, 6 do
			if (iy + iz) % 2 == 0 then
				part("Foam", Vector3.new(0.5, 1.8, 1.8), Vector3.new(-21.8, 9.6 + iy * 1.9, iz * 2.2), rgb(60, 40, 90))
			else
				part("Foam", Vector3.new(0.7, 1.3, 1.3), CFrame.new(-21.7, 9.6 + iy * 1.9, iz * 2.2) * CFrame.Angles(rad(45), 0, 0), rgb(30, 26, 40))
			end
		end
	end
	-- grand bureau (plateau noir, bord LED) + caissons
	part("Desk", Vector3.new(6, 0.5, 30), Vector3.new(-18.8, 3.6, 0), rgb(26, 26, 32))
	part("RGB", Vector3.new(0.12, 0.12, 30), Vector3.new(-15.75, 3.42, 0), rgb(255, 60, 200), {Neon = true, Tag = "CutsceneRGB"})
	for _, z in {-14, 0, 14} do part("Desk", Vector3.new(5, 3.4, 1.2), Vector3.new(-19.2, 1.7, z), rgb(40, 40, 50)) end
	local kbK, towerK = setup(-6.5, "K", -1, "CodeK")
	local kbR, towerR = setup(6.5, "R", 1, "Viewport")
	-- néon "DEV STUDIO" au mur
	local sign = part("Sign", Vector3.new(14, 3.2, 0.2), facing(Vector3.new(-6, 9.5, -15.85), Vector3.new(0, 0, 1)), rgb(15, 12, 22), {Studs = false})
	local sg = ui("SurfaceGui", {Face = Enum.NormalId.Front, LightInfluence = 0, Brightness = 3, PixelsPerStud = 40, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud}, sign)
	local title = txt(sg, "DEV STUDIO", UDim2.fromScale(0.03, 0.05), UDim2.fromScale(0.94, 0.9), rgb(255, 90, 230), Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy), Enum.TextXAlignment.Center)
	ui("UIStroke", {Color = rgb(120, 0, 255), Thickness = 4}, title)
	-- affiche "DRAGON EGGS" (dragon en pixels)
	local poster = part("Poster", Vector3.new(6, 8, 0.15), facing(Vector3.new(8, 7.5, 15.9), Vector3.new(0, 0, -1)), rgb(20, 20, 40), {Studs = false})
	local ps = ui("SurfaceGui", {Face = Enum.NormalId.Front, LightInfluence = 0.3, PixelsPerStud = 30, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud}, poster)
	ui("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 120, 40), rgb(120, 20, 60))}, ui("Frame", {Size = UDim2.fromScale(1, 1), BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1)}, ps))
	local pt = txt(ps, "DRAGON EGGS", UDim2.fromScale(0.05, 0.04), UDim2.fromScale(0.9, 0.16), rgb(255, 230, 90), Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy), Enum.TextXAlignment.Center)
	ui("UIStroke", {Thickness = 3}, pt)
	for _, px in {{3, 4}, {4, 4}, {5, 4}, {2, 5}, {3, 5}, {4, 5}, {5, 5}, {6, 5}, {3, 6}, {4, 6}, {5, 6}, {6, 6}, {7, 6}, {4, 7}, {5, 7}, {6, 3}, {7, 3}, {7, 2}, {2, 4}, {1, 3}} do
		ui("Frame", {Position = UDim2.fromScale(0.08 + px[1] * 0.1, 0.22 + px[2] * 0.075), Size = UDim2.fromScale(0.1, 0.075), BackgroundColor3 = (px[2] <= 3 and rgb(255, 200, 50)) or rgb(200, 30, 40), BorderSizePixel = 0}, ps)
	end
	txt(ps, "COMING SOON", UDim2.fromScale(0.05, 0.86), UDim2.fromScale(0.9, 0.1), rgb(255, 255, 255), Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold), Enum.TextXAlignment.Center)
	part("Poster", Vector3.new(6.4, 8.4, 0.1), facing(Vector3.new(8, 7.5, 15.95), Vector3.new(0, 0, -1)), rgb(240, 240, 240), {Studs = false})
	-- horloge 03:00
	local clock = part("Clock", Vector3.new(3.4, 1.4, 0.2), facing(Vector3.new(-2, 11.6, 15.85), Vector3.new(0, 0, -1)), rgb(10, 10, 12), {Studs = false})
	local cs = ui("SurfaceGui", {Face = Enum.NormalId.Front, LightInfluence = 0, Brightness = 2, PixelsPerStud = 40, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud}, clock)
	txt(cs, "03:00", UDim2.fromScale(0.05, 0.05), UDim2.fromScale(0.9, 0.9), rgb(255, 60, 60), Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold), Enum.TextXAlignment.Center)
	-- étagère avec figurines (œufs) et une plante
	part("Shelf", Vector3.new(8, 0.4, 1.8), Vector3.new(-2, 8.2, -15.0), rgb(110, 75, 45))
	for i, c in {rgb(255, 120, 30), rgb(120, 220, 255), rgb(200, 90, 255), rgb(255, 220, 60)} do
		part("Egg", Vector3.new(0.9, 1.2, 0.9), Vector3.new(-5 + i * 1.6, 9.0, -15.0), c)
		part("Egg", Vector3.new(0.6, 0.4, 0.6), Vector3.new(-5 + i * 1.6, 9.75, -15.0), c)
	end
	part("Pot", Vector3.new(2, 2, 2), Vector3.new(19, 1, 13.5), rgb(200, 120, 70))
	for k = 0, 5 do part("Leaf", Vector3.new(0.5, 3.2, 1.4), CFrame.new(19, 3.2, 13.5) * CFrame.Angles(0, k * 1.05, 0) * CFrame.Angles(0, 0, rad(25)) * CFrame.new(0, 1, 0), rgb(70, 170, 60)) end
	-- mini frigo + canettes, pouf
	part("Fridge", Vector3.new(3, 4.2, 3), Vector3.new(-14, 2.1, 14.0), rgb(235, 235, 240))
	part("Fridge", Vector3.new(0.2, 1.6, 0.3), Vector3.new(-12.4, 2.6, 13.0), rgb(150, 150, 160))
	for i = 0, 2 do part("Can", Vector3.new(0.5, 0.9, 0.5), Vector3.new(-14.8 + i * 0.8, 4.65, 14.0), i == 1 and rgb(255, 60, 60) or rgb(40, 220, 90)) end
	part("Beanbag", Vector3.new(4.2, 2.2, 4.2), Vector3.new(14, 1.1, -12), rgb(255, 160, 40))
	part("Beanbag", Vector3.new(3.2, 1.4, 3.2), CFrame.new(14.4, 2.6, -12) * CFrame.Angles(0, rad(45), 0), rgb(255, 180, 70))
	-- lumières
	for i, l in {{Vector3.new(-12, 13, -6), rgb(170, 80, 255)}, {Vector3.new(-12, 13, 6), rgb(0, 180, 255)}, {Vector3.new(8, 13, 0), rgb(255, 120, 200)}} do
		local lamp = part("Lamp", Vector3.new(3, 0.3, 3), l[1] + Vector3.new(0, 0.85, 0), l[2], {Neon = true, Tag = "CutsceneRGB"})
		local pl = Instance.new("PointLight")
		pl.Name = "RoomLight"
		pl.Color, pl.Range, pl.Brightness = l[2], 26, 1.4
		pl.Parent = lamp
	end
	-- porte (charnière côté -Z) + panneau EXIT
	local hinge = marker("Door", Vector3.new(22.5, 4.5, -3.2))
	local door = Instance.new("Model")
	door.Name = "DoorPanel"
	door.Parent = model
	part("Door", Vector3.new(0.4, 9, 6.3), Vector3.new(22.5, 4.5, 0), rgb(120, 80, 50), {Parent = door})
	part("Door", Vector3.new(0.45, 2.5, 2.2), Vector3.new(22.5, 6.6, 0), rgb(170, 210, 240), {Parent = door, Transparency = 0.3, Studs = false})
	part("Door", Vector3.new(0.7, 0.3, 0.9), Vector3.new(22.5, 4.3, 2.3), rgb(220, 200, 80), {Parent = door})
	door.PrimaryPart = hinge
	hinge.Parent = door
	part("Frame", Vector3.new(1.2, 9.6, 0.5), Vector3.new(22.5, 4.8, -3.4), TRIM)
	part("Frame", Vector3.new(1.2, 9.6, 0.5), Vector3.new(22.5, 4.8, 3.4), TRIM)
	part("Frame", Vector3.new(1.2, 0.5, 7.3), Vector3.new(22.5, 9.4, 0), TRIM)
	local exit = part("Exit", Vector3.new(0.2, 0.9, 2.4), facing(Vector3.new(21.9, 10.6, 0), Vector3.new(-1, 0, 0)), rgb(30, 200, 80), {Neon = true, Studs = false})
	local es = ui("SurfaceGui", {Face = Enum.NormalId.Front, LightInfluence = 0, PixelsPerStud = 50, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud}, exit)
	txt(es, "EXIT", UDim2.fromScale(0.05, 0.05), UDim2.fromScale(0.9, 0.9), Color3.new(1, 1, 1), Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy), Enum.TextXAlignment.Center)
	-- balcon dehors (vue sur la map)
	for i = 0, 6 do part("Balcony", Vector3.new(14, 0.4, 2.4), Vector3.new(30, -0.2, -7.2 + i * 2.4), i % 2 == 0 and rgb(150, 105, 65) or rgb(135, 95, 58)) end
	part("Rail", Vector3.new(0.3, 3.4, 17), Vector3.new(36.8, 1.7, 0), rgb(170, 220, 255), {Transparency = 0.6, Studs = false})
	part("Rail", Vector3.new(0.5, 0.4, 17.2), Vector3.new(36.8, 3.5, 0), rgb(60, 60, 70))
	for _, s in {-1, 1} do
		part("Rail", Vector3.new(14, 3.4, 0.3), Vector3.new(30, 1.7, s * 8.5), rgb(170, 220, 255), {Transparency = 0.6, Studs = false})
		part("Rail", Vector3.new(14, 0.4, 0.5), Vector3.new(30, 3.5, s * 8.5), rgb(60, 60, 70))
	end
	for _, z in {-8.5, -2.8, 2.8, 8.5} do part("Rail", Vector3.new(0.6, 3.8, 0.6), Vector3.new(36.8, 1.9, z), rgb(60, 60, 70)) end
	-- repères pour la mise en scène
	marker("NonoStart", CFrame.new(31, 2.9, 0) * CFrame.Angles(0, rad(-90), 0))
	marker("NonoStop", CFrame.new(-8.6, 2.9, 0) * CFrame.Angles(0, rad(-90), 0))
	marker("OutK", CFrame.new(34, 2.9, -3.2) * CFrame.Angles(0, rad(-90), 0))
	marker("OutR", CFrame.new(34, 2.9, 3.2) * CFrame.Angles(0, rad(-90), 0))
	marker("OutN", CFrame.new(33, 2.9, 0) * CFrame.Angles(0, rad(-90), 0))
	marker("Mid", CFrame.new(10, 2.9, 0))
	model.PrimaryPart = marker("Origin", CFrame.new())
	return model
end

return M
