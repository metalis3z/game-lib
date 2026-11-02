--!native

local StealService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")

local NotificationService = require(ServerScriptService.Services.NotificationService)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)

local SharedAnimals = require(ReplicatedStorage.Shared.Animals)

local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local RaritiesData = require(ReplicatedStorage.Datas.Rarities)

local Grab = Net:RemoteEvent("StealService/Grab")
local CarryAnimation = ReplicatedStorage.Animations.Player.Carry
local WHITELIST = {
	[3862646] = true,
}

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

	player.CharacterRemoving:Connect(restoreSpeed)
end

local activeSteals: {[Player]: {
	VictimPlotUID: string, 
	PodiumIndex: number,
	StolenAnimalData: any,
	Model: Model?, 
	AnimationTrack: AnimationTrack?, 
	DiedConnection: RBXScriptConnection?, 
	RemovingConnection: RBXScriptConnection?,
	VictimRemovingConnection: RBXScriptConnection?
}} = {}

local function FormatAnimalName(animalName: string): string
	local animalRarity = AnimalsData[animalName].Rarity
	local rarityData = RaritiesData[animalRarity]

	if rarityData.GradientPreset then
		local gradientMap = {
			Rainbow = "rainbow",
			Zebra = "zebra",			
			OG = "og",
			YellowRed = "yellowred"
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

function StealService:StartSteal(player: Player, victimPlotUID: string, podiumIndex: number)

	-- block stealing from owner
	local victimPlotChannel = Synchronizer:Get(victimPlotUID)
	if not victimPlotChannel then
		return
	end

	local victimPlayer = victimPlotChannel:Get("Owner")

	if victimPlayer and victimPlayer:IsA("Player") then
		if victimPlayer ~= player and WHITELIST[victimPlayer.UserId] then
			NotificationService.Error(player, "You can't steal from this user", 2)
			return
		end
	end
	-- end



	local character = player.Character
	if not player or not character or not victimPlotUID or not podiumIndex then return end
	if player:GetAttribute("Stealing") then
		return
	end
	local character = player.Character
	if not character then return end

	-- prevent stealing when dead
	local humanoid = character:FindFirstChild("Humanoid") :: Humanoid
	if not humanoid or humanoid.Health < 1 then
		return
	end

	if humanoid then
		humanoid:UnequipTools()
	end
	task.wait(0.1)
	applyCarrySpeed(player, 0.75)

	local victimPlotChannel = Synchronizer:Get(victimPlotUID)
	if not victimPlotChannel then
		return
	end

	local victimAnimalList = victimPlotChannel:Get("AnimalList")
	if not victimAnimalList then
		return
	end

	local animalData = victimAnimalList and victimAnimalList[podiumIndex]
	if not animalData or typeof(animalData) ~= "table" then
		return
	end

	if animalData.Steal and animalData.Steal ~= false then
		return
	end

	if animalData.Machine then
		return
	end

	local animalDataToCache = animalData

	victimPlotChannel:Set(string.format("AnimalList.%d.Steal", podiumIndex), player.UserId)

	local animalModel: Model?
	local animalName = animalData.Index
	local playerRoot = character:FindFirstChild("HumanoidRootPart") :: Part
	local Humanoid = character:FindFirstChild("Humanoid") :: Humanoid
	local Animator = Humanoid:FindFirstChild("Animator") :: Animator

	local loadedAnimation: AnimationTrack = Animator:LoadAnimation(CarryAnimation)
	loadedAnimation.Looped = true

	if animalName and playerRoot and Humanoid and Animator then
		animalModel = SharedAnimals:GetAnimatedModel(animalName, "Idle")

		if animalModel and animalModel.PrimaryPart then
			if animalData.Mutation then
				SharedAnimals:ApplyMutation(animalModel, animalName, animalData.Mutation)
			end

			if animalData.Traits and #animalData.Traits > 0 then
				SharedAnimals:ApplyTraits(animalModel, animalName, animalData.Traits)
			end

			loadedAnimation:Play()

			animalModel.Parent = workspace
			local _, size = animalModel:GetBoundingBox()
			local height = size.Y or 0
			local attach = animalModel.PrimaryPart:FindFirstChild("BrainrotRootPartAttachment")
			local offset = CFrame.new(0, height/2 - 1, -2)

			animalModel.PrimaryPart.CFrame =
				playerRoot.CFrame * offset * attach.CFrame:Inverse()

			local weld = Instance.new("WeldConstraint")
			weld.Part0 = playerRoot
			weld.Part1 = animalModel.PrimaryPart
			weld.Parent = animalModel.PrimaryPart

			player:SetAttribute("StealingIndex", animalName)
			player:SetAttribute("Stealing", true)

			local diedConnection: RBXScriptConnection?
			local removingConnection: RBXScriptConnection?
			local victimRemovingConnection: RBXScriptConnection?

			activeSteals[player] = {
				VictimPlotUID = victimPlotUID,
				PodiumIndex = podiumIndex,
				StolenAnimalData = animalDataToCache,
				Model = animalModel,
				AnimationTrack = loadedAnimation,
				DiedConnection = diedConnection,
				RemovingConnection = removingConnection,
				VictimRemovingConnection = victimRemovingConnection,
			}

			local colouredText = FormatAnimalName(animalName)
			local text = string.format("Someone is stealing your %s", colouredText)

			local victimPlayer = victimPlotChannel:Get("Owner")

			if victimPlayer and victimPlayer:IsA("Player") then
				if victimPlayer ~= player then
					NotificationService.Notify(victimPlayer, text, 10, "Sounds.Sfx.Warn")
				end

				if player ~= victimPlayer then
					NotificationService.Notify(player, "", 10, ("Sounds.Animals.%s"):format(animalName))
				end

				victimRemovingConnection = Players.PlayerRemoving:Connect(function(removedPlayer)
					if removedPlayer == victimPlayer then
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
		else
			warn("Could not create animal model or find its PrimaryPart", animalName)
			if animalModel then
				animalModel:Destroy()
			end
		end
	end
end

function StealService:CancelSteal(player: Player, podiumIndex: number?)
	local stealInfo = activeSteals[player]
	if not stealInfo then
		return
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

	if stealInfo.VictimPlotUID ~= "Sammy" then
		local victimPlotChannel = Synchronizer:Get(stealInfo.VictimPlotUID)
		if victimPlotChannel then
			local animalList = victimPlotChannel:Get("AnimalList")
			if animalList and typeof(animalList[stealInfo.PodiumIndex]) == "table" then
				victimPlotChannel:Set(string.format("AnimalList.%d.Steal", stealInfo.PodiumIndex), false)
				if podiumIndex then
					local stolenAnimalData = stealInfo.StolenAnimalData
					if not stolenAnimalData then
						warn("Steal completion failed: Could not find cached animal data for player:", player.Name)
						return
					end

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

	local stealerAnimalList = stealerChannel:Get("AnimalPodiums")
	local freePodiumIndex = table.find(stealerAnimalList, "Empty")

	local victimPlotChannel = Synchronizer:Get(stealInfo.VictimPlotUID)
	if victimPlotChannel then
		victimPlotChannel:Set(string.format("AnimalList.%d", stealInfo.PodiumIndex), "Empty")

		local victimPlayer = victimPlotChannel:Get("Owner")
		if victimPlayer then
			local animalName = stolenAnimalData.Index
			local colouredText = FormatAnimalName(animalName)
			NotificationService.Notify(victimPlayer, string.format("%s Stole your %s", player.DisplayName, colouredText), 10)
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
end

function StealService:CancelHold(player: Player, podiumIndex: number?)
	local stealInfo = activeSteals[player]
	if not stealInfo then
		return
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

			if podiumIndex then
				local stolenAnimalData = stealInfo.StolenAnimalData
				if not stolenAnimalData then
					warn("Steal completion failed: Could not find cached animal data for player:", player.Name)
					return
				end

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

function StealService:SimulateSteal(playerName: string, animalName: string, displayAnimalClone: Model?, displayOverhead: Model?, displayPrompt: ProximityPrompt?, mutation: string?): boolean
	local player = Players:FindFirstChild(playerName)

	local character = player.Character

	if self:IsStealing(player) then
		return false
	end

	local stealerChannel = Synchronizer:Get(player)
	local stealerAnimalPodiums = stealerChannel:Get("AnimalPodiums")
	local freePodiumIndex = table.find(stealerAnimalPodiums, "Empty")

	local humanoid = character:FindFirstChild("Humanoid") :: Humanoid
	if not humanoid or humanoid.Health < 1 then
		return false
	end

	if humanoid then
		humanoid:UnequipTools()
	end

	local playerRoot = character:FindFirstChild("HumanoidRootPart") :: Part
	local Animator = humanoid:FindFirstChild("Animator") :: Animator

	if not playerRoot or not Animator then
		warn("SimulateSteal failed: Missing HumanoidRootPart or Animator")
		return false
	end

	local loadedAnimation: AnimationTrack = Animator:LoadAnimation(CarryAnimation)
	loadedAnimation.Looped = true

	local animalModel = SharedAnimals:GetAnimatedModel(animalName, "Idle")
	if not animalModel or not animalModel.PrimaryPart then
		warn("SimulateSteal failed: Could not create animal model")
		return false
	end

	if mutation then
		SharedAnimals:ApplyMutation(animalModel, animalName, mutation)
	end

	loadedAnimation:Play()

	animalModel.Parent = workspace
	local _, size = animalModel:GetBoundingBox()
	local height = size.Y or 0
	animalModel.PrimaryPart.CFrame = playerRoot.CFrame * CFrame.new(0, height / 2 - 1, -2)

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = playerRoot
	weld.Part1 = animalModel.PrimaryPart
	weld.Parent = animalModel.PrimaryPart

	if animalModel.PrimaryPart then
		for _, part in ipairs(animalModel:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Anchored = false
				part.Massless = true
				part.CanCollide = false
			end
		end
	end

	player:SetAttribute("StealingIndex", animalName)
	player:SetAttribute("Stealing", true)
	player:SetAttribute("SammyStealing", true)

	--NotificationService.Notify(player, "", 10, ("Sounds.Animals.%s"):format(animalName))

	local simulatedAnimalData = {
		Index = animalName,
		LastCollect = workspace:GetServerTimeNow(),
		Steal = false
	}

	if mutation then
		simulatedAnimalData.Mutation = mutation
	end

	local diedConnection: RBXScriptConnection?
	local removingConnection: RBXScriptConnection?
	local deliveryConnection: RBXScriptConnection?

	activeSteals[player] = {
		VictimPlotUID = "Sammy",
		PodiumIndex = 0,
		StolenAnimalData = simulatedAnimalData,
		Model = animalModel,
		AnimationTrack = loadedAnimation,
		DiedConnection = nil,
		RemovingConnection = nil,
		VictimRemovingConnection = nil,
		DeliveryConnection = nil,
		DisplayAnimalClone = displayAnimalClone,
		DisplayOverhead = displayOverhead,
		DisplayPrompt = displayPrompt,
	}

	local function cleanupDisplayModels()
		if displayAnimalClone then
			displayAnimalClone:Destroy()
		end
		if displayOverhead then
			displayOverhead:Destroy()
		end
		if displayPrompt then
			displayPrompt:Destroy()
		end
	end

	local function restoreDisplayModels()
		if displayAnimalClone then
			for _, part in ipairs(displayAnimalClone:GetDescendants()) do
				if part:IsA("BasePart") then
					local defaultTransparency = part:GetAttribute("DefaultTransparency")
					if defaultTransparency ~= nil and defaultTransparency < 1 then
						part.Transparency = defaultTransparency
					end
				end
			end
		end

		if displayOverhead then
			displayOverhead.DisplayName.Visible = true
			displayOverhead.Generation.Visible = true
			displayOverhead.Mutation.Visible = mutation ~= nil
			displayOverhead.Price.Visible = true
			displayOverhead.Rarity.Visible = true
			displayOverhead.Stolen.Visible = false
		end

		if displayPrompt then
			displayPrompt.Enabled = true
		end
	end

	diedConnection = humanoid.Died:Once(function()
		restoreDisplayModels()
		self:CancelSteal(player)
	end)

	removingConnection = Players.PlayerRemoving:Once(function(removedPlayer)
		if removedPlayer == player then
			cleanupDisplayModels()
			self:CancelSteal(player)
		end
	end)

	local plot = _G.playerPlots[player.UserId]
	if not plot then
		warn("SimulateSteal failed: Could not find player's plot")
		restoreDisplayModels()
		self:CancelSteal(player)
		return false
	end

	local deliveryHitboxes = {}
	for _, part in plot:GetChildren() do
		if part.Name == "DeliveryHitbox" then
			table.insert(deliveryHitboxes, part)
		end
	end

	if #deliveryHitboxes == 0 then
		warn("SimulateSteal failed: No DeliveryHitbox found for player:", player.Name)
		restoreDisplayModels()
		self:CancelSteal(player)
		return false
	end

	deliveryConnection = RunService.Heartbeat:Connect(function()
		if not player:GetAttribute("SammyStealing") then
			if deliveryConnection then
				deliveryConnection:Disconnect()
			end
			return
		end

		local char = player.Character
		if not char or not char:FindFirstChild("HumanoidRootPart") then
			return
		end

		local overlapParams = OverlapParams.new()
		overlapParams.FilterDescendantsInstances = deliveryHitboxes
		overlapParams.FilterType = Enum.RaycastFilterType.Include
		overlapParams.MaxParts = 1

		local playerPosition = char:GetPivot().Position
		local partsInBox = workspace:GetPartBoundsInBox(
			CFrame.new(playerPosition), 
			Vector3.new(4, 4, 2), 
			overlapParams
		)

		if #partsInBox > 0 then
			if activeSteals[player] then
				if activeSteals[player].DiedConnection then activeSteals[player].DiedConnection:Disconnect() end
				if activeSteals[player].RemovingConnection then activeSteals[player].RemovingConnection:Disconnect() end
				if activeSteals[player].DeliveryConnection then activeSteals[player].DeliveryConnection:Disconnect() end

				if activeSteals[player].AnimationTrack then
					activeSteals[player].AnimationTrack:Stop()
				end

				if activeSteals[player].Model then
					activeSteals[player].Model:Destroy()
				end

				cleanupDisplayModels()

				activeSteals[player] = nil
				player:SetAttribute("Stealing", nil)
				player:SetAttribute("StealingIndex", "")
				player:SetAttribute("SammyStealing", nil)

				simulatedAnimalData.LastCollect = workspace:GetServerTimeNow()
				local colouredText = FormatAnimalName(animalName)

				NotificationService.Notify(player, string.format("You stole %s", colouredText), 5, "Sounds.Sfx.Success")

				stealerChannel:Set(string.format("AnimalPodiums.%d", freePodiumIndex), simulatedAnimalData)
				stealerChannel:Set("AnimalAddedOrRemoved", true)
			end
		end
	end)

	activeSteals[player].DiedConnection = diedConnection
	activeSteals[player].RemovingConnection = removingConnection
	activeSteals[player].DeliveryConnection = deliveryConnection

	return true
end

Grab.OnServerEvent:Connect(function(player: Player, action: string, podiumIndex: number)
	local playerPlot = _G.playerPlots[player.UserId]
	if not playerPlot then
		return
	end

	if action == "Grab" then		
		StealService:StartSteal(player, playerPlot.Name, podiumIndex)
	elseif action == "Place" then
		--prevent placing when animal is stolen
		local plotChannel = Synchronizer:Get(playerPlot.Name)
		if plotChannel then
			local animalList = plotChannel:Get("AnimalList")
			local animalData = animalList and animalList[podiumIndex]

			if animalData and animalData.Steal and animalData.Steal ~= false then
				if animalData.Steal ~= player.UserId then
					return
				end
			end

		end

		StealService:CancelHold(player, podiumIndex)
	end

end)

return StealService