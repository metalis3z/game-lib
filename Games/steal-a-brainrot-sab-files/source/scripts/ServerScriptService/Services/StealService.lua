--!native

local StealService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local NotificationService = require(ServerScriptService.Services.NotificationService)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)

local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
local GetBoundingBox = require(ReplicatedStorage.Shared.GetAnimalBoundingBox)
local LuckyBlocks = require(ReplicatedStorage.Datas.LuckyBlocks)
local exclusive_animals = require(game.ReplicatedStorage.Exclusive)
local SkinService = require(ServerScriptService.Services.SkinService)
local BasesData = require(ReplicatedStorage.Datas.Bases)

local playerJoinTimes = {}

local stealLocks: { [string]: boolean } = {}
local function playfakevfx_at_podium(Plot, PodiumIndex)
	local AnimalPodiumsFolder = Plot and Plot:FindFirstChild("AnimalPodiums")
	local PodiumModel = AnimalPodiumsFolder and AnimalPodiumsFolder:FindFirstChild(tostring(PodiumIndex))

	local vfxPosition
	if PodiumModel then
		local Base  = PodiumModel:FindFirstChild("Base")
		local Spawn = Base and Base:FindFirstChild("Spawn")
		if Spawn then
			vfxPosition = Spawn.Position + Vector3.new(0, 1, 0)
		elseif Base and Base.PrimaryPart then
			vfxPosition = Base.PrimaryPart.Position + Vector3.new(0, 1, 0)
		elseif PodiumModel.PrimaryPart then
			vfxPosition = PodiumModel.PrimaryPart.Position + Vector3.new(0, 1, 0)
		end
	end
	if not vfxPosition and Plot and Plot.PrimaryPart then
		vfxPosition = Plot.PrimaryPart.Position
	end

	if vfxPosition then
		pcall(function()
			Net:RemoteEvent("SpawnFakeBrainrot/Poof"):FireAllClients({ Position = vfxPosition })
		end)
	end
end

local function CheckAndClearFakeAnimal(PlayerChannel, Plot, PodiumIndex)
	local AnimalList = PlayerChannel:Get("AnimalPodiums")

	if AnimalList and type(AnimalList[PodiumIndex]) == "table" and AnimalList[PodiumIndex].isfake == true then
		playfakevfx_at_podium(Plot, PodiumIndex)

		AnimalList[PodiumIndex] = "Empty"
		PlayerChannel:Set("AnimalPodiums", AnimalList)
		PlayerChannel:Set("AnimalAddedOrRemoved", true)

		return true
	end

	return false
end
local function acquireStealLock(plotUID: string, podiumIndex: number): boolean
	local key = plotUID .. "_" .. tostring(podiumIndex)
	if stealLocks[key] then return false end
	stealLocks[key] = true
	return true

end

local function releaseStealLock(plotUID: string, podiumIndex: number)
	stealLocks[plotUID .. "_" .. tostring(podiumIndex)] = nil
end
StealService.WHITELIST = {
}
local SKIN_DISABLE_MAP = {
	["Skibidi Toilet"] = "Skibidi",
	["Meowl"]          = "Meowl",
	["Strawberry Elephant"] = "Strawberry",
	["Headless Horseman"] = "Headless",
	["John Pork"] = "John Pork",
	["Smurf Cat"] = "SmurfCat",
}

local carrySpeedConnections = {}

local function applyCarrySpeed(player, speedMultiplier)
	if not player.Character then return end
	local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	if not humanoid:GetAttribute("OriginalWalkSpeed") then
		humanoid:SetAttribute("OriginalWalkSpeed", humanoid.WalkSpeed)
	end

	local originalSpeed = humanoid:GetAttribute("OriginalWalkSpeed") or humanoid.WalkSpeed
	humanoid.WalkSpeed = originalSpeed * speedMultiplier

	local function restoreSpeed()
		if humanoid:GetAttribute("OriginalWalkSpeed") then
			humanoid.WalkSpeed = humanoid:GetAttribute("OriginalWalkSpeed")
			humanoid:SetAttribute("OriginalWalkSpeed", nil)
		end
	end

	if carrySpeedConnections[player] then
		carrySpeedConnections[player]:Disconnect()
	end
	carrySpeedConnections[player] = player.CharacterRemoving:Connect(restoreSpeed)
end

local CARRY_BASE_DISTANCE = -2

local function getCarryOffsets(character: Instance?): (number, number)
	if not character then
		return CARRY_BASE_DISTANCE, 0
	end

	if not character:GetAttribute("IsGiant") then
		return CARRY_BASE_DISTANCE, 0
	end

	local giantScale = character:GetAttribute("GiantScale")
	if typeof(giantScale) ~= "number" or giantScale <= 0 then
		giantScale = 2.5
	end

	local distance = CARRY_BASE_DISTANCE * giantScale
	local height = 1.5 * (giantScale - 1)
	return distance, height
end

local STEAL_PROTECTION_TIME = 30

local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local RaritiesData = require(ReplicatedStorage.Datas.Rarities)

local Grab = Net:RemoteEvent("StealService/Grab")
local CarryAnimation = ReplicatedStorage.Animations.Player.Carry
local function getGroundCF(position: Vector3, character: Model?): CFrame
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = character and {character} or {}

	local result = workspace:Raycast(
		position + Vector3.new(0, 5, 0),
		Vector3.new(0, -30, 0),
		params
	)

	if result then
		return CFrame.new(result.Position + Vector3.new(0, 0.5, 0))
	end

	return CFrame.new(position.X, position.Y - 1, position.Z)
end

local function getWBPoolPart(poolId: string, brainrotId: string)
	local poolsRoot = workspace:FindFirstChild("WBPools")
	if not poolsRoot then
		return nil
	end

	local safeName = poolId:gsub("[/\\%s]", "_")
	local folder = poolsRoot:FindFirstChild(safeName)

	if not folder then
		return nil
	end

	return folder:FindFirstChild(brainrotId)
end

local function getMaxAnimals(player: Player): number
	local plot = _G.playerPlots[player.UserId]
	if not plot then
		return 100
	end
	local tier = plot:GetAttribute("Tier") or 0
	local baseData = BasesData[tier]
	local max = baseData and baseData.MaxAnimals or 100
	return max
end

local function findFreePodiumIndex(player: Player, animalList: table): number?
	local maxAnimals = getMaxAnimals(player)
	for i = 1, maxAnimals do
		local slot = animalList[i]
		if slot == "Empty" or slot == nil then
			return i
		end
	end
	return nil
end

local activeSteals: {[Player]: {
	VictimPlotUID: string,
	PodiumIndex: number,
	StolenAnimalData: any,
	Model: Model?,
	AnimationTrack: AnimationTrack?,
	CarriedOverhead: BillboardGui?,
	DiedConnection: RBXScriptConnection?,
	RemovingConnection: RBXScriptConnection?,
	VictimRemovingConnection: RBXScriptConnection?,
	DisplacedSkin: string?,
}} = {}
local activeEggGrabs: {[number]: {
	poolId: string,
	brainrotId: string,
	savedBDT: number,
	animTrack: AnimationTrack?,
	model: Model?,
	deliveryConn: RBXScriptConnection?,
	diedConn: RBXScriptConnection?,
	removingConn: RBXScriptConnection?,
	partRemovedConn: RBXScriptConnection?,
}} = {}

local activePresents: {[Player]: {
	Model: Model?,
	AnimationTrack: AnimationTrack?,
	DiedConnection: RBXScriptConnection?,
	RemovingConnection: RBXScriptConnection?,
	OnCleanup: (() -> ())?,
}} = {}

