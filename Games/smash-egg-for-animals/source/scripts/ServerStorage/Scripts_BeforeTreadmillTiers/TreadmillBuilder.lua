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
	-- Tapis posé au sol : la bande est basse (on marche dessus sans sauter), entre deux flancs surélevés qui portent de grands
	-- néons encadrés ; une arche à l'avant porte l'écran. Seule la bande est solide : on passe à travers tout le reste.
	local function ghost(o) o = o or {} o.collide = false return o end
	local BELT_Z, BELT_LEN = 1.0, 14.6 -- la bande : son milieu et sa longueur
	local root = F(V(12.7, 0.3, 18.6), V(0, 0.15, 0), ghost({name = "Deck"}))
	m.PrimaryPart = root
	-- la bande : sombre, à peine plus haute que le sol, avec des couloirs peints dans la longueur
	local belt = part(m, "Belt", V(6.4, 0.3, BELT_LEN), CFrame.new(0, 0.36, BELT_Z), {name = "Belt", color = INK, query = true})
	local tex = Instance.new("Texture")
	tex.Name = "Scroll"
	tex.Texture = STUDS
	tex.Face = Enum.NormalId.Top
	tex.StudsPerTileU, tex.StudsPerTileV = 3.2, 3.2
	tex.Transparency = 0.55
	tex.Color3 = Color3.fromRGB(90, 92, 104)
	tex.Parent = belt
	for _, i in {-1, 1} do
		part(m, "Dark", V(1.28, 0.04, BELT_LEN), CFrame.new(i * 1.28, 0.52, BELT_Z), {name = "Stripe", color = Color3.fromRGB(58, 60, 70), collide = false})
	end
	T(V(6.4, 0.45, 0.5), V(0, 0.3, BELT_Z + BELT_LEN / 2 + 0.25), ghost({name = "RearLip"}))
	-- flancs : un socle en marche, un caisson surélevé, deux néons encastrés (un court devant, un long derrière) cernés d'un contour
	for _, sx in {-1, 1} do
		local x = sx * 4.65
		T(V(0.5, 0.6, 17.4), V(sx * 6.1, 0.3, 0.4), ghost({name = "Skirt"}))              -- marche basse à l'extérieur
		F(V(2.7, 1.1, BELT_LEN + 1.6), V(x, 0.85, BELT_Z), ghost({name = "Pod"}))             -- le caisson
		local top = 1.4
		-- contour du caisson : deux longs bords, trois traverses
		F(V(0.4, 0.45, BELT_LEN + 1.6), V(x - sx * 1.15, top + 0.22, BELT_Z), ghost({name = "Rim"}))
		F(V(0.4, 0.45, BELT_LEN + 1.6), V(x + sx * 1.15, top + 0.22, BELT_Z), ghost({name = "Rim"}))
		for _, z in {BELT_Z - BELT_LEN / 2 - 0.6, BELT_Z - 2.9, BELT_Z + BELT_LEN / 2 + 0.6} do
			F(V(1.9, 0.45, 0.4), V(x, top + 0.22, z), ghost({name = "Rim"}))
		end
		-- les néons, un peu en creux dans leur cadre
		G(V(1.9, 0.3, 3.9), V(x, top + 0.1, BELT_Z - 5.05), {name = "SideLight"})
		G(V(1.9, 0.3, 10.3), V(x, top + 0.1, BELT_Z + 2.55), {name = "SideLight"})
		-- bloc d'angle à l'arrière, coiffé d'un néon
		F(V(2.7, 1.7, 1.3), V(x, 0.85, BELT_Z + BELT_LEN / 2 + 1.45), ghost({name = "Corner"}))
		F(V(2.9, 0.35, 1.5), V(x, 1.85, BELT_Z + BELT_LEN / 2 + 1.45), ghost({name = "CornerCap"}))
		G(V(1.6, 0.25, 0.6), V(x, 2.08, BELT_Z + BELT_LEN / 2 + 1.45), {name = "CornerLight"})
	end
	-- arche à l'avant : un capot, deux jambes, une poutre ; des néons à l'intérieur des jambes et sous la poutre
	local AZ = -7.7
	F(V(12.7, 1.9, 2.8), V(0, 0.95, AZ), ghost({name = "Hood"}))
	F(V(12.9, 0.35, 3.0), V(0, 2.05, AZ), ghost({name = "HoodCap"}))
	for _, sx in {-1, 1} do
		F(V(2.3, 4.0, 2.4), V(sx * 4.9, 4.2, AZ), ghost({name = "Leg"}))
		G(V(0.45, 3.4, 1.5), V(sx * 3.6, 4.1, AZ + 0.2), {name = "LegLight"})
		T(V(0.5, 4.0, 0.5), V(sx * 5.9, 4.2, AZ + 1.05), ghost({name = "LegEdge"}))
	end
	F(V(12.7, 1.5, 2.8), V(0, 6.95, AZ), ghost({name = "Beam"}))
	F(V(12.9, 0.35, 3.0), V(0, 7.85, AZ), ghost({name = "BeamCap"}))
	part(m, "Dark", V(9.4, 0.2, 1.7), CFrame.new(0, 8.1, AZ), {name = "BeamPanel", color = INK, collide = false}) -- panneau sombre encastré sur le dessus
	G(V(7.0, 0.3, 1.3), V(0, 6.1, AZ + 0.2), {name = "BeamLight"})
	for i = -1, 1 do G(V(1.6, 0.3, 0.5), V(i * 2.6, 8.25, AZ), {name = "TopLight"}) end
	-- l'écran, dans l'ouverture de l'arche, tourné vers le coureur
	F(V(6.8, 3.3, 0.6), V(0, 4.1, AZ - 0.5), ghost({name = "Console"}))
	local screen = part(m, "Dark", V(6.2, 2.7, 0.12), CFrame.new(0, 4.1, AZ - 0.14), {name = "Screen", color = INK, collide = false})
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

