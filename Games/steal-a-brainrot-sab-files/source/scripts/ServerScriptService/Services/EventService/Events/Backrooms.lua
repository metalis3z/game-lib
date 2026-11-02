local Backrooms = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Trove = require(ReplicatedStorage.Packages.Trove)
local WorldBrainrotService = require(game:GetService("ServerScriptService").Services.WorldBrainrotService)
local StealService = require(game:GetService("ServerScriptService").Services.StealService)
local AnimalService = require(game:GetService("ServerScriptService").Services.AnimalService)
local SoundService = require(game:GetService("ServerScriptService").Services.SoundService)
local HIDE_TAG = "HideInBackroomsServer"
local BACKROOMS_POOL_ID = "Backrooms/Brainrots"
local DESPAWN_TIMER = 60
local NotificationService = require(game:GetService("ServerScriptService").Services.NotificationService)
local animals = require(ReplicatedStorage.Datas.Animals)
local BACKROOMS_BRAINROTS = {
	["1"] = {
		"Lumaca Malefica",
		"Robo Grafito",
		"Gattatino Nyanino",
		"Urubini Flamenguini",
		"Matteo",
		"Espresso Signora",
	},
	["2"] = {
		"Karkerkar Kurkur",
		"La Vacca Saturno Saturnita",
		"Chachechi",
		"Dul Dul Dul",
		"Sammyni Spyderini"
	},
	["3"] = {
		"Abyssaloco",
		"Rubrikiko",
		"Flipa Sandala",
		"Glaciator",
		"To to to Sahur",
		"Chicleteira Bicicleteira",
		"Chicleteirina Bicicleteirina",
	},
}

local isActive = false
local currentTrove = nil
local hiddenInstances = {}

local function roundTimer(value)
	return math.ceil(value / 10) * 10
end

local function hideInstance(instance)
	if not currentTrove then return end
	if hiddenInstances[instance] then return end

	if not instance:IsDescendantOf(Workspace) then return end

	local originalParent = instance.Parent
	if not originalParent then return end

	hiddenInstances[instance] = true
	instance.Parent = script

	currentTrove:Add(function()
		hiddenInstances[instance] = nil

		if originalParent and originalParent.Parent ~= nil then
			pcall(function()
				instance.Parent = originalParent
			end)
		end
	end)
end

local function spawnAtPart(part)
	local partName = part.Name
	local brainrotList = BACKROOMS_BRAINROTS[partName]

	if not brainrotList then
		warn("BackroomsEvent: No brainrot list found for spawn part named '" .. partName .. "'")
		return
	end

	WorldBrainrotService:SpawnBrainrot(BACKROOMS_POOL_ID, {
		cframe = part.CFrame,
		brainrot = brainrotList[math.random(1, #brainrotList)],
		despawnTimer = DESPAWN_TIMER,
		caged = false
	})
end

function Backrooms.OnStart()
	if isActive then return end
	isActive = true
	ReplicatedStorage:SetAttribute("BackroomsEvent", true)

	currentTrove = Trove.new()
	hiddenInstances = {}
	NotificationService.Broadcast('<font color="#FFE311"><b>The Backrooms</b></font> have appeared in the cave!', 5, "Sounds.Sfx.Success")
	WorldBrainrotService:CreatePool(BACKROOMS_POOL_ID)
	currentTrove:Add(function()
		WorldBrainrotService:DestroyPool(BACKROOMS_POOL_ID)
	end)

	for _, instance in CollectionService:GetTagged(HIDE_TAG) do
		hideInstance(instance)
	end

	currentTrove:Connect(CollectionService:GetInstanceAddedSignal(HIDE_TAG), function(instance)
		hideInstance(instance)
	end)

	local BackroomsShop = workspace.Events:FindFirstChild("Backrooms")
	if BackroomsShop then
		BackroomsShop:PivotTo(CFrame.new(-378.455, -5, 12.322))

		currentTrove:Add(function()
			BackroomsShop:PivotTo(CFrame.new(-378.455, -205.5, 12.322))
		end)
	end

	local serverMapTemplate = script:FindFirstChild("BackroomsMap")
	if serverMapTemplate then
		local currentmap = currentTrove:Clone(serverMapTemplate)
		currentmap.Parent = workspace

		local spawnParts = currentmap:FindFirstChild("SpawnParts")
		if spawnParts then
			for _, part in ipairs(spawnParts:GetChildren()) do
				if part:IsA("BasePart") then
					spawnAtPart(part)

					part.Transparency = 1
					part.CanCollide = false
				end
			end
		end

		local pad = currentmap:FindFirstChild("Pad")
		if pad then
			local deliveryHitbox = pad:FindFirstChild("DeliveryHitbox")
			if deliveryHitbox and deliveryHitbox:IsA("BasePart") then
				currentTrove:Connect(deliveryHitbox.Touched, function(hit)
					local character = hit.Parent
					local player = Players:GetPlayerFromCharacter(character)
					if not player then return end

					if StealService:IsGrabbingEgg(player) then
						local grabData = StealService:GetEggGrabData(player)
						if grabData and grabData.poolId == BACKROOMS_POOL_ID then
							local part = workspace:FindFirstChild("WBPools")
							local safeName = BACKROOMS_POOL_ID:gsub("[/\\%s]", "_")
							local folder = part and part:FindFirstChild(safeName)
							local eggPart = folder and folder:FindFirstChild(grabData.brainrotId)

							local eggName = eggPart and eggPart:GetAttribute("BName")
							local mutation = eggPart and eggPart:GetAttribute("BMut")
							local traitsJson = eggPart and eggPart:GetAttribute("BTr")

							local parsedTraits = nil
							if traitsJson and traitsJson ~= "" then
								local ok, result = pcall(function()
									return game:GetService("HttpService"):JSONDecode(traitsJson)
								end)
								if ok then parsedTraits = result end
							end

							StealService:ConsumeEgg(player)
                            SoundService:Play(player, ReplicatedStorage.Sounds.Sfx["Fuse Machine"].Deposit)
							if eggName and animals[eggName] then
								AnimalService.spawnAnimalCustom(
									animals[eggName],
									(mutation and mutation ~= "") and mutation or nil,
									parsedTraits,
									nil,
									nil,
									nil,
									false,
									false,
									false
								)
							end
						end
					end
				end)
			end
		end
	else
		warn("BackroomsEvent: BackroomsMap template not found inside the Backrooms script.")
	end
end

function Backrooms.OnStop()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("BackroomsEvent", nil)

	if currentTrove then
		currentTrove:Destroy()
		currentTrove = nil
	end

	hiddenInstances = {}
end

return Backrooms