local function AddCarriedOverhead(animalModel: Model, isStolen: boolean)
	if not animalModel or not animalModel.PrimaryPart then
		return
	end

	local Overheads = ReplicatedStorage:FindFirstChild("Overheads")
		and ReplicatedStorage.Overheads:FindFirstChild("AnimalOverhead")

	if not Overheads then
		warn("AnimalOverhead not found in ReplicatedStorage.Overheads")
		return
	end

	local Overhead = Overheads:Clone()

	if isStolen then
		Overhead.DisplayName.Text = "STOLEN"
		Overhead.DisplayName.TextColor3 = Color3.fromRGB(255, 0, 0)
	else
		Overhead.DisplayName.Text = ""
	end

	Overhead.DisplayName.TextStrokeTransparency = 0
	Overhead.DisplayName.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

	Overhead.Generation.Visible = false
	Overhead.Price.Visible = false
	Overhead.Rarity.Visible = false
	Overhead.Mutation.Visible = false
	Overhead.Stolen.Visible = false

	local OverheadAttachment =
		animalModel:FindFirstChild("OVERHEAD_ATTACHMENT", true)

	if OverheadAttachment and OverheadAttachment:IsA("Attachment") then
		Overhead.Parent = OverheadAttachment
		return Overhead
	end

	local FallbackAttachment = Instance.new("Attachment")
	FallbackAttachment.Name = "Attachment"
	FallbackAttachment.CFrame = CFrame.new(0, 3, 0)
	FallbackAttachment.Parent = animalModel.PrimaryPart

	Overhead.Parent = FallbackAttachment
	return Overhead
end

local function FormatAnimalName(animalName: string): string
	local animalRarity = AnimalsData[animalName].Rarity
	local rarityData = RaritiesData[animalRarity]

	if rarityData.GradientPreset then
		local gradientMap = {
			Rainbow = "rainbow",
			Zebra = "zebra",			
			OG = "og",
			YellowRed = "yellowred",
			Greenred = "greenred",
			SlowGreenRed = "slowgreenred"
		}

		local gradientTag = gradientMap[rarityData.GradientPreset]
		if gradientTag then
			return string.format("<%s>%s</%s>", gradientTag, animalName, gradientTag)
		else
			return string.format("<font color=\"#%s\">%s</font>", rarityData.Color:ToHex(), animalName)
		end
	else
		return string.format("<font color=\"#%s\">%s</font>", rarityData.Color:ToHex(), animalName)
	end
end

function StealService:GetStealData(player: Player)
	return activeSteals[player]
end

