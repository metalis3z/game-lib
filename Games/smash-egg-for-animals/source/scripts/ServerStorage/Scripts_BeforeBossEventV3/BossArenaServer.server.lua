-- BossArenaServer : le combat contre le Headless dans l'arène (Workspace.BossArena), lancé à la fin de la cinématique
-- Samouraï (SamuraiFilmServer -> GameBindables.StartBossArena:Fire(joueurs)).
--   * le boss : le Headless de la cinématique (FightFilm.Cast), 10 fois la taille d'un joueur, 10 000 PV ; la batte le blesse
--   * toutes les SLAM_EVERY s il frappe le sol : une onde part de lui et traverse toute l'arène en WAVE_TIME s ; il faut sauter
--   * sous la moitié de ses PV, toutes les SNAP_EVERY s il claque des doigts : des mini robots tirent un laser toutes les
--     LASER_EVERY s (LASER_DAMAGE PV sur 100), puis s'autodétruisent au bout de ROBOT_LIFE s (la batte les détruit aussi)
-- Le serveur décide de tout (PV, dégâts, déplacements) ; les effets visuels sont joués par chaque joueur (BossArenaClient,
-- remote BossArena.Fx) et le boss est animé chez chaque joueur à partir de ses attributs (Action, Move*, FaceTo...).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")

local CONFIG = {
	MaxHp = 10000, BatDamage = 50, BatReach = 11, BatCooldown = 0.42, -- (un coup toutes les 0,5 s côté joueur, un peu de marge pour le réseau)
	BossScale = 7, WalkSpeed = 13, TeleportEvery = {20, 30},
	SlamEvery = 15, SlamWindup = 1.3, WaveTime = 5, WaveDamage = 25, WaveThickness = 5, SafeJump = 3.2,
	SnapEvery = 30, RobotsPerSnap = 3, MaxRobots = 6, RobotLife = 10, LaserEvery = 3, LaserDamage = 10,
	MaxTime = 360, EmptyEnd = 4,
}

local arena = workspace:WaitForChild("BossArena")
local C = arena:GetAttribute("Center")
local FLOOR_R = arena:GetAttribute("FloorRadius") or 170
local shared = ReplicatedStorage:WaitForChild("BossArena")
local fxRemote = shared:WaitForChild("Fx")
local Cast = require(ReplicatedStorage:WaitForChild("FightFilm"):WaitForChild("Cast"))
local knockRemote = ReplicatedStorage:WaitForChild("HammerSystem"):WaitForChild("Knock")
local batRemote = ReplicatedStorage:WaitForChild("HammerSystem"):WaitForChild("BatHit")
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local giveZonePet = game:GetService("ServerStorage"):WaitForChild("GameBindables"):WaitForChild("GiveZonePet")
-- récompense selon la place au classement des dégâts : les 7 animaux de la zone Halloween, du meilleur au plus faible
local REWARDS = {"Kraken", "Leviathan", "Megalodon", "Crocodile", "Jellyfish", "Moth", "Bat"}
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")
local startEvent = ServerStorage:WaitForChild("GameBindables"):WaitForChild("StartBossArena")

local rad = math.rad
local function now() return workspace:GetServerTimeNow() end
local function flat(v) return Vector3.new(v.X, 0, v.Z) end

local fight -- nil quand aucun combat
shared:SetAttribute("Active", false)

---------------------------------------------------------------- joueurs
local function rootOf(player)
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if root and humanoid and humanoid.Health > 0 then return root, humanoid end
end
local function inArena(player) return fight and fight.players[player] and player:GetAttribute("InBossArena") == true and rootOf(player) ~= nil end
local function arenaPlayers()
	local list = {}
	if not fight then return list end
	for player in fight.players do if inArena(player) then table.insert(list, player) end end
	return list
end

