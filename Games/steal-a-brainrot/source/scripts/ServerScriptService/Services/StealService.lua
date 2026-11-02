local StealService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")

local NotificationService = require(ServerScriptService.Services.NotificationService)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)

local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
local LuckyBlocks = require(ReplicatedStorage.Datas.LuckyBlocks)
local IndexData = require(ReplicatedStorage.Datas.Index)

local playerJoinTimes = {}
local STEAL_PROTECTION_TIME = 30

-- Cooldown untuk brainrot yang baru saja gagal di-steal (karena pencuri mati)
local failedStealCooldowns = {} -- [plotUID_podiumIndex] = os.clock()
local FAILED_STEAL_COOLDOWN = 10 -- 10 detik cooldown setelah mati

-- Track players who are dead/respawning
local deadPlayers = {} -- [Player] = true

-- Check if player is dead or respawning
local function isPlayerDead(player)
	return deadPlayers[player] == true
end

-- Handle player death
local function onPlayerDied(player)
	deadPlayers[player] = true
end

-- Handle player respawn - clear dead state
local function onCharacterAdded(player, character)
	deadPlayers[player] = nil
end

-- Setup death tracking for a player
local function setupDeathTracking(player)
	-- Handle current character
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.Died:Connect(function()
				onPlayerDied(player)
			end)
		end
	end

	-- Handle future characters
	player.CharacterAdded:Connect(function(newCharacter)
		onCharacterAdded(player, newCharacter)
		local humanoid = newCharacter:WaitForChild("Humanoid", 5)
		if humanoid then
			humanoid.Died:Connect(function()
				onPlayerDied(player)
			end)
		end
	end)
end

-- Setup for existing players
for _, player in ipairs(Players:GetPlayers()) do
	setupDeathTracking(player)
end

-- Setup for new players
Players.PlayerAdded:Connect(function(player)
	setupDeathTracking(player)
end)

local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local RaritiesData = require(ReplicatedStorage.Datas.Rarities)

local CarryAnimation = ReplicatedStorage.Animations.Player.Carry

local Grab = Net:RemoteEvent("StealService/Grab")
local StealRemote = Net:RemoteEvent("5aa39ea1-0c65-4fcf-aff9-b18a7ef277c3")

local activeSteals: {[Player]: {
	VictimPlotUID: string, 
	PodiumIndex: number,
	StolenAnimalData: any,
	Model: Model?, 
	AnimationTrack: AnimationTrack?, 
	CarriedOverhead: BillboardGui?,
	DiedConnection: RBXScriptConnection?, 
	RemovingConnection: RBXScriptConnection?,
	VictimRemovingConnection: RBXScriptConnection?
}} = {}

-- Reverse lookup: tracks which podium each player is actively stealing from
-- Used to detect stale Steal flags that would permanently lock brainrots
local activeStealTargets: {[number]: {VictimPlotUID: string, PodiumIndex: number}} = {}

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

Players.PlayerAdded:Connect(function(player)
	playerJoinTimes[player.UserId] = os.clock()
end)

Players.PlayerRemoving:Connect(function(player)
	playerJoinTimes[player.UserId] = nil
end)

function StealService:GetStealData(player: Player)
	return activeSteals[player]
end