function StealService:StartSteal(player: Player, victimPlotUID: string, podiumIndex: number, targetPodiumIndex: number?)
	warn(("[STEALDBG2] StartSteal entry uid=%s podium=%s (%s)"):format(tostring(victimPlotUID), tostring(podiumIndex), typeof(podiumIndex)))
	if not acquireStealLock(victimPlotUID, podiumIndex) then
		warn("[STEALDBG2] FAIL lock held")
		return
	end
	local character = player.Character
	if not player or not character or not victimPlotUID or not podiumIndex then return end
	if player:GetAttribute("Stealing") then
		releaseStealLock(victimPlotUID, podiumIndex) return
	end

	if player:GetAttribute("StealCooldown") then
		releaseStealLock(victimPlotUID, podiumIndex) return
	end
	player:SetAttribute("StealCooldown", true)
	task.delay(1, function()
		if player then
			player:SetAttribute("StealCooldown", nil)
		end
	end)
	local character = player.Character
	if not character then releaseStealLock(victimPlotUID, podiumIndex) return end

	local humanoid = character:FindFirstChild("Humanoid") :: Humanoid
	if not humanoid or humanoid.Health < 1 then releaseStealLock(victimPlotUID, podiumIndex) return end

	local victimPlotChannel = Synchronizer:Get(victimPlotUID)
	if not victimPlotChannel then releaseStealLock(victimPlotUID, podiumIndex) return end

	local victimPlayer = victimPlotChannel:Get("Owner")

	if typeof(victimPlayer) == "string" then
		victimPlayer = Players:FindFirstChild(victimPlayer)
	end

	if victimPlayer and victimPlayer:IsA("Player") and victimPlayer ~= player then
		local victimChannel = Synchronizer:Get(victimPlayer)
		if victimChannel and victimChannel:Get("StealImmune") == true then
			NotificationService.Error(player, "This player just teleported, try again shortly.", 5)
			releaseStealLock(victimPlotUID, podiumIndex)
			return
		end
	end

	if victimPlayer and victimPlayer:IsA("Player") then
		if victimPlayer ~= player and StealService.WHITELIST[victimPlayer.UserId] then
			NotificationService.Error(player, "You can't steal from this user", 2)
			releaseStealLock(victimPlotUID, podiumIndex)
			return
		end

		local TradeService = require(ServerScriptService.Services.TradeService)
		if victimPlayer ~= player and TradeService:isInTrade(victimPlayer.UserId) then
			NotificationService.Error(player, "You can't steal from someone who is trading.", 2)
			releaseStealLock(victimPlotUID, podiumIndex)
			return
		end
	end

	if victimPlayer and player ~= victimPlayer then
		local joinTime = playerJoinTimes[victimPlayer.UserId]
		if joinTime then
			local elapsed = os.clock() - joinTime
			local remaining = STEAL_PROTECTION_TIME - elapsed
			if remaining > 0 then
				if not player:GetAttribute("AntiStealSpam") then
					player:SetAttribute("AntiStealSpam", true)
					NotificationService.Notify(
						player,
						string.format("<font color=\"#FF0000\">This player just joined, please wait %d seconds</font>", math.ceil(remaining)),
						3,
						"Sounds.Sfx.Error"
					)
					task.delay(0.8, function()
						if player then
							player:SetAttribute("AntiStealSpam", nil)
						end
					end)
				end
				releaseStealLock(victimPlotUID, podiumIndex)
				return
			end
		end
	end

	if victimPlayer and victimPlayer.Name == "SpyderSammy" and player ~= victimPlayer then

		if player:GetAttribute("AntiStealSpam") then
			releaseStealLock(victimPlotUID, podiumIndex)
			return
		end
		player:SetAttribute("AntiStealSpam", true)
		task.delay(0.2, function()
			player:SetAttribute("AntiStealSpam", nil)
		end)

		NotificationService.Notify(
			player,
			"<font color=\"#FF0000\">You can't steal from this user</font>",
			3,
			"Sounds.Sfx.Error"
		)
		releaseStealLock(victimPlotUID, podiumIndex)
		return
	end

	local victimAnimalList = victimPlotChannel:Get("AnimalList")
	if not victimAnimalList then warn("[STEALDBG2] FAIL AnimalList nil") releaseStealLock(victimPlotUID, podiumIndex) return end

	local animalData = victimAnimalList and victimAnimalList[podiumIndex]
	if type(animalData) ~= "table" then
		animalData = victimAnimalList[tostring(podiumIndex)]
	end
	warn(("[STEALDBG2] animalData lookup podium=%s -> %s"):format(tostring(podiumIndex), typeof(animalData) == "table" and tostring(animalData.Index) or tostring(animalData)))
	if not animalData or typeof(animalData) ~= "table"  then warn("[STEALDBG2] FAIL animalData missing") releaseStealLock(victimPlotUID, podiumIndex) return end

	if animalData.Steal and animalData.Steal ~= false then
		releaseStealLock(victimPlotUID, podiumIndex)
		return
	end

	if animalData.Machine then releaseStealLock(victimPlotUID, podiumIndex) return end

	local TradeService = require(ServerScriptService.Services.TradeService)
	if TradeService.isInTrade(player.UserId) then
		NotificationService.Error(player, "You can't steal while trading.", 2)
		releaseStealLock(victimPlotUID, podiumIndex)
		return
	end

	if animalData.InTradeOffer == true then
		NotificationService.Error(player, "That brainrot is currently in a trade offer.", 2)
		releaseStealLock(victimPlotUID, podiumIndex)
		return
	end

	if animalData.Unstealable == true and victimPlayer ~= player then
		NotificationService.Error(player, "This brainrot is unstealable!", 2)
		releaseStealLock(victimPlotUID, podiumIndex)
		return
	end

	if SharedAnimals.IsLocked(animalData) and victimPlayer ~= player then
		NotificationService.Error(player, "This brainrot can't be stolen", 2)
		releaseStealLock(victimPlotUID, podiumIndex)
		return
	end

	if humanoid then
		humanoid:UnequipTools()
	end
	task.wait(0.1)
	applyCarrySpeed(player, 0.75)

	local animalDataToCache = animalData
	if animalData.isfake or animalData.IsFake then
		local clean = {}
		for k, v in pairs(animalData) do
			clean[k] = v
		end
		clean.isfake = nil
		clean.IsFake = nil
		animalDataToCache = clean
	end

	victimPlotChannel:Set(string.format("AnimalList.%d.Steal", podiumIndex), player.UserId)
	victimPlotChannel:Set(string.format("AnimalList.%d.Stolen", podiumIndex), true)

	if victimPlayer == player then
		victimPlotChannel:Set(string.format("AnimalList.%d.StealText", podiumIndex), "")
	else
		victimPlotChannel:Set(string.format("AnimalList.%d.StealText", podiumIndex), "STOLEN")
	end

	victimPlotChannel:Set(string.format("AnimalList.%d.Machine", podiumIndex), nil)
	local isLuckyBlock = LuckyBlocks[animalData.Index] ~= nil

	if isLuckyBlock then
		victimPlotChannel:Set(
			string.format("AnimalList.%d.Timer", podiumIndex),
			0
		)
	else
		victimPlotChannel:Set(
			string.format("AnimalList.%d.Timer", podiumIndex),
			nil
		)
	end

	local animalName = animalData.Index
	local playerRoot = character:FindFirstChild("HumanoidRootPart") :: Part
	local Humanoid = character:FindFirstChild("Humanoid") :: Humanoid
	local Animator = Humanoid:FindFirstChild("Animator") :: Animator
	local displacedSkin: string? = nil
	local victimDisplacedSkin: string? = nil
	local mappedSkin = SKIN_DISABLE_MAP[animalName]
	local ownPlotName = _G.playerPlots[player.UserId] and _G.playerPlots[player.UserId].Name
	local isOwnPlot = (ownPlotName ~= nil and victimPlotUID == ownPlotName)

	if mappedSkin and not isOwnPlot and victimPlayer and victimPlayer:IsA("Player") then
		local victimChannel = Synchronizer:Get(victimPlayer)
		if victimChannel then
			local victimEquippedSkin = victimChannel:Get("Settings.Base Skin")
			if victimEquippedSkin == mappedSkin then
				local victimPodiums = victimChannel:Get("AnimalPodiums") or {}
				local animalCount = 0
				for _, podiumData in pairs(victimPodiums) do
					if typeof(podiumData) == "table" and podiumData.Index == animalName then
						animalCount += 1
					end
				end
				if animalCount <= 1 then
					local victimPlot = _G.playerPlots[victimPlayer.UserId]
					if victimPlot then
						local tier = victimPlot:GetAttribute("Tier") or 0
						SkinService:Apply("Normal", victimPlot, tier)
						victimDisplacedSkin = victimEquippedSkin
					end
				end
			end

			if animalName == "Smurf Cat" then
				local victimPodiums = victimChannel:Get("AnimalPodiums") or {}
				local smurfCatCount = 0
				for _, podiumData in pairs(victimPodiums) do
					if typeof(podiumData) == "table" and podiumData.Index == "Smurf Cat" then
						smurfCatCount += 1
					end
				end
				if smurfCatCount <= 1 then
					local unlockedSkins = victimChannel:Get("UnlockedBaseSkins") or {}
					unlockedSkins.SmurfCat = false
					victimChannel:Set("UnlockedBaseSkins", unlockedSkins)
				end
			end
		end
	end
	local loadedAnimation: AnimationTrack = Animator:LoadAnimation(CarryAnimation)
	loadedAnimation.Looped = true

	if animalName and playerRoot and Humanoid and Animator then

		local isStolen = victimPlayer ~= player
		local carryDistance, carryHeight = getCarryOffsets(character)

		local carryPart = Instance.new("Part")
		carryPart.Name = "StealCarry_" .. animalName
		carryPart.Size = Vector3.new(0.1, 0.1, 0.1)
		carryPart.Transparency = 1
		carryPart.CanCollide = false
		carryPart.Anchored = false
		carryPart.Massless = true
		carryPart.CFrame = playerRoot.CFrame * CFrame.new(0, carryHeight, carryDistance)

		carryPart:SetAttribute("__render_brainrot", animalName)
		carryPart:SetAttribute("__render_animation", "Idle")
		if animalData.Mutation and animalData.Mutation ~= "" then
			carryPart:SetAttribute("__render_mutation", animalData.Mutation)
		end
		carryPart:SetAttribute("__render_traits", HttpService:JSONEncode(animalData.Traits or {}))
		carryPart:SetAttribute("__render_overhead", true)
		carryPart:SetAttribute("__render_stolen", isStolen)

		CollectionService:AddTag(carryPart, "ClientRenderBrainrot")

		local weld = Instance.new("WeldConstraint")
		weld.Part0 = playerRoot
		weld.Part1 = carryPart
		weld.Parent = carryPart

		carryPart.Parent = workspace

		loadedAnimation:Play()

		player:SetAttribute("StealingIndex", animalName)
		player:SetAttribute("Stealing", true)

		local diedConnection: RBXScriptConnection?
		local removingConnection: RBXScriptConnection?
		local victimRemovingConnection: RBXScriptConnection?

		activeSteals[player] = {
			VictimPlotUID = victimPlotUID,
			PodiumIndex = podiumIndex,
			StolenAnimalData = animalDataToCache,
			Model = carryPart,
			AnimationTrack = loadedAnimation,
			CarriedOverhead = nil,
			DiedConnection = diedConnection,
			RemovingConnection = removingConnection,
			VictimRemovingConnection = victimRemovingConnection,
			DisplacedSkin = displacedSkin,
			VictimDisplacedSkin = victimDisplacedSkin,
			VictimUserId = victimPlayer and victimPlayer.UserId,
			TargetPodiumIndex = targetPodiumIndex,
		}

		local colouredText = FormatAnimalName(animalName)
		local text = string.format("Someone is stealing your %s", colouredText)

		if victimPlayer and victimPlayer:IsA("Player") then
			if victimPlayer ~= player then
				NotificationService.Notify(victimPlayer, text, 10, "Sounds.Sfx.Warn")
			end

			if player ~= victimPlayer then
				NotificationService.Notify(player, "", 10, ("Sounds.Animals.%s"):format(animalName))
			end

			victimRemovingConnection = Players.PlayerRemoving:Connect(function(removedPlayer)
				if removedPlayer == victimPlayer then
					local victimPlayerChannel = Synchronizer:Get(removedPlayer)
					if victimPlayerChannel then
						victimPlayerChannel:Set(
							string.format("AnimalPodiums.%d", podiumIndex),
							"Empty"
						)
						victimPlayerChannel:Set("AnimalAddedOrRemoved", true)
					end

					local currentVictimPlotChannel = Synchronizer:Get(victimPlotUID)
					if currentVictimPlotChannel then
						currentVictimPlotChannel:Set(string.format("AnimalList.%d", podiumIndex), "Empty")
					end

					if activeSteals[player] then
						local VictimRemovingConnection = activeSteals[player].VictimRemovingConnection
						if VictimRemovingConnection then
							VictimRemovingConnection:Disconnect()
							VictimRemovingConnection = nil
						end
					end
				end
			end)
		end

		diedConnection = Humanoid.Died:Once(function()
			self:CancelSteal(player)
		end)
		removingConnection = Players.PlayerRemoving:Once(function(removedPlayer)
			if removedPlayer == player then
				self:CancelSteal(player)
			end
		end)

		activeSteals[player].DiedConnection = diedConnection
		activeSteals[player].RemovingConnection = removingConnection
		activeSteals[player].VictimRemovingConnection = victimRemovingConnection

		return true
	end
end

