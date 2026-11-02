-- Construit le tapis de course et son panneau d'améliorations dans chaque base (Workspace["all base"]).
-- Chaque pièce porte un attribut Role ("Frame", "Trim", "Glow", "Belt", "Dark") : SpeedServer recolore le tapis selon son niveau.
-- return function() -> rapport. Peut être relancé : il remplace les tapis existants.
local V = Vector3.new
local rad = math.rad
local STUDS = "rbxassetid://7447638591"

local function part(model, role, size, cf, o)
	o = o or {}
	local p = Instance.new(o.wedge and "WedgePart" or "Part")
	p.Name = o.name or role
	p.Size = size
	p.CFrame = cf
	p.Anchored = true
	p.CanCollide = o.collide ~= false
	p.CanTouch, p.CanQuery = false, o.query == true
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	p.Material = role == "Glow" and Enum.Material.Neon or Enum.Material.Plastic
	if role ~= "Glow" and not o.wedge then pcall(function() p.MaterialVariant = "Studs" end) end
	p.Color = o.color or Color3.fromRGB(128, 132, 142)
	p:SetAttribute("Role", role)
	p.Parent = model
	return p
end

local function treadmill()
	local m = Instance.new("Model")
	m.Name = "Treadmill"
	local GREY, DARKGREY, INK, WHITE = Color3.fromRGB(128, 132, 142), Color3.fromRGB(74, 77, 86), Color3.fromRGB(26, 27, 32), Color3.fromRGB(235, 240, 255)
	local function F(size, pos, o) return part(m, "Frame", size, CFrame.new(pos), o) end
	local function T(size, pos, o) o = o or {} o.color = o.color or DARKGREY return part(m, "Trim", size, CFrame.new(pos), o) end
	local function G(size, pos, o) o = o or {} o.color = WHITE o.collide = false return part(m, "Glow", size, CFrame.new(pos), o) end
	-- socle : une dalle basse, deux longerons, quatre pieds
	local root = F(V(10, 0.8, 17), V(0, 0.4, 0), {name = "Deck"})
	m.PrimaryPart = root
	for _, sx in {-1, 1} do
		F(V(1.6, 0.9, 17), V(sx * 4.2, 1.25, 0), {name = "Rail"})
		G(V(0.25, 0.25, 15.6), V(sx * 3.3, 1.55, 0.2))                       -- filet lumineux le long de la bande
		T(V(1.9, 0.5, 1.9), V(sx * 4.2, 0.25, -7.4), {name = "Foot"})
		T(V(1.9, 0.5, 1.9), V(sx * 4.2, 0.25, 7.4), {name = "Foot"})
		-- montant avant et main courante qui redescend vers l'arrière
		T(V(1, 7.6, 1), V(sx * 4.2, 5.5, -6.6), {name = "Post"})
		F(V(0.8, 0.8, 6.4), V(sx * 4.2, 6.9, -3.2), {name = "Handrail"})
		part(m, "Trim", V(0.7, 0.7, 5.6), CFrame.new(sx * 4.2, 4.3, 0.9) * CFrame.Angles(rad(-58), 0, 0), {name = "Brace", color = DARKGREY})
		G(V(0.3, 0.3, 6), V(sx * 4.2, 7.4, -3.2))
	end
	-- la bande : sombre, creusée entre les longerons ; les joueurs courent dessus
	local belt = part(m, "Belt", V(6.8, 0.5, 14.2), CFrame.new(0, 1.05, 0.6), {name = "Belt", color = INK, query = true})
	local tex = Instance.new("Texture")
	tex.Name = "Scroll"
	tex.Texture = STUDS
	tex.Face = Enum.NormalId.Top
	tex.StudsPerTileU, tex.StudsPerTileV = 3.4, 3.4
	tex.Transparency = 0.55
	tex.Color3 = Color3.fromRGB(90, 92, 104)
	tex.Parent = belt
	for i = -2, 2 do -- bandes de repère peintes sur la bande
		part(m, "Dark", V(6.8, 0.06, 0.5), CFrame.new(0, 1.32, 0.6 + i * 2.8), {name = "Stripe", color = Color3.fromRGB(58, 60, 70), collide = false})
	end
	T(V(6.8, 0.7, 1), V(0, 1.15, 8), {name = "RearRoller"})
	-- petite rampe à l'arrière : on monte sur la bande en marchant, sans sauter
	part(m, "Frame", V(6.8, 1.5, 3.4), CFrame.new(0, 0.75, 10.2) * CFrame.Angles(0, rad(180), 0), {name = "EntryRamp", wedge = true})
	-- capot avant en biais et console
	F(V(10, 1.6, 2.2), V(0, 1.6, -7.4), {name = "Hood"})
	part(m, "Frame", V(6.8, 1.1, 1.6), CFrame.new(0, 1.85, -5.7) * CFrame.Angles(0, rad(180), 0), {name = "HoodSlope", wedge = true})
	T(V(9.4, 0.9, 0.9), V(0, 8.9, -6.6), {name = "Crossbar"})
	local console = part(m, "Frame", V(7.2, 3.6, 0.9), CFrame.new(0, 7.3, -6.3) * CFrame.Angles(rad(-16), 0, 0), {name = "Console"})
	local screen = part(m, "Dark", V(6.2, 2.7, 0.12), console.CFrame * CFrame.new(0, 0, 0.5), {name = "Screen", color = INK, collide = false})
	for i = -1, 1 do G(V(1.5, 0.45, 0.45), V(i * 2.3, 9.6, -6.6)) end -- trois voyants sur la barre du haut
	local gui = Instance.new("SurfaceGui")
	gui.Name = "Display"
	gui.Face = Enum.NormalId.Back
	gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	gui.PixelsPerStud = 40
	gui.LightInfluence = 0
	local function label(name, text, pos, size, color)
		local l = Instance.new("TextLabel")
		l.Name = name
		l.BackgroundTransparency = 1
		l.Position, l.Size = pos, size
		l.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
		l.Text, l.TextScaled, l.TextColor3 = text, true, color
		local s = Instance.new("UIStroke")
		s.Thickness = 3
		s.Parent = l
		l.Parent = gui
		return l
	end
	label("Gain", "+1", UDim2.fromScale(0.04, 0.04), UDim2.fromScale(0.92, 0.58), Color3.fromRGB(120, 255, 120))
	label("Level", "LEVEL 0", UDim2.fromScale(0.04, 0.62), UDim2.fromScale(0.92, 0.32), Color3.new(1, 1, 1))
	gui.Parent = screen
	return m
