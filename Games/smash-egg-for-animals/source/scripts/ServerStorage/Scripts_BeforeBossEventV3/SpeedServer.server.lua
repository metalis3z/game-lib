-- Speed : gain sur le tapis de sa base, améliorations du tapis (payées en argent), vitesse de course.
-- Les attributs Speed et TreadmillLevel du joueur sont chargés et sauvegardés par PetServer.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShopConfig = require(ReplicatedStorage:WaitForChild("ShopSystem"):WaitForChild("ShopConfig")) -- passes Double / x4 / x8 Speed
local MarketplaceService = game:GetService("MarketplaceService")
local ServerStorage = game:GetService("ServerStorage")

local system = ReplicatedStorage:WaitForChild("SpeedSystem")
local Config = require(system:WaitForChild("SpeedConfig"))
local upgradeRemote = system:WaitForChild("Upgrade")
local gainRemote = system:WaitForChild("Gain")
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local notifyRemote = ReplicatedStorage.EggSystem:WaitForChild("Remotes"):WaitForChild("Notify")
local bases = workspace:WaitForChild("all base")

local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local HEAVY_SLOW = 0.8 -- un animal de plus de 100 000 kg sur la tête : on court 1,25 fois moins vite
local function baseOf(player)
	local number = player:GetAttribute("BaseNumber")
	return number and bases:FindFirstChild("base " .. number)
end
local function ownerOf(base)
	return Players:GetPlayerByUserId(base:GetAttribute("OwnerUserId") or 0)
end

---------------------------------------------------------------- apparence et affichages du tapis
local function label(parent, name, pos, size, color)
	local l = Instance.new("TextLabel")
	l.Name = name
	l.BackgroundTransparency = 1
	l.Position, l.Size = pos, size
	l.FontFace = FONT
	l.TextScaled, l.TextColor3, l.Text = true, color or Color3.new(1, 1, 1), ""
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3
	stroke.Parent = l
	l.Parent = parent
	return l
end

-- panneau d'améliorations : la partie lue par tout le monde (le bouton d'achat est ajouté côté client pour le propriétaire)
local function boardGui(base)
	local screen = base:FindFirstChild("TreadmillBoard") and base.TreadmillBoard:FindFirstChild("Screen")
	if not screen then return nil end
	local gui = screen:FindFirstChild("Info")
	if gui and gui:FindFirstChild("Levels") then return gui end
	if gui then gui:Destroy() end -- ancienne présentation
	local prompt = screen:FindFirstChild("UpgradePrompt") -- l'invite [E] a été remplacée par les boutons de l'écran
	if prompt then prompt:Destroy() end
	gui = Instance.new("SurfaceGui")
	gui.Name = "Info"
	gui.Face = Enum.NormalId.Back
	gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	gui.PixelsPerStud = 40
	gui.LightInfluence = 0
	label(gui, "Title", UDim2.fromScale(0.04, 0.05), UDim2.fromScale(0.92, 0.19)).Text = "Upgrade the treadmill"
	label(gui, "Levels", UDim2.fromScale(0.04, 0.29), UDim2.fromScale(0.92, 0.2))
	label(gui, "Gain", UDim2.fromScale(0.04, 0.5), UDim2.fromScale(0.92, 0.11), Color3.fromRGB(120, 255, 120))
	gui.Parent = screen
	return gui
end

-- Une base sans joueur n'a ni tapis ni panneau. Le panneau attend dans ServerStorage et revient quand quelqu'un prend la base.
-- Le tapis, lui, est une copie du modèle de son palier (ServerStorage.TreadmillModels : un modèle tous les 5 niveaux, construits
-- par ServerStorage.TreadmillBuilder) posée sur le repère TreadmillSpot de la base : il change de forme à chaque palier.
local hiddenBoards = ServerStorage:FindFirstChild("HiddenTreadmills") or Instance.new("Folder")
hiddenBoards.Name = "HiddenTreadmills"
hiddenBoards.Parent = ServerStorage
local templates = ServerStorage:WaitForChild("TreadmillModels")
local function showBoard(base, shown)
	local store = hiddenBoards:FindFirstChild(base.Name)
	if shown then
		for _, model in store and store:GetChildren() or {} do model.Parent = base end
	else
		local board = base:FindFirstChild("TreadmillBoard")
		if not board then return end
		if not store then
			store = Instance.new("Folder")
			store.Name = base.Name
			store.Parent = hiddenBoards
		end
		board.Parent = store
	end
end
-- skin = nil : la base n'a pas de joueur, donc pas de tapis
local function setTreadmill(base, skin)
	local current = base:FindFirstChild("Treadmill")
	if not skin then
		if current then current:Destroy() end
		return nil
	end
	if current and current:GetAttribute("Skin") == skin.Name then return current end
	local spot, template = base:FindFirstChild("TreadmillSpot"), templates:FindFirstChild(skin.Name)
	if not spot or not template then return current end
	local model = template:Clone()
	model.Name = "Treadmill"
	model:PivotTo(spot.CFrame)
	model.Parent = base -- le nouveau arrive avant que l'ancien parte : le coureur ne tombe pas
	if current then current:Destroy() end
	return model