function StealService:StartSteal(player: Player, victimPlotUID: string, podiumIndex: number)
	local character = player.Character
	if not player or not character or not victimPlotUID or not podiumIndex then return end
	if player:GetAttribute("Stealing") then
		return
	end

	-- Prevent dead/respawning players from stealing
	if isPlayerDead(player) then
		return
	end

	local character = player.Character
	if not character then return end

	-- Also check if humanoid is alive
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		return
	end

	-- Cek apakah brainrot ini masih dalam cooldown karena gagal steal sebelumnya
	local cooldownKey = victimPlotUID .. "_" .. tostring(podiumIndex)
	local cooldownEnd = failedStealCooldowns[cooldownKey]
	if cooldownEnd and os.clock() < cooldownEnd then
		local remaining = math.ceil(cooldownEnd - os.clock())
		if not player:GetAttribute("AntiStealSpam") then
			player:SetAttribute("AntiStealSpam", true)
			NotificationService.Notify(
				player,
				string.format("<font color=\"#FF0000\">Brainrot ini masih protected! Tunggu %d detik</font>", remaining),
				3,
				"Sounds.Sfx.Error"
			)
			task.delay(0.8, function()
				if player then
					player:SetAttribute("AntiStealSpam", nil)
				end
			end)
		end
		return
	end

	local humanoid = character:FindFirstChild("Humanoid") :: Humanoid
	if humanoid then
		humanoid:UnequipTools()
	end

	local victimPlotChannel = Synchronizer:Get(victimPlotUID)
	if not victimPlotChannel then
		return
	end

	local victimOwner = victimPlotChannel:Get("Owner")

	if typeof(victimOwner) == "string" then
		victimOwner = Players:GetPlayerFromName(victimOwner)
	end

	if victimOwner and player ~= victimOwner then
		local joinTime = playerJoinTimes[victimOwner.UserId]
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
				return
			end
		end
	end

	if victimOwner and victimOwner.Name == "Idk" and player ~= victimOwner then
		if player:GetAttribute("AntiStealSpam") then return end
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
		-- Check if the steal is stale (the player who was stealing is no longer active)
		local stealingUserId = animalData.Steal
		local stealTarget = activeStealTargets[stealingUserId]
		if stealTarget and stealTarget.VictimPlotUID == victimPlotUID and stealTarget.PodiumIndex == podiumIndex then
			-- The player is still actively stealing this brainrot, block the grab
			return
		end

		-- Stale Steal flag detected — the previous steal is no longer active, clean it up
		warn(string.format("[StealService] Clearing stale Steal flag on podium %d (was UserId %d)", podiumIndex, stealingUserId))
		victimPlotChannel:Set(string.format("AnimalList.%d.Steal", podiumIndex), false)
		victimPlotChannel:Set(string.format("AnimalList.%d.Stolen", podiumIndex), false)
		animalData.Steal = false
	end

	-- ✅ FIX: Prevent grabbing brainrots that are in a trade
	if animalData.InTrade then
		NotificationService.Notify(player, "<font color=\"#FF0000\">Ce brainrot est dans un trade!</font>", 3, "Sounds.Sfx.Error")
		return
	end

	-- Prevent stealing brainrots that are in the crafting machine
	if animalData.Machine and animalData.Machine.Type == "Crafting" then
		return
	end

	local animalDataToCache = animalData

	victimPlotChannel:Set(string.format("AnimalList.%d.Steal", podiumIndex), player.UserId)
	victimPlotChannel:Set(string.format("AnimalList.%d.Stolen", podiumIndex), true)

	if victimOwner == player then
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
			local isStolen = victimOwner ~= player
			local carriedOverhead = AddCarriedOverhead(animalModel, isStolen)
			local _, size = animalModel:GetBoundingBox()
			local height = size.Y or 0

			local yOffset = height / 2 - 1

			if animalName == "Mythic Lucky Block" then
				yOffset -= height * -0.5
			end

			if animalName == "Brainrot God Lucky Block" then
				yOffset -= height * -0.5
			end

			if animalName == "Secret Lucky Block" then
				yOffset -= height * -0.5
			end

			if animalName == "Admin Lucky Block" then
				yOffset -= height * -0.5
			end

			if animalName == "Taco Lucky Block" then
				yOffset -= height * -0.5
			end

			if animalName == "Extreme OG Lucky Block" then
				yOffset -= height * -0.5
			end

			if animalName == "Spooky Lucky Block" then
				yOffset -= height * -0.5
			end

			if animalName == "Los Taco Blocks" then
				yOffset -= height * -0.5
			end

			if animalName == "Festive Lucky Block" then
				yOffset -= height * -0.5
			end

			if animalName == "Premium Festive Lucky Block" then
				yOffset -= height * -0.5
			end

			if animalName == "W or L" then
				yOffset -= height * 0.5
			end

			if animalName == "Cocoa Assassino" then
				yOffset -= height * 0.5
			end

			if animalName == "Tacorita Bicicleta" then
				yOffset -= height * -0.1
			end

			if animalName == "Money Money Puggy" then
				yOffset -= height * -0.3
			end

			animalModel.PrimaryPart.CFrame =
				playerRoot.CFrame * CFrame.new(0, yOffset, -2)

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
				CarriedOverhead = carriedOverhead,
				DiedConnection = diedConnection,
				RemovingConnection = removingConnection,
				VictimRemovingConnection = victimRemovingConnection,
			}

			-- Track this player's active steal target for stale detection
			activeStealTargets[player.UserId] = {
				VictimPlotUID = victimPlotUID,
				PodiumIndex = podiumIndex,
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
	activeStealTargets[player.UserId] = nil
	player:SetAttribute("Stealing", nil)
	player:SetAttribute("StealingIndex", "")
	player:SetAttribute("SammyStealing", nil)

	if stealInfo.VictimPlotUID ~= "Sammy" then
		local victimPlotChannel = Synchronizer:Get(stealInfo.VictimPlotUID)
		if victimPlotChannel then
			-- ALWAYS reset Steal and Stolen flags, even if the animalList entry is no longer a table
			-- This prevents brainrots from becoming permanently un-grabbable
			victimPlotChannel:Set(string.format("AnimalList.%d.Steal", stealInfo.PodiumIndex), false)
			victimPlotChannel:Set(string.format("AnimalList.%d.Stolen", stealInfo.PodiumIndex), false)

			local animalList = victimPlotChannel:Get("AnimalList")
			if animalList and typeof(animalList[stealInfo.PodiumIndex]) == "table" then
				-- Jika player mati (bukan cancel biasa), tambah cooldown
				local character = player.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")
				local isDead = not humanoid or humanoid.Health <= 0 or not character.Parent

				if isDead then
					-- Set cooldown untuk brainrot ini
					local cooldownKey = stealInfo.VictimPlotUID .. "_" .. tostring(stealInfo.PodiumIndex)
					failedStealCooldowns[cooldownKey] = os.clock() + FAILED_STEAL_COOLDOWN

					-- Cleanup cooldown setelah selesai
					task.delay(FAILED_STEAL_COOLDOWN + 1, function()
						failedStealCooldowns[cooldownKey] = nil
					end)
				end
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
	activeStealTargets[player.UserId] = nil
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
	end
	stolenAnimalData.Steal = false
	stolenAnimalData.Stolen = true

	local stealerAnimalList = stealerChannel:Get("AnimalPodiums")
	local freePodiumIndex = table.find(stealerAnimalList, "Empty")

	local victimPlotChannel = Synchronizer:Get(stealInfo.VictimPlotUID)
	if victimPlotChannel then
		victimPlotChannel:Set(string.format("AnimalList.%d", stealInfo.PodiumIndex), "Empty")

		local victimPlayer = victimPlotChannel:Get("Owner")
		if victimPlayer then
			local animalName = stolenAnimalData.Index
			local colouredText = FormatAnimalName(animalName)
			NotificationService.Notify(victimPlayer, string.format("%s Stole your %s", player.Name, colouredText), 10)

			-- Check if stolen animal is an OG brainrot and handle base skin removal
			StealService:CheckAndRemoveBaseSkin(victimPlayer, animalName)

			-- Decrease victim's Generation by the stolen animal's generation amount
			local victimChannel = Synchronizer:Get(victimPlayer)
			if victimChannel then
				local generationLoss = SharedAnimals:GetGeneration(
					stolenAnimalData.Index,
					stolenAnimalData.Mutation,
					stolenAnimalData.Traits,
					victimPlayer
				)
				victimChannel:Increase("Generation", -generationLoss)

				-- Remove from victim's Index
				if not LuckyBlocks[animalName] then
					local victimIndex = victimChannel:Get("Index") or {}
					if victimIndex[animalName] then
						if stolenAnimalData.Mutation then
							local current = tonumber(victimIndex[animalName][stolenAnimalData.Mutation]) or 0
							if current > 0 then
								victimIndex[animalName][stolenAnimalData.Mutation] = current - 1
							end
						else
							local current = tonumber(victimIndex[animalName].Default) or 0
							if current > 0 then
								victimIndex[animalName].Default = current - 1
							end
						end
						victimChannel:Set("Index", victimIndex)
					end
				end
			end
		end
	end

	stolenAnimalData.LastCollect = workspace:GetServerTimeNow()
	stolenAnimalData.Steal = false

	local animalName = stolenAnimalData.Index
	local colouredText = FormatAnimalName(animalName)

	NotificationService.Notify(player, string.format("You stole %s", colouredText), 5, "Sounds.Sfx.Success")

	-- Update Index for stolen animal (same logic as PlotService.AddAnimalOnPlotOrQueue)
	if not LuckyBlocks[animalName] then
		local Index = stealerChannel:Get("Index") or {}
		Index[animalName] = Index[animalName] or {}

		if stolenAnimalData.Mutation then
			local current = tonumber(Index[animalName][stolenAnimalData.Mutation]) or 0
			Index[animalName][stolenAnimalData.Mutation] = current + 1
		else
			local current = tonumber(Index[animalName].Default) or 0
			Index[animalName].Default = current + 1
		end

		stealerChannel:Set("Index", Index)
	end

	-- Increase stealer's Generation by the stolen animal's generation amount
	local generationGain = SharedAnimals:GetGeneration(
		stolenAnimalData.Index,
		stolenAnimalData.Mutation,
		stolenAnimalData.Traits,
		player
	)
	stealerChannel:Increase("Generation", generationGain)

	stealerChannel:Increase("Steals", 1)
	stealerChannel:Set(string.format("AnimalPodiums.%d", freePodiumIndex), stolenAnimalData)
	stealerChannel:Set("AnimalAddedOrRemoved", true)
end

function StealService:CancelHold(player: Player, podiumIndex: number?)
	local stealInfo = activeSteals[player]
	if not stealInfo then
		return
	end

	-- CRITICAL FIX: Only allow placing if the brainrot belongs to this player
	local playerPlot = _G.playerPlots[player.UserId]
	if playerPlot and stealInfo.VictimPlotUID ~= playerPlot.Name then
		-- This is a stolen brainrot — cancel the steal and return it to the victim
		self:CancelSteal(player)
		return
	end

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
	activeStealTargets[player.UserId] = nil
	player:SetAttribute("Stealing", nil)
	player:SetAttribute("StealingIndex", "")

	local victimPlotChannel = Synchronizer:Get(stealInfo.VictimPlotUID)
	if victimPlotChannel then
		-- ALWAYS reset Steal and Stolen flags to prevent permanent lock
		victimPlotChannel:Set(string.format("AnimalList.%d.Steal", stealInfo.PodiumIndex), false)
		victimPlotChannel:Set(string.format("AnimalList.%d.Stolen", stealInfo.PodiumIndex), false)

		local animalList = victimPlotChannel:Get("AnimalList")
		if animalList and typeof(animalList[stealInfo.PodiumIndex]) == "table" then
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

function StealService:IsStealActiveOnPodium(stealingUserId: number, victimPlotUID: string, podiumIndex: number): boolean
	local stealTarget = activeStealTargets[stealingUserId]
	if stealTarget and stealTarget.VictimPlotUID == victimPlotUID and stealTarget.PodiumIndex == podiumIndex then
		return true
	end
	return false
end

-- Mapping of OG brainrots to their base skin names
local OG_TO_BASE_SKIN = {
	["Meowl"] = "Meowl",
	["Skibidi Toilet"] = "Skibidi",
	["Strawberry Elephant"] = "Strawberry",
	["Headless Horseman"] = "Headless"
}

function StealService:CheckAndRemoveBaseSkin(victimPlayer: Player, animalName: string)
	-- Check if this animal has an associated base skin
	local baseSkinName = OG_TO_BASE_SKIN[animalName]
	if not baseSkinName then
		return -- Not an OG brainrot with base skin
	end

	local victimChannel = Synchronizer:Get(victimPlayer)
	if not victimChannel then
		return
	end

	-- Check if player still has this brainrot
	local animalPodiums = victimChannel:Get("AnimalPodiums")
	local stillHasBrainrot = false

	for _, podium in pairs(animalPodiums) do
		if typeof(podium) == "table" and podium.Index == animalName then
			stillHasBrainrot = true
			break
		end
	end

	-- If player no longer has the brainrot, remove the base skin
	if not stillHasBrainrot then
		local unlockedSkins = victimChannel:Get("UnlockedBaseSkins")
		if unlockedSkins and unlockedSkins[baseSkinName] then
			unlockedSkins[baseSkinName] = nil
			victimChannel:Set("UnlockedBaseSkins", unlockedSkins)
		end

		-- If player was using this skin, reset to Normal
		local currentSkin = victimChannel:Get({"Settings", "Base Skin"})
		if currentSkin == baseSkinName then
			victimChannel:Set({"Settings", "Base Skin"}, "Normal")
		end
	end
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
	if not humanoid then
		return false
	end

	humanoid:UnequipTools()

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
	local carriedOverhead = AddCarriedOverhead(animalModel, true)
	local _, size = animalModel:GetBoundingBox()
	local height = size.Y or 0

	local yOffset = height / 2 - 1

	if animalName == "Mythic Lucky Block" then
		yOffset -= height * -0.5
	end

	if animalName == "Brainrot God Lucky Block" then
		yOffset -= height * -0.5
	end

	if animalName == "Secret Lucky Block" then
		yOffset -= height * -0.5
	end

	if animalName == "Admin Lucky Block" then
		yOffset -= height * -0.5
	end

	if animalName == "Taco Lucky Block" then
		yOffset -= height * -0.5
	end

	if animalName == "Extreme OG Lucky Block" then
		yOffset -= height * -0.5
	end

	if animalName == "Spooky Lucky Block" then
		yOffset -= height * -0.5
	end

	if animalName == "Los Taco Blocks" then
		yOffset -= height * -0.5
	end

	if animalName == "Festive Lucky Block" then
		yOffset -= height * -0.5
	end

	if animalName == "Premium Festive Lucky Block" then
		yOffset -= height * -0.5
	end

	if animalName == "W or L" then
		yOffset -= height * 0.5
	end

	if animalName == "Cocoa Assassino" then
		yOffset -= height * 0.5
	end

	if animalName == "Tacorita Bicicleta" then
		yOffset -= height * -0.1
	end

	if animalName == "Money Money Puggy" then
		yOffset -= height * -0.3
	end

	animalModel.PrimaryPart.CFrame =
		playerRoot.CFrame * CFrame.new(0, yOffset, -2)

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

	NotificationService.Notify(player, "", 10, ("Sounds.Animals.%s"):format(animalName))

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
		CarriedOverhead = carriedOverhead,
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

	local function isHandFullyInsideHitbox()
		local character = player.Character
		if not character then return false end

		local leftHand = character:FindFirstChild("LeftHand") or character:FindFirstChild("Left Arm")
		local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")

		for _, hitbox in ipairs(deliveryHitboxes) do
			local halfSize = hitbox.Size / 2
			local hitboxCF = hitbox.CFrame

			local function checkHand(hand)
				if not hand or not hand:IsA("BasePart") then
					return false
				end

				local handHalf = hand.Size / 2

				for x = -1, 1, 2 do
					for y = -1, 1, 2 do
						for z = -1, 1, 2 do
							local worldCorner =
								hand.CFrame *
								CFrame.new(
									handHalf.X * x,
									handHalf.Y * y,
									handHalf.Z * z
								)

							local localCorner =
								hitboxCF:PointToObjectSpace(worldCorner.Position)

							if math.abs(localCorner.X) > halfSize.X or
								math.abs(localCorner.Y) > halfSize.Y or
								math.abs(localCorner.Z) > halfSize.Z then
								return false
							end
						end
					end
				end

				return true
			end

			if checkHand(leftHand) or checkHand(rightHand) then
				return true
			end
		end

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

		if isHandFullyInsideHitbox() then
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
				activeStealTargets[player.UserId] = nil
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

	if action == "Place" then
		local stealInfo = activeSteals[player]
		if stealInfo then
			-- CRITICAL FIX: Only allow placing if the brainrot belongs to this player
			-- If the VictimPlotUID is not the player's own plot, the brainrot is stolen from someone else
			if stealInfo.VictimPlotUID ~= playerPlot.Name then
				return -- Reject: player is trying to place a stolen brainrot
			end

			local victimPlotChannel = Synchronizer:Get(stealInfo.VictimPlotUID)
			if victimPlotChannel then
				local animalList = victimPlotChannel:Get("AnimalList")
				local targetAnimal = animalList and animalList[podiumIndex]

				if targetAnimal and targetAnimal.Steal then
					return
				end
			end
		end
	end

	local owner = playerPlot:GetAttribute("Owner")
	if owner == "Idk" and action == "Grab" then
		return
	end

	if action == "Grab" then		
		StealService:StartSteal(player, playerPlot.Name, podiumIndex)
	elseif action == "Place" then
		StealService:CancelHold(player, podiumIndex)
	end
end)

