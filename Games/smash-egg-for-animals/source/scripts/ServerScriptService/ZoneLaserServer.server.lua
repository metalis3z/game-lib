-- Lasers des zones d'œufs : dès qu'un joueur ramasse un animal dans une zone, des murs laser rouges s'allument dans cette zone
-- et balaient l'espace. S'il en touche un, il perd ce qu'il porte et il est renvoyé près des boutiques (comme avec le gardien).
-- Plus la zone est rare, plus il y a de lasers et plus ils sont rapides. Ils s'éteignent quand le joueur ne porte plus rien de la zone.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local binds = ServerStorage:WaitForChild("GameBindables")
local alert = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("BossAlert")

local LEVELS = {"common", "uncommon", "rare", "epic", "legendary", "mythic", "secret"} -- difficulté = place de la rareté (1 à 7)
local WARMUP = 1.2      -- secondes avant qu'un laser qui s'allume devienne dangereux
local THICKNESS = 1.4
local CEILING = 55      -- hauteur maximale des lasers au-dessus du sol de la zone
local HIT_RADIUS = 3.2  -- "épaisseur" du joueur / du dragon
local RED = Color3.fromRGB(255, 30, 30)

local folder = Instance.new("Folder")
folder.Name = "ZoneLasers"
folder.Parent = workspace

local function levelOf(zoneName)
	local lower = string.lower(zoneName)
	for level, prefix in LEVELS do
		if string.sub(lower, 1, #prefix) == prefix then return level end
	end
	return 1
end

local function returnPoint()
	local a, b = workspace:FindFirstChild("egg shop"), workspace:FindFirstChild("dragon shop")
	if a and b then
		local mid = (a:GetBoundingBox().Position + b:GetBoundingBox().Position) / 2
		local hit = workspace:Raycast(Vector3.new(mid.X - 22, mid.Y + 60, mid.Z), Vector3.new(0, -200, 0))
		return Vector3.new(mid.X - 22, hit and hit.Position.Y or 0, mid.Z)
	end
	local safe = workspace:FindFirstChild("safe zone")
	return safe and (safe.Position + Vector3.new(0, safe.Size.Y / 2, 0)) or Vector3.new(0, 5, 0)
end

local function targetOf(player) -- {racine du dragon monté, dragon} ou la racine du personnage
	local dragons = workspace:FindFirstChild("Dragons")
	for _, dragon in dragons and dragons:GetChildren() or {} do
		if dragon:GetAttribute("Rider") == player.UserId and dragon.PrimaryPart then return dragon.PrimaryPart, dragon end
	end
	local character = player.Character
	return character and character:FindFirstChild("HumanoidRootPart"), nil
end

local function beam(size)
	local part = Instance.new("Part")
	part.Name = "Laser"
	part.Anchored = true
	part.CanCollide, part.CanTouch, part.CanQuery, part.CastShadow = false, false, false, false
	part.Material = Enum.Material.Neon
	part.Color = RED
	part.Size = size
	part.Transparency = 0.75
	local glow = part:Clone()
	glow.Name = "Glow"
	glow.Material = Enum.Material.ForceField
	glow.Size = size + Vector3.new(0, 2, 2)
	glow.Transparency = 0.5
	glow.Parent = part
	part.Parent = folder
	return part, glow
end

local active = {} -- [player] = {[zoneName] = {Lasers, Born}}

local function clear(player, zoneName)
	local zones = active[player]
	local set = zones and zones[zoneName]
	if not set then return end
	for _, laser in set.Lasers do laser.Part:Destroy() end
	zones[zoneName] = nil
end

local function start(player, zoneName)
	local zone = workspace:FindFirstChild(zoneName)
	if not zone or not zone:IsA("BasePart") then return end
	active[player] = active[player] or {}
	if active[player][zoneName] then return end
	local level = levelOf(zoneName)
	local rng = Random.new()
	local floorY = zone.Position.Y + zone.Size.Y / 2
	local long = zone.Size.X >= zone.Size.Z and "X" or "Z"          -- grand axe de la zone
	local length = math.max(zone.Size.X, zone.Size.Z)
	local width = math.min(zone.Size.X, zone.Size.Z)
	local lasers = {}
	local speed = 14 + level * 7
	-- 1) murs qui balaient la zone dans sa longueur, à différentes hauteurs
	for i = 1, 2 + level do
		local part, glow = beam(Vector3.new(long == "Z" and width or THICKNESS, THICKNESS, long == "Z" and THICKNESS or width))
		table.insert(lasers, {Part = part, Glow = glow, Kind = "Sweep", Height = 2 + rng:NextNumber(0, 1) ^ 1.6 * (CEILING - 8), Phase = rng:NextNumber(0, math.pi * 2), Speed = speed * rng:NextNumber(0.7, 1.2)})
	end
	-- 2) barres qui montent et descendent, posées en travers
	for i = 1, 1 + math.floor(level / 2) do
		local part, glow = beam(Vector3.new(long == "Z" and width or THICKNESS, THICKNESS, long == "Z" and THICKNESS or width))
		table.insert(lasers, {Part = part, Glow = glow, Kind = "Rise", Along = (i / (2 + math.floor(level / 2)) - 0.5) * length, Phase = rng:NextNumber(0, math.pi * 2), Speed = speed * 0.7})
	end
	-- 3) à partir des zones rares : grandes barres qui tournent autour du centre
	for i = 1, math.max(0, level - 2) do
		local part, glow = beam(Vector3.new(width * 0.95, THICKNESS, THICKNESS))
		table.insert(lasers, {Part = part, Glow = glow, Kind = "Spin", Height = 3 + rng:NextNumber(0, CEILING - 12), Along = rng:NextNumber(-0.35, 0.35) * length, Phase = rng:NextNumber(0, math.pi * 2), Speed = (0.5 + level * 0.14) * (rng:NextNumber() < 0.5 and -1 or 1)})
	end
	active[player][zoneName] = {Lasers = lasers, Born = os.clock(), Zone = zone, FloorY = floorY, Long = long, Length = length}
	alert:FireClient(player, "Lasers activated! Get out of the zone!")
