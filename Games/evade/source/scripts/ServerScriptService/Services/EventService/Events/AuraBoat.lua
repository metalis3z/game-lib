local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local NotificationService = require(ServerScriptService.Services.NotificationService)
-- StealService is no longer needed
local PlotService = require(ServerScriptService.Services.PlotService)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Trove = require(ReplicatedStorage.Packages.Trove)

-- NEW DEPENDENCIES for purchasing
local MoneyService = require(ServerScriptService.Services.MoneyService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals) 
local TweenService = game:GetService("TweenService") -- Added for smoother boat movement

local AuraBoat = {}


local HIDE_POS = Vector3.new(-410.792, -118.038, -169.764)
local SHOW_POS = Vector3.new(-410.792, -8.679, -169.764)
local ROT_Y = 180
local BOAT_SPEED = 0.1
local SPAWN_OFFSET = Vector3.new(0,4,0)
-- Define a destination for the boat to stop/despawn (adjust X based on your map)
local DESTROY_POS_X = 50 

local listanimals = {
	"Bambu Bambu Sahur","Krupuk Pagi Pagi , Meowl",
}
if math.random(1,100) <= 50 then table.insert(listanimals,"Strawberry Elephant") end


local running = false
local ActiveBoatModel = nil


local function debug(...)
	print("[AuraBoat]", ...)
end

local function ensurePrimaryPart(model)
	if not model.PrimaryPart then
		local part = model:FindFirstChildWhichIsA("BasePart") or Instance.new("Part")
		part.Name = "PrimaryPart"
		part.Size = Vector3.new(2,2,2)
		part.Anchored = false
		part.Parent = model
		model.PrimaryPart = part
	end
	return model.PrimaryPart
end