end

local function board()
	local m = Instance.new("Model")
	m.Name = "TreadmillBoard"
	local GREY, DARKGREY, INK, WHITE = Color3.fromRGB(128, 132, 142), Color3.fromRGB(74, 77, 86), Color3.fromRGB(26, 27, 32), Color3.fromRGB(235, 240, 255)
	local base = part(m, "Trim", V(10.4, 0.6, 2.6), CFrame.new(0, 0.3, 0), {name = "Base", color = DARKGREY})
	m.PrimaryPart = base
	for _, sx in {-1, 1} do
		part(m, "Trim", V(0.9, 3, 0.9), CFrame.new(sx * 4, 2.1, 0), {name = "Leg", color = DARKGREY})
	end
	part(m, "Frame", V(10.4, 7.4, 0.9), CFrame.new(0, 7.1, 0), {name = "Panel", color = GREY})
	part(m, "Dark", V(9.4, 6.4, 0.14), CFrame.new(0, 7.1, 0.5), {name = "Screen", color = INK, collide = false, query = true})
	part(m, "Glow", V(10.4, 0.35, 0.35), CFrame.new(0, 11, 0), {name = "TopLight", color = WHITE, collide = false})
	part(m, "Frame", V(4.2, 1.1, 1.1), CFrame.new(0, 11.6, 0), {name = "Crest", color = GREY})
	return m
end

return function()
	local report = {}
	local bases = workspace:WaitForChild("all base")
	for _, base in bases:GetChildren() do
		local garden, spawnPart = base:FindFirstChild("animaux"), base:FindFirstChild("Spawn")
		if garden and spawnPart then
			for _, old in {"Treadmill", "TreadmillBoard"} do
				local o = base:FindFirstChild(old)
				if o then o:Destroy() end
			end
			-- devant le jardin, à DROITE du point d'apparition (quand on regarde le jardin), loin du panneau d'agrandissement du jardin,
			-- et tourné de 180° : on court dos au jardin. Le panneau d'améliorations est encore plus à droite, tourné comme le tapis.
			local toGarden = (Vector3.new(garden.Position.X, 0, garden.Position.Z) - Vector3.new(spawnPart.Position.X, 0, spawnPart.Position.Z)).Unit
			local left = Vector3.new(toGarden.Z, 0, -toGarden.X)
			local ground = spawnPart.Position.Y - spawnPart.Size.Y / 2 - 0.4
			local origin = Vector3.new(spawnPart.Position.X, ground, spawnPart.Position.Z)
			local t = treadmill()
			local spot = origin - toGarden * 6 - left * 19.5
			t:PivotTo(CFrame.lookAt(spot, spot - toGarden) * CFrame.new(0, 0.4, 0))
			t.Parent = base
			local b = board()
			local at = origin - toGarden * 6 - left * 31
			b:PivotTo(CFrame.lookAt(at, at - toGarden) * CFrame.new(0, 0.3, 0)) -- à gauche du tapis, tourné comme lui : son écran regarde du même côté que la console
			b.Parent = base
			-- décor gênant : ce qui touche l'emprise du tapis ou du panneau
			local blocked = {}
			for _, model in {t, b} do
				local cf, size = model:GetBoundingBox()
				local params = OverlapParams.new()
				params.FilterType = Enum.RaycastFilterType.Exclude
				params.FilterDescendantsInstances = {t, b}
				for _, hit in workspace:GetPartBoundsInBox(cf, size + Vector3.new(1, 0, 1), params) do
					if hit.Name ~= "safe zone" and hit.Transparency < 1 then
						local top = hit
						while top.Parent ~= workspace and top.Parent.Parent ~= workspace and not top.Parent:IsA("Folder") do top = top.Parent end
						blocked[top:GetFullName()] = true
					end
				end
			end
			local names = {}
			for n in blocked do table.insert(names, n) end
			table.insert(report, string.format("%s: treadmill at (%.1f, %.1f, %.1f), board at (%.1f, %.1f) | in the way: %s", base.Name, t:GetPivot().X, t:GetPivot().Y, t:GetPivot().Z, b:GetPivot().X, b:GetPivot().Z, #names > 0 and table.concat(names, ", ") or "nothing"))
		end
	end
	return table.concat(report, "\n")
end