function StealService:CancelSteal(player: Player, podiumIndex: number?)
	local stealInfo = activeSteals[player]
	if not stealInfo then return end

	releaseStealLock(stealInfo.VictimPlotUID, stealInfo.PodiumIndex)

	if stealInfo.CarriedOverhead then
		stealInfo.CarriedOverhead:Destroy()
		stealInfo.CarriedOverhead = nil
	end

	if stealInfo.DiedConnection then stealInfo.DiedConnection:Disconnect() end
	if stealInfo.RemovingConnection then stealInfo.RemovingConnection:Disconnect() end
	if stealInfo.VictimRemovingConnection then stealInfo.VictimRemovingConnection:Disconnect() end
	if stealInfo.DeliveryConnection then stealInfo.DeliveryConnection:Disconnect() end

	if stealInfo.AnimationTrack then
		stealInfo.AnimationTrack:Stop()
	end

	if stealInfo.Model then
		stealInfo.Model:Destroy()
	end

	if stealInfo.VictimPlotUID == "Sammy" then
		if stealInfo.DisplayAnimalClone then
			for _, part in ipairs(stealInfo.DisplayAnimalClone:GetDescendants()) do
				if part:IsA("BasePart") and part ~= stealInfo.DisplayAnimalClone.PrimaryPart then
					local defaultTransparency = part:GetAttribute("DefaultTransparency")
					if defaultTransparency ~= nil then
						part.Transparency = defaultTransparency
					else
						part.Transparency = 0
					end
				end
			end
		end

		if stealInfo.DisplayOverhead then
			stealInfo.DisplayOverhead.DisplayName.Visible = true
			stealInfo.DisplayOverhead.Generation.Visible = true
			stealInfo.DisplayOverhead.Mutation.Visible = true
			stealInfo.DisplayOverhead.Price.Visible = true
			stealInfo.DisplayOverhead.Rarity.Visible = true
			stealInfo.DisplayOverhead.Stolen.Visible = false
		end

		if stealInfo.DisplayPrompt then
			stealInfo.DisplayPrompt.Enabled = true
		end
	end
	activeSteals[player] = nil
	player:SetAttribute("Stealing", nil)
	player:SetAttribute("StealingIndex", "")
	player:SetAttribute("SammyStealing", nil)
	if stealInfo.VictimDisplacedSkin and stealInfo.VictimUserId then
		local victimPlayer = Players:GetPlayerByUserId(stealInfo.VictimUserId)
		if victimPlayer then
			local victimPlot = _G.playerPlots[stealInfo.VictimUserId]
			if victimPlot then
				local tier = victimPlot:GetAttribute("Tier") or 0
				SkinService:Apply(stealInfo.VictimDisplacedSkin, victimPlot, tier)
			end
		end
	end
	if stealInfo.VictimPlotUID ~= "Sammy" then
		local victimPlotChannel = Synchronizer:Get(stealInfo.VictimPlotUID)
		if victimPlotChannel then
			local animalList = victimPlotChannel:Get("AnimalList")
			if animalList and typeof(animalList[stealInfo.PodiumIndex]) == "table" then
				victimPlotChannel:Set(string.format("AnimalList.%d.Steal", stealInfo.PodiumIndex), false)
				victimPlotChannel:Set(string.format("AnimalList.%d.Stolen", stealInfo.PodiumIndex), false)
				if podiumIndex then
					local stolenAnimalData = stealInfo.StolenAnimalData
					if not stolenAnimalData then
						warn("Steal completion failed: Could not find cached animal data for player:", player.Name)
						return
					end

					stolenAnimalData.Machine = nil
					if LuckyBlocks[stolenAnimalData.Index] then
						if LuckyBlocks[stolenAnimalData.Index] then
							if LuckyBlocks[stolenAnimalData.Index] then
								stolenAnimalData.Timer = 0
							else
								stolenAnimalData.Timer = nil
							end
						else
							stolenAnimalData.Timer = nil
						end
					end
					stolenAnimalData.Steal = false

					local stealerChannel = Synchronizer:Get(player)
					if not stealerChannel then
						return
					end

					stealerChannel:Set(string.format("AnimalPodiums.%d", stealInfo.PodiumIndex), nil)
					stealerChannel:Set(string.format("AnimalPodiums.%d", podiumIndex), stolenAnimalData)
					stealerChannel:Set("AnimalAddedOrRemoved", true)
				end
			end
		end
	end
end

function StealService:CompleteSteal(player: Player)
	local stealInfo = activeSteals[player]
	if not stealInfo or not player:GetAttribute("Stealing") then return end

	releaseStealLock(stealInfo.VictimPlotUID, stealInfo.PodiumIndex)
	if stealInfo.CarriedOverhead then
		stealInfo.CarriedOverhead:Destroy()
		stealInfo.CarriedOverhead = nil
	end

	if stealInfo.DiedConnection then stealInfo.DiedConnection:Disconnect() end
	if stealInfo.RemovingConnection then stealInfo.RemovingConnection:Disconnect() end
	if stealInfo.VictimRemovingConnection then stealInfo.VictimRemovingConnection:Disconnect() end

	if stealInfo.AnimationTrack then
		stealInfo.AnimationTrack:Stop()
	end
	if stealInfo.Model then
		stealInfo.Model:Destroy()
	end

	activeSteals[player] = nil
	player:SetAttribute("Stealing", nil)
	player:SetAttribute("StealingIndex", "")

	local stealerChannel = Synchronizer:Get(player)
	if not stealerChannel then
		return
	end

	local stolenAnimalData = stealInfo.StolenAnimalData
	if not stolenAnimalData then
		warn("Steal completion failed: Could not find cached animal data for player:", player.Name)
		return
	end

	stolenAnimalData.Machine = nil
	if LuckyBlocks[stolenAnimalData.Index] then
		stolenAnimalData.Timer = 0
	else
		stolenAnimalData.Timer = nil
	end
	stolenAnimalData.Steal = false
	stolenAnimalData.Stolen = true

	local stealerAnimalList = stealerChannel:Get("AnimalPodiums")


	local freePodiumIndex = stealInfo.TargetPodiumIndex
	local maxAnimals = getMaxAnimals(player)

	if freePodiumIndex then
		if freePodiumIndex > maxAnimals then
			freePodiumIndex = nil
		else
			local slotValue = stealerAnimalList and stealerAnimalList[freePodiumIndex]
			local isFree = (slotValue == "Empty" or slotValue == nil)
			if not isFree then
				freePodiumIndex = nil
			end
		end
	end

	if not freePodiumIndex then
		freePodiumIndex = findFreePodiumIndex(player, stealerAnimalList or {})
	end

	if not freePodiumIndex then
		warn("[StealService] CompleteSteal: No free podium found for", player.Name, "(MaxAnimals =", maxAnimals, ") - this should not happen if base-full check is working")
		freePodiumIndex = 1
	end

	local victimPlotChannel = Synchronizer:Get(stealInfo.VictimPlotUID)
	if victimPlotChannel then
		local victimPlayer = victimPlotChannel:Get("Owner")
		if typeof(victimPlayer) == "string" then
			victimPlayer = Players:FindFirstChild(victimPlayer)
		end
		if (not (typeof(victimPlayer) == "Instance" and victimPlayer:IsA("Player")))
			and stealInfo.VictimUserId then
			victimPlayer = Players:GetPlayerByUserId(stealInfo.VictimUserId)
		end

		if victimPlayer and typeof(victimPlayer) == "Instance" and victimPlayer:IsA("Player") then
			local victimPlayerChannel = Synchronizer:Get(victimPlayer)
			if victimPlayerChannel then
				victimPlayerChannel:Set(
					string.format("AnimalPodiums.%d", stealInfo.PodiumIndex),
					"Empty"
				)
				victimPlayerChannel:Set("AnimalAddedOrRemoved", true)
			end
		end

		victimPlotChannel:Set(string.format("AnimalList.%d", stealInfo.PodiumIndex), "Empty")

		if victimPlayer then
			local animalName = stolenAnimalData.Index
			local colouredText = FormatAnimalName(animalName)
			NotificationService.Notify(victimPlayer, string.format("%s Stole your %s", player.Name, colouredText), 10)
		end
	end

	stolenAnimalData.LastCollect = workspace:GetServerTimeNow()
	stolenAnimalData.Steal = false

	local animalName = stolenAnimalData.Index
	local colouredText = FormatAnimalName(animalName)

	NotificationService.Notify(player, string.format("You stole %s", colouredText), 5, "Sounds.Sfx.Success")

	stealerChannel:Increase("Steals", 1)
	stealerChannel:Set(string.format("AnimalPodiums.%d", freePodiumIndex), stolenAnimalData)
	stealerChannel:Set("AnimalAddedOrRemoved", true)

	if stolenAnimalData.Index == "Smurf Cat" then
		local unlockedSkins = stealerChannel:Get("UnlockedBaseSkins") or {}
		unlockedSkins.SmurfCat = true
		stealerChannel:Set("UnlockedBaseSkins", unlockedSkins)
	end

	if stealInfo.VictimDisplacedSkin and stealInfo.VictimUserId then
		local victimPlayer = Players:GetPlayerByUserId(stealInfo.VictimUserId)
		if victimPlayer then
			local victimPlot = _G.playerPlots[stealInfo.VictimUserId]
			if victimPlot then
				local tier = victimPlot:GetAttribute("Tier") or 0
				SkinService:Apply(stealInfo.VictimDisplacedSkin, victimPlot, tier)
			end
		end
	end
