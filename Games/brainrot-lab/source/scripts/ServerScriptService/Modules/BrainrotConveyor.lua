--!strict
-- LOCATION: ServerScriptService/Modules/BrainrotConveyor
-- Sistema de Esteira de Brainrots: spawn no ParteA -> move -> ParteB -> despawn
-- Jogadores pressionam E perto do brainrot para pega-lo -> item vai para a Plot do jogador

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- [ MODULES ]
local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local RarityConfigurations = require(ReplicatedStorage.Modules.RarityConfigurations)
local MutationConfigurations = require(ReplicatedStorage.Modules.MutationConfigurations)
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
local EventConfig = require(ReplicatedStorage.Shared.EventConfig)

-- [ ASSETS ]
local ItemsFolder = ReplicatedStorage:WaitForChild("Items")
local Templates = ReplicatedStorage:WaitForChild("Templates")
local BrainrotUI_Template = Templates:WaitForChild("Brainrot_UI")
local Events = ReplicatedStorage:WaitForChild("Events")
local VFXFolder = ReplicatedStorage:WaitForChild("VFX Mutações")

-- Price multiplier: purchase price = baseIncome * this value
local PRICE_MULTIPLIER = 50

-- [ LATE-LOADED MODULES ]
local ItemManager
local PlayerController
local SlotManager
local EventManager

-- [ CONFIGURATION ]
local SPAWN_INTERVAL = 3        -- seconds between spawns
local TRAVEL_TIME = 50         -- seconds from A to B
local MAX_ACTIVE_BRAINROTS = 20  -- safety cap
local EVENT_MUTATION_CHANCE = 1.0  -- probability a spawned brainrot inherits the active event's mutation

-- Rarity spawn weights (using existing 6 rarities)
local RARITY_WEIGHTS = {
	Common = 50,
	Uncommon = 25,
	Rare = 15,
	Epic = 10,
	-- Legendary and Secret are ONLY spawned via pity timer, never randomly
}

local RARITY_ORDER = {"Common", "Uncommon", "Rare", "Epic"}

-- Pity timer configuration (seconds until guaranteed spawn)
local LEGENDARY_PITY_TIME = 600   -- 10 minutes
local SECRET_PITY_TIME = 3600  -- 2 hours
local MYTHICAL_PITY_TIME = 1800  -- 30 minutes

-- [ STATE ]
local BrainrotConveyor = {}
local activeBrainrots = {}  -- array of {model = Model, claimed = boolean}
local isRunning = false
local PICKUP_RANGE = 10  -- studs - max distance to pick up with E

-- Forced next spawn (set by the admin panel): { itemName, mutation, rarity }
local forcedBrainrot = nil

-- Pity timer state
local pityLegendaryTimer = LEGENDARY_PITY_TIME
local pitySecretTimer = SECRET_PITY_TIME
local pityMythicalTimer = MYTHICAL_PITY_TIME
local legendaryPityActive = false  -- true when timer expired, next spawn is guaranteed Legendary
local secretPityActive = false   -- true when timer expired, next spawn is guaranteed Secret
local mythicalPityActive = false  -- true when timer expired, next spawn is guaranteed Mythical

-- Auto-purchase state
local autoPurchaseSelections = {}  -- [player] = {brainrotName1, brainrotName2, ...}
local autoPurchaseCooldowns = {}   -- [player] = tick() when cooldown started
local BrainrotRemotes  -- will be set in Start

-- UI references for countdown display
local countdownUI
local lblLegendary
local lblSecret
local lblMythical

-- [ HELPERS ]

local function formatTime(seconds: number): string
	seconds = math.max(0, math.floor(seconds))
	local mins = math.floor(seconds / 60)
	local secs = seconds % 60
	return string.format("%02d:%02d", mins, secs)
end

local function getPitySounds()
	local soundsFolder = Workspace:FindFirstChild("Sounds")
	if not soundsFolder then return nil, nil, nil end
	local legendarySound = soundsFolder:FindFirstChild("Spawnou Lendario")
	local secretSound = soundsFolder:FindFirstChild("Spawnou Secret")
	local mythicalSound = soundsFolder:FindFirstChild("spawnou Mitico")
	return legendarySound, secretSound, mythicalSound
end

local function playPityAlertSound(sound: Instance?)
	if not sound or not sound:IsA("Sound") then return end
	-- Restart from the beginning and play for everyone (Sound lives in Workspace, replicates to all clients)
	sound.TimePosition = 0
	sound:Play()
end

local function getCountdownUI()
	if countdownUI then return countdownUI end
	local base = Workspace:FindFirstChild("Base")
	if not base then return nil end
	local path = base:FindFirstChild("Path")
	if not path then return nil end
	local part = path:FindFirstChild("Contador de spawn")
	if not part then return nil end
	local ui = part:FindFirstChild("UI")
	if not ui then return nil end
	countdownUI = ui
	local frame = ui:FindFirstChild("Frame")
	if frame then
		lblLegendary = frame:FindFirstChild("Legendary")
		lblSecret = frame:FindFirstChild("Secret")
		lblMythical = frame:FindFirstChild("Mythic")
	end
	return countdownUI
end

