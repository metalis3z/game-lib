-- ConcertEventServer : event "CONCERT" (commande admin StartConcertEvent, ce serveur ou tous les serveurs)
-- Pendant la durée choisie par l'admin, toutes les zones d'oeufs deviennent une scène de concert (lumières, lasers,
-- boules disco et musique : ConcertEventClient). Les avatars Roblox de Rexydev1, Nono275er et Kinoshi112 se baladent
-- dans les zones (toutes les zones), marchent, dansent et lancent des J'AIME sur les oeufs : un oeuf touché a
-- LIKE_CHANCE de recevoir le trait LIKE (mutation "Like" : revenu de l'animal x5).
-- L'oeuf garde le trait, et l'animal qui en sort aussi (EggZoneServer -> PetServer).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local CollectionService = game:GetService("CollectionService")

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local Config = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local startRemote = remotes:WaitForChild("StartConcertEvent")
local announceRemote = remotes:WaitForChild("BroadcastAnnounce")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")
local fxRemote = ReplicatedStorage:WaitForChild("ConcertFx")

------------------------------------------------------------------ RÉGLAGES
local TOPIC = "AdminConcertEvent"
local DANCERS = {"Rexydev1", "Nono275er", "Kinoshi112"} -- skins Roblox des danseurs
local LIKE_CHANCE = 0.25  -- 25 % : chance qu'un oeuf touché par un j'aime prenne le trait LIKE
local LIKE_RANGE = 150    -- distance max d'un oeuf visé par un lancer
local SCALE = 4           -- taille des danseurs (géants)
local SPACING = 16        -- écart entre les danseurs (ils marchent côte à côte)
local STOPS_PER_ZONE = 4  -- arrêts (marche + danse + lancer) avant de changer de zone
local ANIMS = { -- animations Roblox R15 par défaut
	Walk = "rbxassetid://507777826",
	Idle = "rbxassetid://507766388",
	Throw = "rbxassetid://522635514",
	Dance = {"rbxassetid://507771019", "rbxassetid://507776043", "rbxassetid://507777268"},
}
local MIN_DURATION, MAX_DURATION = 10, 86400
local PINK = Color3.fromRGB(255, 70, 210)

local running, stopRequested, endAt = false, false, 0
local function alive() return not stopRequested and workspace:GetServerTimeNow() < endAt end

local function describe(secs)
	secs = math.floor(secs)
	local h, m, s = secs // 3600, (secs % 3600) // 60, secs % 60
	if h > 0 then return string.format("%dh%02dm", h, m) end
	if m > 0 then return string.format("%dm%02ds", m, s) end
	return s .. "s"
end

------------------------------------------------------------------ MUTATION CONCERT SUR UN OEUF
local function validEgg(e)
	return e and e.Parent and e:IsA("Model") and e:GetAttribute("EggKey") and e.PrimaryPart and not e:GetAttribute("Hatching") and not e:GetAttribute("ConcertMutation")
end

-- un oeuf au hasard dans une zone au hasard (toutes les zones peuvent être choisies)
local function pickEgg()
	local zoneEggs = workspace:FindFirstChild("ZoneEggs")
	if not zoneEggs then return nil end
	local zones = {}
	for _, folder in zoneEggs:GetChildren() do
		local list = {}
		for _, e in folder:GetChildren() do if validEgg(e) then table.insert(list, e) end end
		if #list > 0 then table.insert(zones, list) end
	end
	if #zones == 0 then return nil end
	local list = zones[math.random(#zones)]
	return list[math.random(#list)]
end

local function text(parent, str, pos, size, color, gradient)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Position, l.Size = pos, size
	l.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	l.Text = str
	l.TextScaled = true
	l.TextColor3 = color
	local s = Instance.new("UIStroke") s.Thickness = 3 s.Parent = l
	if gradient then
		local g = Instance.new("UIGradient") g.Color = gradient g.Parent = l
		CollectionService:AddTag(g, "AnimatedGradient") -- fait défiler les couleurs (PetClient)
	end
	CollectionService:AddTag(l, "Text3D")
	l.Parent = parent
	return l
end

local function studs(p)
	p.TopSurface, p.FrontSurface, p.BackSurface, p.LeftSurface, p.RightSurface = Enum.SurfaceType.Studs, Enum.SurfaceType.Studs, Enum.SurfaceType.Studs, Enum.SurfaceType.Studs, Enum.SurfaceType.Studs
	p.BottomSurface = Enum.SurfaceType.Inlet
end

local function applyConcert(egg)
	local root = egg.PrimaryPart
	if not root then return end
	egg:SetAttribute("ConcertMutation", true)
	local height = egg:GetAttribute("Height") or 3
	-- étiquette "CONCERT x5" au-dessus des autres étiquettes de l'oeuf
	local base = height * 0.98 + 1.5
	local labelH = 1.5 + height * 0.14
	local y = base + (3 + height * 0.3) / 2 + 0.4 + labelH / 2
	for _, other in {"WitchTraitLabel", "CowboyTraitLabel"} do
		if root:FindFirstChild(other) then y += labelH + 0.3 end
	end
	local bb = Instance.new("BillboardGui")
	bb.Name = "ConcertLabel"
	bb.Size = UDim2.new(5.5 + height * 0.5, 0, labelH, 0)
	bb.StudsOffsetWorldSpace = Vector3.new(0, y, 0)
	bb.MaxDistance = 120 + height * 6
	bb.LightInfluence = 0
	text(bb, "❤ LIKE ❤", UDim2.fromScale(0, 0), UDim2.fromScale(1, 0.62), Color3.new(1, 1, 1), Config.Gradients.Like)
	text(bb, "x5 TRAIT", UDim2.fromScale(0, 0.62), UDim2.fromScale(1, 0.38), Color3.fromRGB(120, 255, 140))
	bb.Parent = root
	-- petite boule disco en studs qui flotte au-dessus de l'oeuf (elle tourne et change de couleur côté client)
	local s = math.clamp(height * 0.28, 0.8, 12)
	local top = egg:GetPivot().Position + Vector3.new(0, height * 0.5 + s * 1.2, 0)
	local ball = Instance.new("Model")
	ball.Name = "ConcertDisco"
	local function piece(size, offset, color, mat)
		local p = Instance.new("Part")
		p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
		p.Size, p.Color, p.Material = size, color, mat or Enum.Material.Plastic
		p.CFrame = CFrame.new(top + offset)
		studs(p)
		p.Parent = ball
		return p
	end
	local core = piece(Vector3.one * s, Vector3.zero, Color3.fromRGB(200, 205, 220), Enum.Material.Metal)
	piece(Vector3.new(s * 1.12, s * 0.35, s * 0.35), Vector3.zero, Color3.fromRGB(235, 240, 255), Enum.Material.Metal)
	piece(Vector3.new(s * 0.35, s * 0.35, s * 1.12), Vector3.zero, Color3.fromRGB(235, 240, 255), Enum.Material.Metal)
	piece(Vector3.new(s * 0.1, s * 0.9, s * 0.1), Vector3.new(0, s * 0.9, 0), Color3.fromRGB(40, 40, 45))
	ball.PrimaryPart = core
	local light = Instance.new("PointLight")
	light.Name = "ConcertLight"
	light.Color, light.Range, light.Brightness = PINK, 10 + height * 2, 3
	light.Parent = core
	local sparkle = Instance.new("ParticleEmitter")
	sparkle.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	sparkle.Color = Config.Gradients.Like
	sparkle.LightEmission = 1
	sparkle.Rate = 10 + math.min(height, 20)
	sparkle.Lifetime = NumberRange.new(0.8, 1.6)
	sparkle.Speed = NumberRange.new(2, 5)
	sparkle.SpreadAngle = Vector2.new(180, 180)
	sparkle.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5 + height * 0.05), NumberSequenceKeypoint.new(1, 0)})
	sparkle.Parent = core
	ball.Parent = egg
	CollectionService:AddTag(ball, "ConcertDisco")
end

------------------------------------------------------------------ LES DANSEURS (skins Roblox)
local Players = game:GetService("Players")
local templates = {} -- [nom] = modèle R15 prêt à cloner
local function loadTemplates()
	for _, name in DANCERS do
		if not templates[name] then
			local ok, model = pcall(function()
				local id = Players:GetUserIdFromNameAsync(name)
				return Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(id), Enum.HumanoidRigType.R15)
			end)
			if ok and model then
				model.Name = name
				for _, d in model:GetDescendants() do if d:IsA("Script") or d:IsA("LocalScript") then d:Destroy() end end
				templates[name] = model
			else
				warn("[ConcertEvent] skin de " .. name .. " introuvable : " .. tostring(model))
			end
		end
	end
end
task.spawn(loadTemplates) -- prépare les skins dès le démarrage du serveur

-- les zones dans l'ordre du parcours : de la zone Common (début de la map) jusqu'à la dernière
local function zoneParts()
	local list = {}
	for _, z in CollectionService:GetTagged("EggZoneArea") do
		if z:IsA("BasePart") and z.Parent == workspace then table.insert(list, z) end
	end
	table.sort(list, function(a, b) return a.Position.X < b.Position.X end)
	return list
end
local function randomPoint(zone, margin)
	local half = zone.Size / 2
	return Vector3.new(zone.Position.X + (math.random() * 2 - 1) * (half.X - margin), zone.Position.Y + half.Y, zone.Position.Z + (math.random() * 2 - 1) * (half.Z - margin))
end

-- nuage d'étoiles quand un danseur apparaît / disparaît
local function poof(position)
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.Transparency = true, false, false, false, 1
	p.Size = Vector3.one
	p.Position = position
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	e.Color = Config.Gradients.Like
	e.LightEmission = 1
	e.Rate = 0
	e.Lifetime = NumberRange.new(0.6, 1.2)
	e.Speed = NumberRange.new(8, 18)
	e.SpreadAngle = Vector2.new(180, 180)
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 0)})
	e.Parent = p
	p.Parent = workspace
	e:Emit(40)
	game:GetService("Debris"):AddItem(p, 2)
