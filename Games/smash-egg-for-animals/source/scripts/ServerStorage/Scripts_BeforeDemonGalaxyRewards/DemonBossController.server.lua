-- DemonBossController : le combat jouable contre le TRUE DEMON (phase 2), sur la grande place de la ville détruite
-- (Workspace.DestroyedCity), lancé à la fin de la cinématique (DemonCinematicServer -> GameBindables.StartDemonArena).
--   * le boss : le démon de la cinématique en forme finale (FightFilm.DemonCast, ailes, 3 yeux), 12 000 PV ; la batte le blesse
--   * ses attaques sont toutes annoncées avant de frapper (on peut les éviter) :
--       onde au sol (sauter), pluie de météores (cercles rouges), coup de griffes (s'éloigner), charge (ligne rouge)
--   * sous la moitié de ses PV il s'enrage : plus rapide, attaques plus fréquentes, et des colonnes de feu filent vers chaque joueur
--   * pendant tout l'event, les joueurs vont à EventSpeed (attribut, appliqué par SpeedServer) ; mort = retour dans l'arène
--   * victoire : récompenses selon le classement aux dégâts, puis chacun rentre sur SA base ; défaite : retour aussi
-- Le serveur décide de tout (PV, dégâts, déplacements, portée et cadence des coups de batte) ; chaque joueur voit les effets et
-- anime le boss à partir de ses attributs (DemonArenaClient, remote DemonCity.ArenaFx).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")

local shared = ReplicatedStorage:WaitForChild("DemonCity")
local Config = require(shared:WaitForChild("CinematicConfig"))
local CFG = Config.Boss
local Builder = require(ServerStorage:WaitForChild("DemonCityBuilder"))
local DemonCast = require(ReplicatedStorage:WaitForChild("FightFilm"):WaitForChild("DemonCast"))
local fxRemote = shared:WaitForChild("ArenaFx")
local hammer = ReplicatedStorage:WaitForChild("HammerSystem")
local knockRemote = hammer:WaitForChild("Knock")
local batRemote = hammer:WaitForChild("BatHit")
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local bindables = ServerStorage:WaitForChild("GameBindables")
local giveZonePet = bindables:WaitForChild("GiveZonePet")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")
local startEvent = bindables:WaitForChild("StartDemonArena")

local V = Vector3.new
local C = Config.CENTER
local HALF = Config.ARENA_HALF
local function now() return workspace:GetServerTimeNow() end
local function flat(v) return V(v.X, 0, v.Z) end
local function unitOr(v, default) return v.Magnitude > 0.05 and v.Unit or default end
local function smooth(u) return u * u * (3 - 2 * u) end

local fight    -- nil quand aucun combat : {players = {[player] = true}, damage = {}, t0, conns}
local audience = {} -- les joueurs du combat (gardés jusqu'à la toute fin, même pendant la victoire)
shared:SetAttribute("FightActive", false)

local function fxAll(data)
	for player in audience do
		if player.Parent then fxRemote:FireClient(player, data) end
	end
end

---------------------------------------------------------------- joueurs
local function rootOf(player)
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if root and humanoid and humanoid.Health > 0 then return root, humanoid end
end
local function inArena(player)
	return fight ~= nil and fight.players[player] and player:GetAttribute("InDemonArena") == true and rootOf(player) ~= nil
end
local function arenaPlayers()
	local list = {}
	if not fight then return list end
	for player in fight.players do if inArena(player) then table.insert(list, player) end end
	return list
end

-- retour au jeu : sur SA base (sinon au milieu de la zone sûre)
local function homePoint()
	local safe = workspace:FindFirstChild("safe zone")
	if safe then return safe.Position + V(0, safe.Size.Y / 2, 0) end
	return V(0, 5, 0)
end
local function moveCharacter(player, cf)
	local dragons = workspace:FindFirstChild("Dragons")
	for _, dragon in dragons and dragons:GetChildren() or {} do
		if dragon:GetAttribute("Rider") == player.UserId and dragon.PrimaryPart then
			dragon:PivotTo(cf + V(0, 3, 0))
			dragon.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
			return
		end
	end
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if root then
		root.AssemblyLinearVelocity = Vector3.zero
		character:PivotTo(cf + V(0, 4, 0))
	end
end
local function baseSpawn(player)
	local bases = workspace:FindFirstChild("all base")
	local base = bases and bases:FindFirstChild("base " .. tostring(player:GetAttribute("BaseNumber")))
	local spot = base and (base:FindFirstChild("Spawn") or base:FindFirstChild("animaux"))
	if not spot then return nil end
	return (spot:IsA("Model") and spot:GetPivot().Position or spot.Position) + V(0, 3, 0)
end
local function sendHome(player, index)
	player:SetAttribute("InDemonArena", nil)
	player:SetAttribute("EventSpeed", nil)
	local p = baseSpawn(player) or (homePoint() + V(-(index % 4) * 7, 0, ((index // 4) % 5 - 2) * 7))
	pcall(function() player:RequestStreamAroundAsync(p, 5) end)
	moveCharacter(player, CFrame.new(p))
end

---------------------------------------------------------------- le boss
local boss -- {model, hrp, height, radius, pos, move = {from, to, t0, dur, linear}, busyUntil}
local function bossPos()
	local m = boss.move
	if m then
		local u = math.clamp((now() - m.t0) / m.dur, 0, 1)
		return m.from:Lerp(m.to, m.linear and u or smooth(u))
	end
	return boss.pos
end
local function phase() return boss and boss.model:GetAttribute("Phase") or 1 end
local function setAction(name, dur)
	boss.model:SetAttribute("Action", name)
	boss.model:SetAttribute("ActionT", now())
	if dur then boss.busyUntil = now() + dur end
end
local function placeHrp(p)
	boss.hrp.CFrame = CFrame.new(p + V(0, boss.height, 0)) * (boss.hrp.CFrame - boss.hrp.Position)
end
local function setMove(from, to, dur, linear)
	boss.model:SetAttribute("MoveFrom", from)
	boss.model:SetAttribute("MoveTo", to)
	boss.model:SetAttribute("MoveT0", now())
	boss.model:SetAttribute("MoveDur", dur)
	boss.model:SetAttribute("MoveLinear", linear == true)
end
local lastFace
local function faceTo(point)
	point = V(point.X, C.Y, point.Z)
	if lastFace and (lastFace - point).Magnitude < 4 then return end
	lastFace = point
	boss.model:SetAttribute("Face", point)
end
local function faceDir()
	local f = boss.model:GetAttribute("Face")
	return unitOr(flat((f or bossPos() + V(0, 0, 1)) - bossPos()), V(0, 0, 1))
end
local function clampToArena(p)
	local m = HALF - boss.radius - 2
	return V(math.clamp(p.X, C.X - m, C.X + m), C.Y, math.clamp(p.Z, C.Z - m, C.Z + m))
end
local function randomPoint()
	local m = HALF - 8
	return V(C.X + (math.random() * 2 - 1) * m, C.Y, C.Z + (math.random() * 2 - 1) * m)
end
local function stopMove()
	if not boss then return end
	local p = bossPos()
	boss.move = nil
	boss.pos = p
	setMove(p, p, 0.01)
	placeHrp(p)
end
local function moveBoss(to, dur, linear)
	local from = bossPos()
	boss.move = {from = from, to = to, t0 = now(), dur = math.max(dur, 0.05), linear = linear}
	setMove(from, to, math.max(dur, 0.05), linear)
	if not linear then setAction("walk") end
	local mine = boss.move
	task.delay(dur, function()
		if not boss or boss.move ~= mine then return end
		boss.pos = to
		boss.move = nil
		placeHrp(to)
		if boss.model:GetAttribute("Action") == "walk" then setAction("idle") end
	end)
end

local function buildBoss()
	local model = DemonCast.demon({Scale = CFG.Scale, True = true, Name = "TrueDemonBoss"})
	model.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
	local hrp = model.PrimaryPart
	local stand = model:GetAttribute("Stand")
	model:SetAttribute("MaxHp", CFG.MaxHp)
	model:SetAttribute("Hp", CFG.MaxHp)
	model:SetAttribute("Phase", 1)
	model:SetAttribute("Height", stand)
	local outline = Instance.new("Highlight") -- contour rouge : on le voit bien dans la fumée
	outline.Name = "DemonOutline"
	outline.FillColor, outline.FillTransparency = Color3.fromRGB(255, 40, 30), 1
	outline.OutlineColor, outline.OutlineTransparency = Color3.fromRGB(255, 70, 40), 0.15
	outline.DepthMode = Enum.HighlightDepthMode.Occluded
	outline.Parent = model
	local city = Builder.get()
	local spotPart = city:FindFirstChild("BossArena") and city.BossArena:FindFirstChild("BossSpot")
	local spot = spotPart and spotPart.Position or (C + Config.Points.BossSpot)
	local pos = V(spot.X, C.Y, spot.Z)
	model:PivotTo(CFrame.lookAt(pos + V(0, stand, 0), pos + V(0, stand, 1)))
	model:SetAttribute("MoveFrom", pos)
	model:SetAttribute("MoveTo", pos)
	model:SetAttribute("MoveT0", now())
	model:SetAttribute("MoveDur", 0.01)
	model:SetAttribute("Face", pos + V(0, 0, 60))
	model.Parent = workspace
	return {model = model, hrp = hrp, height = stand, radius = 1.3 * CFG.Scale, pos = pos, busyUntil = 0}
end

---------------------------------------------------------------- ce que dit le boss (bulle au-dessus de lui)
local LINES = {
	start = {"You thought you had won?", "Now face my TRUE form!"},
	hit = {"ARGH!", "Insolent worm!", "You'll pay for that!", "Is that all?!", "Pathetic!"},
	slam = {"KNEEL!", "THE EARTH OBEYS ME!", "JUMP, LITTLE ONES!"},
	meteor = {"RAIN OF HELLFIRE!", "BURN!", "The sky is mine!"},
	charge = {"NOWHERE TO RUN!", "I WILL CRUSH YOU!"},
	pillars = {"RISE, FLAMES OF HELL!", "Feel the inferno!"},
	enraged = {"ENOUGH! I WILL BURN THIS CITY TO ASHES!"},
	low = {"No... I am ETERNAL!"},
	death = {"Impossible... this city... was MINE... AAAARGH!"},
	win = {"This city belongs to me now."},
}
local lastLine = 0
local function say(kind, force)
	local list = LINES[kind]
	if not list then return end
	if not force and now() - lastLine < 3 then return end
	lastLine = now()
	fxAll({k = "say", text = list[math.random(#list)], t = kind == "death" and 3.5 or 2.4})
end

---------------------------------------------------------------- dégâts aux joueurs
local function hurt(player, amount, push)
	local root, humanoid = rootOf(player)
	if not root then return end
	humanoid:TakeDamage(amount)
	if push then knockRemote:FireClient(player, push) end
	fxRemote:FireClient(player, {k = "ouch", amount = amount})
end
local function pushAway(root, from, out, up)
	return unitOr(flat(root.Position - from), V(0, 0, 1)) * out + V(0, up, 0)
end

---------------------------------------------------------------- 1. l'onde au sol (il faut sauter)
local function slam()
	stopMove()
	setAction("slam", CFG.SlamWindup + 1.2)
	say("slam", true)
	fxAll({k = "banner", text = "JUMP OVER THE WAVE!", color = Color3.fromRGB(255, 130, 80), t = 1.6})
	task.wait(CFG.SlamWindup)
	if not fight then return end
	local origin = bossPos()
	local reach = HALF * 1.45
	local speed = reach / CFG.WaveTime
	local t0 = now()
	fxAll({k = "wave", o = origin, t0 = t0, speed = speed, dur = CFG.WaveTime})
	local hit = {}
	while fight and now() - t0 < CFG.WaveTime do
		local r = (now() - t0) * speed
		for _, player in arenaPlayers() do
			if not hit[player] then
				local root = rootOf(player)
				local d = flat(root.Position - origin).Magnitude
				local above = root.Position.Y - C.Y - 3 -- hauteur au-dessus de la pose debout
				if math.abs(d - r) < CFG.WaveThickness and above < CFG.SafeJump then
					hit[player] = true
					hurt(player, CFG.WaveDamage, pushAway(root, origin, 70, 45))
				end
			end
		end
		RunService.Heartbeat:Wait()
	end
end

---------------------------------------------------------------- 2. pluie de météores (cercles rouges, puis impact)
local function meteors()
	stopMove()
	local rage = phase() == 2
	setAction("meteor", CFG.MeteorWarn + 1.4)
	say("meteor", true)
	local points = {}
	for _, player in arenaPlayers() do
		local root = rootOf(player)
		local lead = flat(root.AssemblyLinearVelocity) * 0.45 -- (visée un peu devant le joueur qui court)
		local a = math.random() * math.pi * 2
		table.insert(points, clampToArena(flat(root.Position) + V(0, C.Y, 0) + lead + V(math.cos(a), 0, math.sin(a)) * math.random(0, 4)))
	end
	local count = rage and CFG.MeteorCount + 4 or CFG.MeteorCount
	while #points < count do table.insert(points, randomPoint()) end
	local t0 = now() + 0.4
	fxAll({k = "meteorWarn", points = points, t0 = t0, warn = CFG.MeteorWarn, r = CFG.MeteorRadius})
	task.wait(math.max(0, t0 + CFG.MeteorWarn - now()))
	if not fight then return end
	for _, player in arenaPlayers() do
		local root = rootOf(player)
		for _, p in points do
			if flat(root.Position - p).Magnitude < CFG.MeteorRadius and root.Position.Y - C.Y < 14 then
				hurt(player, CFG.MeteorDamage, pushAway(root, p, 60, 50))
				break
			end
		end
	end
end

---------------------------------------------------------------- 3. coup de griffes devant lui
local function swipe(target)
	local tr = rootOf(target)
	if not tr then return end
	stopMove()
	lastFace = nil
	faceTo(tr.Position)
	setAction("swipe", CFG.SwipeWindup + 0.7)
	task.wait(CFG.SwipeWindup)
	if not fight then return end
	local bp = bossPos()
	local fwd = faceDir()
	fxAll({k = "swipe", p = bp + fwd * (boss.radius + 6) + V(0, 6, 0), dir = fwd})
	for _, player in arenaPlayers() do
		local root = rootOf(player)
		local off = flat(root.Position - bp)
		local d = off.Magnitude
		if d < boss.radius + CFG.SwipeRange and (d < 4 or off.Unit:Dot(fwd) > 0.3) and root.Position.Y - C.Y < 22 then
			hurt(player, CFG.SwipeDamage, unitOr(off, fwd) * 75 + V(0, 40, 0))
		end
	end
end

---------------------------------------------------------------- 4. charge à travers la place (ligne rouge d'abord)
local function charge()
	local list = arenaPlayers()
	if #list == 0 then return end
	stopMove()
	local tr = rootOf(list[math.random(#list)])
	local from = bossPos()
	local dir = unitOr(flat(tr.Position - from), V(0, 0, 1))
	local to = clampToArena(from + dir * CFG.ChargeLength)
	if (to - from).Magnitude < 25 then return end
	lastFace = nil
	faceTo(to)
	setAction("chargeWarn", CFG.ChargeWarn + 0.2)
	say("charge", true)
	fxAll({k = "chargeWarn", from = from, to = to, t0 = now(), warn = CFG.ChargeWarn, width = boss.radius * 2})
	task.wait(CFG.ChargeWarn)
	if not fight then return end
	local dur = CFG.ChargeTime * math.max(0.35, (to - from).Magnitude / CFG.ChargeLength)
	setAction("charge", dur + 0.8)
	moveBoss(to, dur, true)
	local hit = {}
	local t1 = now()
	while fight and boss and now() - t1 < dur + 0.05 do
		local p = bossPos()
		for _, player in arenaPlayers() do
			if not hit[player] then
				local root = rootOf(player)
				if flat(root.Position - p).Magnitude < boss.radius + 3 and root.Position.Y - C.Y < 24 then
					hit[player] = true
					local side = unitOr(flat(root.Position - p), V(dir.Z, 0, -dir.X))
					hurt(player, CFG.ChargeDamage, unitOr(side + dir, dir) * 90 + V(0, 55, 0))
				end
			end
		end
		RunService.Heartbeat:Wait()
	end
	if fight then fxAll({k = "chargeEnd", p = to}) end
end

---------------------------------------------------------------- 5. (enragé) colonnes de feu qui filent du boss vers chaque joueur
local function pillars()
	stopMove()
	setAction("pillars", 1.8)
	say("pillars", true)
	local bp = bossPos()
	local lines = {}
	for _, player in arenaPlayers() do
		local root = rootOf(player)
		local off = flat(root.Position - bp)
		local dir = unitOr(off, V(0, 0, 1))
		local pts = {}
		for d = boss.radius + 4, off.Magnitude + 16, CFG.PillarStep do
			local p = bp + dir * d
			if math.abs(p.X - C.X) > HALF - 2 or math.abs(p.Z - C.Z) > HALF - 2 then break end
			table.insert(pts, V(p.X, C.Y, p.Z))
		end
		if #pts > 0 then table.insert(lines, pts) end
	end
	if #lines == 0 then return end
	local t0, step, warn = now() + 0.6, 0.11, 0.55
	fxAll({k = "pillars", lines = lines, t0 = t0, step = step, warn = warn, r = CFG.PillarRadius})
	local events = {}
	for _, pts in lines do
		for i, p in pts do table.insert(events, {t = t0 + warn + (i - 1) * step, p = p}) end
	end
	table.sort(events, function(a, b) return a.t < b.t end)
	local hit = {}
	for _, e in events do
		local dt = e.t - now()
		if dt > 0 then task.wait(dt) end
		if not fight then return end
		for _, player in arenaPlayers() do
			if not hit[player] then
				local root = rootOf(player)
				if flat(root.Position - e.p).Magnitude < CFG.PillarRadius and root.Position.Y - C.Y < 18 then
					hit[player] = true
					hurt(player, CFG.PillarDamage, pushAway(root, e.p, 30, 70))
				end
			end
		end
	end
end

---------------------------------------------------------------- la batte touche le boss (vérifié ici : portée, cadence, batte en main)
local lastBat = {}
batRemote.OnServerEvent:Connect(function(player)
	if not fight or not boss or not inArena(player) then return end
	local character = player.Character
	if not character:FindFirstChild("Bat") then return end
	if os.clock() - (lastBat[player] or 0) < CFG.BatCooldown then return end
	lastBat[player] = os.clock()
	local action = boss.model:GetAttribute("Action")
	if action == "die" or action == "appear" then return end
	local root = rootOf(player)
	local bp = bossPos()
	if flat(root.Position - bp).Magnitude - boss.radius > CFG.BatReach then return end
	if root.Position.Y - C.Y > boss.height * 2.2 then return end
	local before = boss.model:GetAttribute("Hp")
	local hp = math.max(0, before - CFG.BatDamage)
	local max = CFG.MaxHp
	if before > max * 0.25 and hp <= max * 0.25 then say("low", true)
	elseif hp > 0 and math.random() < 0.15 then say("hit") end
	boss.model:SetAttribute("Hp", hp)
	boss.model:SetAttribute("HurtT", now())
	fight.damage[player] = (fight.damage[player] or 0) + CFG.BatDamage
	local toward = unitOr(flat(bp - root.Position), V(0, 0, -1))
	fxAll({k = "hit", p = root.Position + toward * 4 + V(0, 3, 0), amount = CFG.BatDamage, by = player.UserId})
end)
Players.PlayerRemoving:Connect(function(player) lastBat[player] = nil end)

---------------------------------------------------------------- fin du combat
local function finish(win)
	if not fight then return end
	local f = fight
	fight = nil
	for _, c in f.conns or {} do c:Disconnect() end
	for player in f.players do if player.Parent then player:SetAttribute("EventSpeed", nil) end end
	if win then
		stopMove()
		setAction("die")
		say("death", true)
		fxAll({k = "death", p = bossPos(), t0 = now(), height = boss.height})
		fxAll({k = "banner", text = "VICTORY!", color = Color3.fromRGB(255, 220, 90), t = 5})
		-- récompenses : classement aux dégâts ; le 1er gagne le meilleur animal de la Demon Zone, le 2e le suivant...
		local ranking = {}
		for player, dmg in f.damage do if player.Parent and dmg > 0 then table.insert(ranking, {player = player, damage = dmg}) end end
		table.sort(ranking, function(a, b) return a.damage > b.damage end)
		local lines = {}
		for rank, entry in ranking do
			local petName = Config.Rewards[rank]
			if not petName then break end
			local info = EggConfig.Pets[petName]
			local ok = pcall(function() return giveZonePet:Invoke(entry.player, petName) end)
			table.insert(lines, "#" .. rank .. " " .. entry.player.DisplayName .. " (" .. entry.damage .. ") : " .. (info and info.Name or petName))
			if ok then fxRemote:FireClient(entry.player, {k = "reward", rank = rank, pet = info and info.Name or petName, damage = entry.damage}) end
		end
		for player in f.players do
			if player.Parent then notifyRemote:FireClient(player, "THE TRUE DEMON is defeated! " .. (lines[1] and table.concat(lines, "  |  ") or "")) end
		end
	else
		say("win", true)
		fxAll({k = "banner", text = "DEFEATED...", color = Color3.fromRGB(255, 90, 90), t = 4})
	end
	task.wait(win and 8 or 3)
	local index = 0
	for player in f.players do
		if player.Parent and player:GetAttribute("InDemonArena") then sendHome(player, index) index += 1 end
		if player.Parent then player:SetAttribute("InDemonArena", nil) end
	end
	if boss then boss.model:Destroy() boss = nil end
	table.clear(audience)
	shared:SetAttribute("FightActive", false)
	task.wait(1)
	if not fight then
		Builder.setCollapsed(false)
		Builder.show(false)
	end
end

---------------------------------------------------------------- début et déroulé du combat
local function start(list)
	if fight then return end
	local players = {}
	for _, player in list or Players:GetPlayers() do
		if player.Parent and not player:GetAttribute("InBossArena") then players[player] = true end
	end
	if next(players) == nil then
		Builder.show(false)
		return
	end
	fight = {players = players, damage = {}, t0 = now(), conns = {}}
	for player in players do audience[player] = true end
	shared:SetAttribute("FightActive", true)
	local city = Builder.show(true)
	Builder.setCollapsed(true) -- (la façade de l'hôtel est restée effondrée après la cinématique)
	boss = buildBoss()
	lastFace = nil
	-- tout le monde au sud de la place, face au boss
	local spawns = {}
	for _, s in city.BossArena:GetChildren() do if s.Name == "Spawn" then table.insert(spawns, s.Position) end end
	if #spawns == 0 then spawns = {C + V(0, 3, 80)} end
	local index = 0
	for player in players do
		index += 1
		local spot = spawns[(index - 1) % #spawns + 1]
		pcall(function() player:RequestStreamAroundAsync(spot, 5) end)
		player:SetAttribute("InDemonArena", true)
		player:SetAttribute("EventSpeed", CFG.EventSpeed)
		moveCharacter(player, CFrame.lookAt(spot, V(C.X, spot.Y, C.Z - 40)))
		local _, humanoid = rootOf(player)
		if humanoid then
			humanoid.Health = humanoid.MaxHealth
			local bat = player.Backpack:FindFirstChild("Bat")
			if bat then humanoid:EquipTool(bat) end -- la batte en main : c'est elle qui blesse le boss
		end
	end
	-- mort pendant le combat : on réapparaît dans l'arène
	for player in players do
		table.insert(fight.conns, player.CharacterAdded:Connect(function(character)
			if not fight or not fight.players[player] or not player:GetAttribute("InDemonArena") then return end
			task.spawn(function()
				local root = character:WaitForChild("HumanoidRootPart", 10)
				local humanoid = character:WaitForChild("Humanoid", 10)
				if not root or not humanoid or not fight then return end
				task.wait(0.15)
				local spot = spawns[math.random(1, #spawns)]
				pcall(function() player:RequestStreamAroundAsync(spot, 5) end)
				moveCharacter(player, CFrame.lookAt(spot, V(C.X, spot.Y, C.Z - 40)))
				humanoid.Health = humanoid.MaxHealth
				local bat = player.Backpack:WaitForChild("Bat", 4)
				if bat and humanoid.Parent then humanoid:EquipTool(bat) end
				fxRemote:FireClient(player, {k = "banner", text = "BACK IN THE FIGHT!", color = Color3.fromRGB(140, 255, 160), t = 1.8})
			end)
		end))
	end
	fxAll({k = "start"})
	setAction("appear", 3.4) -- il tombe du ciel et rugit (DemonArenaClient)
	task.delay(1.4, function() if fight then say("start", true) end end)
	local nextSlam, nextMeteor, nextCharge, nextPillar = now() + 9, now() + 15, now() + 22, math.huge
	local nextSwipe, nextMove = now() + 5, now() + 4
	local emptySince
	task.spawn(function()
		while fight do
			task.wait(0.15)
			if not fight or not boss then break end
			local t = now()
			-- (un joueur mort qui va réapparaître compte encore : il a toujours InDemonArena)
			local still = 0
			for player in fight.players do if player.Parent and player:GetAttribute("InDemonArena") then still += 1 end end
			if still == 0 then
				emptySince = emptySince or t
				if t - emptySince > CFG.EmptyEnd then finish(false) break end
			else
				emptySince = nil
			end
			local hp = boss.model:GetAttribute("Hp")
			if hp <= 0 then finish(true) break end
			if t - fight.t0 > CFG.MaxTime then finish(false) break end
			local rage = phase() == 2
			if not rage and hp <= CFG.MaxHp / 2 then
				-- phase enragée : plus rapide, plus d'attaques
				stopMove()
				boss.model:SetAttribute("Phase", 2)
				setAction("enrage", 2.6)
				say("enraged", true)
				fxAll({k = "enrage"})
				fxAll({k = "banner", text = "THE TRUE DEMON IS ENRAGED!", color = Color3.fromRGB(255, 60, 40), t = 2.6})
				nextPillar = t + 4
				nextSlam = math.min(nextSlam, t + 7)
				nextMeteor = math.min(nextMeteor, t + 10)
				continue
			end
			if t < boss.busyUntil then continue end
			-- le joueur le plus proche
			local bp = bossPos()
			local nearest, nd
			for _, player in arenaPlayers() do
				local d = flat(rootOf(player).Position - bp).Magnitude
				if not nd or d < nd then nearest, nd = player, d end
			end
			if nearest and nd < boss.radius + CFG.SwipeRange - 2 and t >= nextSwipe then
				nextSwipe = t + (rage and 2.2 or 3.4)
				task.spawn(swipe, nearest)
			elseif t >= nextSlam then
				nextSlam = t + (rage and CFG.RageSlamEvery or CFG.SlamEvery)
				task.spawn(slam)
			elseif t >= nextMeteor then
				nextMeteor = t + (rage and CFG.RageMeteorEvery or CFG.MeteorEvery)
				task.spawn(meteors)
			elseif t >= nextCharge then
				nextCharge = t + (rage and CFG.RageChargeEvery or CFG.ChargeEvery)
				task.spawn(charge)
			elseif rage and t >= nextPillar then
				nextPillar = t + CFG.PillarEvery
				task.spawn(pillars)
			elseif nearest and t >= nextMove and not boss.move then
				-- il marche vers le joueur le plus proche
				local target = flat(rootOf(nearest).Position) + V(0, C.Y, 0)
				local off = flat(target - bp)
				local stopAt = boss.radius + 9
				if off.Magnitude > stopAt + 3 then
					local to = clampToArena(bp + off.Unit * math.min(off.Magnitude - stopAt, 45))
					local dur = flat(to - bp).Magnitude / (rage and CFG.RageWalkSpeed or CFG.WalkSpeed)
					if dur > 0.2 then
						moveBoss(to, dur)
						nextMove = t + dur + (rage and 0.2 or 0.6)
					end
				else
					faceTo(target)
					nextMove = t + 0.6
				end
			end
		end
	end)
end
startEvent.Event:Connect(function(list) task.spawn(start, list) end)
Players.PlayerRemoving:Connect(function(player)
	audience[player] = nil
	if fight then
		fight.players[player] = nil
		fight.damage[player] = nil
	end
end)