end

local function refreshBase(base)
	local owner = ownerOf(base)
	showBoard(base, owner ~= nil)
	local level = owner and owner:GetAttribute("TreadmillLevel") or 0
	local skin = Config.Skin(level)
	local treadmill = setTreadmill(base, owner and skin or nil)
	-- le panneau prend les couleurs du palier
	local board = base:FindFirstChild("TreadmillBoard")
	for _, p in board and board:GetDescendants() or {} do
		if p:IsA("BasePart") then
			local role = p:GetAttribute("Role")
			if role == "Frame" then
				p.Color = skin.Frame
			elseif role == "Trim" then
				p.Color = skin.Trim
				p.Material = skin.NeonTrim and Enum.Material.Neon or Enum.Material.Plastic
			elseif role == "Glow" then
				p.Color = skin.Glow
			end
		end
	end
	if not treadmill then return end
	local display = treadmill:FindFirstChild("Screen") and treadmill.Screen:FindFirstChild("Display")
	if display then
		display.Gain.Text = "+" .. Config.Format(Config.GainPerSecond(level)) .. "/s"
		display.Level.Text = "LEVEL " .. level
	end
	local gui = boardGui(base)
	if gui then
		local maxed = level >= Config.MaxLevel
		gui.Levels.Text = maxed and ("Level " .. level .. " (MAX)") or ("Level " .. level .. " > Level " .. (level + 1))
		gui.Gain.Text = "+" .. Config.Format(Config.GainPerSecond(level)) .. "/s" .. (maxed and "" or ("  >  +" .. Config.Format(Config.GainPerSecond(level + 1)) .. "/s"))
	end
end
for _, base in bases:GetChildren() do
	refreshBase(base)
	base:GetAttributeChangedSignal("OwnerUserId"):Connect(function() refreshBase(base) end)
end

