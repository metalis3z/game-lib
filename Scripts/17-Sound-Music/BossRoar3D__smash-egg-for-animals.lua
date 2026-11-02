-- Reference copy for study. Game: Smash Egg For Animals (smash-egg-for-animals)
-- Original: StarterPlayer/StarterPlayerScripts/ZoneBossRoarClient.client.lua
-- What it does: 3D positional roars for tagged bosses while they chase: per-boss sound config (id, volume, pitch), linear rolloff from 40 to 190 studs, random offsets so bosses do not roar in sync, fade-out before destroy, muted in safe zone and arenas. Comments are in French.

-- Rugissements des gardiens de zone : seulement PENDANT UNE POURSUITE (attribut Chasing) : chaque gardien rugit alors toutes les 7 s pendant 2 s.
-- Le son est en 3D, posé sur le gardien : on l'entend dans sa zone (fort de près, de plus en plus faible en s'éloignant),
-- plus du tout au-delà de ~190 studs, ni dans la safe zone, ni dans l'arène du boss.
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local EVERY, LENGTH = 7, 2 -- un rugissement toutes les 7 s, qui dure 2 s
local NEAR, FAR = 40, 190 -- plein volume jusqu'à 40 studs, silence à 190 (≈ la taille d'une zone)

-- un son choisi pour chaque gardien : Id, volume, vitesse (plus bas = plus grave), début dans le fichier
local SOUNDS = {
	Cow = {Id = 9113628042, Volume = 2, Speed = 0.85}, -- mugissement de taureau
	Tiger = {Id = 9120048719, Volume = 2.2, Speed = 0.95}, -- rugissement de tigre
	Shark = {Id = 109577263860109, Volume = 2, Speed = 0.7}, -- grondement de monstre marin
	Whale = {Id = 123987752396522, Volume = 2.6, Speed = 0.85}, -- appel de baleine géante, grave
	Sphinx = {Id = 9125629454, Volume = 2.2, Speed = 0.9}, -- rugissement de lion
	FireDragon = {Id = 122225901664901, Volume = 2.2, Speed = 0.95}, -- rugissement de dragon
	Cerberus = {Id = 9116303194, Volume = 2.4, Speed = 0.8}, -- grognement de chien géant
	TRex = {Id = 7127123554, Volume = 2.4, Speed = 0.9}, -- rugissement de dinosaure
	RockCandyDragon = {Id = 257001341, Volume = 2, Speed = 1.05}, -- dragon (plus aigu)
	Kraken = {Id = 9125471073, Volume = 2.6, Speed = 0.65}, -- grondement profond de créature
	Mosasaurus = {Id = 109577263860109, Volume = 2.2, Speed = 0.6}, -- reptile marin géant
	Dragon = {Id = 122225901664901, Volume = 2.2, Speed = 1.15}, -- dragon ange (plus clair)
	Pumpking = {Id = 9125467833, Volume = 2.6, Speed = 0.75}, -- grondement de monstre
	Zorvex = {Id = 9125842589, Volume = 2.4, Speed = 0.9}, -- voix de robot géant
	Reaper = {Id = 9125471073, Volume = 2.4, Speed = 0.5}, -- le Reaper : grondement spectral très grave (son de créature ralenti)
}
local DEFAULT = {Id = 9125467833, Volume = 2.2, Speed = 0.9}

local function pick(model)
	return SOUNDS[model:GetAttribute("Kit") or ""] or SOUNDS[model:GetAttribute("Rig") or ""] or DEFAULT
end

-- la safe zone : une grande Part, on regarde seulement si le joueur est dedans à plat (X/Z)
local function inSafeZone(pos)
	local zone = workspace:FindFirstChild("safe zone")
	if not zone or not zone:IsA("BasePart") then return false end
	local p = zone.CFrame:PointToObjectSpace(pos)
	local h = zone.Size / 2
	return math.abs(p.X) <= h.X and math.abs(p.Z) <= h.Z
end

local function rootOf(model)
	return model.PrimaryPart or model:FindFirstChild("Root") or model:FindFirstChildWhichIsA("BasePart", true)
end

local bosses = {} -- [modèle] = prochain rugissement (os.clock)
local function add(model)
	bosses[model] = os.clock() + math.random() * EVERY -- chacun son rythme : ils ne rugissent pas tous en même temps
end
CollectionService:GetInstanceAddedSignal("ZoneBoss"):Connect(add)
CollectionService:GetInstanceRemovedSignal("ZoneBoss"):Connect(function(model) bosses[model] = nil end)
for _, model in CollectionService:GetTagged("ZoneBoss") do add(model) end

local function roar(model, root)
	local cfg = pick(model)
	local s = Instance.new("Sound")
	s.Name = "GuardianRoar"
	s.SoundId = "rbxassetid://" .. cfg.Id
	s.Volume = cfg.Volume
	s.PlaybackSpeed = cfg.Speed
	s.RollOffMode = Enum.RollOffMode.Linear
	s.RollOffMinDistance = NEAR
	s.RollOffMaxDistance = FAR
	s.Parent = root
	s:Play()
	model:SetAttribute("RoarAt", os.clock()) -- (local) l'animal fait son geste de rugissement en même temps
	task.delay(LENGTH - 0.45, function()
		if s.Parent then TweenService:Create(s, TweenInfo.new(0.45), {Volume = 0}):Play() end
	end)
	task.delay(LENGTH, function() s:Destroy() end)
end

while true do
	task.wait(0.2)
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local now = os.clock()
	for model, nextAt in bosses do
		if not model.Parent then
			bosses[model] = nil
		elseif model:GetAttribute("Chasing") ~= true then
			-- il ne rugit QUE quand il poursuit quelqu'un : au calme il se tait (et rugit tout de suite au début d'une poursuite)
			bosses[model] = now
		elseif now >= nextAt then
			bosses[model] = now + EVERY
			local root = rootOf(model)
			if hrp and root and not player:GetAttribute("InBossArena") and not player:GetAttribute("InDemonArena") and not inSafeZone(hrp.Position)
				and (root.Position - hrp.Position).Magnitude < FAR then
				roar(model, root)
			end
		end
	end
end
