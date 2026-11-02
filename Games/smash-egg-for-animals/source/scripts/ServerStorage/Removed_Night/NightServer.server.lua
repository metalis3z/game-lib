-- Nuit : toutes les DAY_LENGTH secondes la nuit tombe pendant NIGHT_LENGTH secondes.
-- Quand elle tombe : fondu noir chez tout le monde, retour au spawn, et un mur blanc remplit toute la carte (de la zone sûre à la dernière zone,
-- du sol au plafond invisible). Il affiche un compte à rebours de WALL_TIME secondes, puis pendant RESET_TIME secondes "les œufs ont été réinitialisés"
-- (tous les œufs des zones sont remplacés), puis il s'enfonce dans le sol et disparaît.
-- Admin : remote AdminSystem.Remotes.StartNight(scope) — "server" = ce serveur, sinon tous les serveurs.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local MessagingService = game:GetService("MessagingService")

local DAY_LENGTH = 285    -- secondes de jour entre deux nuits (4 min 45)
local HUGE_EVERY = 6       -- un Huge Egg toutes les 6 nuits : 6 x (285 + 15) s = 30 min pile
local NIGHT_LENGTH = 15   -- la nuit dure 15 secondes : 10 de compte à rebours, 5 pendant que les œufs changent
local WALL_TIME = 10      -- compte à rebours sur le mur
local RESET_TIME = 5      -- puis "les œufs ont été réinitialisés"
local WALL_SINK = 1.1        -- secondes pour que le mur s'enfonce (en douceur)
local NIGHT_ICON = "rbxassetid://131317614803230"
local TOPIC = "AdminNight"
local hugeDue = false -- vrai pendant la nuit où le Huge Egg doit apparaître
-- couloir des zones : mesuré à chaque nuit sur la carte (largeur de la première zone d'œufs, ouverture entre les murs
-- au bord de la zone sûre), ainsi que le début du mur et sa hauteur. Valeurs de secours si la mesure échoue :
local GATE_Z0, GATE_Z1 = -251.5, -84.5 -- ouverture de la zone sûre
local LANE_Z0, LANE_Z1 = -251.5, -84.5 -- couloir des zones
local GATE_DEPTH = 28
local WALL_END_X = 10000
local DEFAULT_TOP = 69

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local bindables = ServerStorage:WaitForChild("GameBindables")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")

local fade = ReplicatedStorage:FindFirstChild("NightFade") or Instance.new("RemoteEvent")
fade.Name = "NightFade"
fade.Parent = ReplicatedStorage

local DAY = {ClockTime = Lighting.ClockTime, Brightness = Lighting.Brightness, OutdoorAmbient = Lighting.OutdoorAmbient}
local NIGHT = {Brightness = 1.4, OutdoorAmbient = Color3.fromRGB(70, 75, 120)}

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