end

-- J'AIME qui vole en cloche de la main du danseur jusqu'à l'oeuf
local LIKE_ICONS = {"❤", "👍", "❤", "💖"}
local function throwLike(from, egg)
	local height = egg:GetAttribute("Height") or 3
	local to = egg:GetPivot().Position + Vector3.new(0, height * 0.3, 0)
	local holder = Instance.new("Part")
	holder.Anchored, holder.CanCollide, holder.CanQuery, holder.CanTouch, holder.Transparency = true, false, false, false, 1
	holder.Size = Vector3.one
	holder.Position = from
	local bb = Instance.new("BillboardGui")
	bb.Size = UDim2.fromScale(7 + height * 0.3, 7 + height * 0.3)
	bb.LightInfluence = 0
	bb.MaxDistance = 400
	local icon = Instance.new("TextLabel")
	icon.BackgroundTransparency = 1
	icon.Size = UDim2.fromScale(1, 1)
	icon.TextScaled = true
	icon.Text = LIKE_ICONS[math.random(#LIKE_ICONS)]
	icon.TextColor3 = Color3.fromRGB(255, 70, 130)
	icon.Parent = bb
	bb.Parent = holder
	local trail = Instance.new("ParticleEmitter")
	trail.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	trail.Color = Config.Gradients.Like
	trail.LightEmission = 1
	trail.Rate = 40
	trail.Lifetime = NumberRange.new(0.3, 0.6)
	trail.Speed = NumberRange.new(0, 1)
	trail.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.8), NumberSequenceKeypoint.new(1, 0)})
	trail.Parent = holder
	holder.Parent = workspace
	local dist = (to - from).Magnitude
	local duration = math.clamp(dist / 45, 0.5, 1.4)
	local arc = math.clamp(dist * 0.35, 4, 25)
	local t = 0
	while t < duration do
		t += task.wait()
		local k = math.min(1, t / duration)
		holder.Position = from:Lerp(to, k) + Vector3.new(0, math.sin(k * math.pi) * arc, 0)
	end
	trail.Enabled = false
	bb.Enabled = false
	game:GetService("Debris"):AddItem(holder, 0.7)
	-- impact : le j'aime a LIKE_CHANCE de donner le trait
	if not validEgg(egg) then return end
	local success = math.random() < LIKE_CHANCE
	fxRemote:FireAllClients("result", to, height, success)
	if success then
		applyConcert(egg)
		local info = Config.Eggs[egg:GetAttribute("EggKey")]
		local zonePart = egg.Parent and workspace:FindFirstChild(egg.Parent.Name)
		local zoneName = zonePart and zonePart:GetAttribute("ZoneTitle") or (egg.Parent and egg.Parent.Name) or "a zone"
		notifyRemote:FireAllClients("LIKE TRAIT! A " .. (info and info.Name or "egg") .. " got x5 in the " .. zoneName .. "!")
	else
		poof(to)
	end