local function getConveyorParts()
	local folder = Workspace:FindFirstChild("BrainrotConveyor")
	if not folder then return nil, nil end
	local parteA = folder:FindFirstChild("ParteA")
	local parteB = folder:FindFirstChild("ParteB")
	return parteA, parteB
end

local function selectRandomItem()
	-- Check pity timers first (Secret takes priority over Legendary)
	if secretPityActive then
		secretPityActive = false
		pitySecretTimer = SECRET_PITY_TIME
		local items = ItemConfigurations.GetItemsByRarity("Secret")
		if items and #items > 0 then
			return items[math.random(1, #items)], "Secret"
		end
	end

	if mythicalPityActive then
		mythicalPityActive = false
		pityMythicalTimer = MYTHICAL_PITY_TIME
		local items = ItemConfigurations.GetItemsByRarity("Mythical")
		if items and #items > 0 then
			return items[math.random(1, #items)], "Mythical"
		end
	end

	if legendaryPityActive then
		legendaryPityActive = false
		pityLegendaryTimer = LEGENDARY_PITY_TIME
		local items = ItemConfigurations.GetItemsByRarity("Legendary")
		if items and #items > 0 then
			return items[math.random(1, #items)], "Legendary"
		end
	end

	-- Weighted random selection by rarity
	local totalWeight = 0
	for _, rarity in ipairs(RARITY_ORDER) do
		totalWeight += RARITY_WEIGHTS[rarity] or 0
	end

	local roll = math.random() * totalWeight
	local accumulated = 0
	local selectedRarity = "Common"

	for _, rarity in ipairs(RARITY_ORDER) do
		accumulated += RARITY_WEIGHTS[rarity] or 0
		if roll <= accumulated then
			selectedRarity = rarity
		break
		end
	end

	-- Get all items of this rarity
	local items = ItemConfigurations.GetItemsByRarity(selectedRarity)
	if not items or #items == 0 then
		-- Fallback to Common
		items = ItemConfigurations.GetItemsByRarity("Common")
		selectedRarity = "Common"
	end

	if not items or #items == 0 then return nil, nil end

	local itemName = items[math.random(1, #items)]
	return itemName, selectedRarity
end

local function getModelFromItem(item): Model?
	if item:IsA("Model") then return item end
	if item:IsA("Folder") then
		return item:FindFirstChildOfClass("Model")
	end
	return nil
end

local function attachBrainrotUI(item: Instance, itemName: string, rarity: string, mutation: string, baseIncome: number)
	local model = getModelFromItem(item)
	if not model then return end
	local rootPart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
	if not rootPart then return end

	local ui = BrainrotUI_Template:Clone()
	ui.Name = "Brainrot_UI"
	ui.Adornee = rootPart

	local frame = ui:FindFirstChild("Frame")
	if not frame then return end

	local lblTitle = frame:FindFirstChild("Title") :: TextLabel
	local lblEarn = frame:FindFirstChild("Earn") :: TextLabel
	local lblPrice = frame:FindFirstChild("Price") :: TextLabel
	local lblRarity = frame:FindFirstChild("Rarity") :: TextLabel
	local lblType = frame:FindFirstChild("Type") :: TextLabel
	local mutationsFrame = frame:FindFirstChild("Mutations")

	-- Set Title (brainrot name)
	if lblTitle then
		lblTitle.Text = itemName
	end

	-- Set Earn (yellow - income per second)
	if lblEarn then
		lblEarn.Text = "$" .. NumberFormatter.Format(baseIncome) .. "/s"
	end

	-- Set Price (green - purchase cost)
	local itemData = ItemConfigurations.GetItemData(itemName)
	local price = itemData and itemData.Price or 0
	if lblPrice then
		if price == 0 then
			lblPrice.Text = "Grátis"
		else
			lblPrice.Text = "$" .. NumberFormatter.Format(price)
		end
	end

	-- Set Rarity text and color
	if lblRarity then
		local rarityConfig = RarityConfigurations[rarity]
		if rarityConfig then
			lblRarity.Text = rarityConfig.DisplayName
			lblRarity.TextColor3 = rarityConfig.TextColor
			local stroke = lblRarity:FindFirstChildOfClass("UIStroke")
			if stroke then stroke.Color = rarityConfig.StrokeColor; stroke.Thickness = rarityConfig.StrokeThickness end
			local gradient = lblRarity:FindFirstChildOfClass("UIGradient")
			if gradient then gradient.Color = rarityConfig.GradientColor end
		else
			lblRarity.Text = rarity
		end
	end

	-- Hide the Type label entirely - mutations are shown via icon + VFX only (no text)
	if lblType then
		lblType.Visible = false
	end

	-- Hide ALL mutation icons initially
	if mutationsFrame then
		for _, icon in ipairs(mutationsFrame:GetChildren()) do
			if icon:IsA("ImageLabel") then
				icon.Visible = false
			end
		end
	end

	-- Position the GUI above the model based on its bounding box height
	local bbCFrame, bbSize = model:GetBoundingBox()
	local rootPos = rootPart.Position
	local modelTopOffset = bbCFrame.Position.Y + bbSize.Y / 2 - rootPos.Y
	ui.StudsOffset = Vector3.new(0, modelTopOffset + 8, 0)

	ui.Parent = model
end

local function applyMutationTexture(item: Instance, itemTemplate: Instance, mutation: string)
	local textures = itemTemplate:FindFirstChild("Textures")
	local mutTex = textures and textures:FindFirstChild(mutation)
	if not mutTex then return end
	local mutModel = getModelFromItem(item)
	local brainrot = mutModel and mutModel:FindFirstChild("Brainrot")
	local mesh = brainrot and brainrot:FindFirstChild("Mesh")
	if mesh and mesh:IsA("MeshPart") then
		if mutTex:IsA("StringValue") and mutTex.Value ~= "" then
			mesh.TextureID = mutTex.Value
		elseif mutTex:IsA("SurfaceAppearance") then
			for _, sa in ipairs(mesh:GetChildren()) do
				if sa:IsA("SurfaceAppearance") then sa:Destroy() end
			end
			mutTex:Clone().Parent = mesh
		end
	end
end

local function applyMutationVFX(item: Instance, mutation: string)
	local model = getModelFromItem(item)
	if not model then return end
	local brainrot = model:FindFirstChild("Brainrot")
	local mesh = brainrot and brainrot:FindFirstChild("Mesh")
	if not mesh or not mesh:IsA("BasePart") then return end

	local mutationLower = string.lower(mutation)
	local applied = false
	for _, emitter in ipairs(VFXFolder:GetChildren()) do
		if emitter:IsA("ParticleEmitter") then
			local nameLower = string.lower(emitter.Name)
			if nameLower == mutationLower or nameLower:match("^" .. mutationLower .. "%d+$") then
				emitter:Clone().Parent = mesh
				applied = true
			end
		end
	end

	-- Fallback: use the mutation's ApplyVFX module if no VFX Mutações emitter exists
	if not applied then
		local mutationsFolder = Events:FindFirstChild("Mutations")
		local mutFolder = mutationsFolder and mutationsFolder:FindFirstChild(mutation)
		local mutModule = mutFolder and mutFolder:FindFirstChild(mutation)
		if mutModule then
			local ok, result = pcall(require, mutModule)
			if ok and result and result.ApplyVFX then
				result.ApplyVFX(model)
			end
		end
	end
end

local function playBrainrotAnimation(item: Instance, itemTemplate: Instance, animName: string)
	local model = getModelFromItem(item)
	if not model then return end
	local brainrot = model:FindFirstChild("Brainrot")
	local animController = brainrot and brainrot:FindFirstChildOfClass("AnimationController")
	local animator = animController and animController:FindFirstChildOfClass("Animator")
	if not animator then return end

	local anims = itemTemplate:FindFirstChild("Animations")
	local anim = anims and anims:FindFirstChild(animName)
	if not anim or not anim:IsA("Animation") then return end

	for _, tr in ipairs(animator:GetPlayingAnimationTracks()) do
		tr:Stop()
	end

	local ok, track = pcall(function()
		return animator:LoadAnimation(anim)
	end)
	if ok and track then
		track.Looped = true
		track:Play()
	end
end

local function applyMutationUI(item: Instance, mutation: string)
	local model = getModelFromItem(item)
	local brainrotUI = model and model:FindFirstChild("Brainrot_UI")
	if not brainrotUI then return end
	local frame = brainrotUI:FindFirstChild("Frame")
	if not frame then return end
	local mutationsFolder = frame:FindFirstChild("Mutations")
	if not mutationsFolder then return end
	local icon = mutationsFolder:FindFirstChild(mutation)
	if icon and icon:IsA("ImageLabel") then
		icon.Visible = true
	end
end

local function getItemPivot(item: Instance): CFrame
	local model = getModelFromItem(item)
	if model then return model:GetPivot() end
	if item:IsA("Model") then return item:GetPivot() end
	return CFrame.new(0, 0, 0)
end

local function getItemExtents(item: Instance): Vector3
	local model = getModelFromItem(item)
	if model then return model:GetExtentsSize() end
	if item:IsA("Model") then return item:GetExtentsSize() end
	return Vector3.new(2, 2, 2)
end

local function pivotItemTo(item: Instance, cf: CFrame)
	local model = getModelFromItem(item)
	if model then
		model:PivotTo(cf)
	elseif item:IsA("Model") then
		item:PivotTo(cf)
	end
end

local function findPlayerPlotCollectPosition(player: Player): CFrame?
	local plot = Workspace:FindFirstChild("Plot_" .. player.Name)
	if not plot then return nil end

	-- Find Floor1 -> Slots -> Slot1 -> CollectTouch
	local floor1 = plot:FindFirstChild("Floor1")
	if not floor1 then return nil end

	local slots = floor1:FindFirstChild("Slots")
	if not slots then return nil end

	-- Find first available slot with a CollectTouch
	for i = 1, 10 do
		local slot = slots:FindFirstChild("Slot" .. tostring(i))
		if slot then
			local collectTouch = slot:FindFirstChild("CollectTouch")
			if collectTouch and collectTouch:IsA("BasePart") then
				-- Position in front of the CollectTouch part
				local offset = collectTouch.CFrame.LookVector * 3 + Vector3.new(0, 3, 0)
				return collectTouch.CFrame + offset
			end
		end
	end

	-- Fallback: use plot spawn
	local plotSpawn = plot:FindFirstChild("Spawn")
	if plotSpawn and plotSpawn:IsA("BasePart") then
		return plotSpawn.CFrame + Vector3.new(0, 3, 0)
	end

	return nil
end

local function findFirstEmptySlot(player: Player): (string?, string?, Model?)
	local plot = Workspace:FindFirstChild("Plot_" .. player.Name)
	if not plot then return nil, nil, nil end

	local profile = PlayerController:GetProfile(player)
	if not profile then return nil, nil, nil end

	if not profile.Data.Plots then profile.Data.Plots = {} end

	for _, floorModel in ipairs(plot:GetChildren()) do
		if floorModel.Name:match("Floor%d+") then
			local slotsFolder = floorModel:FindFirstChild("Slots")
			if slotsFolder then
				local floorData = profile.Data.Plots[floorModel.Name] or {}
				for i = 1, 10 do
					local slotName = "Slot" .. tostring(i)
					local slotModel = slotsFolder:FindFirstChild(slotName)
					if slotModel and slotModel:GetAttribute("IsUnlocked") == true then
						local slotData = floorData[slotName]
						if not slotData or not slotData.Item then
							return floorModel.Name, slotName, slotModel
						end
					end
				end
			end
		end
	end

	return nil, nil, nil
end

local function getConveyorSpeed(): number
	local parteA, parteB = getConveyorParts()
	if not parteA or not parteB then return 7 end
	local distance = (parteA.Position - parteB.Position).Magnitude
	if distance <= 0 then return 7 end
	return distance / TRAVEL_TIME
end

local function moveBrainrotToPos(model: Instance, startPos: Vector3, targetPos: Vector3, player: Player): boolean
	local distance = (startPos - targetPos).Magnitude
	if distance < 0.1 then return true end

	local speed = getConveyorSpeed()
	local duration = math.max(0.5, distance / speed)
	local startTime = tick()

	while true do
		if not player.Parent or not model.Parent then return false end

		local elapsed = tick() - startTime
		local alpha = math.clamp(elapsed / duration, 0, 1)
		local currentPos = startPos:Lerp(targetPos, alpha)

		pivotItemTo(model, CFrame.lookAt(currentPos, Vector3.new(targetPos.X, currentPos.Y, targetPos.Z)))

		if alpha >= 1 then break end
		task.wait(0.05)
	end

	return true
end

local function moveBrainrotToTarget(model: Instance, player: Player): boolean
	-- Step 1: Go to the plot's Collect part first
	local plot = Workspace:FindFirstChild("Plot_" .. player.Name)
	local startPos = getItemPivot(model).Position

	if plot then
		local collectPart = plot:FindFirstChild("Collect")
		if collectPart and collectPart:IsA("BasePart") then
			-- Keep the brainrot at the same height as the conveyor (no floating)
			local collectPos = Vector3.new(collectPart.Position.X, startPos.Y, collectPart.Position.Z)
			local arrived = moveBrainrotToPos(model, startPos, collectPos, player)
			if not arrived then return false end
		end
	end

	-- Brainrot disappears at the Collect
	model.Parent = nil
	return true
end

local function reserveSlot(player: Player, floorName: string, slotName: string)
	local profile = PlayerController:GetProfile(player)
	if not profile then return end
	if not profile.Data.Plots then profile.Data.Plots = {} end
	if not profile.Data.Plots[floorName] then profile.Data.Plots[floorName] = {} end
	-- Mark slot as reserved so findFirstEmptySlot skips it
	profile.Data.Plots[floorName][slotName] = {
		Item = { Name = "__RESERVED__", Mutation = "Normal", Rarity = "Common" },
		Level = 1,
		Stored = 0,
		Reserved = true,
	}
end

local function placeItemInSlot(player: Player, floorName: string, slotName: string, itemName: string, mutation: string, rarity: string): boolean
	local profile = PlayerController:GetProfile(player)
	if not profile then return false end

	if not profile.Data.Plots then profile.Data.Plots = {} end
	if not profile.Data.Plots[floorName] then profile.Data.Plots[floorName] = {} end

	profile.Data.Plots[floorName][slotName] = {
		Item = {
			Name = itemName,
			Mutation = mutation,
			Rarity = rarity
		},
		Level = 1,
		Stored = 0
	}

	-- Mark the brainrot as discovered so it shows as owned in the Index
	if not profile.Data.DiscoveredItems then profile.Data.DiscoveredItems = {} end
	local key = mutation .. "_" .. itemName
	if not profile.Data.DiscoveredItems[key] then
		profile.Data.DiscoveredItems[key] = true
		local Events = ReplicatedStorage:FindFirstChild("Events")
		if Events and Events:FindFirstChild("RefreshIndex") then
			Events.RefreshIndex:FireClient(player)
		end
	end

	SlotManager.RefreshSlot(player, floorName, slotName)
	return true
end

local function onBrainrotGrabbed(player: Player, brainrotModel: Model, entry: any)
	if entry.claimed then return end

	local itemName = brainrotModel:GetAttribute("OriginalName")
	local rarity = brainrotModel:GetAttribute("Rarity")
	local mutation = brainrotModel:GetAttribute("Mutation") or "Normal"
	local purchasePrice = brainrotModel:GetAttribute("Price") or 0

	if not itemName or not rarity then
		brainrotModel.Parent = nil
		return
	end

	-- Check if player has enough money to buy the brainrot
	if purchasePrice > 0 then
		local profile = PlayerController:GetProfile(player)
		if not profile then return end
		if (profile.Data.Money or 0) < purchasePrice then
			local notif = Events:FindFirstChild("ShowNotification")
			if notif then
				notif:FireClient(player, "Not enough money! Need $" .. NumberFormatter.Format(purchasePrice), "Error")
			end
			return
		end
		if not PlayerController:DeductMoney(player, purchasePrice) then
			return
		end
	end

	entry.claimed = true

	-- Find first empty slot in the player's plot
	local floorName, slotName, slotModel = findFirstEmptySlot(player)

	if slotModel then
		-- Reserve the slot IMMEDIATELY to prevent other brainrots from using it
		reserveSlot(player, floorName, slotName)

		-- Play the brainrot's pickup sound ONLY for the player who grabbed it
		local pickupSound = brainrotModel:FindFirstChildOfClass("Sound")
		local soundId = (pickupSound and pickupSound.SoundId ~= "") and pickupSound.SoundId or "rbxassetid://93529351909119"
		local playEvent = Events:FindFirstChild("PlayPickupSound")
		if playEvent then
			playEvent:FireClient(player, soundId)
		end

		-- Start the brainrot traveling toward the player's base (stealable in transit)
		entry.inTransit = true
		entry.targetPlayer = player
		entry.floorName = floorName
		entry.slotName = slotName
		entry.itemName = itemName
		entry.mutation = mutation
		entry.rarity = rarity

		-- Show notification
		local notif = Events:FindFirstChild("ShowNotification")
		if notif then
			local rarityConfig = RarityConfigurations[rarity]
			local rarityName = rarityConfig and rarityConfig.DisplayName or rarity
			notif:FireClient(player, "Voce Pegou: " .. itemName .. " (" .. rarityName .. ")!", "Success")
		end
	else
		-- No empty slot available, block the pickup
		entry.claimed = false

		local notif = Events:FindFirstChild("ShowNotification")
		if notif then
			notif:FireClient(player, "Sem espaços vazios! Desbloqueie mais andares para obter mais brainrots.", "Error")
		end
	end
end

local function getPlayerCollectPos(player: Player, model: Instance): Vector3?
	local plot = Workspace:FindFirstChild("Plot_" .. player.Name)
	if not plot then return nil end
	local collectPart = plot:FindFirstChild("Collect")
	if collectPart and collectPart:IsA("BasePart") then
		local startPos = getItemPivot(model).Position
		return Vector3.new(collectPart.Position.X, startPos.Y, collectPart.Position.Z)
	end
	return nil
end

local function stealBrainrot(player: Player, brainrotModel: Model, entry: any)
	if not entry.inTransit then return end
	if entry.targetPlayer == player then return end -- can't steal your own brainrot

	-- Release the previous owner's slot reservation
	local prevPlayer = entry.targetPlayer
	if prevPlayer then
		local prof = PlayerController:GetProfile(prevPlayer)
		if prof and prof.Data.Plots and prof.Data.Plots[entry.floorName] then
			local sd = prof.Data.Plots[entry.floorName][entry.slotName]
			if sd and sd.Reserved then
				prof.Data.Plots[entry.floorName][entry.slotName] = { Item = nil, Level = 1, Stored = 0 }
			end
		end
	end

	-- Find a new empty slot for the thief
	local floorName, slotName, slot = findFirstEmptySlot(player)
	if not slot then
		-- No slot available; the brainrot keeps going to the original owner
		local notif = Events:FindFirstChild("ShowNotification")
		if notif then
			notif:FireClient(player, "Sem espaços vazios! Desbloqueie mais andares para obter mais brainrots.", "Error")
		end
		return
	end

	reserveSlot(player, floorName, slotName)

	-- Redirect the brainrot toward the thief's base
	entry.targetPlayer = player
	entry.floorName = floorName
	entry.slotName = slotName

	-- Play the pickup sound for the thief
	local pickupSound = brainrotModel:FindFirstChildOfClass("Sound")
	local soundId = (pickupSound and pickupSound.SoundId ~= "") and pickupSound.SoundId or "rbxassetid://93529351909119"
	local playEvent = Events:FindFirstChild("PlayPickupSound")
	if playEvent then
		playEvent:FireClient(player, soundId)
	end

	-- Notify
	local notif = Events:FindFirstChild("ShowNotification")
	if notif then
		notif:FireClient(player, "Voce Roubou: " .. (entry.itemName or "Brainrot") .. "!", "Success")
	end
end

local function checkAutoPurchase(itemName: string, brainrotModel: Instance, entry: any)
	for player, selections in pairs(autoPurchaseSelections) do
		if not player.Parent then continue end

		-- Check if this brainrot is in the player's selections
		local found = false
		for _, sel in ipairs(selections) do
			if sel == itemName then
				found = true
				break
			end
		end
		if not found then continue end

		-- Try to auto-purchase (onBrainrotGrabbed checks money and slots internally)
		onBrainrotGrabbed(player, brainrotModel, entry)

		-- If the brainrot was claimed, auto-purchase succeeded
		if entry.claimed then
			local notif = BrainrotRemotes and BrainrotRemotes:FindFirstChild("AutoPurchaseNotification")
			if notif then
				notif:FireClient(player)
			end
			break
		end
	end
end

local function spawnBrainrot()
	local parteA, parteB = getConveyorParts()
	if not parteA or not parteB then return end

	if #activeBrainrots >= MAX_ACTIVE_BRAINROTS then return end

	local itemName, rarity
	local mutation = "Normal"
	local eventMutation

	-- If the admin queued a specific brainrot, spawn that one next
	local forced = forcedBrainrot
	if forced then
		forcedBrainrot = nil
		itemName = forced.itemName
		rarity = forced.rarity or "Common"
		mutation = forced.mutation or "Normal"
	else
		itemName, rarity = selectRandomItem()
		if not itemName then return end

		-- Determine the active event's mutation (if any event is running)
		local currentEvent = EventManager and EventManager.GetCurrentEvent and EventManager.GetCurrentEvent() or nil
		local eventConfig = currentEvent and EventConfig.Events[currentEvent] or nil
		eventMutation = eventConfig and eventConfig.MutationName or nil

		-- Probability: a spawned brainrot inherits the active event's mutation
		if eventMutation and math.random() <= EVENT_MUTATION_CHANCE then
			mutation = eventMutation
		end

		-- If no event mutation was rolled, roll Gold (10%) and Diamond (5%)
		if mutation == "Normal" then
			local mutRoll = math.random()
			if mutRoll <= 0.05 then
				mutation = "Diamond"
			elseif mutRoll <= 0.15 then
				mutation = "Gold"
			end
		end
	end

	local mutationFolder = ItemsFolder:FindFirstChild(mutation) or ItemsFolder:FindFirstChild("Normal")
	if not mutationFolder then return end

	local itemTemplate = mutationFolder:FindFirstChild(itemName) or ItemsFolder.Normal:FindFirstChild(itemName)
	if not itemTemplate then return end

	local item = itemTemplate:Clone()
	item.Name = "ConveyorBrainrot"
	item:SetAttribute("OriginalName", itemName)
	item:SetAttribute("Mutation", mutation)
	item:SetAttribute("Rarity", rarity)
	item:SetAttribute("Level", 1)
	item:SetAttribute("IsSpawnedItem", true)
	item:SetAttribute("BrainrotName", itemName)

	local itemData = ItemConfigurations.GetItemData(itemName)
	local baseIncome = itemData and itemData.Income or 0
	item:SetAttribute("Earn", baseIncome)

	-- Apply the mutation's texture (Gold, Diamond, Lava, etc.) if the item has one
	applyMutationTexture(item, itemTemplate, mutation)

	-- If the brainrot got the active event's mutation, set event attributes + highlight
	if eventMutation and mutation == eventMutation then
		item:SetAttribute("ActiveEvent", currentEvent)
		if eventConfig and eventConfig.Multiplier then
			item:SetAttribute("EventMultiplier", eventConfig.Multiplier)
		end
		if not item:GetAttribute("BaseEarn") then
			item:SetAttribute("BaseEarn", baseIncome)
		end
		if eventConfig then
			local hl = Instance.new("Highlight")
			hl.Name = "EventHighlight"
			hl.FillTransparency = 0.5
			hl.OutlineTransparency = 0.3
			hl.FillColor = eventConfig.Color
			hl.OutlineColor = eventConfig.OutlineColor
			hl.Parent = item
		end
	end

	-- Apply the mutation's VFX (cloned from VFX Mutações, or via mutation module)
	applyMutationVFX(item, mutation)

	-- Set purchase price from the balance data (0 = free)
	local purchasePrice = itemData and itemData.Price or 0
	item:SetAttribute("Price", purchasePrice)

	-- Anchor all parts, make non-collidable
	if item:IsA("BasePart") then
		item.Anchored = true
		item.CanCollide = false
		item.CanQuery = false
		item.CanTouch = false
	end
	for _, part in ipairs(item:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = true
			part.CanCollide = false
			part.CanQuery = false
			part.CanTouch = false
		end
	end

	-- Destroy any Humanoid inside the brainrot model.
	-- The Roblox engine automatically forces CanCollide = true on R6 body parts
	-- (Torso, Arms, Legs) when a Humanoid is present, overriding our settings above.
	-- The conveyor brainrots use AnimationController for animations, not Humanoid,
	-- so destroying it is safe and prevents the collision from being re-activated.
	for _, d in ipairs(item:GetDescendants()) do
		if d:IsA("Humanoid") then
			d:Destroy()
		end
		end

	-- Find the conveyor belt surface (the flat belt the brainrots should sit flush on)
	local belt = Workspace.Base and Workspace.Base:FindFirstChild("BasePLayer") and Workspace.Base.BasePLayer:FindFirstChild("Assets") and Workspace.Base.BasePLayer.Assets:FindFirstChild("Part")
	local beltTopY = belt and (belt.Position.Y + belt.Size.Y / 2) or (parteA.Position.Y + parteA.Size.Y / 2)

	-- Measure the actual offset from the model's pivot to the bottom of its bounding box
	-- This ensures the model sits flush on the conveyor surface regardless of pivot placement
	pivotItemTo(item, CFrame.new(parteA.Position))
	local model = getModelFromItem(item)
	local pivotToBottomOffset = 0
	if model then
		local bbCFrame, bbSize = model:GetBoundingBox()
		local pivotPos = model:GetPivot().Position
		pivotToBottomOffset = bbCFrame.Position.Y - bbSize.Y / 2 - pivotPos.Y
	end

	local startPos = Vector3.new(parteA.Position.X, beltTopY - pivotToBottomOffset, parteA.Position.Z)
	local endPos = Vector3.new(parteB.Position.X, beltTopY - pivotToBottomOffset, parteB.Position.Z)
	local spawnCFrame = CFrame.lookAt(startPos, endPos)
	pivotItemTo(item, spawnCFrame)
	item.Parent = Workspace

	-- Attach Brainrot_UI (show mutation name for Gold, Diamond, and Lava)
	attachBrainrotUI(item, itemName, rarity, mutation, baseIncome)

	-- Show the mutation's icon in the UI
	applyMutationUI(item, mutation)

	-- Play the walk animation so brainrots animate while moving on the conveyor
	playBrainrotAnimation(item, itemTemplate, "Walk")

	-- Create entry
	local entry = {
		model = item,
		claimed = false,
		startPos = startPos,
		endPos = endPos,
		startTime = tick(),
	}
	table.insert(activeBrainrots, entry)

	-- Check if any player has auto-purchase enabled for this brainrot
	checkAutoPurchase(itemName, item, entry)

	-- Highlight removed by user request
end

local function updateBrainrots(dt: number)
	local i = 1
	while i <= #activeBrainrots do
		local entry = activeBrainrots[i]

		if not entry.model.Parent then
			-- Remove destroyed entries
			table.remove(activeBrainrots, i)
		elseif entry.inTransit then
			-- Moving toward the target player's base (stealable in transit)
			local targetPos = getPlayerCollectPos(entry.targetPlayer, entry.model)
			if not targetPos then
				entry.model.Parent = nil
				table.remove(activeBrainrots, i)
			else
				local currentPos = getItemPivot(entry.model).Position
				local toTarget = targetPos - currentPos
				local dist = toTarget.Magnitude
				local speed = getConveyorSpeed()
				local step = speed * dt

				if dist <= step then
					-- Reached the base: place the item in the reserved slot
					placeItemInSlot(entry.targetPlayer, entry.floorName, entry.slotName, entry.itemName, entry.mutation, entry.rarity)
					entry.model.Parent = nil
					table.remove(activeBrainrots, i)
				else
					local newPos = currentPos + toTarget.Unit * step
					pivotItemTo(entry.model, CFrame.lookAt(newPos, targetPos))
					i += 1
				end
			end
		else
			-- Move the brainrot toward ParteB on the conveyor
			local elapsed = tick() - entry.startTime
			local alpha = math.clamp(elapsed / TRAVEL_TIME, 0, 1)

			if alpha >= 1 then
				-- Reached ParteB, despawn
				entry.model.Parent = nil
				table.remove(activeBrainrots, i)
			else
				-- Interpolate position, facing forward towards ParteB
				local currentPos = entry.startPos:Lerp(entry.endPos, alpha)
				local newCFrame = CFrame.lookAt(currentPos, entry.endPos)
				pivotItemTo(entry.model, newCFrame)
				i += 1
			end
		end
	end
end

-- [ ADMIN: FORCE NEXT SPAWN ]

-- Queue a specific brainrot as the NEXT brainrot to spawn on the conveyor
function BrainrotConveyor:SetForcedBrainrot(itemName: string, mutation: string?, rarity: string?)
	forcedBrainrot = {
		itemName = itemName,
		mutation = mutation or "Normal",
		rarity = rarity or "Common",
	}
end

-- [ INITIALIZATION ]

function BrainrotConveyor:Init(controllers)
	PlayerController = controllers.PlayerController
	local Modules = ServerScriptService:WaitForChild("Modules")
	ItemManager = require(Modules:WaitForChild("ItemManager"))
	SlotManager = require(Modules:WaitForChild("SlotManager"))
	EventManager = require(Modules:WaitForChild("EventManager"))

	print("[BrainrotConveyor] Initialized")
end

-- [ START ]

function BrainrotConveyor:Start()
	if isRunning then return end
	isRunning = true

	-- Listen for E-key pickup requests from clients
	local pickupEvent = Events:FindFirstChild("PickupBrainrot")
	if pickupEvent then
		pickupEvent.OnServerEvent:Connect(function(player, brainrotModel)
			if not player or not brainrotModel then return end

			-- Validate the model is an active conveyor brainrot (claimed or in transit)
			local entry = nil
			for _, e in ipairs(activeBrainrots) do
				if e.model == brainrotModel then
					entry = e
					break
				end
			end
			if not entry then return end

			-- Validate player proximity
			local character = player.Character
			if not character then return end
			local hrp = character:FindFirstChild("HumanoidRootPart")
			if not hrp then return end

			local brainrotPos = getItemPivot(brainrotModel).Position
			local distance = (hrp.Position - brainrotPos).Magnitude
			if distance > PICKUP_RANGE then return end

			if entry.inTransit then
				-- Steal a brainrot that another player already bought
				stealBrainrot(player, brainrotModel, entry)
			else
				-- Fresh pickup from the conveyor
				onBrainrotGrabbed(player, brainrotModel, entry)
			end
		end)
	else
		warn("[BrainrotConveyor] PickupBrainrot RemoteEvent not found!")
	end

	-- Setup auto-purchase remotes
	BrainrotRemotes = ReplicatedStorage:FindFirstChild("BrainrotRemotes")
	if BrainrotRemotes then
		local setAuto = BrainrotRemotes:FindFirstChild("SetAutoPurchase")
		local getData = BrainrotRemotes:FindFirstChild("GetAutoPurchaseData")

		if setAuto then
			setAuto.OnServerEvent:Connect(function(player, action, brainrotType)
				if action == "add" then
					if not autoPurchaseSelections[player] then
						autoPurchaseSelections[player] = {}
					end
					-- Max 8 selections
					if #autoPurchaseSelections[player] >= 8 then
						setAuto:FireClient(player, "addResult", brainrotType, false)
						return
					end
					-- Check for duplicates
					for _, sel in ipairs(autoPurchaseSelections[player]) do
						if sel == brainrotType then
							setAuto:FireClient(player, "addResult", brainrotType, false)
							return
						end
					end
					table.insert(autoPurchaseSelections[player], brainrotType)
					setAuto:FireClient(player, "addResult", brainrotType, true)
				elseif action == "remove" then
					if autoPurchaseSelections[player] then
						for i, sel in ipairs(autoPurchaseSelections[player]) do
							if sel == brainrotType then
								table.remove(autoPurchaseSelections[player], i)
								break
							end
						end
					end
					setAuto:FireClient(player, "removeResult", brainrotType, true)
				end
			end)
		end

		if getData then
			getData.OnServerInvoke = function(player)
				return {
					selections = autoPurchaseSelections[player] or {},
					globalCooldown = 0
				}
			end
		end
	else
		warn("[BrainrotConveyor] BrainrotRemotes folder not found!")
	end

	-- Cleanup on player leave
	Players.PlayerRemoving:Connect(function(player)
		autoPurchaseSelections[player] = nil
		autoPurchaseCooldowns[player] = nil
	end)

	-- Spawn loop
	task.spawn(function()
		while isRunning do
			spawnBrainrot()
			task.wait(SPAWN_INTERVAL)
		end
	end)

	-- Movement loop (runs every frame for smooth 60fps movement)
	RunService.Heartbeat:Connect(function(dt)
		updateBrainrots(dt)
	end)

	-- Pity timer countdown loop
	local legendarySound, secretSound, mythicalSound = getPitySounds()

	task.spawn(function()
		while isRunning do
			if not legendaryPityActive then
				pityLegendaryTimer = math.max(0, pityLegendaryTimer - 1)
				if pityLegendaryTimer <= 0 then
					legendaryPityActive = true
					playPityAlertSound(legendarySound)
				end
			end
			if not secretPityActive then
				pitySecretTimer = math.max(0, pitySecretTimer - 1)
				if pitySecretTimer <= 0 then
					secretPityActive = true
					playPityAlertSound(secretSound)
				end
			end
			if not mythicalPityActive then
				pityMythicalTimer = math.max(0, pityMythicalTimer - 1)
				if pityMythicalTimer <= 0 then
					mythicalPityActive = true
					playPityAlertSound(mythicalSound)
				end
			end

			-- Update UI
			getCountdownUI()
			if lblLegendary then
				if legendaryPityActive then
					lblLegendary.Text = 'Guaranteed <font color="#FFCC00">Legendary</font> spawning now!'
				else
					lblLegendary.Text = 'Guaranteed <font color="#FFCC00">Legendary</font> in ' .. formatTime(pityLegendaryTimer)
				end
			end
			if lblSecret then
				if secretPityActive then
					lblSecret.Text = 'Guaranteed <font color="#FFFFFF">Secret</font> spawning now!'
				else
					lblSecret.Text = 'Guaranteed <font color="#FFFFFF">Secret</font> in ' .. formatTime(pitySecretTimer)
				end
			end
			if lblMythical then
				if mythicalPityActive then
					lblMythical.Text = 'Guaranteed <font color="#FF007F">Mythical</font> spawning now!'
				else
					lblMythical.Text = 'Guaranteed <font color="#FF007F">Mythical</font> in ' .. formatTime(pityMythicalTimer)
				end
			end

			task.wait(1)
		end
	end)

	print("[BrainrotConveyor] Started - Spawning brainrots every " .. SPAWN_INTERVAL .. "s")
	print("[BrainrotConveyor] Pity timers: Legendary=" .. LEGENDARY_PITY_TIME .. "s, Secret=" .. SECRET_PITY_TIME .. "s, Mythical=" .. MYTHICAL_PITY_TIME .. "s")
end

return BrainrotConveyor