end

function StealService:CancelHold(player: Player, podiumIndex: number?)
	local stealInfo = activeSteals[player]
	if not stealInfo then return end

	releaseStealLock(stealInfo.VictimPlotUID, stealInfo.PodiumIndex)

	if stealInfo.CarriedOverhead then
		stealInfo.CarriedOverhead:Destroy()
		stealInfo.CarriedOverhead = nil
	end

	if stealInfo.DiedConnection then stealInfo.DiedConnection:Disconnect() end
	if stealInfo.RemovingConnection then stealInfo.RemovingConnection:Disconnect() end
	if stealInfo.VictimRemovingConnection then stealInfo.VictimRemovingConnection:Disconnect() end

	if stealInfo.AnimationTrack then
		stealInfo.AnimationTrack:Stop()
	end

	if stealInfo.Model then
		stealInfo.Model:Destroy()
	end

	activeSteals[player] = nil
	player:SetAttribute("Stealing", nil)
	player:SetAttribute("StealingIndex", "")

	local victimPlotChannel = Synchronizer:Get(stealInfo.VictimPlotUID)
	if victimPlotChannel then
		local animalList = victimPlotChannel:Get("AnimalList")
		if animalList and typeof(animalList[stealInfo.PodiumIndex]) == "table" then
			victimPlotChannel:Set(string.format("AnimalList.%d.Steal", stealInfo.PodiumIndex), false)
			victimPlotChannel:Set(string.format("AnimalList.%d.Stolen", stealInfo.PodiumIndex), false)

			if podiumIndex then
				local stolenAnimalData = stealInfo.StolenAnimalData
				if not stolenAnimalData then
					warn("Steal completion failed: Could not find cached animal data for player:", player.Name)
					return
				end

				stolenAnimalData.Machine = nil
				if LuckyBlocks[stolenAnimalData.Index] then
					stolenAnimalData.Timer = 0
				end
				stolenAnimalData.Steal = false
				stolenAnimalData.Stolen = true	

				local stealerChannel = Synchronizer:Get(player)
				if not stealerChannel then
					return
				end

				local stealerAnimalPodiums = stealerChannel:Get("AnimalPodiums")
				if not stealerAnimalPodiums then
					warn("Could not find AnimalPodiums for player:", player.Name)
					return
				end

				local occupyingAnimalData = stealerAnimalPodiums[podiumIndex]
				local originalPodiumIndex = stealInfo.PodiumIndex

				stealerChannel:Set(string.format("AnimalPodiums.%d", originalPodiumIndex), occupyingAnimalData)
				stealerChannel:Set(string.format("AnimalPodiums.%d", podiumIndex), stolenAnimalData)

				stealerChannel:Set("AnimalAddedOrRemoved", true)
			end
		end
	end
end

function StealService:IsStealing(player: Player): boolean
	return activeSteals[player] ~= nil
end

local function teardownPresent(player: Player, destroyModel: boolean)
	local entry = activePresents[player]
	if not entry then return nil end
	activePresents[player] = nil

	if entry.DiedConnection then entry.DiedConnection:Disconnect() end
	if entry.RemovingConnection then entry.RemovingConnection:Disconnect() end
	if entry.AnimationTrack then pcall(function() entry.AnimationTrack:Stop() end) end
	if entry.Model and destroyModel then entry.Model:Destroy() end

	if carrySpeedConnections[player] then
		carrySpeedConnections[player]:Disconnect()
		carrySpeedConnections[player] = nil
	end
	player:SetAttribute("Stealing", nil)
	player:SetAttribute("StealingIndex", "")

	if entry.OnCleanup then pcall(entry.OnCleanup) end
	return entry
end