StealRemote.OnServerEvent:Connect(function(player, time, key, plotName, podiumIndex)

	if typeof(plotName) ~= "string" then return end
	if typeof(podiumIndex) ~= "number" then return end
	if player:GetAttribute("Stealing") then return end

	-- Validate player is inside victim's plot StealHitbox
	local victimPlotChannel = Synchronizer:Get(plotName)
	if not victimPlotChannel then return end

	local victimOwner = victimPlotChannel:Get("Owner")
	if not victimOwner then return end

	-- Find the victim's plot model
	local victimPlot = nil
	for _, plot in ipairs(workspace.Plots:GetChildren()) do
		if plot.Name == plotName then
			victimPlot = plot
			break
		end
	end

	if not victimPlot then return end

	local stealHitbox = victimPlot:FindFirstChild("StealHitbox")
	if not stealHitbox then return end

	local character = player.Character
	if not character then return end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then return end

	-- Check if player is inside the StealHitbox
	local overlapParams = OverlapParams.new()
	overlapParams.FilterDescendantsInstances = {stealHitbox}
	overlapParams.FilterType = Enum.RaycastFilterType.Include
	overlapParams.MaxParts = 1

	local hrpPosition = humanoidRootPart.Position
	local partsInBox = workspace:GetPartBoundsInBox(
		CFrame.new(hrpPosition),
		humanoidRootPart.Size,
		overlapParams
	)

	if #partsInBox == 0 then
		-- Player is NOT inside the StealHitbox, reject the steal
		return
	end

	StealService:StartSteal(player, plotName, podiumIndex)

end)

