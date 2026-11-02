-- Gardiens des zones d'œufs : un animal géant se promène dans la zone. Quand un joueur prend un œuf, il le poursuit
-- (contour rouge, "!" au-dessus de la tête). S'il le touche : les œufs sont perdus et le joueur est renvoyé près des boutiques.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Config = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
-- un gardien par zone : le meilleur animal de la rareté, en géant (modèles ServerStorage.ZoneBosses.Mesh_..., fabriqués par AnimalWiring)
local BOSS_ZONES = {Common = "common egg zone", Uncommon = "UNcommon egg zone", Rare = "RARE egg zone", Epic = "EPIC egg zone", Legendary = "LEGENDARY egg zone",
	Mythic = "MYTHIC egg zone", Secret = "SECRET egg zone", Ancient = "ANCIENT dino egg zone", OG = "OG candy egg zone", Divine = "DIVINE angel egg zone",
	Galactic = "GALACTIC galaxy egg zone"} -- zone Galaxy (12e) : la Galaxy Mosasaurus géante, à la vitesse du speed conseillé (6T = ~220)
local BOSSES = {}
for _, rarity in Config.Rarities do
	local keys = Config.EggsByValue(rarity)
	if BOSS_ZONES[rarity] and #keys > 0 then
		local pet = Config.Eggs[keys[#keys] ].Pets[1].Pet
		table.insert(BOSSES, {Zone = BOSS_ZONES[rarity], Rarity = rarity, Template = "Mesh_" .. pet, Name = Config.Pets[pet].Name, Title = "Giant " .. Config.Pets[pet].Name, Speed = 60, HitRadius = 11})
	end
end
-- zone Halloween (tout au fond) : le roi maudit. HitRadius plus large, il est bien plus gros que les autres gardiens
table.insert(BOSSES, {Zone = "Halloween egg zone", Rarity = "Prismatic", Template = "Pumpking", Name = "Pumpking", Title = "PUMPKING", Speed = 60, HitRadius = 13,
	BaseSpeed = 200}) -- dernière zone : il fonce à 200
local WANDER_SPEED = 20  -- vitesse de promenade
local CHASE_SPEED = 20   -- vitesse de charge
local CHASE_TIME = 15    -- secondes de poursuite au maximum
local WINDUP = 0.35      -- avant de charger, il se dresse (court : il réagit presque aussitôt)
local LEASH = 30         -- la poursuite s'arrête si le joueur s'éloigne de plus de 30 studs de la zone
local HIT_RADIUS = 9     -- distance (à plat) à laquelle le gardien touche le joueur
local HIT_SCALE = 1 / 1.5 -- zone de contact réduite de 1,5 fois (il faut vraiment qu'il arrive sur le joueur)
local HIGH_ABOVE = 10    -- il ne saute que si le joueur est vraiment en hauteur (plus de 10 studs au-dessus du sol)...
local HIGH_TIME = 0.3    -- ...depuis plus de 0,3 s (un simple saut du joueur ne le fait plus bondir), ou s'il vole en dragon
local HIT_HEIGHT = 14    -- au-dessus de cette hauteur, le dragon vole trop haut pour être touché
local MARGIN = 10        -- le gardien reste à cette distance des bords de la zone
local JUMP_CROUCH = 0.4   -- secondes accroupi avant le grand saut d'envol
local JUMP_BOOST = 2      -- après son saut, il va 3 fois plus vite...
local JUMP_BOOST_TIME = 0.25 -- ...pendant 2 secondes
local RETURN_HEIGHT = 45  -- hauteur de vol quand il rentre dans sa zone
local LEAD_TIME = 0.5    -- en poursuite il vise là où le joueur sera dans 0,5 s (il coupe les virages au lieu de lui courir après)
local FOLLOW_GAP = 22     -- joueur plus rapide que lui : il le suit en restant à cette distance (en plus de sa portée), sans le coller
local RUSH_MULT = 3       -- après avoir touché un voleur, il fonce sur le suivant à 3 fois sa vitesse, jusqu'à se caler derrière lui
local WANDER_MULT = 0.6   -- promenade : 60 % de sa vitesse de poursuite...
local WANDER_MIN, WANDER_MAX = 18, 24 -- ...promenade plus vive qu'avant (avant : 12 à 15)
local SPEED_MULT = 1.3   -- en poursuite, tous les gardiens vont 30 % plus vite qu'avant...
-- ...SAUF contre un joueur qui a le speed conseillé de la zone : là il reste un peu plus lent que lui (95 %), on peut toujours avoir le pet
local HOME_SPEED = 55
local RETURN_SPEED = 200 -- tous les gardiens rentrent dans leur zone à 200 après une poursuite
local STEAL_ON_HIT = false -- true = en touchant le joueur, il lui reprend l'œuf et le rapporte dans sa gueule ; false = tout ce que le joueur porte tombe au sol là où il est touché
local SpeedConfig = require(ReplicatedStorage:WaitForChild("SpeedSystem"):WaitForChild("SpeedConfig"))
local TAG = "ZoneBoss"
local templates = ServerStorage:WaitForChild("ZoneBosses")
local binds = ServerStorage:WaitForChild("GameBindables")
local alert = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("BossAlert")
local knockRemote = ReplicatedStorage:WaitForChild("HammerSystem"):WaitForChild("Knock") -- même éjection que la batte (HammerClient)
local MONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
-- là où le joueur touché est renvoyé : sur la plaque verte entre les deux boutiques, un peu en retrait
local function returnPoint()
	local a, b = workspace:FindFirstChild("egg shop"), workspace:FindFirstChild("dragon shop")
	if a and b then
		local pa, pb = a:GetBoundingBox().Position, b:GetBoundingBox().Position
		local mid = (pa + pb) / 2
		local hit = workspace:Raycast(Vector3.new(mid.X - 22, mid.Y + 60, mid.Z), Vector3.new(0, -200, 0))
		return Vector3.new(mid.X - 22, hit and hit.Position.Y or 0, mid.Z)
	end
	local safe = workspace:FindFirstChild("safe zone")
	return safe and (safe.Position + Vector3.new(0, safe.Size.Y / 2, 0)) or Vector3.new(0, 5, 0)
end
local function targetOf(player) -- {racine du dragon du joueur (ou du personnage), dragon}
	local dragons = workspace:FindFirstChild("Dragons")
	for _, dragon in dragons and dragons:GetChildren() or {} do
		if dragon:GetAttribute("Owner") == player.UserId and dragon.PrimaryPart then return dragon.PrimaryPart, dragon end
	end
	local character = player.Character
	return character and character:FindFirstChild("HumanoidRootPart"), nil
end
local function label(parent, text, color, size, offsetY)
	local billboard = Instance.new("BillboardGui")
	billboard.Size = size
	billboard.StudsOffsetWorldSpace = Vector3.new(0, offsetY, 0)
	billboard.AlwaysOnTop = true
	billboard.LightInfluence = 0
	billboard.MaxDistance = 400
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Size = UDim2.fromScale(1, 1)
	l.FontFace = MONT
	l.Text = text
	l.TextScaled = true
	l.TextColor3 = color
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3
	stroke.Parent = l
	CollectionService:AddTag(l, "Text3D") -- texte en relief (script client Text3D)
	l.Parent = billboard
	billboard.Parent = parent
	return billboard
end
-- les zones peuvent être renommées dans le Workspace ("common FOREST egg zone"...) : on les retrouve par leur premier mot (la rareté)
local function resolveZoneName(name)
	if workspace:FindFirstChild(name) then return name end
	local keyword = string.lower(string.match(name, "^(%a+)") or name)
	for _, child in workspace:GetChildren() do
		local lower = string.lower(child.Name)
		if child:IsA("BasePart") and string.find(lower, "egg zone", 1, true) and string.sub(lower, 1, #keyword) == keyword then return child.Name end
	end
	return name
end
local function startBoss(config)
	config.Zone = resolveZoneName(config.Zone)
	local zone = workspace:FindFirstChild(config.Zone)
	local template = templates:FindFirstChild(config.Template)
	if not zone or not template then
		warn("[ZoneBossServer] zone ou modèle introuvable : " .. config.Zone)
		return
	end
	local floorY = zone.Position.Y + zone.Size.Y / 2
	local chaseSpeed = config.Speed or CHASE_SPEED -- vitesse pour rentrer dans sa zone
	-- vitesse de base du gardien en poursuite : celle d'un joueur qui a le speed conseillé de la zone (EggConfig.ZoneSpeed).
	-- Il ne dépasse jamais cette vitesse (pas d'accélération pour rattraper).
	local baseSpeed = config.BaseSpeed or SpeedConfig.Walk(Config.ZoneSpeed[config.Rarity] or 0) -- = la vitesse d'un joueur qui a pile le speed recommandé : en dessous, il te rattrape
	local wanderSpeed = math.clamp(baseSpeed * WANDER_MULT, WANDER_MIN, WANDER_MAX)
	-- vitesse de charge : celle du voleur, plus ou moins. Speed conseillé de la zone atteint (EggConfig.ZoneSpeed) : le gardien est
	-- plus lent que lui et ne le rattrape pas ; en dessous, il est plus rapide, d'autant plus que le joueur est loin du compte.
	local function chaseFor(player)
		local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		local walk = humanoid and humanoid.WalkSpeed or 16
		if walk < 8 then walk = 16 end
		return walk
	end
	-- le joueur porte-t-il un œuf volé dans CETTE zone ?
	local function carriesMine(player)
		return string.find(player:GetAttribute("CarryZones") or "", "|" .. config.Zone .. "|", 1, true) ~= nil
	end
	local half = Vector3.new(zone.Size.X / 2 - MARGIN, 0, zone.Size.Z / 2 - MARGIN)
	local function clampToZone(p)
		return Vector3.new(math.clamp(p.X, zone.Position.X - half.X, zone.Position.X + half.X), 0, math.clamp(p.Z, zone.Position.Z - half.Z, zone.Position.Z + half.Z))
	end
	local function randomPoint()
		return Vector3.new(zone.Position.X + (math.random() * 2 - 1) * half.X, 0, zone.Position.Z + (math.random() * 2 - 1) * half.Z)
	end
	local boss = template:Clone()
	boss.Name = config.Title
	boss:SetAttribute("BaseSpeed", baseSpeed) -- vitesse de poursuite de ce gardien (selon le speed conseillé de sa zone)
	if config.Skin then config.Skin(boss) end
	local root = boss.PrimaryPart
	local rootHeight = -root.PivotOffset.Position.Y
	boss:PivotTo(CFrame.new(zone.Position.X, floorY, zone.Position.Z))
	local attachment = Instance.new("Attachment")
	attachment.Parent = root
	local drive = Instance.new("LinearVelocity")
	drive.Attachment0 = attachment
	drive.RelativeTo = Enum.ActuatorRelativeTo.World
	drive.MaxForce = math.huge
	drive.VectorVelocity = Vector3.zero
	drive.Parent = root
	local steer = Instance.new("AlignOrientation")
	steer.Mode = Enum.OrientationAlignmentMode.OneAttachment
	steer.Attachment0 = attachment
	steer.MaxTorque = math.huge
	steer.Responsiveness = 30
	steer.MaxAngularVelocity = 6 -- au calme ; en poursuite il tourne beaucoup plus vite (voir plus bas)
	steer.CFrame = CFrame.new()
	steer.Parent = root
	local highlight = Instance.new("Highlight")
	highlight.FillColor = Color3.fromRGB(255, 30, 30)
	highlight.FillTransparency = 0.7
	highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
	highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	highlight.Enabled = false
	highlight.Parent = boss
	local height = boss:GetAttribute("Height") or 20
	label(root, config.Title, Color3.new(1, 1, 1), UDim2.fromScale(16, 3), height - rootHeight + 2)
	local bang = label(root, "!", Color3.fromRGB(255, 30, 30), UDim2.fromScale(9, 9), height - rootHeight + 9)
	bang.Enabled = false
	boss.Parent = workspace
	root.Anchored = false
	root:SetNetworkOwner(nil)
	CollectionService:AddTag(boss, TAG)
	local carryBack
	local state = {Mode = "Wander", Goal = randomPoint(), Pause = 0, Target = nil, Timer = 0, Yaw = 0}
	local function setChasing(player)
		state.Target = player
		state.Mode = player and "Chase" or ((state.StolenList and #state.StolenList > 0) and "Return" or "Wander") -- œufs repris en gueule : il les rapporte
		state.Timer = 0
		state.Rush = false
		state.TopSpeed = nil -- vitesse max de la poursuite (voir plus bas)
		state.Goal = randomPoint()
		highlight.Enabled = player ~= nil
		bang.Enabled = player ~= nil
		for _, d in boss:GetDescendants() do -- vapeur de colère, poussière, lueur rouge
			if d:GetAttribute("Rage") then d.Enabled = player ~= nil end
		end
		boss:SetAttribute("Chasing", player ~= nil)
	end
	-- après avoir touché le voleur : il tient l'œuf dans sa gueule et le rapporte dans sa zone
	local eggModels = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggModels")
	function carryBack(stolen)
		state.StolenList = state.StolenList or {}
		table.insert(state.StolenList, stolen)
		if state.StolenVisual then return end -- un seul œuf visible dans sa gueule, il rapporte tous les autres aussi
		local jaw, head
		for _, d in boss:GetDescendants() do
			if d:IsA("Weld") and d:GetAttribute("Anim") == "Jaw" then jaw, head = d.Part1, d.Part0 end
		end
		local template = eggModels:FindFirstChild(stolen.Key)
		if not jaw or not template then return end
		local visual = template:Clone()
		visual.Name = "StolenEgg"
		local size = (boss:GetAttribute("Height") or 20) * 0.16
		visual:ScaleTo(size / 13)
		visual:PivotTo(jaw.CFrame * CFrame.new(0, 0, size * 0.6))
		for _, part in visual:GetDescendants() do
			if part:IsA("BasePart") then
				part.Anchored, part.Massless = false, true
				part.CanCollide, part.CanQuery, part.CanTouch = false, false, false
				local weld = Instance.new("WeldConstraint")
				weld.Part0, weld.Part1 = head, part
				weld.Parent = part
			end
		end
		visual.Parent = boss
		state.StolenVisual = visual
	end
	binds:WaitForChild("EggGrabbed").Event:Connect(function(player, zoneName)
		if zoneName ~= config.Zone or state.Target == player then return end
		setChasing(player)
		alert:FireClient(player, "The " .. config.Title .. " saw you! RUN!")
	end)
	RunService.Heartbeat:Connect(function(dt)
		if not boss.Parent then return end
		local position = root.Position
		local flat = Vector3.new(position.X, 0, position.Z)
		local speed, goal = wanderSpeed, state.Goal
		state.Boost = math.max(0, (state.Boost or 0) - dt)
		local flyY = floorY + rootHeight -- hauteur visée : au sol, ou celle du joueur poursuivi s'il vole
		if state.Mode == "Chase" then
			local player = state.Target
			local targetRoot, dragon = nil, nil
			if player and player.Parent then targetRoot, dragon = targetOf(player) end
			state.Timer += dt
			local targetFlat = targetRoot and Vector3.new(targetRoot.Position.X, 0, targetRoot.Position.Z)
			local outside = targetFlat and (targetFlat - clampToZone(targetFlat)).Magnitude or math.huge
			if not targetRoot or (state.Timer > 1 and not carriesMine(player)) then
				setChasing(nil)
			else
				-- il sort de sa zone pour suivre le voleur, en visant un peu devant lui (anticipation des virages)
				local tv = targetRoot.AssemblyLinearVelocity
				local playerVel = Vector3.new(tv.X, 0, tv.Z)
				local playerSpeed = chaseFor(player)
				local chaseDist = targetFlat and (targetFlat - flat).Magnitude or 0
				-- anticipation proportionnelle à la distance : de près il vise le joueur lui-même (pas de dépassement quand il tourne en rond)
				local lead = chaseDist < 15 and 0 or math.min(LEAD_TIME, chaseDist / math.max(baseSpeed, playerSpeed, 1) * 0.35)
				goal = targetFlat + playerVel * lead
				state.FaceGoal = targetFlat
				state.Follow = nil
				-- distance où il se cale derrière le joueur : juste au-delà de sa zone de contact (proche, mais sans toucher)
				local keep = (config.HitRadius or HIT_RADIUS) * HIT_SCALE + 7
				if state.Rush and chaseDist <= keep + 2 then state.Rush = false end
				if state.Timer < WINDUP then
					speed = 0.01
				elseif state.Rush then
					-- il revient en trombe (3 fois sa vitesse) et freine net pour se caler derrière le joueur, sans le toucher
					speed = math.min(math.max(baseSpeed * RUSH_MULT, playerSpeed * 1.5), (chaseDist - keep) * 4)
					if speed < 1 then speed = 0.01 end
				else
					local running = playerVel.Magnitude
					-- il prend la vitesse du joueur dès qu'il le suit, et ne RALENTIT PLUS jusqu'à le toucher : il garde la plus grande
					-- vitesse atteinte pendant la poursuite (le joueur ralentit -> il se rapproche et le touche). Jamais moins que sa vitesse.
					local cap = math.max(math.min(baseSpeed * 3, 250), running * 1.15)
					local fast = baseSpeed * SPEED_MULT
					state.TopSpeed = math.max(state.TopSpeed or fast, math.min(running, cap), fast)
					if playerSpeed >= baseSpeed * 0.98 then
						state.TopSpeed = math.min(state.TopSpeed, playerSpeed * 0.95) -- bon speed : il ne le rattrape pas en ligne droite
					end
					-- il fonce TOUT DROIT sur le joueur, en visant un peu devant lui
					local aim = goal - flat
					local toTarget = aim.Magnitude > 0.1 and aim.Unit or Vector3.zero
					state.Follow = toTarget * state.TopSpeed
					speed = state.TopSpeed
				end
				-- en hauteur pour de vrai (dragon, ou perché longtemps) : il s'envole pour le suivre. Un saut du joueur : il reste au sol.
				local high = targetRoot.Position.Y - floorY > HIGH_ABOVE
				state.HighTime = high and (state.HighTime or 0) + dt or 0
				if state.Timer >= WINDUP and (dragon or state.HighTime > HIGH_TIME) then flyY = math.max(flyY, targetRoot.Position.Y) end
				-- s'il arrive sur le voleur, il le touche (quelle que soit la vitesse du joueur), jamais pendant son retour en trombe
				if state.Timer > WINDUP and not state.Rush and (targetFlat - flat).Magnitude < (config.HitRadius or HIT_RADIUS) * HIT_SCALE and math.abs(targetRoot.Position.Y - (position.Y - rootHeight + 3)) < HIT_HEIGHT * 0.5 then -- (hauteur comptée depuis ses pieds, pas le centre de son corps)
					-- touché !
					local stolen = STEAL_ON_HIT and binds.StealCarried:Invoke(player, config.Zone) or nil -- il reprend l'œuf (désactivé : STEAL_ON_HIT)
					-- sinon : tout ce que le joueur porte est posé au sol là où il a été touché, le compte à rebours reprend (comme un coup de batte)
					if not STEAL_ON_HIT then binds.PlaceCarried:Fire(player) end
					-- éjecté comme par la batte : projeté loin du gardien (c'est le client du joueur qui applique l'élan)
					local away = targetFlat - flat
					away = away.Magnitude > 0.1 and away.Unit or Vector3.new(1, 0, 0)
					if dragon then
						dragon.PrimaryPart.AssemblyLinearVelocity = away * 110 + Vector3.new(0, 60, 0)
					else
						knockRemote:FireClient(player, away * 95 + Vector3.new(0, 55, 0))
						knockRemote:FireAllClients(nil, targetRoot.Position) -- étincelles du choc
					end
					alert:FireClient(player, "You were hit by " .. config.Name .. "!", true)
					if stolen then carryBack(stolen) end
					-- un autre joueur porte un œuf de sa zone ? il fonce aussitôt sur lui (le plus proche), sinon il rentre
					local nextPlayer, nextDist
					for _, other in Players:GetPlayers() do
						local otherRoot = other ~= player and carriesMine(other) and targetOf(other)
						if otherRoot then
							local d = (Vector3.new(otherRoot.Position.X, 0, otherRoot.Position.Z) - flat).Magnitude
							if not nextDist or d < nextDist then nextPlayer, nextDist = other, d end
						end
					end
					if nextPlayer then
						setChasing(nextPlayer)
						state.Timer = WINDUP -- pas d'intimidation : il repart aussitôt
						state.Rush = true
						alert:FireClient(nextPlayer, "The " .. config.Title .. " is coming for you! RUN!")
					else
						setChasing(nil)
						state.Pause = 0.8
						state.Cooldown = 1.5
					end
				end
			end
		end
		if state.Mode == "Wander" then
			-- surveille la zone : tout joueur qui s'y trouve avec un œuf est pris en chasse (même s'il est sorti puis revenu)
			state.Cooldown = math.max(0, (state.Cooldown or 0) - dt)
			state.Scan = (state.Scan or 0) - dt
			if state.Cooldown <= 0 and state.Scan <= 0 then
				state.Scan = 0.1
				for _, player in Players:GetPlayers() do
					-- seul un joueur qui porte un œuf de cette zone l'intéresse, où qu'il soit
					if carriesMine(player) and targetOf(player) then
						setChasing(player)
						alert:FireClient(player, "The " .. config.Title .. " saw you! RUN!")
						break
					end
				end
			end
			goal = state.Goal
			if state.Pause > 0 then
				state.Pause -= dt
				speed = 0
			elseif (goal - flat).Magnitude < 3 then
				state.Goal = randomPoint()
				state.Pause = math.random() * 1.5
				speed = 0
			end
		end
		-- poursuite terminée loin de chez lui : il rentre vite dans sa zone
		if state.Mode == "Wander" and (flat - clampToZone(flat)).Magnitude > 1 then
			goal = state.Goal
			speed = RETURN_SPEED -- il rentre 3 fois plus vite que sa vitesse de base
		end
		if state.Mode == "Return" then
			goal = state.Goal
			speed = RETURN_SPEED
			if (goal - flat).Magnitude < 4 then -- arrivé : il repose les œufs
				for i, stolen in state.StolenList or {} do
					binds.ReturnEgg:Fire(config.Zone, stolen, Vector3.new(flat.X + (i - 1) * 4, floorY, flat.Z))
				end
				if state.StolenVisual then state.StolenVisual:Destroy() end
				state.StolenList, state.StolenVisual = nil, nil
				state.Mode = "Wander"
				state.Pause = 1
			end
		end
		-- il revient à pied : s'il est encore en l'air, il ralentit pour descendre d'abord
		if state.Mode ~= "Chase" and position.Y - (floorY + rootHeight) > 3 then
			speed = math.min(speed, 5)
		end
		local toGoal = goal - flat
		local wanted, facing = Vector3.zero, nil
		if state.Mode == "Chase" and state.Follow and state.Timer >= WINDUP and not state.Rush then
			wanted = state.Follow
			facing = state.FaceGoal and (state.FaceGoal - flat).Magnitude > 0.5 and (state.FaceGoal - flat).Unit or nil
		elseif speed > 0 and toGoal.Magnitude > 0.5 then
			facing = toGoal.Unit
			if state.Mode ~= "Chase" then speed = math.min(speed, math.max(10, toGoal.Magnitude * 3)) end -- il ralentit en arrivant
			wanted = facing * (speed > 1 and speed or 0)
		end
		if state.Mode ~= "Chase" then state.Follow, state.FaceGoal = nil, nil end
		-- mouvement fluide : la vitesse rejoint la vitesse voulue en douceur (il accélère, freine et tourne en courbe, sans à-coup)
		local rate = state.Mode == "Chase" and 22 or (wanted.Magnitude > 0 and 3.5 or 5) -- en poursuite il réagit vite, sans à-coup
		state.Velocity = state.Rush and wanted or (state.Velocity or Vector3.zero):Lerp(wanted, 1 - math.exp(-dt * rate))
		local velocity = state.Velocity
		local faceDist = state.FaceGoal and (state.FaceGoal - flat).Magnitude or math.huge
		if state.Mode == "Chase" and state.FaceGoal and faceDist > 0.5 and velocity.Magnitude < 4 then
			local dir = (state.FaceGoal - flat).Unit
			state.Yaw = math.atan2(dir.X, dir.Z)           -- en poursuite, de près : il regarde le joueur (il le suit bien du regard)
		elseif velocity.Magnitude > 2 then
			state.Yaw = math.atan2(velocity.X, velocity.Z) -- il regarde là où il va
		elseif facing then
			state.Yaw = math.atan2(facing.X, facing.Z)     -- à l'arrêt (intimidation) : il se tourne vers sa cible
		end
		-- reste à hauteur du sol de la zone
		local liftStrength = state.Mode == "Chase" and 12 or 20
		local lift = math.clamp((flyY - position.Y) * liftStrength, state.Mode == "Chase" and -200 or -400, 120) -- il monte vite et redescend encore plus vite
		local flying = position.Y - (floorY + rootHeight) > 2
		if not flying and not state.Jump and flyY > floorY + rootHeight + HIGH_ABOVE * 0.6 and state.Mode == "Chase" then
			state.Jump = 0
			state.Boost = JUMP_CROUCH + JUMP_BOOST_TIME -- élan : il fonce après son saut
			boss:SetAttribute("Jump", true)
		end
		if state.Jump then
			state.Jump += dt
			if state.Jump < JUMP_CROUCH then       -- s'accroupit sur place
				lift = (floorY + rootHeight - position.Y) * 8
				state.Velocity *= math.exp(-dt * 10) -- il freine pour se ramasser
				velocity = state.Velocity
			elseif state.Jump < JUMP_CROUCH + 0.55 then -- bondit
				lift = 62 * (1 - (state.Jump - JUMP_CROUCH) / 0.55 * 0.7)
			else
				state.Jump = nil
				boss:SetAttribute("Jump", false)
			end
		end
		if flying ~= state.Flying then
			state.Flying = flying
			if not flying then -- atterrissage : nuage de poussière et onde de choc
				local dust = root:FindFirstChild("RageDust") and root.RageDust:FindFirstChildOfClass("ParticleEmitter")
				if dust then dust:Emit(50) end
				local ring = Instance.new("Part")
				ring.Shape = Enum.PartType.Cylinder
				ring.Material = Enum.Material.Neon
				ring.Color = Color3.fromRGB(255, 244, 214)
				ring.Transparency = 0.35
				ring.Anchored, ring.CanCollide, ring.CanQuery, ring.CanTouch, ring.CastShadow = true, false, false, false, false
				ring.Size = Vector3.new(0.4, 8, 8)
				ring.CFrame = CFrame.new(position.X, position.Y - rootHeight + 0.3, position.Z) * CFrame.Angles(0, 0, math.rad(90))
				ring.Parent = workspace
				game:GetService("TweenService"):Create(ring, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(0.4, 70, 70), Transparency = 1}):Play()
				game:GetService("Debris"):AddItem(ring, 0.6)
			end
			boss:SetAttribute("Flying", flying)
		end
		drive.VectorVelocity = velocity + Vector3.new(0, lift, 0)
		-- rotation lissée ici (pas de saut d'angle) ; en poursuite il pivote vite pour coller aux virages du joueur
		local current = state.SmoothYaw or state.Yaw
		local diff = (state.Yaw - current + math.pi) % (2 * math.pi) - math.pi
		state.SmoothYaw = current + diff * (1 - math.exp(-dt * (state.Mode == "Chase" and 18 or 6)))
		steer.MaxAngularVelocity = state.Mode == "Chase" and 24 or 5
		steer.CFrame = CFrame.Angles(0, state.SmoothYaw, 0)
	end)
	Players.PlayerRemoving:Connect(function(player)
		if state.Target == player then setChasing(nil) end
	end)
end
-- thème Halloween : les gardiens sont déguisés (zombie, vampire, squelette...) et changent de nom
if game:GetService("Lighting"):GetAttribute("Theme") == "Halloween" and ServerStorage:FindFirstChild("HalloweenBossSkins") then
	local Skins = require(ServerStorage.HalloweenBossSkins)
	for _, config in BOSSES do
		local title = Skins.Titles[config.Template]
		if title then
			config.Title, config.Name = title, title
			config.Skin = function(boss) Skins.Apply(boss, config.Template) end
		end
	end
end
for _, config in BOSSES do task.spawn(startBoss, config) end