end

binds:WaitForChild("EggGrabbed").Event:Connect(start)

RunService.Heartbeat:Connect(function()
	local now = os.clock()
	for player, zones in active do
		local carrying = player:GetAttribute("CarryZones") or ""
		for zoneName, set in zones do
			local age = now - set.Born
			if not player.Parent or (age > 1 and not string.find(carrying, "|" .. zoneName .. "|", 1, true)) then
				clear(player, zoneName)
				continue
			end
			local zone = set.Zone
			local armed = age >= WARMUP
			local target = armed and targetOf(player)
			local hit = false
			for _, laser in set.Lasers do
				local cf
				if laser.Kind == "Sweep" then
					local along = math.sin(now * laser.Speed / set.Length * 2 + laser.Phase) * set.Length / 2
					cf = CFrame.new(zone.Position + Vector3.new(set.Long == "X" and along or 0, zone.Size.Y / 2 + laser.Height, set.Long == "Z" and along or 0))
				elseif laser.Kind == "Rise" then
					local height = 2 + (math.sin(now * laser.Speed / 20 + laser.Phase) * 0.5 + 0.5) * (CEILING - 6)
					cf = CFrame.new(zone.Position + Vector3.new(set.Long == "X" and laser.Along or 0, zone.Size.Y / 2 + height, set.Long == "Z" and laser.Along or 0))
				else
					cf = CFrame.new(zone.Position + Vector3.new(set.Long == "X" and laser.Along or 0, zone.Size.Y / 2 + laser.Height, set.Long == "Z" and laser.Along or 0)) * CFrame.Angles(0, now * laser.Speed + laser.Phase, 0)
				end
				laser.Part.CFrame = cf
				laser.Glow.CFrame = cf
				-- allumage : il clignote d'abord, puis devient plein et dangereux
				laser.Part.Transparency = armed and 0 or (0.5 + 0.4 * math.sin(now * 25))
				if target and not hit then
					local r = cf:PointToObjectSpace(target.Position)
					local half = laser.Part.Size / 2
					if math.abs(r.X) <= half.X + HIT_RADIUS and math.abs(r.Y) <= half.Y + HIT_RADIUS and math.abs(r.Z) <= half.Z + HIT_RADIUS then hit = true end
				end
			end
			if hit then
				local root, dragon = targetOf(player)
				binds.DropCarried:Fire(player) -- il perd ce qu'il porte
				local destination = returnPoint()
				if dragon then
					dragon:PivotTo(CFrame.new(destination + Vector3.new(0, 3, 0)))
					dragon.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
				elseif player.Character then
					player.Character:PivotTo(CFrame.new(destination + Vector3.new(0, 5, 0)))
				end
				alert:FireClient(player, "You were hit by a laser!", true)
				clear(player, zoneName)
			end
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	for zoneName in active[player] or {} do clear(player, zoneName) end
	active[player] = nil
end)