end

-- l'oeuf valide le plus proche d'un point (dans la zone où se trouve le danseur)
local function nearestEgg(zone, position)
	local zoneEggs = workspace:FindFirstChild("ZoneEggs")
	local folder = zoneEggs and zoneEggs:FindFirstChild(zone.Name)
	if not folder then return nil end
	local best, bestDist = nil, LIKE_RANGE
	for _, e in folder:GetChildren() do
		if validEgg(e) then
			local d = (e:GetPivot().Position - position).Magnitude
			if d < bestDist and math.random() < 0.8 then best, bestDist = e, d end
		end
	end
	return best
end

local dancersFolder
local function spawnDancer(name, zone, start)
	local template = templates[name]
	if not template then return nil end
	local rig = template:Clone()
	pcall(function() rig:ScaleTo(SCALE) end) -- danseur géant
	local hum = rig:FindFirstChildOfClass("Humanoid")
	local root = rig:FindFirstChild("HumanoidRootPart")
	if not hum or not root then rig:Destroy() return nil end
	hum.DisplayName = "🎤 " .. name
	hum.WalkSpeed = 16 * 2
	hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
	hum.BreakJointsOnDeath = false
	start = start or randomPoint(zone, 10)
	rig:PivotTo(CFrame.new(start + Vector3.new(0, 3 * SCALE, 0)))
	rig.Parent = dancersFolder
	pcall(function() root:SetNetworkOwner(nil) end)
	poof(start + Vector3.new(0, 3, 0))
	local animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
	local function load(id, priority, looped)
		local a = Instance.new("Animation")
		a.AnimationId = id
		local ok, track = pcall(function() return animator:LoadAnimation(a) end)
		if not ok then return nil end
		track.Priority = priority
		track.Looped = looped
		return track
	end
	local d = {name = name, rig = rig, hum = hum, root = root, zone = zone}
	d.idle = load(ANIMS.Idle, Enum.AnimationPriority.Idle, true)
	d.walk = load(ANIMS.Walk, Enum.AnimationPriority.Movement, true)
	d.throw = load(ANIMS.Throw, Enum.AnimationPriority.Action, false)
	d.dances = {}
	for _, id in ANIMS.Dance do
		local t = load(id, Enum.AnimationPriority.Action, true)
		if t then table.insert(d.dances, t) end
	end
	if d.idle then d.idle:Play() end
	-- animation de marche quand il avance
	hum.Running:Connect(function(speed)
		if not d.walk then return end
		if speed > 0.5 then
			if not d.walk.IsPlaying then d.walk:Play(0.15) end
			d.walk:AdjustSpeed(speed / (16 * math.sqrt(SCALE))) -- grandes jambes : pas plus lents
		elseif d.walk.IsPlaying then
			d.walk:Stop(0.2)
		end
	end)
	return d
