-- Teykx Lazer Event Service
-- Toutes les X secondes, un rayon laser Teykx frappe un brainrot aléatoire sur la route
-- et lui applique le trait "Teykx".

local EVENT_NAME = "Teykx Lazer"
local TRAIT_NAME = "Teykx Lazer"
local ANNOUNCE_TEXT = "%s a été frappé par le Laser Teykx !"
local ANNOUNCE_COLOR = "#FF2E00"

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local AnimalService = require(ServerScriptService.Services.AnimalService)

local LazerHit = Net:RemoteEvent("EventService/TeykxLazer/Hit")
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

-- Skin/NPC "Teykx Lazer" placé par le dev, rangé dans le module client de l'event.
-- On le clone dans le Workspace à sa position d'origine tant que l'event est actif.
local NPCTemplate = ReplicatedStorage.Controllers.EventController.Events
	:WaitForChild("Teykx Lazer")
	:WaitForChild("Teykx Lazer")
	:WaitForChild("Teykx Lazer")
	:WaitForChild("Teykx Lazer")

local spawnedNPC: Model? = nil

local CONFIG = {
	TickInterval = 8, -- secondes entre chaque tir de laser
	BeamHeight = 60,  -- hauteur des deux points sources du rayon
	BeamSpread = 12,  -- écart horizontal entre les deux points sources
}

local TeykxLazer = {}

local running = false
local runningThread = nil
local alreadyTagged = {}

local function spawnNPC()
	if spawnedNPC then
		return
	end

	local originalPivot = NPCTemplate:GetPivot()

	local clone = NPCTemplate:Clone()
	clone.Parent = workspace
	clone:PivotTo(originalPivot)

	local humanoid = clone:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	end

	spawnedNPC = clone
end

local function despawnNPC()
	if spawnedNPC then
		spawnedNPC:Destroy()
		spawnedNPC = nil
	end
end

local function announce(animalName: string)
	local text = string.format(
		"<font color=\"%s\">%s</font>",
		ANNOUNCE_COLOR,
		string.format(ANNOUNCE_TEXT, animalName)
	)

	for _, player in ipairs(Players:GetPlayers()) do
		NotificationEvent:FireClient(player, text, 5, "Sounds.Sfx.Success", "Top")
	end
end

local function getEligibleAnimals()
	local animals = {}
	for _, model in ipairs(CollectionService:GetTagged("Animal")) do
		if model.PrimaryPart and not alreadyTagged[model] then
			table.insert(animals, model)
		end
	end
	return animals
end

local function tick()
	local animals = getEligibleAnimals()
	if #animals == 0 then
		return
	end

	local target = animals[math.random(1, #animals)]
	alreadyTagged[target] = true

	local targetPos = target.PrimaryPart.CFrame.Position
	local source1 = targetPos + Vector3.new(-CONFIG.BeamSpread, CONFIG.BeamHeight, -CONFIG.BeamSpread)
	local source2 = targetPos + Vector3.new(CONFIG.BeamSpread, CONFIG.BeamHeight, CONFIG.BeamSpread)

	-- Effet visuel du double rayon convergeant sur le brainrot ciblé (voir client: EventController.Events["Teykx Lazer"])
	LazerHit:FireAllClients(source1, source2, targetPos)

	-- Applique le trait Teykx au brainrot touché
	local ok, err = pcall(function()
		AnimalService:AddTraits(target, { TRAIT_NAME })
	end)

	if not ok then
		warn("[" .. EVENT_NAME .. "] AddTraits échoué :", err)
		return
	end

	announce(target.Name)

	target.AncestryChanged:Once(function(_, parent)
		if not parent then
			alreadyTagged[target] = nil
		end
	end)
end

function TeykxLazer.OnStart()
	if running then
		return
	end
	running = true
	alreadyTagged = {}

	spawnNPC()

	runningThread = task.spawn(function()
		while running do
			local ok, err = pcall(tick)
			if not ok then
				warn("[" .. EVENT_NAME .. "] tick échoué :", err)
			end
			task.wait(CONFIG.TickInterval)
		end
	end)
end

function TeykxLazer.OnStop()
	running = false
	if runningThread then
		task.cancel(runningThread)
		runningThread = nil
	end
	alreadyTagged = {}
	despawnNPC()
end

return TeykxLazer
