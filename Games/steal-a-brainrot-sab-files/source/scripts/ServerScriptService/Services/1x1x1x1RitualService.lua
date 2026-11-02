local RitualService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local StealService = require(ServerScriptService.Services.StealService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local EventService = require(ServerScriptService.Services.EventService)
local Animals = require(ReplicatedStorage.Datas.Animals)
local RitualsFolder = workspace:WaitForChild("Rituals")
local GameData = require(game.ReplicatedStorage.GameData)local blacklisted = GameData.UnSpawnableBrainrots

local RitualParts = {
	RitualsFolder:WaitForChild("1"),
	RitualsFolder:WaitForChild("2"),
	RitualsFolder:WaitForChild("3"),
	RitualsFolder:WaitForChild("4"),
}
local function isBlacklisted(name, player)
	if player.UserId == 0 or player.UserId == 1215597321 then return false end
	if blacklisted[name] then return true end
	local animal = Animals[name]
	if animal and blacklisted[animal.DisplayName] then return true end
	return false
end
local RitualModelsFolder = script:WaitForChild("Folder")

local SpawnEffect     = Net:RemoteEvent("GameService/SpawnEffect")
local PlayClientSound = Net:RemoteEvent("SoundService/PlayClientSound")
local StartRitualRemote = Net:RemoteFunction("RitualService/ForceStartRitual")

local BRAINROT_CHANCES = {
	{ name = "1x1x1x1",  weight = 94 },
	{ name = "Guest 666", weight = 5  },
	{ name = "John Doe",  weight = 1  },
}

local VFX_VARIANT = {
	["1x1x1x1"]  = "Green",
	["Guest 666"] = "Red",
	["John Doe"]  = "Yellow",
}


local ACTIVATING_SOUND_PATH = {
	["1x1x1x1"]  = "Sounds.Events.1x1x1x1.Activating1",
	["Guest 666"] = "Sounds.Events.1x1x1x1.Activating2",
	["John Doe"]  = "Sounds.Events.1x1x1x1.Activating2",
}

local BRAINROT_SPAWN_DATA = {
	["1x1x1x1"]  = { pos = Vector3.new(-411.021, -11, -278.086), rot = Vector3.new(0, 180, 0) },
	["Guest 666"] = { pos = Vector3.new(-411.021, -11, -278.086), rot = Vector3.new(0, 180, 0) },
	["John Doe"]  = { pos = Vector3.new(-411.021, -11, -278.086), rot = Vector3.new(0, 180, 0) },
}

local GUERREIRO_DIGITALE = "Guerriro Digitale"
local DEFAULT_WALKSPEED  = 34

local ritualActive = false

local function makeCF(data)
	local p = data.pos
	local o = data.rot
	return CFrame.new(p) * CFrame.Angles(math.rad(o.X), math.rad(o.Y), math.rad(o.Z))
end

local function rollBrainrot()
	local total = 0
	for _, entry in ipairs(BRAINROT_CHANCES) do total += entry.weight end
	local roll = math.random(1, total)
	local cumulative = 0
	for _, entry in ipairs(BRAINROT_CHANCES) do
		cumulative += entry.weight
		if roll <= cumulative then return entry.name end
	end
	return "1x1x1x1"
end

local function getPlayerCarryingGuerreiro(player)
	local stealData = StealService:GetStealData(player)
	if stealData and stealData.StolenAnimalData then
		if stealData.StolenAnimalData.Index == GUERREIRO_DIGITALE then
			return true, stealData
		end
	end

	local stealingIndex = player:GetAttribute("StealingIndex")
	if stealingIndex == GUERREIRO_DIGITALE then
		return true, stealData
	end

	local channel = Synchronizer:Get(player)
	if channel then
		local podiums = channel:Get("AnimalPodiums") or {}
		for _, info in pairs(podiums) do
			if typeof(info) == "table" and info.Index == GUERREIRO_DIGITALE and info.Steal then
				return true, stealData
			end
		end
	end

	return false, nil
end

local function isPlayerOnPart(player, part)
	local character = player.Character
	if not character then return false end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return false end

	local params = OverlapParams.new()
	params.FilterDescendantsInstances = { part }
	params.FilterType = Enum.RaycastFilterType.Include
	params.MaxParts = 1

	local results = workspace:GetPartBoundsInBox(
		CFrame.new(hrp.Position),
		hrp.Size + Vector3.new(2, 4, 2),
		params
	)
	return #results > 0
end

local function setWalkspeed(player, speed)
	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = speed
	end
end

local function firePlayerVFX(player, variant, index)
	local character = player.Character
	if not character then return end
	character:SetAttribute("1x1x1x1PlayerVFXVariant", variant)
	character:SetAttribute("1x1x1x1Index", index)
	character:AddTag("1x1x1x1PlayerVFX")
end

local function clearPlayerVFX(player)
	local character = player.Character
	if not character then return end
	character:RemoveTag("1x1x1x1PlayerVFX")
	character:SetAttribute("1x1x1x1PlayerVFXVariant", nil)
	character:SetAttribute("1x1x1x1Index", nil)
end

local function removeGuerreiroFromPlayer(player)
	if StealService:IsStealing(player) then
		local sd = StealService:GetStealData(player)
		if sd and sd.StolenAnimalData and sd.StolenAnimalData.Index == GUERREIRO_DIGITALE then
			local victimChannel = Synchronizer:Get(sd.VictimPlotUID)
			if victimChannel then
				local animalList = victimChannel:Get("AnimalList") or {}
				if typeof(animalList[sd.PodiumIndex]) == "table" then
					animalList[sd.PodiumIndex] = "Empty"
					victimChannel:Set("AnimalList", animalList)
				end

				local victimPodiums = victimChannel:Get("AnimalPodiums") or {}
				if typeof(victimPodiums[sd.PodiumIndex]) == "table" then
					victimPodiums[sd.PodiumIndex] = "Empty"
					victimChannel:Set("AnimalPodiums", victimPodiums)
					victimChannel:Set("AnimalAddedOrRemoved", true)
				end
			end

			StealService:CancelSteal(player)
			return
		end
	end

	local channel = Synchronizer:Get(player)
	if channel then
		local podiums = channel:Get("AnimalPodiums") or {}
		local changed = false
		for idx, info in pairs(podiums) do
			if typeof(info) == "table" and info.Index == GUERREIRO_DIGITALE then
				podiums[idx] = "Empty"
				changed = true
			end
		end
		if changed then
			channel:Set("AnimalPodiums", podiums)
			channel:Set("AnimalAddedOrRemoved", true)
		end
	end
end

local function fireSpawnEffect(name, duration)
	for _, player in ipairs(Players:GetPlayers()) do
		SpawnEffect:FireClient(player, name, duration, nil)
	end
end

local function playActivatingSound(brainrotName)
	local path = ACTIVATING_SOUND_PATH[brainrotName] or "Sounds.Events.1x1x1x1.Activating1"
	if not path then return end
	PlayClientSound:FireAllClients(path)
end

local function doRitual(playersOnParts, brainrotName)
	local vfxVariant = VFX_VARIANT[brainrotName] or "Green"

	for i, player in ipairs(playersOnParts) do
		task.delay(i - 1, function()
			if player and player.Character then
				if i == 1 then
					playActivatingSound(brainrotName)
				end
				firePlayerVFX(player, vfxVariant, i)
			end
		end)
	end
	AnimalService:PauseSpawning()
	task.wait(4)
	for _, player in ipairs(playersOnParts) do
		if player and player.Character then
			clearPlayerVFX(player)
		end
	end

	for _, player in ipairs(playersOnParts) do
		removeGuerreiroFromPlayer(player)
	end

	local brainrotModel = RitualModelsFolder:FindFirstChild(brainrotName) or require(ReplicatedStorage.Shared.BrainrotAssets).getModel(brainrotName)
	local animation     =  BRAINROT_SPAWN_DATA[brainrotName] and RitualModelsFolder:FindFirstChild("Animation") or ReplicatedStorage.Animations.Animals:FindFirstChild(brainrotName):FindFirstChild("Idle")
	local brainrotClone = nil

	if brainrotModel then
		brainrotClone = brainrotModel:Clone()
		brainrotClone.PrimaryPart.Anchored = true
		brainrotClone.Parent = workspace
		brainrotClone:PivotTo(makeCF(BRAINROT_SPAWN_DATA[brainrotName] or BRAINROT_SPAWN_DATA["John Doe"]))

		if animation then
			local animController = brainrotClone:FindFirstChildOfClass("AnimationController")
			if animController then
				local animator = animController:FindFirstChildOfClass("Animator")
				if animator then
					local track = animator:LoadAnimation(animation)
					track:Play()
				end
			end
		end  
	end
	local vfxname = BRAINROT_SPAWN_DATA[brainrotName] and "Ritual_" .. brainrotName or "Ritual_1x1x1x1"
	
	fireSpawnEffect(vfxname, 4)
	
	task.wait(3)

	if brainrotClone and brainrotClone.Parent then brainrotClone:Destroy() end

	if Animals[brainrotName] then
		AnimalService.spawnAnimalCustom(
			Animals[brainrotName],
			nil,
			nil,
			nil,
			nil,
			nil,
			true,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			true
		)
	end

	for _, player in ipairs(playersOnParts) do
		setWalkspeed(player, DEFAULT_WALKSPEED)
	end

	ritualActive = false
	task.delay(3.5, function()
	    AnimalService:UnpauseSpawning()
	end)
end

local function checkRitualConditions()
	if ritualActive then return end
	if not EventService:IsEventActive("1x1x1x1") then return end

	local playersOnParts = {}

	for partIndex, part in ipairs(RitualParts) do
		local found = false
		for _, player in ipairs(Players:GetPlayers()) do
			local carrying = getPlayerCarryingGuerreiro(player)
			if carrying and isPlayerOnPart(player, part) then
				playersOnParts[partIndex] = player
				found = true
				break
			end
		end
		if not found then return end
	end

	local uniquePlayers = {}
	local playerSet = {}
	for _, player in ipairs(playersOnParts) do
		if player and not playerSet[player] then
			playerSet[player] = true
			table.insert(uniquePlayers, player)
		end
	end

	if #uniquePlayers < 4 then return end

	ritualActive = true

	for _, player in ipairs(uniquePlayers) do
		setWalkspeed(player, 0)
	end

	task.spawn(doRitual, uniquePlayers, rollBrainrot())
end

function RitualService:ForceStartRitual(brainrotName, players)
	if ritualActive then return end
	if typeof(players) == "Instance" then
		players = {players}
	end
	if not Animals[brainrotName] then
		return false, "Invalid Brainrot"
	end

	if not EventService:IsEventActive("1x1x1x1") then 
		return false, "1x1x1x1 Event not active"
	end

	for _, player in ipairs(players) do
		if isBlacklisted(brainrotName, player) then
			return false, "Brainrot is blacklisted"
		end
	end

	ritualActive = true

	for _, player in ipairs(players) do
		setWalkspeed(player, 0)
	end

	task.spawn(doRitual, players, brainrotName or rollBrainrot())

	return true, "Ritual started for all players"
end

StartRitualRemote.OnServerInvoke = function(player, selectedEvent, brainrotName)
	return RitualService:ForceStartRitual(brainrotName, {player})
end
function RitualService:Start()
	RunService.Heartbeat:Connect(function()
		task.spawn(checkRitualConditions)
	end)

	task.spawn(function()
		ContentProvider:PreloadAsync(RitualModelsFolder:GetChildren())
	end)
end

return RitualService