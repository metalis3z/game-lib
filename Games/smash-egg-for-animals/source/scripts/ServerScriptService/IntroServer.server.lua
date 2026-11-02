-- Cinématique d'arrivée, côté serveur. La cinématique elle-même est jouée sur l'écran du joueur (StarterPlayerScripts.IntroClient).
-- Ici on s'occupe de ce que seul le serveur peut faire :
--   le streaming : pendant la cinématique la caméra est loin du personnage, donc on déplace le « point de chargement » du joueur
--                  (ReplicationFocus) vers la forêt, puis le long des zones, pour que le décor soit là quand la caméra passe ;
--   le boss : une copie du gardien de la dernière zone est posée dans la forêt tant qu'un joueur regarde la cinématique.
-- Le joueur envoie "start", puis "fly" (survol des zones), puis "end". Tout est remis en place au bout de MaxTime quoi qu'il arrive.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local system = ReplicatedStorage:WaitForChild("IntroSystem")
local Config = require(system:WaitForChild("IntroConfig"))
local stage = system:WaitForChild("Stage")
local forest = ReplicatedStorage:WaitForChild("IntroForest") -- hors du monde : chaque joueur en pose une copie chez lui pendant sa cinématique
local template = ServerStorage:WaitForChild("ZoneBosses"):WaitForChild(Config.Boss)

local watching = {} -- [player] = {Focus = pièce suivie par le streaming, Tween}
local boss

local function spawnBoss()
	if boss and boss.Parent then return end
	local start = forest:WaitForChild("BossStart").Position
	boss = template:Clone()
	boss.Name = "IntroBoss"
	boss.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
	boss:PivotTo(CFrame.lookAt(start, start + Vector3.new(1, 0, 0))) -- le modèle regarde vers +Z : son avant est tourné vers la caméra (-X)
	CollectionService:AddTag(boss, "ZoneBoss") -- son squelette est animé sur l'écran du joueur (PumpkingClient)
	boss.Parent = workspace
end

local function finish(player)
	local entry = watching[player]
	if not entry then return end
	watching[player] = nil
	if entry.Tween then entry.Tween:Cancel() end
	if player.Parent then player.ReplicationFocus = nil end
	entry.Focus:Destroy()
	if next(watching) == nil and boss then
		boss:Destroy()
		boss = nil
	end
end

-- Les zones, de la première à la dernière. Leurs pièces sont trop loin pour être toujours chargées chez le joueur : on publie
-- leurs mesures dans l'attribut "Zones" du dossier IntroSystem (lu par IntroClient et TutorialClient).
local function zoneParts()
	local zones = {}
	for _, p in workspace:GetChildren() do
		if p:IsA("BasePart") and p.Name:lower():find("egg zone") then table.insert(zones, p) end
	end
	table.sort(zones, function(a, b) return a.Position.X < b.Position.X end)
	return zones
end
do
	local list = {}
	for _, p in zoneParts() do
		table.insert(list, {X = p.Position.X, Z = p.Position.Z, Top = p.Position.Y + p.Size.Y / 2, SizeX = p.Size.X, SizeZ = p.Size.Z, Color = p.Color:ToHex()})
	end
	system:SetAttribute("Zones", HttpService:JSONEncode(list))
end
-- le survol va du fond de la dernière zone jusqu'à l'entrée de la première
local function flyEnds()
	local zones = zoneParts()
	local first, last = zones[1], zones[#zones]
	return Vector3.new(last.Position.X, 30, last.Position.Z), Vector3.new(first.Position.X - first.Size.X / 2, 30, first.Position.Z)
end

stage.OnServerEvent:Connect(function(player, name)
	if name == "start" then
		if watching[player] then return end
		local focus = Instance.new("Part")
		focus.Name = "IntroFocus"
		focus.Size = Vector3.one
		focus.Transparency = 1
		focus.Anchored = true
		focus.CanCollide, focus.CanQuery, focus.CanTouch = false, false, false
		focus.Position = forest:WaitForChild("CameraSpot").Position
		focus.Parent = workspace
		watching[player] = {Focus = focus}
		spawnBoss()
		player.ReplicationFocus = focus
		task.delay(Config.MaxTime, function()
			if watching[player] and watching[player].Focus == focus then finish(player) end
		end)
	elseif name == "lastzone" then
		-- le client va filmer la dernière zone : on déplace le point de chargement là-bas
		-- pour que le décor soit streamé avant l'arrivée de la caméra
		local entry = watching[player]
		if not entry or entry.Tween then return end
		local zones = zoneParts()
		local last = zones[#zones]
		if last then
			entry.Focus.Position = Vector3.new(last.Position.X, 30, last.Position.Z)
		end
	elseif name == "fly" then
		local entry = watching[player]
		if not entry or entry.Tween then return end
		local from, to = flyEnds()
		entry.Focus.Position = from
		entry.Tween = TweenService:Create(entry.Focus, TweenInfo.new(Config.FlyTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = to})
		entry.Tween:Play()
	elseif name == "end" then
		finish(player)
	end
end)
Players.PlayerRemoving:Connect(finish)