-- Periodic cleanup of stale Steal flags on all plots
-- This prevents brainrots from becoming permanently locked when steal processes fail,
-- players disconnect mid-steal, or CancelSteal doesn't fully clean up.
-- Without this, the client blocks all prompts (Grab AND Steal) when it sees a stuck
-- Steal flag, and the server never gets a chance to clear it on-demand.
task.spawn(function()
	while task.wait(10) do
		local plotsFolder = workspace:FindFirstChild("Plots")
		if not plotsFolder then continue end

		for _, plot in ipairs(plotsFolder:GetChildren()) do
			local plotChannel = Synchronizer:Get(plot.Name)
			if not plotChannel then continue end

			local animalList = plotChannel:Get("AnimalList")
			if not animalList or typeof(animalList) ~= "table" then continue end

			for podiumIndex, animalData in pairs(animalList) do
				if typeof(animalData) == "table"
					and animalData.Steal
					and animalData.Steal ~= false
					and animalData.Steal ~= "FuseMachine"
				then
					local stealingUserId = animalData.Steal
					local numericPodiumIndex = tonumber(podiumIndex)

					-- Check if this steal is actually still active
					local stealTarget = activeStealTargets[stealingUserId]
					local isStale = true

					if stealTarget
						and stealTarget.VictimPlotUID == plot.Name
						and stealTarget.PodiumIndex == numericPodiumIndex
					then
						isStale = false
					end

					if isStale then
						warn(string.format(
							"[StealService] Periodic cleanup: Clearing stale Steal flag on plot %s podium %s (was UserId %s)",
							plot.Name, tostring(podiumIndex), tostring(stealingUserId)
						))
						plotChannel:Set(string.format("AnimalList.%s.Steal", tostring(podiumIndex)), false)
						plotChannel:Set(string.format("AnimalList.%s.Stolen", tostring(podiumIndex)), false)
					end
				end
			end
		end
	end
end)

return StealService