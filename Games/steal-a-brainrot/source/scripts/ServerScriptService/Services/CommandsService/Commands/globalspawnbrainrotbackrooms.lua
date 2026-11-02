-- ================================================================
-- globalspawnbrainrotbackrooms
-- Commande Conch : spawn un animal dans les Backrooms sur TOUS les
-- serveurs actifs via MessagingService.
-- Condition : l'event Backrooms doit être actif (BackroomsEvent)
--
-- Message : "King spawned [nom de l'animal] in backrooms!"
-- ================================================================

local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")

local CHANNEL = "GlobalSpawnBackroomsAnimal_V1"
local Subscribed = false

-- ----------------------------------------------------------------
-- Données partagées (chargées une seule fois au niveau du module)
-- ----------------------------------------------------------------

local Animals = require(ReplicatedStorage.Datas.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Traits = require(ReplicatedStorage.Datas.Traits)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
local StealService = require(game.ServerScriptService.Services.StealService)
local NotificationService = require(game.ServerScriptService.Services.NotificationService)

local TIMER_COLOR = Color3.fromRGB(180, 0, 0)

-- ----------------------------------------------------------------
-- Helpers (identiques au spawnbrainrotbackrooms local)
-- ----------------------------------------------------------------

local function getTimer(animalName)
	local data = Animals[animalName]
	if data then
		if data.Rarity == "Secret" or data.Rarity == "Admin" then return 120
		elseif data.Rarity == "Brainrot God" then return 60 end
	end
	return 60
end

local function getBackroomsSpawnParts()
	local br = Workspace:FindFirstChild("Backrooms")
	if not br then return nil end
	local map = br:FindFirstChild("BackroomsMap")
	if not map then return nil end
	local folder = map:FindFirstChild("SpawnParts")
	if not folder then return nil end
	local list = {}
	for _, part in ipairs(folder:GetDescendants()) do
		if part:IsA("BasePart") then
			table.insert(list, part)
		end
	end
	return #list > 0 and list or nil
end

local function placeAnimalOnPart(spawnPart, animalName, mutation, traits)
	local animalData = Animals[animalName]
	if not animalData then return false, ("Animal '%s' introuvable."):format(animalName) end

	local animalTemplate = ReplicatedStorage.Models.Animals:FindFirstChild(animalName)
	if not animalTemplate then return false, ("Modèle introuvable pour '%s'."):format(animalName) end

	local displayModel = animalTemplate:Clone()
	if not displayModel.PrimaryPart then
		local p = displayModel:FindFirstChildWhichIsA("BasePart", true)
		if p then displayModel.PrimaryPart = p end
	end
	if not displayModel.PrimaryPart then
		displayModel:Destroy()
		return false, "Modèle sans PrimaryPart."
	end

	spawnPart.Transparency = 1
	spawnPart.CanCollide = false
	spawnPart.CanTouch = false
	displayModel:PivotTo(spawnPart.CFrame)
	displayModel.Parent = Workspace

	local primaryPart = displayModel.PrimaryPart
	for _, part in ipairs(displayModel:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = false
			part.CanCollide = false
			part.Massless = true
			if part ~= primaryPart then
				local w = Instance.new("WeldConstraint")
				w.Part0 = primaryPart; w.Part1 = part; w.Parent = primaryPart
			end
		end
	end
	local aw = Instance.new("WeldConstraint")
	aw.Part0 = spawnPart; aw.Part1 = primaryPart; aw.Parent = spawnPart
	primaryPart.Anchored = false
	spawnPart.Anchored = true

	-- Animation idle
	local animFolder = ReplicatedStorage.Animations.Animals:FindFirstChild(animalName)
	local idleAnim = animFolder and animFolder:FindFirstChild("Idle")
	local animCtrl = displayModel:FindFirstChild("AnimationController")
	if idleAnim and animCtrl then
		local anim = animCtrl:FindFirstChildWhichIsA("Animator")
			or Instance.new("Animator", animCtrl)
		anim:LoadAnimation(idleAnim):Play()
	end

	-- Overhead
	local timerDuration = getTimer(animalName)
	local overhead = ReplicatedStorage.Overheads.AnimalOverhead:Clone()
	overhead.DisplayName.Text = animalData.DisplayName or animalName
	overhead.Price.Text = "$" .. NumberUtils:ToString(animalData.Price or 0)
	overhead.Generation.Text = "$" .. NumberUtils:ToString(SharedAnimals:GetGeneration(animalName) or 0) .. "/s"
	overhead.Rarity.Text = animalData.Rarity
	overhead.Mutation.Visible = false
	overhead.Stolen.Visible = true
	overhead.Stolen.Text = timerDuration .. "s"
	overhead.Stolen.TextColor3 = TIMER_COLOR
	overhead.Traits.Visible = false

	if mutation and mutation ~= "" then
		overhead.Mutation.Text = mutation
		overhead.Mutation.Visible = true
	end

	local rarityData = Rarities[animalData.Rarity]
	if rarityData then
		overhead.Rarity.TextColor3 = rarityData.Color
		if rarityData.StrokeColor then
			overhead.Rarity.UIStroke.Color = rarityData.StrokeColor
		end
	end

	local attachment = displayModel:FindFirstChild("OVERHEAD_ATTACHMENT", true)
	if not attachment then
		attachment = Instance.new("Attachment")
		attachment.Name = "OVERHEAD_ATTACHMENT"
		attachment.CFrame = CFrame.new(0, 0, 0)
		overhead.ExtentsOffsetWorldSpace = Vector3.new(0, 5, 0)
		attachment.Parent = primaryPart
	end
	overhead.Adornee = primaryPart
	overhead.Parent = attachment

	if rarityData and rarityData.GradientPreset then
		CollectionService:AddTag(overhead.Rarity, "Gradients_" .. rarityData.GradientPreset)
		if animalData.Rarity == "Brainrot God" or animalData.Rarity == "Secret" then
			CollectionService:AddTag(overhead.DisplayName, "Gradients_" .. rarityData.GradientPreset)
		end
	end

	-- Timer + grab
	local grabbed = false
	local remainingTime = timerDuration

	task.spawn(function()
		while remainingTime > 0 do
			task.wait(1)
			if grabbed then
				repeat task.wait(0.5) until not grabbed or not displayModel.Parent
			end
			if not displayModel.Parent or not overhead.Parent then return end
			remainingTime -= 1
			overhead.Stolen.Text = remainingTime .. "s"
			if remainingTime <= 0 then
				pcall(function() displayModel:Destroy() end)
				return
			end
		end
	end)

	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Grab"
	prompt.ObjectText = animalName
	prompt.HoldDuration = 1.5
	prompt.MaxActivationDistance = 10
	prompt.RequiresLineOfSight = false
	prompt.Style = Enum.ProximityPromptStyle.Custom
	prompt.Parent = primaryPart

	prompt.Triggered:Connect(function(player)
		if not player or not player:IsA("Player") then return end
		if StealService:IsStealing(player) then return end
		if grabbed then return end
		grabbed = true
		prompt.Enabled = false

		local ok = StealService:SimulateSteal(player.Name, animalName, displayModel, overhead, prompt, nil, true)
		if not ok then
			grabbed = false
			prompt.Enabled = true
			return
		end

		local stealInfo = StealService:GetActiveSteal(player)
		if stealInfo and stealInfo.Model then
			stealInfo.Model:SetAttribute("DropRemainingTime", remainingTime)
		end

		task.spawn(function()
			repeat task.wait(0.2) until not player:GetAttribute("SammyStealing")
			grabbed = false
		end)
	end)

	return true
end

-- ----------------------------------------------------------------
-- Exécution locale du spawn (utilisée par le subscriber)
-- ----------------------------------------------------------------

local function runLocalSpawn(animalName, mutParam, validTraits)
	-- Vérifier que l'event Backrooms est actif sur CE serveur
	if not ReplicatedStorage:GetAttribute("BackroomsEvent") then return end

	local spawnParts = getBackroomsSpawnParts()
	if not spawnParts then return end

	local chosenPart = spawnParts[math.random(#spawnParts)]
	local ok, _ = placeAnimalOnPart(chosenPart, animalName, mutParam, #validTraits > 0 and validTraits or nil)
	if not ok then return end

	-- ✅ Message demandé : "King spawned [nom de l'animal] in backrooms!"
	local animalData = Animals[animalName]
	local displayName = animalData and animalData.DisplayName or animalName
	local rarityData = animalData and Rarities[animalData.Rarity]
	local color = rarityData and rarityData.Color or Color3.fromRGB(255, 255, 255)
	local hex = string.format("%02X%02X%02X",
		math.floor(color.R * 255),
		math.floor(color.G * 255),
		math.floor(color.B * 255)
	)

	local notifText
	if mutParam then
		notifText = string.format(
			'<font color="#FFFFFF">King spawned </font><font color="#%s"><b>%s %s</b></font><font color="#FFFFFF"> in backrooms!</font>',
			hex, mutParam, displayName
		)
	else
		notifText = string.format(
			'<font color="#FFFFFF">King spawned </font><font color="#%s"><b>%s</b></font><font color="#FFFFFF"> in backrooms!</font>',
			hex, displayName
		)
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if player:GetAttribute("InBackrooms") == true then
			NotificationService.Notify(player, notifText, 8, "Sounds.Sfx.Success")
		end
	end
end

-- ----------------------------------------------------------------
-- Abonnement MessagingService (tous les serveurs reçoivent le spawn)
-- ----------------------------------------------------------------

if not Subscribed then
	Subscribed = true
	MessagingService:SubscribeAsync(CHANNEL, function(message)
		local data = message.Data
		if typeof(data) ~= "table" then return end

		local animalName = data.animalName
		local mutParam   = data.mutParam
		local validTraits = data.validTraits or {}

		if not animalName then return end
		if not Animals[animalName] then return end

		runLocalSpawn(animalName, mutParam, validTraits)
	end)
end

-- ----------------------------------------------------------------
-- Module / commande Conch
-- ----------------------------------------------------------------

local module = function(Conch, Config)

	Conch.register("globalspawnbrainrotbackrooms", {
		permissions = { Config.RequiredRole or "super-user" },

		description = "Spawn un animal dans les Backrooms sur TOUS les serveurs actifs. L'event Backrooms doit être actif.",

		arguments = function()
			return
				{
					kind = "argument",
					type = "Brainrot",
					name = "Brainrot",
				},
			{
				kind     = "argument",
				type     = "Mutation",
				name     = "Mutation",
				optional = true,
			},
			{
				kind     = "argument",
				type     = "Traits",
				name     = "Traits",
				typeHint = "{ Trait? }",
				optional = true,
			}
		end,

		callback = function(brainrot, mutation, traits)

			-- 1. Vérifier que l'event Backrooms est actif sur CE serveur
			if not ReplicatedStorage:GetAttribute("BackroomsEvent") then
				return false, "L'event Backrooms n'est pas actif en ce moment."
			end

			-- 2. Résoudre l'animal
			local AnimalData
			for _, data in pairs(Animals) do
				if data.DisplayName == brainrot or data.Name == brainrot then
					AnimalData = data
					break
				end
			end
			if not AnimalData then
				return false, ("Brainrot '%s' introuvable."):format(tostring(brainrot))
			end
			local animalName = AnimalData.Name or brainrot

			-- 3. Valider la mutation (optionnelle)
			local mutParam
			if mutation and mutation ~= "" and mutation ~= "Normal" then
				if not Mutations[mutation] then
					return false, ("Mutation '%s' introuvable."):format(tostring(mutation))
				end
				mutParam = mutation
			end

			-- 4. Valider les traits (optionnels)
			local validTraits = {}
			if traits ~= nil then
				if type(traits) ~= "table" then
					return false, "Traits doit être une table : { \"Fireworks\" }"
				end
				for _, trait in ipairs(traits) do
					if Traits[trait] then
						table.insert(validTraits, trait)
					end
				end
			end

			-- 5. Exécuter sur CE serveur
			runLocalSpawn(animalName, mutParam, validTraits)

			-- 6. Broadcaster à TOUS les autres serveurs
			local ok, err = pcall(function()
				MessagingService:PublishAsync(CHANNEL, {
					animalName  = animalName,
					mutParam    = mutParam,
					validTraits = validTraits,
				})
			end)
			if not ok then
				return false, "MessagingService error : " .. tostring(err)
			end

			-- 7. Retour console
			local displayName = AnimalData.DisplayName or animalName
			local resultMsg = ("Spawned %s in the Backrooms on ALL servers!"):format(displayName)
			if mutParam then
				resultMsg = ("Spawned %s %s in the Backrooms on ALL servers!"):format(mutParam, displayName)
			end
			return resultMsg
		end,
	})

end

return module