---------------------------------------------------------------- vitesse de course
local function applyWalk(player)
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	if player:GetAttribute("OnTreadmill") then humanoid.WalkSpeed = 0 return end -- figé sur la bande : il court sur place
	if player:GetAttribute("SlowMode") then humanoid.WalkSpeed = Config.BaseWalk return end -- Slow Mode (bouton à gauche de l'écran) : vitesse de départ, 16
	humanoid.WalkSpeed = Config.Walk(player:GetAttribute("Speed") or 0) * (player:GetAttribute("CarryHeavy") and HEAVY_SLOW or 1)
end

-- Slow Mode : le joueur choisit de marcher à la vitesse de départ (pratique quand son speed le rend trop rapide à diriger)
system:WaitForChild("SlowMode").OnServerEvent:Connect(function(player, on)
	player:SetAttribute("SlowMode", on == true or nil)
end)

---------------------------------------------------------------- amélioration du tapis
local function upgrade(player)
	local level = player:GetAttribute("TreadmillLevel")
	if not level then return end -- données pas encore chargées
	if level >= Config.MaxLevel then
		notifyRemote:FireClient(player, "Your treadmill is already at max level!")
		return
	end
	local cost = Config.Cost(level)
	local money = player:GetAttribute("Money") or 0
	if money < cost then
		notifyRemote:FireClient(player, "Not enough money! You need " .. EggConfig.FormatMoney(cost))
		return
	end
	player:SetAttribute("Money", money - cost)
	player:SetAttribute("TreadmillLevel", level + 1)
	local skin = Config.Skin(level + 1)
	if skin.Level == level + 1 and skin.Level > 0 then notifyRemote:FireClient(player, string.upper(skin.Name) .. " TREADMILL unlocked!") end
end
upgradeRemote.OnServerEvent:Connect(function(player, withRobux)
	if withRobux ~= true then upgrade(player) return end
	-- bouton Robux : un niveau acheté avec le produit Config.RobuxProductId (0 = produit pas encore créé)
	local level = player:GetAttribute("TreadmillLevel")
	if not level or level >= Config.MaxLevel then return end
	if Config.RobuxProductId == 0 then
		notifyRemote:FireClient(player, "Robux upgrades are coming soon!")
	else
		MarketplaceService:PromptProductPurchase(player, Config.RobuxProductId)
	end
end)
require(game:GetService("ServerScriptService"):WaitForChild("Purchases")).register(Config.RobuxProductId, function(player)
	local level = player:GetAttribute("TreadmillLevel")
	if not level then return false end -- pas encore chargé : Roblox réessaiera
	if level < Config.MaxLevel then
		player:SetAttribute("TreadmillLevel", level + 1)
		notifyRemote:FireClient(player, "Treadmill upgraded to level " .. (level + 1) .. "!")
	end
	return true
end)

local function onPlayer(player)
	player:GetAttributeChangedSignal("Speed"):Connect(function() applyWalk(player) end)
	player:GetAttributeChangedSignal("CarryHeavy"):Connect(function() applyWalk(player) end)
	player:GetAttributeChangedSignal("SlowMode"):Connect(function() applyWalk(player) end)
	player:GetAttributeChangedSignal("TreadmillLevel"):Connect(function()
		local base = baseOf(player)
		if base then refreshBase(base) end
	end)
	player.CharacterAdded:Connect(function(character)
		character:WaitForChild("Humanoid", 10)
		applyWalk(player)
	end)
	applyWalk(player)
end
Players.PlayerAdded:Connect(onPlayer)
for _, player in Players:GetPlayers() do onPlayer(player) end

---------------------------------------------------------------- gain : le propriétaire court sur la bande de son tapis
-- Dès qu'il monte dessus il ne peut plus avancer ; un saut le fait descendre. C'est son propre écran (SpeedClient) qui le voit
-- monter, l'arrête et le fait glisser en douceur au milieu de la bande, face à la console : il prévient avec le remote Mount.
-- Le serveur ne déplace plus le personnage (ça donnait un à-coup) ; il vérifie seulement qu'il est bien sur sa bande.
local STAND = 3.4      -- hauteur de la racine du personnage au-dessus du centre de la bande quand il est posé dessus
local EXIT_PAUSE = 2   -- secondes après un saut pendant lesquelles la bande ne le reprend pas
local MOUNT_GRACE = 0.6 -- secondes laissées à la position du joueur pour arriver jusqu'au serveur après sa montée
local leftAt = {}      -- [player] = heure de sa dernière descente
local mountedAt = {}   -- [player] = heure de sa montée annoncée par son écran
Players.PlayerRemoving:Connect(function(player) leftAt[player], mountedAt[player] = nil, nil end)
system:WaitForChild("Mount").OnServerEvent:Connect(function(player)
	if player:GetAttribute("OnTreadmill") or os.clock() - (leftAt[player] or 0) <= EXIT_PAUSE then return end
	local base = baseOf(player)
	local belt = base and base:FindFirstChild("Treadmill") and base.Treadmill:FindFirstChild("Belt")
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if not (belt and root and humanoid and humanoid.Health > 0 and player:GetAttribute("Speed")) then return end
	if (root.Position - belt.Position).Magnitude > belt.Size.Z + 40 then return end -- large : à grande vitesse sa position arrive en retard
	mountedAt[player] = os.clock()
	player:SetAttribute("OnTreadmill", true)
	humanoid.WalkSpeed = 0
end)
while true do
	task.wait(Config.Tick)
	for _, player in Players:GetPlayers() do
		local on = false
		local speed, level = player:GetAttribute("Speed"), player:GetAttribute("TreadmillLevel")
		local base = baseOf(player)
		local belt = base and base:FindFirstChild("Treadmill") and base.Treadmill:FindFirstChild("Belt")
		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if speed and level and belt and root and humanoid and humanoid.Health > 0 then
			local rel = belt.CFrame:PointToObjectSpace(root.Position)
			local was = player:GetAttribute("OnTreadmill") == true
			local jumped = was and (rel.Y > STAND + 1.1 or humanoid:GetState() == Enum.HumanoidStateType.Jumping)
			if jumped then leftAt[player] = os.clock() end
			local inside = math.abs(rel.X) <= belt.Size.X / 2 + 0.6 and math.abs(rel.Z) <= belt.Size.Z / 2 + 0.6 and rel.Y > 0 and rel.Y < 9
			if was and not inside and not jumped and os.clock() - (mountedAt[player] or 0) < MOUNT_GRACE then
				on = true -- il vient de monter : sa position n'est pas encore arrivée ici (pas de gain ce tour-ci)
			elseif inside and not jumped and os.clock() - (leftAt[player] or 0) > EXIT_PAUSE then
				on = true
				if not was then -- son écran ne l'a pas annoncé (remote perdu) : on le prend quand même
					player:SetAttribute("OnTreadmill", true)
					humanoid.WalkSpeed = 0
				end
				local gain = Config.Gain(level) * math.max(player:GetAttribute("TrailMult") or 1, 1) -- la traînée équipée multiplie le gain (TrailServer)
					* ShopConfig.SpeedMult(player) * math.max(tonumber(ReplicatedStorage:GetAttribute("SpeedEventMult")) or 1, 1) -- + event admin 2X / 4X SPEED (SpeedEventServer) -- gamepass Double / x4 / x8 Speed : le meilleur possédé (PassServer)
				player:SetAttribute("Speed", speed + gain)
				gainRemote:FireClient(player, gain)
			end
		end
		if (player:GetAttribute("OnTreadmill") or false) ~= on then
			player:SetAttribute("OnTreadmill", on or nil)
			applyWalk(player)
		end
	end
end