-- retour au jeu : sur la plaque entre les deux boutiques (comme après la nuit)
local function homePoint()
	local a, b = workspace:FindFirstChild("egg shop"), workspace:FindFirstChild("dragon shop")
	if a and b then
		local mid = (a:GetBoundingBox().Position + b:GetBoundingBox().Position) / 2
		local hit = workspace:Raycast(Vector3.new(mid.X - 22, mid.Y + 60, mid.Z), Vector3.new(0, -200, 0))
		return Vector3.new(mid.X - 22, hit and hit.Position.Y or 0, mid.Z)
	end
	local safe = workspace:FindFirstChild("safe zone") -- (les boutiques n'existent plus : au milieu de la zone sûre)
	if safe then return safe.Position + Vector3.new(0, safe.Size.Y / 2, 0) end
	return Vector3.new(0, 5, 0)
end
local function moveCharacter(player, cf)
	local dragons = workspace:FindFirstChild("Dragons")
	for _, dragon in dragons and dragons:GetChildren() or {} do
		if dragon:GetAttribute("Rider") == player.UserId and dragon.PrimaryPart then
			dragon:PivotTo(cf + Vector3.new(0, 3, 0))
			dragon.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
			return
		end
	end
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if root then
		root.AssemblyLinearVelocity = Vector3.zero
		character:PivotTo(cf + Vector3.new(0, 4, 0))
	end
end
local function sendHome(player, index)
	player:SetAttribute("InBossArena", nil)
	local p = homePoint() + Vector3.new(-(index % 4) * 7, 0, ((index // 4) % 5 - 2) * 7)
	moveCharacter(player, CFrame.new(p))
end

---------------------------------------------------------------- le boss
local boss -- {model, hrp, pos, move = {from, to, t0, dur}, busyUntil}
local function bossPos()
	local m = boss.move
	if m then
		local k = math.clamp((now() - m.t0) / m.dur, 0, 1)
		return m.from:Lerp(m.to, k * k * (3 - 2 * k))
	end
	return boss.pos
end
local function setAction(name, dur)
	boss.model:SetAttribute("Action", name)
	boss.model:SetAttribute("ActionT", now())
	if dur then boss.busyUntil = now() + dur end
end
local function buildBoss()
	local model, welds, stump = Cast.headless()
	model.Name = "ArenaHeadless"
	local gs, gsRoot = Cast.greatsword()
	for _, p in gs:GetDescendants() do if p:IsA("BasePart") then p.Parent = model end end
	local gw = Instance.new("Weld")
	gw.Name = "SwordGrip"
	gw.Part0, gw.Part1 = model["Right Arm"], gsRoot
	gw.C0 = CFrame.new(0, -1.75, 0) * CFrame.Angles(rad(-55), 0, 0)
	gw.C1 = CFrame.new(Cast.GREATSWORD_GRIP)
	gw.Parent = gsRoot
	gs:Destroy()
	model:ScaleTo(CONFIG.BossScale)
	model.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
	local hrp = model.PrimaryPart
	local legLen = model["Right Leg"].Size.Y
	local torsoHalf = model.Torso.Size.Y / 2
	model:SetAttribute("Height", legLen + torsoHalf)
	model:SetAttribute("MaxHp", CONFIG.MaxHp)
	model:SetAttribute("Hp", CONFIG.MaxHp)
	-- aura et lumière violettes
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = Color3.fromRGB(190, 90, 255), 90, 3, false
	light.Parent = model.Torso
	local outline = Instance.new("Highlight") -- contour violet : on le voit bien dans la nuit de l'arène
	outline.FillColor, outline.FillTransparency = Color3.fromRGB(120, 40, 200), 0.85
	outline.OutlineColor, outline.OutlineTransparency = Color3.fromRGB(220, 140, 255), 0.1
	outline.DepthMode = Enum.HighlightDepthMode.Occluded
	outline.Parent = model
	local start = arena.Spawns.BossSpot.Position
	local pos = Vector3.new(start.X, C.Y, start.Z)
	model:PivotTo(CFrame.lookAt(pos + Vector3.new(0, legLen + torsoHalf, 0), pos + Vector3.new(0, legLen + torsoHalf, 1)))
	model.Parent = workspace
	return {model = model, hrp = hrp, height = legLen + torsoHalf, radius = model.Torso.Size.X / 2 + 2, pos = pos, busyUntil = 0}
end
local function stopMove()
	if not boss then return end
	local p = bossPos()
	boss.move = nil
	boss.pos = p
	boss.model:SetAttribute("MoveFrom", p)
	boss.model:SetAttribute("MoveTo", p)
	boss.model:SetAttribute("MoveT0", now())
	boss.model:SetAttribute("MoveDur", 0.01)
	boss.hrp.CFrame = CFrame.new(p + Vector3.new(0, boss.height, 0)) * (boss.hrp.CFrame - boss.hrp.Position)
end
local function randomPoint(minFrom, maxFrom)
	local from = bossPos()
	for _ = 1, 40 do
		local a = math.random() * math.pi * 2
		local r = math.sqrt(math.random()) * (FLOOR_R - 45)
		local p = Vector3.new(C.X + math.cos(a) * r, C.Y, C.Z + math.sin(a) * r)
		local d = flat(p - from).Magnitude
		if d >= (minFrom or 30) and d <= (maxFrom or math.huge) then return p end
	end
	return Vector3.new(C.X, C.Y, C.Z)
end
local function moveBoss(to, dur)
	local from = bossPos()
	boss.move = {from = from, to = to, t0 = now(), dur = dur}
	boss.model:SetAttribute("MoveFrom", from)
	boss.model:SetAttribute("MoveTo", to)
	boss.model:SetAttribute("MoveT0", now())
	boss.model:SetAttribute("MoveDur", dur)
	setAction("walk")
	task.delay(dur, function()
		if not boss or boss.move == nil or boss.move.to ~= to then return end
		boss.pos = to
		boss.move = nil
		boss.hrp.CFrame = CFrame.new(to + Vector3.new(0, boss.height, 0)) * (boss.hrp.CFrame - boss.hrp.Position)
		if boss.model:GetAttribute("Action") == "walk" then setAction("idle") end
	end)
end

---------------------------------------------------------------- ce que dit le boss (bulle au-dessus de lui, BossArenaClient)
local LINES = {
	start = {"You dare enter MY arena?!", "Welcome to your grave, mortals!"},
	hit = {"AÏE!", "OUCH!", "Is that all you've got?!", "ARGH! You'll pay for that!", "Insolent worm!", "That... tickles."},
	slam = {"FEEL THE GROUND SHAKE!", "JUMP, LITTLE ONES!", "KNEEL BEFORE ME!"},
	teleport = {"Catch me if you can...", "Too slow!", "Over here, fools!"},
	snap = {"Machines... ATTACK!", "Rise, my little monsters!"},
	enraged = {"ENOUGH! Now you'll see my true power!"},
	low = {"No... I will NOT fall here!"},
	critical = {"IMPOSSIBLE! How are you still standing?!"},
	death = {"No... this can't be... AAAAARGH!"},
	win = {"Pathetic. Come back when you're stronger."},
}
local lastLine = 0
local function say(kind, force)
	local list = LINES[kind]
	if not list then return end
	if not force and now() - lastLine < 3 then return end
	lastLine = now()
	local colors = {
		hit = {Color3.fromRGB(255, 120, 120), Color3.fromRGB(255, 220, 120)},
		death = {Color3.fromRGB(255, 80, 80), Color3.fromRGB(190, 90, 255)},
	}
	fxRemote:FireAllClients({k = "say", text = list[math.random(#list)], colors = colors[kind], t = kind == "death" and 3.5 or 2.4})
end

---------------------------------------------------------------- dégâts aux joueurs
local function hurt(player, amount, push)
	local root, humanoid = rootOf(player)
	if not root then return end
	humanoid:TakeDamage(amount)
	if push then knockRemote:FireClient(player, push) end
end

---------------------------------------------------------------- l'onde (coup au sol)
local function slam()
	stopMove()
	setAction("slam", CONFIG.SlamWindup + 1.2)
	say("slam", true)
	fxRemote:FireAllClients({k = "banner", text = "JUMP OVER THE WAVE!", color = Color3.fromRGB(255, 200, 90), t = 1.6})
	task.wait(CONFIG.SlamWindup)
	if not fight then return end
	local origin = bossPos()
	local speed = (FLOOR_R + 5) / CONFIG.WaveTime
	local t0 = now()
	fxRemote:FireAllClients({k = "wave", o = origin, t0 = t0, speed = speed, dur = CONFIG.WaveTime})
	local hit = {}
	while fight and now() - t0 < CONFIG.WaveTime do
		local r = (now() - t0) * speed
		for _, player in arenaPlayers() do
			if not hit[player] then
				local root = rootOf(player)
				local d = flat(root.Position - origin).Magnitude
				local above = root.Position.Y - C.Y - 3 -- hauteur au-dessus de la pose debout
				if math.abs(d - r) < CONFIG.WaveThickness and above < CONFIG.SafeJump then
					hit[player] = true
					local away = flat(root.Position - origin)
					away = away.Magnitude > 0.1 and away.Unit or Vector3.new(0, 0, 1)
					hurt(player, CONFIG.WaveDamage, away * 70 + Vector3.new(0, 45, 0))
					fxRemote:FireAllClients({k = "hit", p = root.Position})
				end
			end
		end
		RunService.Heartbeat:Wait()
	end
end

---------------------------------------------------------------- mini robots (phase 2)
local robots = {}
local RGB = Color3.fromRGB
local function buildRobot()
	local model = Instance.new("Model")
	model.Name = "MiniRobot"
	local function p(size, color, mat, shape, cf, neon)
		local part = Instance.new("Part")
		part.Size, part.Color = size, color
		part.Material = neon and Enum.Material.Neon or (mat or Enum.Material.Metal)
		if shape then part.Shape = shape end
		part.CanCollide, part.CanQuery, part.CanTouch, part.CastShadow = false, false, false, false
		part.Anchored = false
		part.Massless = true
		part.Parent = model
		return part, cf
	end
	local body = Instance.new("Part")
	body.Name = "Body"
	body.Shape = Enum.PartType.Ball
	body.Size = Vector3.new(3, 3, 3)
	body.Color = RGB(46, 42, 58)
	body.Material = Enum.Material.Metal
	body.Anchored, body.CanCollide, body.CanQuery, body.CanTouch, body.CastShadow = true, false, false, false, false
	body.Parent = model
	model.PrimaryPart = body
	local parts = {
		{Vector3.new(3.2, 0.4, 3.2), RGB(190, 90, 255), nil, Enum.PartType.Cylinder, CFrame.Angles(0, 0, rad(90)), true},  -- anneau lumineux
		{Vector3.new(1.1, 1.1, 1.1), RGB(255, 60, 70), nil, Enum.PartType.Ball, CFrame.new(0, 0.2, -1.25), true, "Eye"},     -- oeil laser
		{Vector3.new(0.4, 1.6, 2.2), RGB(70, 64, 88), nil, nil, CFrame.new(1.7, 0, 0.2)},                                     -- ailerons
		{Vector3.new(0.4, 1.6, 2.2), RGB(70, 64, 88), nil, nil, CFrame.new(-1.7, 0, 0.2)},
		{Vector3.new(0.2, 1.4, 0.2), RGB(232, 186, 82), nil, nil, CFrame.new(0, 2, 0.3)},                                     -- antenne
		{Vector3.new(0.5, 0.5, 0.5), RGB(255, 140, 255), nil, Enum.PartType.Ball, CFrame.new(0, 2.8, 0.3), true},
		{Vector3.new(0.9, 0.6, 0.9), RGB(255, 150, 60), nil, Enum.PartType.Ball, CFrame.new(0, -1.5, 0.4), true, "Thruster"},
	}
	for _, info in parts do
		local part = p(info[1], info[2], info[3], info[4], nil, info[6])
		if info[7] then part.Name = info[7] end
		local w = Instance.new("Weld")
		w.Part0, w.Part1, w.C0 = body, part, info[5]
		w.Parent = part
	end
	local flame = Instance.new("ParticleEmitter")
	flame.Texture = "rbxasset://textures/particles/fire_main.dds"
	flame.Color = ColorSequence.new(RGB(255, 200, 120), RGB(255, 80, 30))
	flame.LightEmission, flame.Rate, flame.Lifetime = 0.8, 30, NumberRange.new(0.15, 0.3)
	flame.Speed, flame.EmissionDirection = NumberRange.new(4, 7), Enum.NormalId.Bottom
	flame.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 0)})
	flame.Parent = model.Thruster
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = RGB(255, 60, 70), 10, 1.5, false
	light.Parent = model.Eye
	model.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
	return model
end
local function destroyRobot(robot, quiet)
	if not robots[robot] then return end
	robots[robot] = nil
	if robot.Parent then
		if not quiet then fxRemote:FireAllClients({k = "boom", p = robot:GetPivot().Position, s = 1}) end
		robot:Destroy()
	end
end
local function spawnRobot(at, target)
	local robot = buildRobot()
	robot:PivotTo(CFrame.new(at))
	robot.Parent = workspace
	local info = {target = target, born = now(), nextShot = now() + 2.5, angle = math.random() * math.pi * 2, pos = at}
	robots[robot] = info
	task.spawn(function()
		while fight and robots[robot] and robot.Parent do
			local dt = RunService.Heartbeat:Wait()
			if now() - info.born >= CONFIG.RobotLife then break end
			-- cible vivante, sinon une autre
			if not inArena(info.target) then
				local list = arenaPlayers()
				info.target = list[math.random(math.max(#list, 1))]
				if not info.target then break end
			end
			local root = rootOf(info.target)
			info.angle += dt * 0.9
			local want = root.Position + Vector3.new(math.cos(info.angle) * 14, 9 + math.sin(info.angle * 2) * 1.5, math.sin(info.angle) * 14)
			info.pos = info.pos:Lerp(want, 1 - math.exp(-dt * 2.5))
			robot:PivotTo(CFrame.lookAt(info.pos, root.Position))
			if now() >= info.nextShot then
				info.nextShot = now() + CONFIG.LaserEvery
				local eye = robot:FindFirstChild("Eye")
				fxRemote:FireAllClients({k = "laser", a = eye and eye.Position or info.pos, b = root.Position})
				hurt(info.target, CONFIG.LaserDamage)
			end
		end
		destroyRobot(robot) -- autodestruction
	end)
end
local function snap()
	stopMove()
	setAction("snap", 1.4)
	say("snap", true)
	task.wait(0.55)
	if not fight then return end
	local p = bossPos() + Vector3.new(0, boss.height * 1.4, 0)
	fxRemote:FireAllClients({k = "snap", p = p})
	local count = 0
	for _ in robots do count += 1 end
	local list = arenaPlayers()
	for i = 1, math.min(CONFIG.RobotsPerSnap, CONFIG.MaxRobots - count) do
		local target = list[(i - 1) % math.max(#list, 1) + 1]
		if target then
			local a = i / CONFIG.RobotsPerSnap * math.pi * 2
			spawnRobot(p + Vector3.new(math.cos(a) * 8, 0, math.sin(a) * 8), target)
		end
	end
end

---------------------------------------------------------------- téléportation : il s'enfonce dans un trou noir et ressort d'un autre, ailleurs dans l'arène
local function teleport()
	stopMove()
	local from, to = bossPos(), randomPoint(70)
	setAction("vanish", 2.6)
	say("teleport", true)
	fxRemote:FireAllClients({k = "tp", from = from, to = to, t0 = now(), height = boss.height})
	task.wait(1.05)
	if not fight or not boss then return end
	boss.pos = to
	boss.model:SetAttribute("MoveFrom", to)
	boss.model:SetAttribute("MoveTo", to)
	boss.model:SetAttribute("MoveT0", now())
	boss.model:SetAttribute("MoveDur", 0.01)
	boss.hrp.CFrame = CFrame.new(to + Vector3.new(0, boss.height, 0)) * (boss.hrp.CFrame - boss.hrp.Position)
	setAction("appear", 1.4)
end

---------------------------------------------------------------- la batte touche le boss (ou un robot)
local lastBat = {}
batRemote.OnServerEvent:Connect(function(player)
	if not fight or not boss or not inArena(player) then return end
	local root = rootOf(player)
	if not player.Character:FindFirstChild("Bat") then return end
	if os.clock() - (lastBat[player] or 0) < CONFIG.BatCooldown then return end
	lastBat[player] = os.clock()
	-- un robot à portée ?
	for robot in robots do
		if robot.Parent and (robot:GetPivot().Position - root.Position).Magnitude < 12 then
			destroyRobot(robot)
			return
		end
	end
	local action = boss.model:GetAttribute("Action")
	if action == "vanish" or action == "appear" or action == "die" then return end -- dans le trou noir : intouchable
	local bp = bossPos()
	local d = flat(root.Position - bp).Magnitude - boss.radius
	if d > CONFIG.BatReach then return end
	local before = boss.model:GetAttribute("Hp")
	local hp = math.max(0, before - CONFIG.BatDamage)
	local max = CONFIG.MaxHp
	if before > max * 0.75 and hp <= max * 0.75 then say("hit", true)
	elseif before > max * 0.25 and hp <= max * 0.25 then say("low", true)
	elseif before > max * 0.1 and hp <= max * 0.1 then say("critical", true)
	elseif hp > 0 and math.random() < 0.18 then say("hit") end
	boss.model:SetAttribute("Hp", hp)
	boss.model:SetAttribute("HurtT", now())
	fight.damage[player] = (fight.damage[player] or 0) + CONFIG.BatDamage
	fxRemote:FireAllClients({k = "hit", p = root.Position + flat(bp - root.Position).Unit * 4 + Vector3.new(0, 3, 0), big = true, amount = CONFIG.BatDamage})
end)
Players.PlayerRemoving:Connect(function(player) lastBat[player] = nil end)

---------------------------------------------------------------- déroulé d'un combat
local function finish(win)
	if not fight then return end
	local f = fight
	fight = nil
	for _, c in f.conns or {} do c:Disconnect() end
	shared:SetAttribute("Active", false)
	for robot in robots do destroyRobot(robot, true) end
	if win then
		stopMove()
		setAction("die")
		say("death", true)
		fxRemote:FireAllClients({k = "death", p = bossPos(), t0 = now(), height = boss.height})
		fxRemote:FireAllClients({k = "banner", text = "VICTORY!", color = Color3.fromRGB(255, 220, 90), t = 5})
		fxRemote:FireAllClients({k = "boom", p = bossPos() + Vector3.new(0, boss.height, 0), s = 6})
		-- récompenses : classement aux dégâts ; le 1er gagne le meilleur animal de la zone Halloween (le Kraken), le 2e le suivant
		-- dans l'index (en partant du meilleur)... jusqu'au 7e
		local ranking = {}
		for player, dmg in f.damage do if player.Parent and dmg > 0 then table.insert(ranking, {player = player, damage = dmg}) end end
		table.sort(ranking, function(a, b) return a.damage > b.damage end)
		local lines = {}
		for rank, entry in ranking do
			local petName = REWARDS[rank]
			if not petName then break end
			local info = EggConfig.Pets[petName]
			local ok = pcall(function() return giveZonePet:Invoke(entry.player, petName) end)
			table.insert(lines, "#" .. rank .. " " .. entry.player.DisplayName .. " (" .. entry.damage .. ") : " .. (info and info.Name or petName))
			if ok then
				fxRemote:FireClient(entry.player, {k = "reward", rank = rank, pet = info and info.Name or petName, damage = entry.damage})
			end
		end
		for player in f.players do
			if player.Parent then notifyRemote:FireClient(player, "The Headless is defeated! " .. (lines[1] and table.concat(lines, "  |  ") or "")) end
		end
	else
		say("win", true)
		fxRemote:FireAllClients({k = "banner", text = "DEFEATED...", color = Color3.fromRGB(255, 90, 90), t = 4})
	end
	task.wait(win and 8 or 3)
	local index = 0
	for player in f.players do
		if player.Parent and player:GetAttribute("InBossArena") then sendHome(player, index) index += 1 end
		if player.Parent then player:SetAttribute("InBossArena", nil) end
	end
	if boss then boss.model:Destroy() boss = nil end
	shared:SetAttribute("Active", false)
end

local function start(list)
	if fight then return end
	local players = {}
	for _, player in list or Players:GetPlayers() do if player.Parent then players[player] = true end end
	if next(players) == nil then return end
	fight = {players = players, damage = {}, t0 = now()}
	boss = buildBoss()
	shared:SetAttribute("Active", true)
	-- tout le monde dans l'arène, devant l'arche du sud, face au boss
	local spawns = {}
	for _, s in arena.Spawns:GetChildren() do if s.Name == "Spawn" then table.insert(spawns, s.Position) end end
	local index = 0
	for player in players do
		index += 1
		local spot = spawns[(index - 1) % #spawns + 1]
		pcall(function() player:RequestStreamAroundAsync(spot, 5) end)
		player:SetAttribute("InBossArena", true)
		moveCharacter(player, CFrame.lookAt(spot, Vector3.new(C.X, spot.Y, C.Z)))
		local _, humanoid = rootOf(player)
		if humanoid then
			humanoid.Health = humanoid.MaxHealth
			-- la batte en main : c'est elle qui blesse le boss
			local bat = player.Backpack:FindFirstChild("Bat")
			if bat then humanoid:EquipTool(bat) end
		end
	end
	-- mort pendant le combat : on reste dans le combat et on réapparaît dans l'arène (sur une des places de départ)
	fight.conns = {}
	for player in players do
		table.insert(fight.conns, player.CharacterAdded:Connect(function(character)
			if not fight or not fight.players[player] or not player:GetAttribute("InBossArena") then return end
			task.spawn(function()
				local root = character:WaitForChild("HumanoidRootPart", 10)
				local humanoid = character:WaitForChild("Humanoid", 10)
				if not root or not humanoid or not fight then return end
				task.wait(0.15)
				local spot = spawns[math.random(1, #spawns)]
				pcall(function() player:RequestStreamAroundAsync(spot, 5) end)
				moveCharacter(player, CFrame.lookAt(spot, Vector3.new(C.X, spot.Y, C.Z)))
				humanoid.Health = humanoid.MaxHealth
				local bat = player.Backpack:WaitForChild("Bat", 4)
				if bat and humanoid.Parent then humanoid:EquipTool(bat) end
				fxRemote:FireClient(player, {k = "banner", text = "BACK IN THE FIGHT!", color = Color3.fromRGB(140, 255, 160), t = 1.8})
			end)
		end))
	end
	fxRemote:FireAllClients({k = "start"})
	setAction("roar", 2)
	task.delay(0.4, function() say("start", true) end)
	local nextSlam = now() + 6
	local nextSnap = math.huge
	local nextMove = now() + 3
	local nextTeleport = now() + math.random(CONFIG.TeleportEvery[1], CONFIG.TeleportEvery[2])
	local emptySince
	task.spawn(function()
		while fight do
			task.wait(0.2)
			if not fight then break end
			local t = now()
			-- (un joueur mort qui va réapparaître compte encore : il a toujours InBossArena)
			local still = 0
			for player in fight.players do if player.Parent and player:GetAttribute("InBossArena") then still += 1 end end
			if still == 0 then
				emptySince = emptySince or t
				if t - emptySince > CONFIG.EmptyEnd then finish(false) break end
			else
				emptySince = nil
			end
			local hp = boss.model:GetAttribute("Hp")
			if hp <= 0 then finish(true) break end
			if t - fight.t0 > CONFIG.MaxTime then finish(false) break end
			if hp <= CONFIG.MaxHp / 2 and boss.model:GetAttribute("Phase") ~= 2 then
				boss.model:SetAttribute("Phase", 2)
				fxRemote:FireAllClients({k = "banner", text = "THE HEADLESS IS ENRAGED!", color = Color3.fromRGB(255, 80, 120), t = 2.5})
				say("enraged", true)
				nextSnap = t + 2
			end
			local bp = bossPos()
			-- une marche coupée (coup au sol, claquement, téléportation) : il repart peu après, pas à la fin prévue de l'ancienne marche
			if not boss.move and nextMove > t + 4.5 then nextMove = t + 1 + math.random() * 2 end
			if t >= boss.busyUntil then
				if t >= nextSlam then
					nextSlam = t + CONFIG.SlamEvery
					task.spawn(slam) -- (slam arrête la marche lui-même)
				elseif t >= nextSnap then
					nextSnap = t + CONFIG.SnapEvery
					task.spawn(snap)
				elseif t >= nextTeleport and not boss.move then
					nextTeleport = t + math.random(CONFIG.TeleportEvery[1], CONFIG.TeleportEvery[2])
					task.spawn(teleport)
				elseif t >= nextMove and not boss.move then
					-- il se promène au hasard dans l'arène, puis s'arrête un moment (animation de repos)
					local to = randomPoint(35, 120)
					local dur = flat(to - bp).Magnitude / CONFIG.WalkSpeed
					moveBoss(to, dur)
					nextMove = t + dur + 2 + math.random() * 2.5
				end
			end
		end
	end)
end
startEvent.Event:Connect(function(list) task.spawn(start, list) end)
Players.PlayerRemoving:Connect(function(player) if fight then fight.players[player] = nil fight.damage[player] = nil end end)