local function playIdleAnimation(clone, animalName)
	local animRoot = ReplicatedStorage:FindFirstChild("Animations")
	if not animRoot then return end
	local animalsFolder = animRoot:FindFirstChild("Animals")
	if not animalsFolder then return end
	local animFolder = animalsFolder:FindFirstChild(animalName)
	if not animFolder then return end
	local idleAnim = animFolder:FindFirstChild("Idle")
	if not idleAnim or not idleAnim:IsA("Animation") then return end

	local controller = clone:FindFirstChildOfClass("AnimationController")
	if not controller then
		controller = Instance.new("AnimationController")
		controller.Parent = clone
	end

	local animator = controller:FindFirstChildWhichIsA("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = controller
	end

	local ok, track = pcall(function() return animator:LoadAnimation(idleAnim) end)
	if ok and track then
		track.Looped = true
		track:Play()
		debug("Playing Idle animation for", animalName)
	end
end


local function addOverhead(animalName, spawnPart, model)
	local animalData = AnimalsData[animalName]
	if not animalData then return nil end

	local attachment = model:FindFirstChild("OVERHEAD_ATTACHMENT", true)
	if not attachment then
		attachment = Instance.new("Attachment")
		attachment.Position = Vector3.new(0, model:GetExtentsSize().Y*0.75*(animalData.OverheadYOffsetModifier or 1),0)
		attachment.Name = "OVERHEAD_ATTACHMENT"
		attachment.Parent = spawnPart
	end

	if ReplicatedStorage:FindFirstChild("Overheads") and ReplicatedStorage.Overheads:FindFirstChild("AnimalOverhead") then
		local overhead = ReplicatedStorage.Overheads.AnimalOverhead:Clone()
		local sharedAnimals = require(ReplicatedStorage.Shared.Animals)
		overhead.Generation.Text = ("$%*/s"):format(NumberUtils:ToString(sharedAnimals:GetGeneration(animalName)))
		overhead.DisplayName.Text = animalData.DisplayName or animalName
		overhead.Price.Text = "$"..NumberUtils:ToString(animalData.Price or 0)
		overhead.Rarity.Text = animalData.Rarity or "Common"

		if Rarities[animalData.Rarity] then
			overhead.Rarity.TextColor3 = Rarities[animalData.Rarity].Color
			if Rarities[animalData.Rarity].StrokeColor then
				overhead.Rarity.UIStroke.Color = Rarities[animalData.Rarity].StrokeColor
			end
			if Rarities[animalData.Rarity].GradientPreset then
				Trove.new():Add(Gradients.apply(overhead.Rarity, Rarities[animalData.Rarity].GradientPreset))
			end
		end

		overhead.Mutation.Visible = false
		overhead.Parent = attachment
		return overhead
	end

	return nil
end


local function spawnAnimalOnBoat(boatModel)
	local spawnPart = boatModel:FindFirstChild("SpawningBrain", true)
	if not spawnPart then
		warn("SpawningBrain not found on boat!")
		return
	end

	local animalName = listanimals[math.random(1,#listanimals)]
	local template = ReplicatedStorage.Models.Animals:FindFirstChild(animalName)
	local animalData = AnimalsData[animalName]

	if not animalData then
		warn("AnimalsData missing for:", animalName)
		return
	end

	local clone
	if template then
		clone = template:Clone()
	else
		-- Fallback model creation (in case the template is missing)
		clone = Instance.new("Model")
		clone.Name = animalName
		local part = Instance.new("Part")
		part.Size = Vector3.new(2,2,2)
		part.Anchored = false
		part.Position = spawnPart.Position + Vector3.new(0,4,0)
		part.Parent = clone
		clone.PrimaryPart = part
	end

	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://140460021178666" 
	sound.Volume = 10
	sound.PlaybackSpeed = 0.5
	sound.Looped = true
	sound:Play()


	if clone.PrimaryPart then
		clone:SetPrimaryPartCFrame(spawnPart.CFrame * CFrame.new(SPAWN_OFFSET))

		-- Weld the animal to the boat so it moves with it
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = boatModel.PrimaryPart
		weld.Part1 = clone.PrimaryPart
		weld.Parent = clone
	else
		clone:PivotTo(spawnPart.CFrame * CFrame.new(SPAWN_OFFSET))
	end

	clone:SetAttribute("SpawnedByAuraBoat", true)
	clone.Parent = boatModel
	-- We must ensure the animal cannot move on its own while on the boat
	clone:SetAttribute("ForceIdle", true)


	playIdleAnimation(clone, animalName)


	local overhead = addOverhead(animalName, spawnPart, clone)


	local promptTarget = clone.PrimaryPart or spawnPart
	local prompt = Instance.new("ProximityPrompt")

	-- PROMPT SETTINGS FOR PURCHASE
	prompt.ActionText = "Purchase" 
	prompt.ObjectText = string.format("%s $%s", animalData.DisplayName or animalName, NumberUtils:ToString(nil, animalData.Price))
	prompt.HoldDuration = 0.25 
	prompt.MaxActivationDistance = 10
	prompt.Parent = promptTarget

	-- Store necessary data on the animal
	clone:SetAttribute("Price", animalData.Price)
	clone:SetAttribute("Index", animalName)

	local isBought = false
	local PurchasingPlayer = nil
	local ReservedPodiumIndex = nil

	prompt.Triggered:Connect(function(player)
		if isBought then return end 

		local price = clone:GetAttribute("Price") or animalData.Price
		local PlayerChannel = Synchronizer:Get(player)

		-- 1. Check if the player can afford it
		local CanAfford, Amount = MoneyService:CanAfford(player, price)
		if not CanAfford then
			NotificationService.Error(player, string.format("You need $%s more to buy this.", NumberUtils:ToString(nil, Amount)))
			return
		end

		-- 2. Check for free podium space
		local Podiums = PlotService.getFreePodium(player)
		if not Podiums then
			NotificationService.Error(player, "You need more room in your base to buy a brainrot.")
			return
		end

		ReservedPodiumIndex = tonumber(Podiums.Name)
		if not ReservedPodiumIndex then
			NotificationService.Error(player, "Invalid podium index.")
			return
		end

		-- 3. Reserve the spot and deduct money
		PlotService.AddToQueue(player, ReservedPodiumIndex)
		MoneyService:Add(player, -price)

		isBought = true
		PurchasingPlayer = player
		prompt.Enabled = false

		-- Set attributes needed for the AnimalService to process the animal post-purchase
		clone:SetAttribute("TargetPlayer", player.UserId) 
		clone:SetAttribute("ReservedPodiumIndex", ReservedPodiumIndex)

		-- Hide overhead or change it to 'Sold' if necessary (optional)
		if overhead then
			overhead.Price.Text = "SOLD!"
		end
	end)

	-- Attach Animal to the boat model's `Destroying` event for cleanup
	clone.Destroying:Connect(function()
		if ActiveBoatModel and ActiveBoatModel.Parent then
			-- This ensures the boat is destroyed if the animal is bought/destroyed early
			ActiveBoatModel:Destroy()
		end
	end)
end


local function startMoving(model)
	task.spawn(function()
		local isAnimalBought = false
		local animalModel = model:FindFirstChildWhichIsA("Model")

		while running and model and model.PrimaryPart do

			-- Check if the animal was bought
			if animalModel and animalModel:GetAttribute("TargetPlayer") then
				isAnimalBought = true
			end

			model:SetPrimaryPartCFrame(model.PrimaryPart.CFrame * CFrame.new(0,0,-BOAT_SPEED))

			-- Check if boat reached the despawn point (X coordinate limit)
			if model.PrimaryPart.Position.X < DESTROY_POS_X then
				running = false

				if isAnimalBought and animalModel and animalModel.Parent then
					-- 1. If bought: UNWELD the animal
					local weld = animalModel:FindFirstChildOfClass("WeldConstraint")
					if weld then weld:Destroy() end

					-- 2. Move animal to the main workspace/road area
					animalModel.Parent = Workspace 

					-- 3. Remove the ForceIdle to let the AnimalService (or other movement scripts) take over
					animalModel:SetAttribute("ForceIdle", false) 

					-- Clear boat-related attribute
					animalModel:SetAttribute("SpawnedByAuraBoat", nil)
				else
					-- 4. If NOT bought: destroy the animal with the boat
					if animalModel and animalModel.Parent then
						animalModel:Destroy()
					end
				end

				-- 5. Finally, destroy the boat
				model:Destroy()
				break
			end

			RunService.Heartbeat:Wait()
		end

		ActiveBoatModel = nil -- Clear the reference when destroyed
	end)
end


function AuraBoat.OnStart()
	running = true

	-- Find the template boat as a direct child of this ModuleScript
	local templateBoat = script:FindFirstChild("AuraBoat")

	if not templateBoat or not templateBoat:IsA("Model") then
		warn("Template 'AuraBoat' model not found as a child of the ModuleScript! Cannot start event.")
		return
	end

	-- Create the folder for the event in Workspace
	local folder = Workspace:FindFirstChild("Events") and Workspace.Events:FindFirstChild("AuraBoat")
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = "AuraBoat"
		folder.Parent = Workspace:FindFirstChild("Events") or Workspace
	end

	-- Clone the template boat
	local model = templateBoat:Clone()
	model.Name = "AuraBoat_Active"
	model.Parent = folder

	ActiveBoatModel = model -- Store reference to the active model

	-- Ensure the clone has a PrimaryPart before trying to use it
	ensurePrimaryPart(model)

	-- Set initial position (using Tween for a smoother start)
	model:SetPrimaryPartCFrame(CFrame.new(HIDE_POS) * CFrame.Angles(0,math.rad(ROT_Y),0))
	task.wait(1)

	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	local tween = TweenService:Create(model.PrimaryPart, tweenInfo, {CFrame = CFrame.new(SHOW_POS) * CFrame.Angles(0,math.rad(ROT_Y),0)})
	tween:Play()
	tween.Completed:Wait()

	startMoving(model)
	task.delay(0.5,function()
		spawnAnimalOnBoat(model)
	end)
end

function AuraBoat.OnStop()
	running = false
	local folder = Workspace:FindFirstChild("Events") and Workspace.Events:FindFirstChild("AuraBoat")
	if not folder then return end

	-- Look for the active boat model
	local model = ActiveBoatModel or folder:FindFirstChild("AuraBoat_Active")
	if not model then
		model = folder:FindFirstChild("AuraBoat")
		if not model then return end
	end

	-- If the boat is still moving, stopping will be handled by the startMoving loop breaking.
	-- If the model exists but running is false, manually clean up:
	for _, child in ipairs(model:GetDescendants()) do
		if child:GetAttribute("SpawnedByAuraBoat") then
			child:Destroy()
		end
		if child:IsA("Sound") and child.SoundId == "rbxassetid://140460021178666" then
			child:Destroy()
		end
	end

	model:Destroy()
	ActiveBoatModel = nil
end

return AuraBoat