end

local function despawnDancer(d)
	if d.rig.Parent then
		poof(d.root.Position)
		d.rig:Destroy()
	end
end

-- position de chaque danseur dans le groupe : côte à côte autour du point visé
local function formation(target, index, count)
	return target + Vector3.new((index - (count + 1) / 2) * SPACING, 0, 0)
end

-- le GROUPE : ils restent ensemble dans la même zone et avancent vers le même endroit, arrêt après arrêt
local function groupLoop(group)
	local zones = zoneParts()
	local zone = group[1].zone
	while alive() do
		for _ = 1, STOPS_PER_ZONE do
			if not alive() then return end
			-- tout le groupe marche vers le même endroit
			local target = randomPoint(zone, 22 + SPACING)
			for i, d in group do d.hum:MoveTo(formation(target, i, #group)) end
			local walked = 0
			while walked < 7 and alive() do
				walked += task.wait(0.2)
				local moving = false
				for _, d in group do if d.hum.MoveDirection.Magnitude > 0.05 then moving = true end end
				if not moving and walked > 0.6 then break end
			end
			for _, d in group do
				d.hum:MoveTo(d.root.Position)
				if d.walk and d.walk.IsPlaying then d.walk:Stop(0.15) end
			end
			if not alive() then return end
			-- ils dansent ensemble (chacun sa danse)
			for _, d in group do
				d.dance = #d.dances > 0 and d.dances[math.random(#d.dances)] or nil
				if d.dance then d.dance:Play(0.2) end
			end
			local danced, danceTime = 0, 2.5 + math.random() * 1.5
			while danced < danceTime and alive() do
				danced += task.wait(0.1)
				for _, d in group do if d.walk and d.walk.IsPlaying then d.walk:Stop(0.1) end end
			end
			for _, d in group do if d.dance then d.dance:Stop(0.2) end end
			if not alive() then return end
			-- chacun lance un ou deux j'aime sur les oeufs autour du groupe
			local throws = {}
			for _, d in group do
				table.insert(throws, task.spawn(function()
					for _ = 1, math.random(1, 2) do
						local egg = nearestEgg(zone, d.root.Position)
						if not egg or not alive() then break end
						local look = egg:GetPivot().Position
						d.root.CFrame = CFrame.lookAt(d.root.Position, Vector3.new(look.X, d.root.Position.Y, look.Z))
						if d.throw then d.throw:Play(0.05) end
						task.wait(0.25)
						local hand = d.rig:FindFirstChild("RightHand")
						task.spawn(throwLike, hand and hand.Position or (d.root.Position + Vector3.new(0, 2 * SCALE, 0)), egg)
						task.wait(0.7)
					end
				end))
			end
			task.wait(1.8)
		end
		-- tout le groupe disparaît et réapparaît ensemble dans une autre zone
		if not alive() then return end
		if #zones > 1 then
			-- zone suivante dans l'ordre ; après la dernière, ils reviennent au début (zone Common)
			local index = table.find(zones, zone) or 0
			zone = zones[index + 1] or zones[1]
			local center = randomPoint(zone, 22 + SPACING)
			for i, d in group do
				poof(d.root.Position)
				d.zone = zone
				local p = formation(center, i, #group)
				d.rig:PivotTo(CFrame.new(p + Vector3.new(0, 3 * SCALE, 0)))
				poof(p + Vector3.new(0, 3 * SCALE, 0))
			end
		end
	end
end

-- (ancienne boucle d'un danseur seul, plus utilisée)
local function dancerLoop(d)
	local zones = zoneParts()
	while alive() and d.rig.Parent do
		for _ = 1, STOPS_PER_ZONE do
			if not alive() then return end
			-- il marche vers un endroit de la zone
			d.hum:MoveTo(randomPoint(d.zone, 12))
			local walked = 0
			while walked < 5 and alive() do
				walked += task.wait(0.2)
				if d.hum.MoveDirection.Magnitude < 0.05 and walked > 0.6 then break end
			end
			d.hum:Move(Vector3.zero)
			d.hum:MoveTo(d.root.Position) -- il s'arrête net
			if d.walk and d.walk.IsPlaying then d.walk:Stop(0.15) end
			if not alive() then return end
			-- il danse
			local dance = #d.dances > 0 and d.dances[math.random(#d.dances)]
			if dance then dance:Play(0.2) end
			local danced = 0
			local danceTime = 2 + math.random() * 1.5
			while danced < danceTime and alive() do
				danced += task.wait(0.1)
				if d.walk and d.walk.IsPlaying then d.walk:Stop(0.1) end -- pas de pas de marche pendant la danse
			end
			if dance then dance:Stop(0.2) end
			if not alive() then return end
			-- il lance un ou deux j'aime sur les oeufs proches
			for _ = 1, math.random(1, 2) do
				local egg = nearestEgg(d.zone, d.root.Position)
				if not egg then break end
				local look = egg:GetPivot().Position
				d.root.CFrame = CFrame.lookAt(d.root.Position, Vector3.new(look.X, d.root.Position.Y, look.Z))
				if d.throw then d.throw:Play(0.05) end
				task.wait(0.25)
				local hand = d.rig:FindFirstChild("RightHand")
				task.spawn(throwLike, hand and hand.Position or (d.root.Position + Vector3.new(0, 2, 0)), egg)
				task.wait(0.6)
			end
		end
		-- il disparaît et réapparaît dans une autre zone au hasard
		if not alive() then return end
		if #zones > 1 then
			local nextZone = d.zone
			while nextZone == d.zone do nextZone = zones[math.random(#zones)] end
			poof(d.root.Position)
			d.zone = nextZone
			local p = randomPoint(nextZone, 10)
			d.rig:PivotTo(CFrame.new(p + Vector3.new(0, 4, 0)))
			poof(p + Vector3.new(0, 3, 0))
		end
	end
end

------------------------------------------------------------------ EVENT
local function runEvent(duration)
	if running then return end
	running, stopRequested = true, false
	endAt = workspace:GetServerTimeNow() + duration
	ReplicatedStorage:SetAttribute("ConcertEventEnd", endAt)
	ReplicatedStorage:SetAttribute("ConcertTime", true) -- les clients allument les lumières, la musique et le HUD
	local dancers = {}
	local ok, err = pcall(function()
		loadTemplates()
		dancersFolder = Instance.new("Folder")
		dancersFolder.Name = "ConcertDancers"
		dancersFolder.Parent = workspace
		task.wait(2) -- intro : les lumières s'allument
		-- les danseurs arrivent ensemble, côte à côte, dans la première zone (Common)
		local zones = zoneParts()
		if #zones > 0 then
			local zone = zones[1]
			local center = randomPoint(zone, 22 + SPACING)
			for i, name in DANCERS do
				local d = spawnDancer(name, zone, formation(center, i, #DANCERS))
				if d then table.insert(dancers, d) end
			end
			if #dancers > 0 then
				task.spawn(function()
					local ok2, e2 = pcall(groupLoop, dancers)
					if not ok2 then warn("[ConcertEvent] groupe : " .. tostring(e2)) end
				end)
			end
		end
		while alive() do task.wait(0.5) end
	end)
	if not ok then warn("[ConcertEvent] " .. tostring(err)) end
	for _, d in dancers do pcall(despawnDancer, d) end
	if dancersFolder then dancersFolder:Destroy() dancersFolder = nil end
	ReplicatedStorage:SetAttribute("ConcertTime", nil)
	ReplicatedStorage:SetAttribute("ConcertEventEnd", nil)
	running, stopRequested = false, false
end

------------------------------------------------------------------ COMMANDE ADMIN + TOUS LES SERVEURS
local function handle(action, duration)
	if action == "start" then
		if running then return end
		announceRemote:FireAllClients("EVENT", "CONCERT TIME! Rexydev1, Nono275er and Kinoshi112 are throwing LIKES on eggs in ALL zones (x5 trait) for " .. describe(duration) .. "!", 0)
		task.spawn(runEvent, duration)
	elseif action == "stop" then
		stopRequested = true
	end
end

pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) == "table" then
			handle(data.action, math.clamp(tonumber(data.duration) or 600, MIN_DURATION, MAX_DURATION))
		end
	end)
end)

startRemote.OnServerEvent:Connect(function(player, action, duration, scope) -- scope "server" = ce serveur seulement
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	if action ~= "start" and action ~= "stop" then return end
	duration = math.clamp(tonumber(duration) or 600, MIN_DURATION, MAX_DURATION)
	if action == "start" and running then
		notifyRemote:FireClient(player, "The concert is already running")
		return
	end
	local ok = scope ~= "server" and pcall(function() MessagingService:PublishAsync(TOPIC, {action = action, duration = duration}) end)
	if not ok then handle(action, duration) end
	notifyRemote:FireClient(player, action == "start" and ("Concert started (" .. describe(duration) .. ")") or "Concert stopped")
end)