-- keepPlaces = true : les tapis sont refaits là où ils sont déjà (les panneaux ne bougent pas)
return function(keepPlaces)
	local report = {}
	local bases = workspace:WaitForChild("all base")
	for _, base in bases:GetChildren() do
		local garden, spawnPart = base:FindFirstChild("animaux"), base:FindFirstChild("Spawn")
		if garden and spawnPart then
			local oldT = base:FindFirstChild("Treadmill")
			local oldDeck = oldT and oldT:FindFirstChild("Deck")
			local kept = keepPlaces and oldDeck and (oldDeck.CFrame * CFrame.new(0, -oldDeck.Size.Y / 2, 0)) -- le sol sous l'ancien tapis
			local floor = workspace:FindFirstChild("safe zone")
			if kept and floor then kept = kept + Vector3.new(0, floor.Position.Y + floor.Size.Y / 2 - kept.Y, 0) end
			if kept then
				oldT:Destroy()
				local t = treadmill()
				t:PivotTo(kept * CFrame.new(0, t.PrimaryPart.Size.Y / 2, 0))
				t.Parent = base
				table.insert(report, base.Name .. ": treadmill rebuilt in place")
				continue
			end
			for _, old in {"Treadmill", "TreadmillBoard"} do
				local o = base:FindFirstChild(old)
				if o then o:Destroy() end
			end
			-- devant le jardin, à DROITE du point d'apparition (quand on regarde le jardin), loin du panneau d'agrandissement du jardin,
			-- et tourné de 180° : on court dos au jardin. Le panneau d'améliorations est encore plus à droite, tourné comme le tapis.
			local toGarden = (Vector3.new(garden.Position.X, 0, garden.Position.Z) - Vector3.new(spawnPart.Position.X, 0, spawnPart.Position.Z)).Unit
			local left = Vector3.new(toGarden.Z, 0, -toGarden.X)
			local ground = spawnPart.Position.Y - spawnPart.Size.Y / 2 - 0.4
			local safe = workspace:FindFirstChild("safe zone")
			if safe then ground = safe.Position.Y + safe.Size.Y / 2 end -- posé à même le sol de la safe zone
			local origin = Vector3.new(spawnPart.Position.X, ground, spawnPart.Position.Z)
			local t = treadmill()
			local spot = origin - toGarden * 6 - left * 19.5
			t:PivotTo(CFrame.lookAt(spot, spot - toGarden) * CFrame.new(0, t.PrimaryPart.Size.Y / 2, 0))
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