function StealService:StealPresent(player: Player, presentTemplate: Instance, onCleanup: (() -> ())?): boolean
	if not player or activePresents[player] or activeSteals[player] then return false end
	if not presentTemplate then return false end

	local character = player.Character
	if not character then return false end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local hrp = character:FindFirstChild("HumanoidRootPart")
	local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
	if not humanoid or humanoid.Health <= 0 or not hrp or not animator then return false end

	local present = presentTemplate:Clone()
	local root = present.PrimaryPart or present:FindFirstChild("RootPart")
	if not (root and root:IsA("BasePart")) then
		present:Destroy()
		return false
	end
	present.PrimaryPart = root
	present.Name = "CarriedPresent"

	humanoid:UnequipTools()

	local animTrack = animator:LoadAnimation(CarryAnimation)
	animTrack.Looped = true
	animTrack.Priority = Enum.AnimationPriority.Action
	animTrack:Play()

	present.Parent = workspace
	for _, part in ipairs(present:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = false
			part.Massless = true
			part.CanCollide = false
			part.CanTouch = false
		end
	end

	local holdCFrame = hrp.CFrame * CFrame.new(0, 0.5, -2.2) * CFrame.Angles(math.rad(10), math.rad(180), 0)
	present:PivotTo(holdCFrame)

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = hrp
	weld.Part1 = root
	weld.Parent = root

	applyCarrySpeed(player, 0.75)
	player:SetAttribute("StealingIndex", "Present")
	player:SetAttribute("Stealing", true)

	local entry = {
		Model = present,
		AnimationTrack = animTrack,
		OnCleanup = onCleanup,
		DiedConnection = nil,
		RemovingConnection = nil,
	}
	activePresents[player] = entry

	entry.DiedConnection = humanoid.Died:Once(function()
		StealService:CancelPresent(player)
	end)
	entry.RemovingConnection = Players.PlayerRemoving:Once(function(removed)
		if removed == player then
			StealService:CancelPresent(player)
		end
	end)

	return true
end

function StealService:IsCarryingPresent(player: Player): boolean
	return activePresents[player] ~= nil
end

function StealService:DeliverPresent(player: Player): boolean
	if not activePresents[player] then return false end
	teardownPresent(player, true)
	return true
end

function StealService:CancelPresent(player: Player)
	teardownPresent(player, true)
end

function StealService:SimulateSteal(
	playerName: string, 
	animalName: string, 
	displayAnimalClone: Model?, 
	displayOverhead: Model?, 
	displayPrompt: ProximityPrompt?, 
	mutation: string?, 
	targetPodiumIndex: number?,
	victimPlotChannel: any?,
	victimPodiumIndex: number?
): boolean
	local player = Players:FindFirstChild(playerName)
	if not player then
		warn("SimulateSteal failed: Player not found:", playerName)
		return false
	end

	local character = player.Character
	if not character then
		warn("SimulateSteal failed: No character for", playerName)
		return false
	end

	if self:IsStealing(player) then
		return false
	end

	local stealerChannel = Synchronizer:Get(player)
	if not stealerChannel then
		warn("SimulateSteal failed: No Synchronizer channel for", playerName)
		return false
	end

	local humanoid = character:FindFirstChild("Humanoid") :: Humanoid
	if not humanoid or humanoid.Health < 1 then
		return false
	end

	local stealerAnimalPodiums = stealerChannel:Get("AnimalPodiums")
	if not stealerAnimalPodiums then
		warn("SimulateSteal failed: Could not get AnimalPodiums for", playerName)
		return false
	end

	local reservedPodiumIndex: number? = nil

	if targetPodiumIndex then
		local slotData = stealerAnimalPodiums[targetPodiumIndex]
		if slotData == "Empty" or slotData == nil then
			reservedPodiumIndex = targetPodiumIndex
		end
	end

	if not reservedPodiumIndex then
		local plot = _G.playerPlots[player.UserId]
		local podiumFolder = plot and plot:FindFirstChild("AnimalPodiums")

		if podiumFolder then
			local podiums = podiumFolder:GetChildren()
			table.sort(podiums, function(a, b)
				return tonumber(a.Name) < tonumber(b.Name)
			end)

			for _, podium in ipairs(podiums) do
				local idx = tonumber(podium.Name)
				if idx then
					local slotData = stealerAnimalPodiums[idx]
					if slotData == "Empty" or slotData == nil then
						reservedPodiumIndex = idx
						break
					end
				end
			end
		else
			for i = 1, 100 do
				local slotData = stealerAnimalPodiums[i]
				if slotData == "Empty" or slotData == nil then
					reservedPodiumIndex = i
					break
				end
			end
		end
	end

	if not reservedPodiumIndex then
		NotificationService.Error(player, "Your inventory is full!", 3)
		return false
	end

	stealerChannel:Set(string.format("AnimalPodiums.%d", reservedPodiumIndex), "Reserved")

	humanoid:UnequipTools()
	task.wait(0.1)
	applyCarrySpeed(player, 0.75)

	local playerRoot = character:FindFirstChild("HumanoidRootPart") :: Part
	local Animator = humanoid:FindFirstChild("Animator") :: Animator

	if not playerRoot or not Animator then
		warn("SimulateSteal failed: Missing HumanoidRootPart or Animator")
		stealerChannel:Set(string.format("AnimalPodiums.%d", reservedPodiumIndex), "Empty")
		return false
	end

	local loadedAnimation: AnimationTrack = Animator:LoadAnimation(CarryAnimation)
	loadedAnimation.Looped = true

	local carryDistance, carryHeight = getCarryOffsets(character)

	local carryPart = Instance.new("Part")
	carryPart.Name = "SimulateStealCarry_" .. animalName
	carryPart.Size = Vector3.new(0.1, 0.1, 0.1)
	carryPart.Transparency = 1
	carryPart.CanCollide = false
	carryPart.Anchored = false
	carryPart.Massless = true
	carryPart.CFrame = playerRoot.CFrame * CFrame.new(0, carryHeight, carryDistance)

	carryPart:SetAttribute("__render_brainrot", animalName)
	carryPart:SetAttribute("__render_animation", "Idle")
	if mutation and mutation ~= "" then
		carryPart:SetAttribute("__render_mutation", mutation)
	end
	carryPart:SetAttribute("__render_traits", "[]")
	carryPart:SetAttribute("__render_overhead", true)
	carryPart:SetAttribute("__render_stolen", true)

	CollectionService:AddTag(carryPart, "ClientRenderBrainrot")

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = playerRoot
	weld.Part1 = carryPart
	weld.Parent = carryPart

	carryPart.Parent = workspace

	loadedAnimation:Play()

	player:SetAttribute("StealingIndex", animalName)
	player:SetAttribute("Stealing", true)
	player:SetAttribute("SammyStealing", true)

	NotificationService.Notify(player, "", 10, ("Sounds.Animals.%s"):format(animalName))

	local LuckyBlocksData = require(ReplicatedStorage.Datas.LuckyBlocks)
	local isLuckyBlock = LuckyBlocksData[animalName] ~= nil

	local simulatedAnimalData = {
		Index      = animalName,
		LastCollect = workspace:GetServerTimeNow(),
		Mutation   = mutation,
		Steal      = false,
		Timer      = isLuckyBlock and 0 or nil,
		Stolen     = true,
	}

	local diedConnection: RBXScriptConnection?
	local removingConnection: RBXScriptConnection?
	local deliveryConnection: RBXScriptConnection?

	local function releaseReservation()
		local currentPodiums = stealerChannel:Get("AnimalPodiums") or {}
		if currentPodiums[reservedPodiumIndex] == "Reserved" then
			stealerChannel:Set(
				string.format("AnimalPodiums.%d", reservedPodiumIndex),
				"Empty"
			)
		end
	end

	local function cleanupDisplayModels()
		if displayAnimalClone then displayAnimalClone:Destroy() end
		if displayOverhead    then displayOverhead:Destroy()    end
		if displayPrompt      then displayPrompt:Destroy()      end
	end

	local function restoreDisplayModels()
		if displayAnimalClone then
			for _, part in ipairs(displayAnimalClone:GetDescendants()) do
				if part:IsA("BasePart") then
					local def = part:GetAttribute("DefaultTransparency")
					if def ~= nil and def < 1 then
						part.Transparency = def
					end
				end
			end
		end

		if displayOverhead then
			local function show(name, visible)
				local lbl = displayOverhead:FindFirstChild(name)
				if lbl then lbl.Visible = visible end
			end
			show("DisplayName", true)
			show("Generation",  true)
			show("Mutation",    mutation ~= nil)
			show("Price",       true)
			show("Rarity",      true)
			show("Stolen",      false)
		end

		if displayPrompt then
			displayPrompt.Enabled = true
		end
	end

	local function teardownCarry()
		if activeSteals[player] then
			local info = activeSteals[player]
			if info.CarriedOverhead   then info.CarriedOverhead:Destroy() end
			if info.DiedConnection    then info.DiedConnection:Disconnect() end
			if info.RemovingConnection then info.RemovingConnection:Disconnect() end
			if info.DeliveryConnection then info.DeliveryConnection:Disconnect() end
			if info.AnimationTrack    then info.AnimationTrack:Stop() end
			if info.Model             then info.Model:Destroy() end
			activeSteals[player] = nil
		end

		player:SetAttribute("Stealing",      nil)
		player:SetAttribute("StealingIndex", "")
		player:SetAttribute("SammyStealing", nil)
	end

	activeSteals[player] = {
		CarriedOverhead  = nil,
		VictimPlotUID    = "Sammy",
		PodiumIndex      = 0,
		StolenAnimalData = simulatedAnimalData,
		Model            = carryPart,
		AnimationTrack   = loadedAnimation,
		DiedConnection          = nil,
		RemovingConnection      = nil,
		VictimRemovingConnection = nil,
		DeliveryConnection      = nil,
		DisplayAnimalClone = displayAnimalClone,
		DisplayOverhead    = displayOverhead,
		DisplayPrompt      = displayPrompt,
		ReservedPodiumIndex = reservedPodiumIndex,
		TargetPodiumIndex   = reservedPodiumIndex,
	}

	diedConnection = humanoid.Died:Once(function()
		releaseReservation()
		restoreDisplayModels()
		teardownCarry()
	end)

	removingConnection = Players.PlayerRemoving:Once(function(removedPlayer)
		if removedPlayer == player then
			releaseReservation()
			cleanupDisplayModels()
			teardownCarry()
		end
	end)

	local plot = _G.playerPlots[player.UserId]
	if not plot then
		warn("SimulateSteal failed: Could not find player's plot for", playerName)
		releaseReservation()
		restoreDisplayModels()
		teardownCarry()
		return false
	end

	local deliveryHitboxes = {}
	for _, part in ipairs(plot:GetChildren()) do
		if part.Name == "DeliveryHitbox" then
			table.insert(deliveryHitboxes, part)
		end
	end

	if #deliveryHitboxes == 0 then
		warn("SimulateSteal failed: No DeliveryHitbox found for player:", playerName)
		releaseReservation()
		restoreDisplayModels()
		teardownCarry()
		return false
	end

	deliveryConnection = RunService.Heartbeat:Connect(function()
		if not player:GetAttribute("SammyStealing") then
			if deliveryConnection then
				deliveryConnection:Disconnect()
				deliveryConnection = nil
			end
			return
		end

		local char = player.Character
		if not char or not char:FindFirstChild("HumanoidRootPart") then return end

		local OverlapParams = OverlapParams.new()
		OverlapParams.FilterDescendantsInstances = deliveryHitboxes
		OverlapParams.FilterType = Enum.RaycastFilterType.Include
		OverlapParams.MaxParts = 1

		local PlayerPosition = char:GetPivot().Position
		local PartsInBox = workspace:GetPartBoundsInBox(
			CFrame.new(PlayerPosition), 
			Vector3.new(4, 4, 2), 
			OverlapParams
		)

		if #PartsInBox == 0 then return end

		if deliveryConnection then
			deliveryConnection:Disconnect()
			deliveryConnection = nil
		end

		if not activeSteals[player] then return end

		simulatedAnimalData.LastCollect = workspace:GetServerTimeNow()

		local colouredText = FormatAnimalName(animalName)

		stealerChannel:Set(
			string.format("AnimalPodiums.%d", reservedPodiumIndex),
			simulatedAnimalData
		)
		stealerChannel:Set("AnimalAddedOrRemoved", true)
		stealerChannel:Increase("Steals", 1)

		if victimPlotChannel and victimPodiumIndex then
			victimPlotChannel:Set(string.format("AnimalList.%d", victimPodiumIndex), "Empty")
		end

		NotificationService.Notify(
			player,
			string.format("You stole %s", colouredText),
			5,
			"Sounds.Sfx.Success"
		)

		cleanupDisplayModels()
		teardownCarry()
	end)

	if activeSteals[player] then
		activeSteals[player].DiedConnection      = diedConnection
		activeSteals[player].RemovingConnection  = removingConnection
		activeSteals[player].DeliveryConnection  = deliveryConnection
	end

	return true
end
function StealService:SimulateEggGrab(
	player: Player,
	eggName: string,
	poolId: string,
	brainrotId: string,
	savedBDT: number,
	speedBonus: number?
): boolean

	if activeEggGrabs[player.UserId] then
		return false
	end

	if activeSteals[player] then
		return false
	end

	local char = player.Character
	if not char then
		return false
	end

	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		return false
	end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not hrp or not animator then
		return false
	end

	local plot = _G.playerPlots[player.UserId]
	if not plot then
		return false
	end

	local hitboxes = {}

	for _, p in ipairs(plot:GetChildren()) do
		if p.Name == "DeliveryHitbox" then
			table.insert(hitboxes, p)
		end
	end

	if #hitboxes == 0 then
		return false
	end

	humanoid:UnequipTools()

	local animTrack = nil

	local ok, track = pcall(function()
		local t = animator:LoadAnimation(CarryAnimation)
		t.Looped = true
		t:Play()
		return t
	end)

	if ok then
		animTrack = track
	end

	local part = getWBPoolPart(poolId, brainrotId)
	local mutation = part and part:GetAttribute("BMut")
	local traitsJson = (part and part:GetAttribute("BTr")) or "[]"

	local carryPart = Instance.new("Part")
	carryPart.Name = "EggCarry_" .. eggName
	carryPart.Size = Vector3.new(0.1, 0.1, 0.1)
	carryPart.Transparency = 1
	carryPart.CanCollide = false
	carryPart.Anchored = false
	carryPart.Massless = true
	carryPart.CFrame = hrp.CFrame * CFrame.new(0, 1, -2)

	carryPart:SetAttribute("__render_brainrot", eggName)
	carryPart:SetAttribute("__render_animation", "Idle")
	if mutation and mutation ~= "" then
		carryPart:SetAttribute("__render_mutation", mutation)
	end
	carryPart:SetAttribute("__render_traits", traitsJson)

	CollectionService:AddTag(carryPart, "ClientRenderBrainrot")

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = hrp
	weld.Part1 = carryPart
	weld.Parent = carryPart

	carryPart.Parent = workspace

	local grabData = {
		poolId = poolId,
		brainrotId = brainrotId,
		savedBDT = savedBDT,
		animTrack = animTrack,
		model = carryPart,
		deliveryConn = nil,
		diedConn = nil,
		removingConn = nil,
		partRemovedConn = nil,
		originalWalkSpeed = nil,
	}

	if typeof(speedBonus) == "number" and speedBonus > 0 then
		grabData.originalWalkSpeed = humanoid.WalkSpeed
		humanoid.WalkSpeed = humanoid.WalkSpeed + speedBonus
	end

	activeEggGrabs[player.UserId] = grabData
	if AnimalsData[eggName] and not AnimalsData[eggName].Egg then
		NotificationService.Notify(player, "", 10, ("Sounds.Animals.%s"):format(eggName))
	end
	local function doDropEgg()
		local cd = activeEggGrabs[player.UserId]

		if not cd then
			return
		end

		if cd.animTrack then
			pcall(function()
				cd.animTrack:Stop()
			end)
		end

		if cd.deliveryConn then
			cd.deliveryConn:Disconnect()
		end

		if cd.diedConn then
			cd.diedConn:Disconnect()
		end

		if cd.removingConn then
			cd.removingConn:Disconnect()
		end

		if cd.partRemovedConn then
			cd.partRemovedConn:Disconnect()
		end

		if cd.model then
			cd.model:Destroy()
		end

		if cd.originalWalkSpeed ~= nil then
			local char = player.Character
			local humanoid = char and char:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = cd.originalWalkSpeed
			end
		end

		activeEggGrabs[player.UserId] = nil

		local part = getWBPoolPart(poolId, brainrotId)

		if not part then
			return
		end

		local c = player.Character
		local h = c and c:FindFirstChild("HumanoidRootPart")

		if h then
			local dropPos = (h.CFrame * CFrame.new(0, 0, -4)).Position
			local dropCF = getGroundCF(dropPos, c)

			part:SetAttribute("BCF", dropCF)
			part.CFrame = dropCF
		end

		part:SetAttribute("BDT", cd.savedBDT)
		part:SetAttribute("BG", 0)
	end

	local deliveryConn

	deliveryConn = RunService.Heartbeat:Connect(function()

		if not activeEggGrabs[player.UserId] then
			return
		end

		local c = player.Character

		if not c or not c:FindFirstChild("HumanoidRootPart") then
			return
		end

		local params = OverlapParams.new()
		params.FilterDescendantsInstances = hitboxes
		params.FilterType = Enum.RaycastFilterType.Include
		params.MaxParts = 1

		local found = workspace:GetPartBoundsInBox(
			CFrame.new(c:GetPivot().Position),
			Vector3.new(4,4,2),
			params
		)

		if #found > 0 then

			local cd = activeEggGrabs[player.UserId]

			if not cd then
				return
			end

			local part = getWBPoolPart(cd.poolId, cd.brainrotId)

			if not part then
				doDropEgg()
				return
			end

			local eggName = part:GetAttribute("BName")
			if not eggName or eggName == "" then
				warn("No BName attribute on world brainrot part")
				if cd.animTrack then
					pcall(function() cd.animTrack:Stop() end)
				end
				if cd.deliveryConn then cd.deliveryConn:Disconnect() end
				if cd.diedConn then cd.diedConn:Disconnect() end
				if cd.removingConn then cd.removingConn:Disconnect() end
				if cd.partRemovedConn then cd.partRemovedConn:Disconnect() end
				if cd.model then cd.model:Destroy() end
				activeEggGrabs[player.UserId] = nil
				part:Destroy()
				return
			end

			local stealerChannel = Synchronizer:Get(player)
			if not stealerChannel then
				warn("No player channel for", player.Name)
				doDropEgg()
				return
			end

			local stealerAnimalPodiums = stealerChannel:Get("AnimalPodiums") or {}
			local freePodiumIndex = findFreePodiumIndex(player, stealerAnimalPodiums)

			if not freePodiumIndex then
				NotificationService.Error(player, "Your inventory is full!", 3)
				doDropEgg()
				return
			end

			if cd.animTrack then
				pcall(function() cd.animTrack:Stop() end)
			end
			if cd.deliveryConn then cd.deliveryConn:Disconnect() end
			if cd.diedConn then cd.diedConn:Disconnect() end
			if cd.removingConn then cd.removingConn:Disconnect() end
			if cd.partRemovedConn then cd.partRemovedConn:Disconnect() end
			if cd.model then cd.model:Destroy() end

			activeEggGrabs[player.UserId] = nil

			local mutation = part:GetAttribute("BMut")
			local traitsJson = part:GetAttribute("BTr")
			local timer = part:GetAttribute("BTim")

			local parsedTraits = nil
			if traitsJson and traitsJson ~= "" then
				local ok, result = pcall(function()
					return game:GetService("HttpService"):JSONDecode(traitsJson)
				end)
				if ok and result then
					parsedTraits = result
				end
			end

			local LuckyBlocksData = require(ReplicatedStorage.Datas.LuckyBlocks)
			local isLuckyBlock = LuckyBlocksData[eggName] ~= nil

			local animalData = {
				Index = eggName,
				LastCollect = workspace:GetServerTimeNow(),
				Mutation = (mutation and mutation ~= "") and mutation or nil,
				Traits = parsedTraits,
				Steal = false,
				Timer = isLuckyBlock and math.max(0, timer or 0) or nil,
				Stolen = false,
			}

			part:SetAttribute("BDelivered", player.UserId)

			stealerChannel:Set(string.format("AnimalPodiums.%d", freePodiumIndex), animalData)
			stealerChannel:Set("AnimalAddedOrRemoved", true)

			local ok, colouredText = pcall(FormatAnimalName, eggName)
			if not ok or not colouredText then
				colouredText = eggName
			end
			NotificationService.Notify(
				player,
				string.format("You stole %s", colouredText),
				5,
				"Sounds.Sfx.Success"
			)

			part:Destroy()
		end
	end)

	grabData.deliveryConn = deliveryConn

	local trackedPart = getWBPoolPart(poolId, brainrotId)
	if trackedPart then
		grabData.partRemovedConn = trackedPart.AncestryChanged:Connect(function(_, parent)
			if parent == nil then
				doDropEgg()
			end
		end)
	end

	grabData.diedConn = humanoid.Died:Once(doDropEgg)

	grabData.removingConn =
		Players.PlayerRemoving:Once(function(p)
			if p == player then
				doDropEgg()
			end
		end)

	return true
end

function StealService:CancelEggGrab(player: Player)
	local cd = activeEggGrabs[player.UserId]

	if not cd then
		return
	end

	if cd.animTrack then
		pcall(function()
			cd.animTrack:Stop()
		end)
	end

	if cd.deliveryConn then
		cd.deliveryConn:Disconnect()
	end

	if cd.diedConn then
		cd.diedConn:Disconnect()
	end

	if cd.removingConn then
		cd.removingConn:Disconnect()
	end

	if cd.partRemovedConn then
		cd.partRemovedConn:Disconnect()
	end

	if cd.model then
		cd.model:Destroy()
	end

	if cd.originalWalkSpeed ~= nil then
		local char = player.Character
		local humanoid = char and char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = cd.originalWalkSpeed
		end
	end

	activeEggGrabs[player.UserId] = nil

	local part = getWBPoolPart(cd.poolId, cd.brainrotId)

	if not part then
		return
	end

	local c = player.Character
	local h = c and c:FindFirstChild("HumanoidRootPart")

	if h then
		local dropPos = (h.CFrame * CFrame.new(0, 0, -4)).Position
		local dropCF = getGroundCF(dropPos, c)

		part:SetAttribute("BCF", dropCF)
		part.CFrame = dropCF
	end

	part:SetAttribute("BDT", cd.savedBDT)
	part:SetAttribute("BG", 0)
end

function StealService:CancelWorldBrainrotGrab(player: Player)
	return StealService:CancelEggGrab(player)
end

function StealService:IsGrabbingEgg(player: Player): boolean
	return activeEggGrabs[player.UserId] ~= nil
end

function StealService:IsGrabbingWorldBrainrot(player: Player): boolean
	return activeEggGrabs[player.UserId] ~= nil
end
function StealService:ConsumeEgg(player: Player)
	local cd = activeEggGrabs[player.UserId]

	if not cd then
		return
	end

	if cd.animTrack then
		pcall(function()
			cd.animTrack:Stop()
		end)
	end

	if cd.deliveryConn then
		cd.deliveryConn:Disconnect()
	end

	if cd.diedConn then
		cd.diedConn:Disconnect()
	end

	if cd.removingConn then
		cd.removingConn:Disconnect()
	end

	if cd.partRemovedConn then
		cd.partRemovedConn:Disconnect()
	end

	if cd.model then
		cd.model:Destroy()
	end

	if cd.originalWalkSpeed ~= nil then
		local char = player.Character
		local humanoid = char and char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = cd.originalWalkSpeed
		end
	end

	activeEggGrabs[player.UserId] = nil

	local part = getWBPoolPart(cd.poolId, cd.brainrotId)

	if part then
		part:Destroy()
	end
end
function StealService:GetEggGrabData(player: Player)
	return activeEggGrabs[player.UserId]
end

local Workspace = game:GetService("Workspace")

local allInsidePlayersTables = {}

local function SetupBaseProtection(plot)
	if not plot or not plot:IsA("Model") then return end

	local hitbox = plot:FindFirstChild("StealHitbox")
	if not hitbox or not hitbox:IsA("BasePart") then return end

	local insidePlayers = {}
	table.insert(allInsidePlayersTables, insidePlayers)

	hitbox.Touched:Connect(function(hit)
		local character = hit.Parent
		local player = Players:GetPlayerFromCharacter(character)
		if not player then return end

		insidePlayers[player] = true
	end)

	task.spawn(function()
		while plot.Parent do
			for player in pairs(insidePlayers) do
				local character = player.Character
				if not character then
					insidePlayers[player] = nil
					continue
				end
				local root = character:FindFirstChild("HumanoidRootPart")
				if root then
					local dist = (root.Position - hitbox.Position).Magnitude
					if dist > (hitbox.Size.X + hitbox.Size.Z) / 2 then
						insidePlayers[player] = nil
					end
				end
			end
			task.wait(2)
		end
	end)

	plot:GetAttributeChangedSignal("Locked"):Connect(function()
		if plot:GetAttribute("Locked") == true then
		end
	end)
end

local RagdollModule = require(ReplicatedStorage.Packages.Ragdoll)

function StealService:Start()
	task.spawn(function()
		Players.PlayerRemoving:Connect(function(player)
			if carrySpeedConnections[player] then
				carrySpeedConnections[player]:Disconnect()
				carrySpeedConnections[player] = nil
			end
		end)

		Players.PlayerAdded:Connect(function(player)
			playerJoinTimes[player.UserId] = os.clock()
		end)

		Players.PlayerRemoving:Connect(function(player)
			playerJoinTimes[player.UserId] = nil
		end)

		Grab.OnServerEvent:Connect(function(player: Player, action: string, podiumIndex: number)
			local playerPlot = _G.playerPlots[player.UserId]
			if not playerPlot then
				return
			end
			local PlayerChannel = Synchronizer:Get(player)
			if CheckAndClearFakeAnimal(PlayerChannel, playerPlot, podiumIndex) then return end
			if action == "Place" then
				local stealInfo = activeSteals[player]
				if stealInfo then
					local victimPlotChannel = Synchronizer:Get(stealInfo.VictimPlotUID)
					if victimPlotChannel then
						local animalList = victimPlotChannel:Get("AnimalList")
						local targetAnimal = animalList and animalList[podiumIndex]

						if targetAnimal and targetAnimal.Steal and targetAnimal.Steal ~= player.UserId then
							return
						end
					end
				end
			end

			local owner = playerPlot:GetAttribute("Owner")
			if owner == "SpyderSammy" and action == "Grab" then
				return
			end

			if action == "Grab" then		
				StealService:StartSteal(player, playerPlot.Name, podiumIndex)
			elseif action == "Place" then
				StealService:CancelHold(player, podiumIndex)
			end
		end)

		Players.PlayerRemoving:Connect(function(player)
			for _, insidePlayers in ipairs(allInsidePlayersTables) do
				insidePlayers[player] = nil
			end
		end)

		for _, plot in pairs(Workspace:GetChildren()) do
			if plot.Name:match("Plot") then
				SetupBaseProtection(plot)
			end
		end

		Workspace.ChildAdded:Connect(function(child)
			if child.Name:match("Plot") then
				SetupBaseProtection(child)
			end
		end)

		RagdollModule.OnRagdoll(function(character, isRagdolled)
			if not isRagdolled then return end

			local player = Players:GetPlayerFromCharacter(character)
			if not player then return end

			if activeEggGrabs[player.UserId] then
				StealService:CancelEggGrab(player)
			end

			if activeSteals[player] then
				StealService:CancelSteal(player)
			end

			if activePresents[player] then
				StealService:CancelPresent(player)
			end
		end)
	end)
end

return StealService