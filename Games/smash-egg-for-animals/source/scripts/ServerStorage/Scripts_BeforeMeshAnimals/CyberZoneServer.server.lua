-- CyberZoneServer : œufs à voler dans la Cyber Zone + Fermier (boss) qui poursuit les joueurs
--  * ProximityPrompt « Prendre » sur chaque socle : le joueur TIENT l'œuf dans sa main (modèle de l'œuf), un seul à la fois
--  * La Cyber Zone ne contient que les pires œufs (Common / Uncommon) ; une fois un œuf sécurisé, un NOUVEL œuf nul respawn sur le socle
--  * Le boss ne bouge pas tant que personne ne porte d'œuf : dès qu'un œuf est pris, il attaque le porteur
--  * L'œuf n'arrive dans l'inventaire qu'une fois le joueur sorti de la Cyber Zone (échelle ou bord ouest)
--  * Si le boss touche le joueur : retour à sa base + les œufs portés retournent sur leur socle
--  * Si le joueur sort de la zone, le boss arrête de le poursuivre et retourne à son poste
-- Réglages du boss : attributs de Workspace["Cyber Zone"].CyberBoss (WalkSpeed, AttackRange)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local zone = workspace:WaitForChild("Cyber Zone")
local ground = zone:WaitForChild("Part") -- le sol de la zone : définit ses limites
local spotsFolder = zone:WaitForChild("CyberEggs")
local boss = zone:WaitForChild("CyberBoss")
local bases = workspace:WaitForChild("all base")
local tradeBridge = ServerScriptService:WaitForChild("TradeBridge") -- répondu par PetServer (GiveEgg)
local EggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(EggSystem:WaitForChild("EggConfig"))
local notifyRemote = EggSystem:WaitForChild("Remotes"):WaitForChild("Notify")

ground.Anchored = true

local ATTACK_COOLDOWN = 1.2 -- secondes entre deux coups
local HIT_SLACK = 3         -- marge de portée au moment de l'impact
local RESPAWN_DELAY = 5 -- secondes après la sortie de la Cyber Zone avant qu'un nouvel œuf nul respawn sur le socle
local HELD_HEIGHT = 2.2 -- hauteur (studs) de l'œuf tenu dans la main
local WEAK_EGGS = {"ChickenEgg", "PigEgg"} -- les pires œufs du jeu (Common / Uncommon) : seuls œufs de la Cyber Zone
local EGG_COLORS = {
	ChickenEgg = Color3.fromRGB(235, 235, 235),
	PigEgg = Color3.fromRGB(95, 220, 110),
}
local EggModels = EggSystem:WaitForChild("EggModels")
local setSpotEgg, respawnSpot, makeHeldEgg -- définies plus bas

local carried = {}    -- [player] = {{Spot = Model, EggName = string, Visual = Part}}
local hiddenEggs = {} -- [spot] = modèle d'œuf (retiré du monde quand il est pris)
local spotInfo = {}   -- [spot] = {Pivot, Scale, Bottom} : emplacement d'origine de l'œuf du socle

local function notify(player, text)
	notifyRemote:FireClient(player, text)
end

local function inZone(position)
	local lp = ground.CFrame:PointToObjectSpace(position)
	return math.abs(lp.X) <= ground.Size.X / 2 and math.abs(lp.Z) <= ground.Size.Z / 2 and lp.Y >= -10
end

local function aliveParts(player)
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if hum and root and hum.Health > 0 then
		return char, hum, root
	end
end

-- au sol ou sur une échelle (évite de « sortir » en tombant dans le vide)
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Exclude
local function isGrounded(char, root)
	rayParams.FilterDescendantsInstances = {char}
	if workspace:Raycast(root.Position, Vector3.new(0, -5.5, 0), rayParams) then return true end
	overlapParams.FilterDescendantsInstances = {char}
	for _, part in workspace:GetPartBoundsInBox(root.CFrame, Vector3.new(5, 6, 5), overlapParams) do
		if part:IsA("TrussPart") then return true end
	end
	return false
end

---------------------------------------------------------------- Socles d'œufs
local function setAvailable(spot, available)
	spot:SetAttribute("Available", available)
	local egg = hiddenEggs[spot]
	if egg then egg.Parent = available and spot or nil end
	local pedestal = spot:FindFirstChild("Pedestal")
	local prompt = pedestal and pedestal:FindFirstChild("Prompt")
	if prompt then prompt.Enabled = available end
	local beacon = spot:FindFirstChild("Beacon")
	if beacon then beacon.Transparency = available and 0.75 or 1 end
end