local NIGHT_FRONT = 38 -- la nuit, les joueurs sont posés à 38 studs DEVANT le mur (face à son écran), en rangs
local faceRemote = ReplicatedStorage:FindFirstChild("NightFace") or Instance.new("RemoteEvent")
faceRemote.Name = "NightFace" -- le client tourne sa caméra vers le mur (NightFaceClient)
faceRemote.Parent = ReplicatedStorage
local function sendHome(player, index, front)
	local destination, look
	if front then
		-- rangs de 8, face au mur (côté zone sûre), centrés sur l'écran
		local col, row = index % 8, index // 8
		local inRow = math.min(8, front.Count - row * 8) -- chaque rang est centré sur l'écran du mur
		local x, z = front.X - row * 7, front.Z + (col - (inRow - 1) / 2) * 7
		local hit = workspace:Raycast(Vector3.new(x, front.Floor + 40, z), Vector3.new(0, -120, 0))
		destination = Vector3.new(x, hit and hit.Position.Y or front.Floor, z)
		look = Vector3.new(1, 0, 0)
	else
		destination = returnPoint() + Vector3.new(-(index % 4) * 7, 0, ((index // 4) % 5 - 2) * 7)
	end
	local function place(offsetY)
		local at = destination + Vector3.new(0, offsetY, 0)
		return look and CFrame.lookAt(at, at + look) or CFrame.new(at)
	end
	local dragons = workspace:FindFirstChild("Dragons")
	for _, dragon in dragons and dragons:GetChildren() or {} do
		if dragon:GetAttribute("Rider") == player.UserId and dragon.PrimaryPart then
			dragon:PivotTo(place(3))
			dragon.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
			if look then faceRemote:FireClient(player, front.Look) end
			return
		end
	end
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if root then
		root.AssemblyLinearVelocity = Vector3.zero
		character:PivotTo(place(5))
		if look then faceRemote:FireClient(player, front.Look) end
	end
end

-- début du mur (bord de la zone sûre), sol, et plafond invisible au-dessus du couloir
local function measure()
	local safe = workspace:FindFirstChild("safe zone")
	local x0 = safe and (safe.Position.X + safe.Size.X / 2) or 29
	local floor = safe and (safe.Position.Y + safe.Size.Y / 2) or 0
	local top = DEFAULT_TOP
	local params = RaycastParams.new()
	local ignore = {}
	local origin = Vector3.new(x0 + GATE_DEPTH + 240, floor + 5, (LANE_Z0 + LANE_Z1) / 2)
	for _ = 1, 25 do
		params.FilterDescendantsInstances = ignore
		local hit = workspace:Raycast(origin, Vector3.new(0, 3000, 0), params)
		if not hit then break end
		if hit.Instance.Transparency >= 1 and hit.Instance.CanCollide then
			top = hit.Position.Y
			break
		end
		table.insert(ignore, hit.Instance)
	end
	-- largeur du couloir : celle de la première zone d'œufs
	local laneZ0, laneZ1 = LANE_Z0, LANE_Z1
	for _, child in workspace:GetChildren() do
		local lower = string.lower(child.Name)
		if child:IsA("BasePart") and string.sub(lower, 1, 6) == "common" and string.find(lower, "egg zone", 1, true) then
			laneZ0, laneZ1 = child.Position.Z - child.Size.Z / 2, child.Position.Z + child.Size.Z / 2
		end
	end
	-- ouverture de la zone sûre : on cherche les murs de chaque côté (rayons le long de Z, au milieu du bloc de devant)
	local gateZ0, gateZ1 = laneZ0, laneZ1
	local center = Vector3.new(x0 + GATE_DEPTH / 2, floor + 6, (laneZ0 + laneZ1) / 2)
	local function wallAt(direction)
		local skip = {}
		for _, player in Players:GetPlayers() do if player.Character then table.insert(skip, player.Character) end end
		local rp = RaycastParams.new()
		for _ = 1, 25 do
			rp.FilterDescendantsInstances = skip
			local hit = workspace:Raycast(center, Vector3.new(0, 0, direction * 300), rp)
			if not hit then return nil end
			if hit.Instance.CanCollide and hit.Instance.Transparency < 1 and hit.Instance.Size.Y > 6 then return hit.Position.Z end
			table.insert(skip, hit.Instance)
		end
		return nil
	end
	local zA, zB = wallAt(-1), wallAt(1)
	if zA and zB and zB - zA > 40 then gateZ0, gateZ1 = zA, zB end
	return x0, floor, top, laneZ0, laneZ1, gateZ0, gateZ1
end

local function buildWall()
	local x0, floor, top, laneZ0, laneZ1, gateZ0, gateZ1 = measure()
	local height = top - floor
	local model = Instance.new("Model")
	model.Name = "NightWall"
	local function block(xa, xb, za, zb)
		local part = Instance.new("Part")
		part.Anchored = true
		part.Size = Vector3.new(xb - xa, height, zb - za)
		part.CFrame = CFrame.new((xa + xb) / 2, floor + height / 2, (za + zb) / 2)
		part.Color = Color3.new(1, 1, 1)
		part.Material = Enum.Material.SmoothPlastic
		part.TopSurface, part.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		part.CastShadow = false
		part.Parent = model
		return part
	end
	local front = block(x0, x0 + GATE_DEPTH, gateZ0, gateZ1) -- bouche juste l'ouverture de la zone sûre (rien ne dépasse des murs)
	local x = x0 + GATE_DEPTH
	while x < WALL_END_X do
		local length = math.min(2000, WALL_END_X - x)
		block(x, x + length, laneZ0, laneZ1)
		x += length
	end

	-- face côté spawn : icône de nuit + secondes
	local gui = Instance.new("SurfaceGui")
	gui.Face = Enum.NormalId.Left
	gui.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
	local width = gateZ1 - gateZ0
	gui.CanvasSize = Vector2.new(math.floor(width / height * 420), 420)
	gui.LightInfluence = 0
	gui.Brightness = 1
	local back = Instance.new("Frame")
	back.Size = UDim2.fromScale(1, 1)
	back.BorderSizePixel = 0
	back.BackgroundColor3 = Color3.new(1, 1, 1)
	back.Parent = gui
	local row = Instance.new("Frame")
	row.BackgroundTransparency = 1
	row.AnchorPoint = Vector2.new(0.5, 0.5)
	row.Position = UDim2.fromScale(0.5, 0.5)
	row.Size = UDim2.new(0, 760, 0, 390) -- l'icône en haut, les textes dessous
	row.Parent = back
	local icon = Instance.new("ImageLabel")
	icon.BackgroundTransparency = 1
	icon.Image = NIGHT_ICON
	icon.Size = UDim2.fromOffset(190, 190)
	icon.AnchorPoint = Vector2.new(0.5, 0)
	icon.Position = UDim2.new(0.5, 0, 0, 0)
	icon.Parent = row
	local font = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	local function text(str, position, size, color, thickness)
		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.Position, label.Size = position, size
		label.FontFace = font
		label.Text = str
		label.TextScaled = true
		label.TextColor3 = color
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = thickness
		stroke.Color = Color3.new(0, 0, 0)
		stroke.Parent = label
		label.Parent = row
		return label
	end
	local title = text("NIGHT", UDim2.fromOffset(0, 192), UDim2.new(1, 0, 0, 70), Color3.fromRGB(150, 175, 255), 7)
	local timer = text("10", UDim2.fromOffset(0, 264), UDim2.new(1, 0, 0, 124), Color3.new(1, 1, 1), 10)
	gui.Parent = front
	model.Parent = workspace
	return model, title, timer, height
end

local function setLighting(night, seconds)
	local info = TweenInfo.new(seconds or 3, Enum.EasingStyle.Sine)
	if Lighting:GetAttribute("FixedClock") then
		-- thème Halloween : le ciel est déjà nocturne, l'heure reste fixe (la lune ne bouge pas) et la nuit ne fait qu'assombrir
		local brightness = night and DAY.Brightness * 0.4 or DAY.Brightness
		local ambient = night and DAY.OutdoorAmbient:Lerp(Color3.new(0, 0, 0), 0.55) or DAY.OutdoorAmbient
		TweenService:Create(Lighting, info, {Brightness = brightness, OutdoorAmbient = ambient}):Play()
		return
	end
	if night then
		TweenService:Create(Lighting, info, {ClockTime = 24, Brightness = NIGHT.Brightness, OutdoorAmbient = NIGHT.OutdoorAmbient}):Play()
		task.delay(3.1, function() if ReplicatedStorage:GetAttribute("NightEnd") then Lighting.ClockTime = 0 end end)
	else
		Lighting.ClockTime = 0
		TweenService:Create(Lighting, info, {ClockTime = DAY.ClockTime, Brightness = DAY.Brightness, OutdoorAmbient = DAY.OutdoorAmbient}):Play()
	end
end

local nightsLeft = HUGE_EVERY -- nuits avant le prochain Huge Egg
local function notifyAll(text)
	for _, p in Players:GetPlayers() do notifyRemote:FireClient(p, text) end
end
local function runNight()
	local finish = workspace:GetServerTimeNow() + NIGHT_LENGTH + 0.55
	fade:FireAllClients() -- fondu noir
	task.wait(0.55)       -- l'écran est noir : on déplace tout le monde et le mur apparaît
	ReplicatedStorage:SetAttribute("NightEnd", finish)
	local okFront, x0, floor, top, _, _, gateZ0, gateZ1 = pcall(measure)
	local front = okFront and {X = x0 - NIGHT_FRONT, Z = (gateZ0 + gateZ1) / 2, Floor = floor, Count = #Players:GetPlayers(),
		Look = Vector3.new(x0, floor + math.min(top - floor, 60) * 0.5, (gateZ0 + gateZ1) / 2)} or nil -- (Look : le centre de l'écran du mur)
	for index, player in Players:GetPlayers() do sendHome(player, index - 1, front) end
	local wall, title, timer, height = buildWall()
	local clear = bindables:FindFirstChild("ClearEggs")
	if clear then pcall(function() clear:Invoke() end) end -- la nuit tombe : les œufs des zones disparaissent
	setLighting(true)
	local opens = os.clock() + WALL_TIME
	while os.clock() < opens do
		local left = opens - os.clock()
		timer.Text = tostring(math.ceil(left))
		timer.TextColor3 = left <= 3 and Color3.fromRGB(255, 110, 90) or Color3.new(1, 1, 1)
		task.wait(0.2)
	end
	-- les œufs sont réinitialisés : message sur le mur + annonce des œufs spéciaux apparus
	title.Text = "NEW EGGS!"
	timer.Text = "THE EGGS HAVE BEEN RESET"
	timer.TextColor3 = Color3.fromRGB(150, 255, 130)
	-- les nouveaux œufs apparaissent petit à petit pendant ces 5 secondes (annonce des œufs spéciaux quand c'est fini)
	task.spawn(function()
		local reset = bindables:FindFirstChild("ResetEggs")
		local ok, specials = pcall(function() return reset and reset:Invoke(RESET_TIME - WALL_SINK - 0.3) or {} end)
		-- c'est l'heure du Huge Egg : il apparaît avec les nouveaux œufs
		if hugeDue then
			hugeDue = false
			local huge = bindables:FindFirstChild("SpawnHugeEgg")
			local okHuge, info = pcall(function() return huge and huge:Invoke() end)
			if okHuge and type(info) == "table" then
				if ok and type(specials) == "table" then table.insert(specials, 1, info) end
				notifyAll("A HUGE EGG (" .. math.floor(info.Kg / 1000) .. "K kg) appeared in the " .. tostring(info.Zone) .. "!")
			end
		end
		if not ok then warn("[NightServer] egg reset failed: " .. tostring(specials)) end
		local announce = remotes:FindFirstChild("EggSpawnAnnounce")
		if announce then
			announce:FireAllClients("The eggs", "", "Reset")
			if ok and type(specials) == "table" then
				for index, special in specials do
					if index > 4 then break end
					announce:FireAllClients(special.Name, special.Zone, special.Rarity, nil, nil, nil, special.Giant)
				end
			end
		end
	end)
	-- les 5 dernières secondes : le soleil se lève pendant que les œufs changent, puis le mur tombe d'un coup
	setLighting(false, RESET_TIME)
	task.wait(RESET_TIME - WALL_SINK)
	for _, part in wall:GetChildren() do
		TweenService:Create(part, TweenInfo.new(WALL_SINK, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {CFrame = part.CFrame - Vector3.new(0, height + 4, 0)}):Play()
	end
	task.wait(WALL_SINK)
	wall:Destroy()
	ReplicatedStorage:SetAttribute("NightEnd", nil)
end

local force = false
local start = bindables:FindFirstChild("StartNight") or Instance.new("BindableEvent")
start.Name = "StartNight"
start.Parent = bindables
start.Event:Connect(function() force = true end)

pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function() force = true end)
end)
remotes:WaitForChild("StartNight").OnServerEvent:Connect(function(player, scope)
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	if ReplicatedStorage:GetAttribute("NightEnd") then
		notifyRemote:FireClient(player, "It is already night on this server")
		if scope == "server" then return end
	end
	local sent = scope ~= "server" and pcall(function() MessagingService:PublishAsync(TOPIC, {t = os.time()}) end)
	if not sent then force = true end
	notifyRemote:FireClient(player, sent and "Night started on ALL servers" or "Night started on this server")
end)

while true do
	local nightAt = workspace:GetServerTimeNow() + DAY_LENGTH
	ReplicatedStorage:SetAttribute("NightAt", nightAt)
	-- heure prévue du prochain Huge Egg (pendant la réinitialisation des œufs de la nuit où il tombe)
	ReplicatedStorage:SetAttribute("HugeEggAt", nightAt + (nightsLeft - 1) * (DAY_LENGTH + NIGHT_LENGTH + 0.55) + 0.55 + WALL_TIME)
	force = false
	while workspace:GetServerTimeNow() < nightAt and not force do task.wait(0.25) end
	ReplicatedStorage:SetAttribute("NightAt", nil)
	ReplicatedStorage:SetAttribute("IsNight", true) -- plus aucune nouvelle mutation d'œuf (EggConfig.MutationsAllowed)
	nightsLeft -= 1
	if nightsLeft <= 0 then nightsLeft = HUGE_EVERY hugeDue = true end
	local ok, err = pcall(runNight)
	if not ok then warn("[NightServer] night failed: " .. tostring(err)) ReplicatedStorage:SetAttribute("NightEnd", nil) end
	ReplicatedStorage:SetAttribute("IsNight", nil) -- le jour revient : les mutations reprennent
end
