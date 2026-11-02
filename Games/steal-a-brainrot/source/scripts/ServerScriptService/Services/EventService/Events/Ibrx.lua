-- Ibrx Event Service
-- Tag un brainrot aléatoire sur la route avec le trait "Ibrx" et l'annonce à tous les joueurs.

local EVENT_NAME = "Ibrx"
local TRAIT_NAME = "Ibrx"
local ANNOUNCE_TEXT = "%s Ibrx one top !"
local ANNOUNCE_COLOR = "#FF3B3B"

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local AnimalService = require(ServerScriptService.Services.AnimalService)

local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local CONFIG = {
	TickInterval = 6, -- secondes entre chaque tirage
}

local Ibrx = {}

local running = false
local runningThread = nil
local alreadyTagged = {}

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

	local ok, err = pcall(function()
		AnimalService:AddTraits(target, { TRAIT_NAME })
	end)

	if not ok then
		warn("[" .. EVENT_NAME .. "Event] AddTraits échoué :", err)
		return
	end

	announce(target.Name)

	target.AncestryChanged:Once(function(_, parent)
		if not parent then
			alreadyTagged[target] = nil
		end
	end)
end

function Ibrx.OnStart()
	if running then
		return
	end
	running = true
	alreadyTagged = {}

	runningThread = task.spawn(function()
		while running do
			local ok, err = pcall(tick)
			if not ok then
				warn("[" .. EVENT_NAME .. "Event] tick échoué :", err)
			end
			task.wait(CONFIG.TickInterval)
		end
	end)
end

function Ibrx.OnStop()
	running = false
	if runningThread then
		task.cancel(runningThread)
		runningThread = nil
	end
	alreadyTagged = {}
end

return Ibrx