local function pickWeakEgg()
	return WEAK_EGGS[math.random(#WEAK_EGGS)]
end

-- remplace l'œuf d'un socle par `eggName` (modèle de EggModels, même taille / même position que l'ancien)
function setSpotEgg(spot, eggName)
	local info = spotInfo[spot]
	local source = EggModels:FindFirstChild(eggName)
	if not info or not source then return end
	local old = hiddenEggs[spot]
	if old then old:Destroy() end
	local egg = source:Clone()
	egg.Name = "Egg"
	egg:ScaleTo(info.Scale)
	egg:PivotTo(info.Pivot)
	local cf, size = egg:GetBoundingBox()
	egg:PivotTo(info.Pivot + Vector3.new(0, info.Bottom - (cf.Position.Y - size.Y / 2), 0))
	hiddenEggs[spot] = egg
	egg.Parent = spot:GetAttribute("Available") and spot or nil
	spot:SetAttribute("EggName", eggName)
	local color = EGG_COLORS[eggName] or Color3.new(1, 1, 1)
	spot:SetAttribute("EggColor", color)
	local eggInfo = Config.Eggs[eggName]
	local pedestal = spot:FindFirstChild("Pedestal")
	local prompt = pedestal and pedestal:FindFirstChild("Prompt")
	if prompt and eggInfo then prompt.ObjectText = eggInfo.Name end
	for _, partName in {"Ring", "Beacon"} do
		local part = spot:FindFirstChild(partName)
		if part and part:IsA("BasePart") then part.Color = color end
	end
end

-- un œuf sécurisé : le socle se remplit plus tard avec un NOUVEL œuf nul tiré au hasard
function respawnSpot(spot)
	setSpotEgg(spot, pickWeakEgg())
	setAvailable(spot, true)
end

-- l'œuf pris (même modèle que sur le socle, réduit) est tenu dans la main droite du joueur
function makeHeldEgg(char, root, spot)
	local source = hiddenEggs[spot]
	if not source then return nil end
	local egg = source:Clone()
	egg.Name = "CarriedEgg"
	local _, size = egg:GetBoundingBox()
	egg:ScaleTo(egg:GetScale() * HELD_HEIGHT / size.Y)
	local hand = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")
	local holder = hand or root
	local offset = CFrame.new(1.5, 0, -1.5) -- sans main : devant le joueur
	if hand then
		offset = hand.Name == "RightHand" and CFrame.new(0, -0.4, -1.3) or CFrame.new(0, -0.9, -1.3)
	end
	local upright = root.CFrame - root.CFrame.Position
	egg:PivotTo(CFrame.new((holder.CFrame * offset).Position) * upright)
	local eggRoot = egg.PrimaryPart or egg:FindFirstChildWhichIsA("BasePart", true)
	local parts = {}
	for _, d in egg:GetDescendants() do
		if d:IsA("BasePart") then
			table.insert(parts, d)
			d.CanCollide = false
			d.CanTouch = false
			d.CanQuery = false
			d.Massless = true
			if d ~= eggRoot then
				local w = Instance.new("WeldConstraint")
				w.Part0 = eggRoot
				w.Part1 = d
				w.Parent = d
			end
		end
	end
	local grip = Instance.new("WeldConstraint")
	grip.Part0 = holder
	grip.Part1 = eggRoot
	grip.Parent = eggRoot
	for _, d in parts do d.Anchored = false end
	egg.Parent = char
	return egg
end

-- le joueur perd ses œufs : ils reviennent sur leur socle
local function dropAll(player)
	local list = carried[player]
	carried[player] = nil
	if not list then return 0 end
	for _, item in list do
		if item.Visual then item.Visual:Destroy() end
		setAvailable(item.Spot, true)
	end
	return #list
end

-- le joueur est sorti de la zone : les œufs portés vont dans son inventaire
local function secure(player)
	local list = carried[player]
	if not list or #list == 0 then return end
	carried[player] = nil
	local given, full = {}, false
	for _, item in list do
		if item.Visual then item.Visual:Destroy() end
		local ok = tradeBridge:Invoke("GiveEgg", player, item.EggName)
		if ok then
			local info = Config.Eggs[item.EggName]
			table.insert(given, info and info.Name or item.EggName)
			task.delay(RESPAWN_DELAY, respawnSpot, item.Spot)
		else
			full = true
			setAvailable(item.Spot, true)
		end
	end
	if #given > 0 then
		notify(player, "Left the Cyber Zone! In your inventory: " .. table.concat(given, ", "))
	end
	if full then
		notify(player, "Egg inventory full: some eggs were left on their pedestal.")
	end
end

local function onTriggered(spot, player)
	if not spot:GetAttribute("Available") then return end
	local char, _, root = aliveParts(player)
	if not char then return end
	local pedestal = spot:FindFirstChild("Pedestal")
	if not pedestal or (root.Position - pedestal.Position).Magnitude > 30 then return end
	if carried[player] and #carried[player] > 0 then
		notify(player, "You're already carrying an egg! Leave the Cyber Zone to keep it.")
		return
	end
	local eggName = spot:GetAttribute("EggName")
	local held = makeHeldEgg(char, root, spot) -- l'œuf apparaît dans la main du joueur
	setAvailable(spot, false)
	carried[player] = {{Spot = spot, EggName = eggName, Visual = held}}
	local info = Config.Eggs[eggName]
	notify(player, (info and info.Name or eggName) .. " stolen! Leave the Cyber Zone to keep it and run from the Farmer!")
end

for _, spot in spotsFolder:GetChildren() do
	if spot:IsA("Model") then
		local egg = spot:FindFirstChild("Egg")
		hiddenEggs[spot] = egg
		if egg then
			local cf, size = egg:GetBoundingBox()
			spotInfo[spot] = {Pivot = egg:GetPivot(), Scale = egg:GetScale(), Bottom = cf.Position.Y - size.Y / 2}
		end
		setAvailable(spot, true)
		setSpotEgg(spot, pickWeakEgg()) -- la Cyber Zone ne contient que les pires œufs du jeu
		local pedestal = spot:FindFirstChild("Pedestal")
		local prompt = pedestal and pedestal:FindFirstChild("Prompt")
		if prompt then
			prompt.Triggered:Connect(function(player)
				onTriggered(spot, player)
			end)
		end
	end
end

-- mort / départ : les œufs portés sont perdus
local function watchHumanoid(player, char)
	local hum = char:WaitForChild("Humanoid", 10)
	if hum then
		hum.Died:Connect(function()
			dropAll(player)
		end)
	end
end
local function watchPlayer(player)
	player.CharacterAdded:Connect(function(char)
		watchHumanoid(player, char)
	end)
	if player.Character then
		task.spawn(watchHumanoid, player, player.Character)
	end
end
Players.PlayerAdded:Connect(watchPlayer)
for _, player in Players:GetPlayers() do watchPlayer(player) end
Players.PlayerRemoving:Connect(dropAll)

-- détection de la sortie de zone
local exitAcc = 0
RunService.Heartbeat:Connect(function(dt)
	exitAcc += dt
	if exitAcc < 0.25 then return end
	exitAcc = 0
	for player, list in carried do
		if #list > 0 then
			local char, _, root = aliveParts(player)
			if char and not inZone(root.Position) and isGrounded(char, root) then
				task.spawn(secure, player)
			end
		end
	end
end)

---------------------------------------------------------------- Retour à la base (même logique que BaseServer)
local function baseCFrame(player)
	local number = player:GetAttribute("BaseNumber")
	local base = number and bases:FindFirstChild("base " .. number)
	local spawnPart = base and base:FindFirstChild("Spawn")
	if not spawnPart then return nil end
	local pos = spawnPart.Position + Vector3.new(0, 3.5, 0)
	local animals, plants = base:FindFirstChild("animaux"), base:FindFirstChild("plantes")
	local center = (animals and plants) and (animals.Position + plants.Position) / 2 or base:GetBoundingBox().Position
	return CFrame.lookAt(pos, Vector3.new(center.X, pos.Y, center.Z))
end

local function sendToBase(player)
	local char, _, root = aliveParts(player)
	if not char then return end
	local lost = dropAll(player)
	local cf = baseCFrame(player)
	if cf then
		root.AssemblyLinearVelocity = Vector3.zero
		char:PivotTo(cf)
	else
		player:LoadCharacter()
	end
	if lost > 0 then
		notify(player, "The Farmer caught you! You go back to your base and lose your eggs.")
	else
		notify(player, "The Farmer caught you! You go back to your base.")
	end
end

---------------------------------------------------------------- Fermier
local hum = boss:WaitForChild("Humanoid")
local bossRoot = boss:WaitForChild("HumanoidRootPart")
local torso = boss:WaitForChild("Torso")
local motors = {
	RS = torso:WaitForChild("Right Shoulder"),
	LS = torso:WaitForChild("Left Shoulder"),
	RH = torso:WaitForChild("Right Hip"),
	LH = torso:WaitForChild("Left Hip"),
}
local rest = {}
for key, m in motors do rest[key] = m.C0 end
local home = bossRoot.Position
pcall(function() bossRoot:SetNetworkOwner(nil) end)

local target, attackStart, attackHit, attackTarget
local lastAttack, walkPhase = 0, 0
local lastPos, lastPosTime = bossRoot.Position, os.clock()

local function pose(armR, armL, legR, legL)
	motors.RS.C0 = rest.RS * CFrame.Angles(armR, 0, 0)
	motors.LS.C0 = rest.LS * CFrame.Angles(armL, 0, 0)
	motors.RH.C0 = rest.RH * CFrame.Angles(legR, 0, 0)
	motors.LH.C0 = rest.LH * CFrame.Angles(legL, 0, 0)
end

-- le boss ne réagit QU'AUX joueurs qui portent un œuf dans la Cyber Zone (sinon il reste à son poste)
local function pickTarget()
	local best, bestDist
	for player, list in carried do
		if #list > 0 then
			local _, _, root = aliveParts(player)
			if root and inZone(root.Position) then
				local d = (root.Position - bossRoot.Position).Magnitude
				if not bestDist or d < bestDist then best, bestDist = player, d end
			end
		end
	end
	return best
end

local function think()
	hum.WalkSpeed = boss:GetAttribute("WalkSpeed") or 17
	if attackStart then return end
	local attackRange = boss:GetAttribute("AttackRange") or 9
	target = pickTarget()
	if target then
		local _, _, root = aliveParts(target)
		local offset = root.Position - bossRoot.Position
		local flat = Vector3.new(offset.X, 0, offset.Z).Magnitude
		if flat <= attackRange and math.abs(offset.Y) <= 10 and os.clock() - lastAttack >= ATTACK_COOLDOWN then
			attackStart, attackHit, attackTarget = os.clock(), false, target
			hum:MoveTo(bossRoot.Position)
		else
			hum:MoveTo(root.Position)
			-- anti-blocage : saute s'il n'avance plus
			if os.clock() - lastPosTime > 1 then
				if (bossRoot.Position - lastPos).Magnitude < 2 then hum.Jump = true end
				lastPos, lastPosTime = bossRoot.Position, os.clock()
			end
		end
	else
		if (bossRoot.Position - home).Magnitude > 6 then
			hum:MoveTo(home)
		else
			hum:MoveTo(bossRoot.Position)
		end
	end
	-- sécurité : s'il tombe de la plateforme, retour au poste
	if bossRoot.Position.Y < ground.Position.Y - 30 then
		bossRoot.AssemblyLinearVelocity = Vector3.zero
		bossRoot.CFrame = CFrame.new(home)
	end
end

local function attackAngle(e)
	if e < 0.35 then
		return math.pi * 0.92 * (e / 0.35) -- bras levés
	elseif e < 0.5 then
		return math.pi * 0.92 + (0.2 - math.pi * 0.92) * ((e - 0.35) / 0.15) -- coup vers le bas
	end
	return 0.2 * math.max(0, 1 - (e - 0.5) / 0.35)
end

local function stepAttack(now)
	local e = now - attackStart
	local _, _, root = aliveParts(attackTarget)
	if root and e < 0.5 then
		local p = bossRoot.Position
		bossRoot.CFrame = CFrame.lookAt(p, Vector3.new(root.Position.X, p.Y, root.Position.Z))
	end
	local a = attackAngle(e)
	pose(a, a, 0, 0)
	if e >= 0.5 and not attackHit then
		attackHit = true
		local _, _, r = aliveParts(attackTarget)
		if r and inZone(r.Position) then
			local d = r.Position - bossRoot.Position
			local reach = (boss:GetAttribute("AttackRange") or 9) + HIT_SLACK
			if Vector3.new(d.X, 0, d.Z).Magnitude <= reach and math.abs(d.Y) <= 12 then
				sendToBase(attackTarget)
			end
		end
	end
	if e >= 0.85 then
		attackStart = nil
		lastAttack = now
	end
end

local thinkAcc, animAcc = 0, 0
RunService.Heartbeat:Connect(function(dt)
	thinkAcc += dt
	if thinkAcc >= 0.1 then
		thinkAcc = 0
		think()
	end
	animAcc += dt
	if animAcc < 1 / 30 then return end
	local step = animAcc
	animAcc = 0
	local now = os.clock()
	if attackStart then
		stepAttack(now)
	else
		local v = bossRoot.AssemblyLinearVelocity
		local speed = Vector3.new(v.X, 0, v.Z).Magnitude
		walkPhase += step * math.clamp(speed, 0, 20) * 0.45
		local swing = math.sin(walkPhase) * 0.9 * math.clamp(speed / 10, 0, 1)
		pose(-swing, swing, swing, -swing)
	end
end)
