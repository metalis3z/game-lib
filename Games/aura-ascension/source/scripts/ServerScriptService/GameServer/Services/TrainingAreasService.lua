local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(script.Parent.Parent.Config.GameConfig)
local TrainingAreasConfig = require(script.Parent.Parent.Config.TrainingAreasConfig)
local Billboard3D = require(ReplicatedStorage.Frameworks["3D Billboard"])

local TrainingAreasService = {}
TrainingAreasService.__index = TrainingAreasService

local REJECTION_COOLDOWN = 3.25
local REJECTION_RAGDOLL_DURATION = 3
local REJECTION_RESPAWN_DELAY = 3
local REJECTION_HORIZONTAL_SPEED = 230
local REJECTION_VERTICAL_SPEED = 250

function TrainingAreasService.new()
	local service = {
		AreaParts = {},
		AreaTouchConnections = {},
		CurrentAreaByPlayer = {},
		UnlockedByPlayer = {},
		RejectCooldowns = {},
		RejectTokens = {},
		FahsFolder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Sounds"):WaitForChild("Fahs"),
		KOTHState = {
			IsClaimed = false,
			KingUserId = nil,
			KingName = nil,
			ClaimStartedAt = 0,
			WinCredited = false,
		},
	}

	return setmetatable(service, TrainingAreasService)
end

function TrainingAreasService:Init(registry)
	self.Registry = registry
	self.RemoteBinder = registry:Get("RemoteBinder")
	self.DataService = registry:Get("DataService")
	self.PlayerService = registry:Get("PlayerService")
	self.LegacyBridge = registry:Get("LegacyBridgeService")
	self.RemoteBinder:BindFunction("TrainingAreasService", "GetTrainingAreasData", function(player)
		return self:GetTrainingAreasData(player)
	end)
end

function TrainingAreasService:Start()
	self:_resolveAreaParts()
	self.DataService.ProfileLoaded.Event:Connect(function(player)
		self:_refreshUnlockedStateForPlayer(player)
		self:RefreshPlayerAreaData(player)
		self.RemoteBinder:FireClient("TrainingAreasService", "KOTHStateChanged", player, self:_copyKOTHState())
		self.LegacyBridge:PushKOTHState(self:_copyKOTHState(), player)
	end)
	Players.PlayerRemoving:Connect(function(player)
		self.CurrentAreaByPlayer[player] = nil
		self.UnlockedByPlayer[player] = nil
		self.RejectTokens[player] = nil
		for key in pairs(self.RejectCooldowns) do
			if string.find(key, tostring(player.UserId) .. ":", 1, true) == 1 then
				self.RejectCooldowns[key] = nil
			end
		end
		if self.KOTHState.KingUserId == player.UserId then
			self:_setKOTHKing(nil)
		end
	end)

	task.defer(function()
		self:RefreshAllPlayers()
		local state = self:_copyKOTHState()
		for _, player in ipairs(Players:GetPlayers()) do
			if self.DataService:GetProfile(player) then
				self.RemoteBinder:FireClient("TrainingAreasService", "KOTHStateChanged", player, state)
				self.LegacyBridge:PushKOTHState(state, player)
			end
		end
	end)

	task.spawn(function()
		while true do
			task.wait(GameConfig.TrainingTickSeconds)
			self:_runTrainingTick()
		end
	end)

	task.spawn(function()
		while true do
			task.wait(1)
			self:_runKOTHTick()
		end
	end)
end

function TrainingAreasService:_resolveAreaParts()
	for _, connection in ipairs(self.AreaTouchConnections) do
		connection:Disconnect()
	end
	table.clear(self.AreaTouchConnections)

	local trainingAreasFolder = workspace:WaitForChild("Training Areas")
	for _, area in ipairs(TrainingAreasConfig.List) do
		local model = trainingAreasFolder:FindFirstChild(area.Name)
		if model then
			local hitbox = model:FindFirstChild("AreaHitbox", true)
			if hitbox and hitbox:IsA("BasePart") then
				self.AreaParts[area.Name] = hitbox
				table.insert(self.AreaTouchConnections, hitbox.Touched:Connect(function(otherPart)
					self:_onAreaHitboxTouched(area, hitbox, otherPart)
				end))
			end
		end
	end
	local kothFolder = workspace:FindFirstChild("KOTH")
	self.KOTHHitbox = kothFolder and kothFolder:FindFirstChild("AreaHitbox")
end

function TrainingAreasService:_resolveCharacterFromPart(part)
	local current = part and part.Parent
	while current and current ~= workspace do
		if current:IsA("Model") and current:FindFirstChildOfClass("Humanoid") then
			return current
		end
		current = current.Parent
	end
	return nil
end

function TrainingAreasService:_isBodyPartCandidate(part, character)
	if not part or not character or not part:IsA("BasePart") or not part:IsDescendantOf(character) then
		return false
	end
	if part.Name == "HumanoidRootPart" then
		return true
	end
	if part:FindFirstAncestorWhichIsA("Accessory") then
		return false
	end
	if part:FindFirstAncestorOfClass("Tool") then
		return false
	end
	return true
end

function TrainingAreasService:_isPartPointInside(hitbox, worldPosition)
	local localPosition = hitbox.CFrame:PointToObjectSpace(worldPosition)
	local halfSize = hitbox.Size * 0.5
	return math.abs(localPosition.X) <= halfSize.X
		and math.abs(localPosition.Y) <= halfSize.Y
		and math.abs(localPosition.Z) <= halfSize.Z
end

function TrainingAreasService:_isCharacterInsidePart(player, part, overlappingPart)
	if not player or not part then
		return false
	end
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not humanoid or humanoid.Health <= 0 or not root or not root:IsA("BasePart") then
		return false
	end
	if overlappingPart and self:_isBodyPartCandidate(overlappingPart, character) then
		return true
	end
	if self:_isPartPointInside(part, root.Position) then
		return true
	end
	local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
	if torso and torso:IsA("BasePart") and self:_isPartPointInside(part, torso.Position) then
		return true
	end
	return false
end

function TrainingAreasService:_getPlayersInPart(part)
	local seen = {}
	local players = {}
	if not part then
		return players
	end
	for _, touchedPart in ipairs(workspace:GetPartsInPart(part)) do
		local character = self:_resolveCharacterFromPart(touchedPart)
		local player = character and Players:GetPlayerFromCharacter(character)
		if player and not seen[player] and self:_isCharacterInsidePart(player, part, touchedPart) then
			seen[player] = true
			players[#players + 1] = player
		end
	end
	return players
end

function TrainingAreasService:_getAreaBoostValue(areaName)
	local area = TrainingAreasConfig.ByName[areaName]
	return area and (area.DisplayBoost or area.PassiveMultiplier or area.AuraPerTick) or 1
end

function TrainingAreasService:_playRejectSound(player)
	local sounds = self.FahsFolder:GetChildren()
	if #sounds == 0 then
		return
	end

	local selected = sounds[math.random(1, #sounds)]
	if not selected:IsA("Sound") then
		return
	end

	local playerGui = player:FindFirstChildOfClass("PlayerGui")
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	local targetParent = playerGui or root
	if not targetParent then
		return
	end

	local soundClone = selected:Clone()
	soundClone.Name = "TrainingRejectSound"
	soundClone.RollOffMaxDistance = 0
	soundClone.Parent = targetParent
	soundClone:Play()
	Debris:AddItem(soundClone, math.max(2, soundClone.TimeLength + 0.5))
end

function TrainingAreasService:_showRejectBillboard(player)
	pcall(function()
		Billboard3D.new(player)
	end)
end

function TrainingAreasService:_buildRejectKnockback(player, hitbox)
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not root or not root:IsA("BasePart") then
		return Vector3.new(0, REJECTION_VERTICAL_SPEED, 0)
	end

	local away = root.Position - hitbox.Position
	away = Vector3.new(away.X, 0, away.Z)
	if away.Magnitude < 0.001 then
		away = -hitbox.CFrame.LookVector
		away = Vector3.new(away.X, 0, away.Z)
	end
	away = away.Magnitude > 0 and away.Unit or Vector3.new(0, 0, -1)
	return away * REJECTION_HORIZONTAL_SPEED + Vector3.new(0, REJECTION_VERTICAL_SPEED, 0)
end

function TrainingAreasService:_requestCharacterRagdoll(player, knockback)
	local character = player.Character
	if not character then
		return false
	end

	local token = (character:GetAttribute("RagdollRequestToken") or 0) + 1
	character:SetAttribute("RagdollKnockbackX", knockback.X)
	character:SetAttribute("RagdollKnockbackY", knockback.Y)
	character:SetAttribute("RagdollKnockbackZ", knockback.Z)
	character:SetAttribute("RagdollDuration", REJECTION_RAGDOLL_DURATION)
	character:SetAttribute("RagdollRequestToken", token)
	return true
end

function TrainingAreasService:_applyRejectEffect(player, cooldownKey, hitbox)
	local now = os.clock()
	if (self.RejectCooldowns[cooldownKey] or 0) > now then
		return false
	end
	self.RejectCooldowns[cooldownKey] = now + REJECTION_COOLDOWN

	local token = (self.RejectTokens[player] or 0) + 1
	self.RejectTokens[player] = token

	self:_requestCharacterRagdoll(player, self:_buildRejectKnockback(player, hitbox))
	
	if self.LegacyBridge and self.LegacyBridge.FX then
		self.LegacyBridge.FX:FireClient(player, player.UserId)
	end
	
	self:_showRejectBillboard(player)
	self:_playRejectSound(player)

	task.delay(REJECTION_RESPAWN_DELAY, function()
		if self.RejectTokens[player] ~= token then
			return
		end
		if player.Parent ~= Players then
			return
		end
		local liveCharacter = player.Character
		local liveHumanoid = liveCharacter and liveCharacter:FindFirstChildOfClass("Humanoid")
		if liveHumanoid and liveHumanoid.Health > 0 then
			player:LoadCharacter()
		end
	end)

	return true
end

function TrainingAreasService:_rejectPlayerFromArea(player, area, hitbox)
	return self:_applyRejectEffect(player, tostring(player.UserId) .. ":" .. area.Name, hitbox)
end

function TrainingAreasService:_rejectPlayerFromKOTH(player)
	return self:_applyRejectEffect(player, tostring(player.UserId) .. ":KOTH", self.KOTHHitbox)
end

function TrainingAreasService:_onAreaHitboxTouched(area, hitbox, otherPart)
	if not otherPart then
		return
	end
	local character = self:_resolveCharacterFromPart(otherPart)
	local player = character and Players:GetPlayerFromCharacter(character)
	if not player or not self.DataService:GetProfile(player) then
		return
	end
	if not self:_isCharacterInsidePart(player, hitbox, otherPart) then
		return
	end
	if self.PlayerService:CanAccessArea(player, area.Name) then
		return
	end
	self:_rejectPlayerFromArea(player, area, hitbox)
end

function TrainingAreasService:_setCurrentArea(player, areaName)
	areaName = type(areaName) == "string" and areaName or ""
	if self.CurrentAreaByPlayer[player] == areaName then
		return false
	end
	self.CurrentAreaByPlayer[player] = areaName
	if self.DataService:GetProfile(player) then
		self.DataService:Mutate(player, function(data)
			data.Progression.CurrentArea = areaName
		end)
		self.PlayerService:SyncReplicatedState(player)
	end
	return true
end

function TrainingAreasService:_refreshUnlockedStateForPlayer(player)
	local profile = self.DataService:GetProfile(player)
	if not profile then
		return false
	end

	local unlockedMap = self.UnlockedByPlayer[player]
	if not unlockedMap then
		unlockedMap = {}
		self.UnlockedByPlayer[player] = unlockedMap
	end

	local changed = false
	local newlyUnlocked = {}
	for _, area in ipairs(TrainingAreasConfig.List) do
		local unlocked = self.PlayerService:CanAccessArea(player, area.Name)
		if unlockedMap[area.Name] ~= unlocked then
			unlockedMap[area.Name] = unlocked
			changed = true
			if unlocked then
				newlyUnlocked[#newlyUnlocked + 1] = area
			end
		end
	end

	if #newlyUnlocked > 0 then
		self.DataService:Mutate(player, function(data)
			for _, area in ipairs(newlyUnlocked) do
				data.Progression.UnlockedAreas[area.Name] = true
			end
		end)
	end

	return changed
end

function TrainingAreasService:RefreshAllPlayers()
	for _, player in ipairs(Players:GetPlayers()) do
		self:_refreshUnlockedStateForPlayer(player)
		self:RefreshPlayerAreaData(player)
	end
end

function TrainingAreasService:_runTrainingTick()
	local candidateAreas = {}
	for _, area in ipairs(TrainingAreasConfig.List) do
		local hitbox = self.AreaParts[area.Name]
		for _, player in ipairs(self:_getPlayersInPart(hitbox)) do
			if self.PlayerService:CanAccessArea(player, area.Name) then
				local current = candidateAreas[player]
				if not current or area.Requirement > current.Requirement then
					candidateAreas[player] = area
				end
			else
				self:_rejectPlayerFromArea(player, area, hitbox)
			end
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if self.DataService:GetProfile(player) then
			local selectedArea = candidateAreas[player]
			local selectedAreaName = selectedArea and selectedArea.Name or ""
			local previousAreaName = self:GetCurrentAreaName(player)
			local areaChanged = self:_setCurrentArea(player, selectedAreaName)
			if selectedArea then
				self.PlayerService:MarkTutorialZone(player, selectedAreaName)
			end
			if areaChanged then
				if selectedArea then
					local displayBoost = self:_getAreaBoostValue(selectedAreaName)
					self.RemoteBinder:FireClient("TrainingAreasService", "AreaStatusChanged", player, selectedAreaName, displayBoost)
					self.LegacyBridge:PushAreaStatus(player, selectedAreaName, displayBoost)
				else
					self.RemoteBinder:FireClient("TrainingAreasService", "AreaStatusChanged", player, nil, nil)
				end
			end
			local unlockedChanged = self:_refreshUnlockedStateForPlayer(player)
			if areaChanged or unlockedChanged or previousAreaName ~= selectedAreaName then
				self:RefreshPlayerAreaData(player)
			end
		end
	end
end

function TrainingAreasService:GetCurrentAreaName(player)
	return self.CurrentAreaByPlayer[player] or ""
end

function TrainingAreasService:GetCurrentAreaBoost(player)
	local areaName = self:GetCurrentAreaName(player)
	if areaName == "" then
		return 1
	end
	return self:_getAreaBoostValue(areaName)
end

function TrainingAreasService:GetPassiveMultiplier(player)
	return self:GetCurrentAreaBoost(player)
end

function TrainingAreasService:GetKOTHMultiplier(player)
	if not player or self.KOTHState.KingUserId ~= player.UserId then
		return 1
	end
	return math.max(1, tonumber(GameConfig.KOTH.AuraMultiplier) or 1)
end

function TrainingAreasService:GetTrainingAreasData(player)
	local profile = self.DataService:GetProfile(player)
	if not profile then
		return {}
	end

	local cursedZoneService = self.Registry:Get("CursedZoneService")
	local response = {}
	for _, area in ipairs(TrainingAreasConfig.List) do
		local boost = self:_getAreaBoostValue(area.Name)
		response[area.Name] = {
			Requirement = area.Requirement,
			PassiveMultiplier = boost,
			AuraPerTick = boost,
			AuraBoost = boost,
			Unlocked = self.PlayerService:CanAccessArea(player, area.Name),
			Current = self.CurrentAreaByPlayer[player] == area.Name,
			IsEventActive = cursedZoneService:IsAreaAvailable(area.Name),
		}
		if profile.Progression.UnlockedAreas[area.Name] then
			response[area.Name].UnlockedBefore = true
		end
	end
	return response
end

function TrainingAreasService:RefreshPlayerAreaData(player)
	if player.Parent ~= Players then
		return
	end
	local data = self:GetTrainingAreasData(player)
	self.RemoteBinder:FireClient("TrainingAreasService", "TrainingAreasData", player, data)
	self.LegacyBridge:PushTrainingAreasData(player, data)
end

function TrainingAreasService:PushAuraTickFeedback(player, awarded, areaName, displayBoost, source)
	if awarded <= 0 then
		return
	end
	self.RemoteBinder:FireClient("TrainingAreasService", "Tick", player, awarded, areaName or "Passive", displayBoost or 1, source or "Passive")
end

function TrainingAreasService:BroadcastCursedZone(message, notificationType, origin, duration)
	self.RemoteBinder:FireAll("TrainingAreasService", "CursedZoneNotification", message, notificationType)
	if origin then
		self.RemoteBinder:FireAll("TrainingAreasService", "CursedZoneShake", origin, duration or 3)
	end
end

function TrainingAreasService:_copyKOTHState()
	return {
		IsClaimed = self.KOTHState.IsClaimed,
		KingUserId = self.KOTHState.KingUserId,
		KingName = self.KOTHState.KingName,
		ClaimStartedAt = self.KOTHState.ClaimStartedAt,
	}
end

function TrainingAreasService:_setKOTHKing(player)
	if player then
		self.KOTHState.IsClaimed = true
		self.KOTHState.KingUserId = player.UserId
		self.KOTHState.KingName = player.DisplayName
		self.KOTHState.ClaimStartedAt = os.time()
		self.KOTHState.WinCredited = false
		self.RemoteBinder:FireAll("TrainingAreasService", "KOTHNotification", player.DisplayName:upper() .. " CLAIMED KOTH", "KOTHNotification")
		self.LegacyBridge:PushKOTHNotification(player.DisplayName:upper() .. " CLAIMED KOTH", "KOTHNotification")
	else
		self.KOTHState.IsClaimed = false
		self.KOTHState.KingUserId = nil
		self.KOTHState.KingName = nil
		self.KOTHState.ClaimStartedAt = 0
		self.KOTHState.WinCredited = false
	end

	local state = self:_copyKOTHState()
	self.RemoteBinder:FireAll("TrainingAreasService", "KOTHStateChanged", state)
	self.LegacyBridge:PushKOTHState(state)
end

function TrainingAreasService:_runKOTHTick()
	if not self.KOTHHitbox or not self.KOTHHitbox:IsA("BasePart") then
		return
	end

	local occupants = self:_getPlayersInPart(self.KOTHHitbox)
	table.sort(occupants, function(left, right)
		local leftAura = left:GetAttribute("Aura") or 0
		local rightAura = right:GetAttribute("Aura") or 0
		return leftAura > rightAura
	end)

	local currentKing = self.KOTHState.KingUserId and Players:GetPlayerByUserId(self.KOTHState.KingUserId) or nil
	local strongestOccupant = occupants[1]

	if currentKing and not self:_isCharacterInsidePart(currentKing, self.KOTHHitbox) then
		self.RemoteBinder:FireAll("TrainingAreasService", "KOTHNotification", currentKing.DisplayName:upper() .. " LEFT KOTH", "KOTHNotification")
		self.LegacyBridge:PushKOTHNotification(currentKing.DisplayName:upper() .. " LEFT KOTH", "KOTHNotification")
		currentKing = nil
		self:_setKOTHKing(nil)
	end

	if not strongestOccupant then
		if self.KOTHState.IsClaimed then
			local previousUserId = self.KOTHState.KingUserId
			self:_setKOTHKing(nil)
			if previousUserId then
				local previousPlayer = Players:GetPlayerByUserId(previousUserId)
				if previousPlayer then
					self.PlayerService:SyncReplicatedState(previousPlayer)
				end
			end
		end
		return
	end

	if currentKing and currentKing == strongestOccupant then
		for index = 2, #occupants do
			self:_rejectPlayerFromKOTH(occupants[index])
		end
	elseif currentKing and currentKing ~= strongestOccupant then
		if self:_rejectPlayerFromKOTH(currentKing) then
			self.RemoteBinder:FireAll("TrainingAreasService", "KOTHNotification", currentKing.DisplayName:upper() .. " LEFT KOTH", "KOTHNotification")
			self.LegacyBridge:PushKOTHNotification(currentKing.DisplayName:upper() .. " LEFT KOTH", "KOTHNotification")
		end
		for _, challenger in ipairs(occupants) do
			if challenger ~= strongestOccupant then
				self:_rejectPlayerFromKOTH(challenger)
			end
		end
		self:_setKOTHKing(strongestOccupant)
		self.PlayerService:SyncReplicatedState(strongestOccupant)
		self.PlayerService:SyncReplicatedState(currentKing)
	else
		for index = 2, #occupants do
			self:_rejectPlayerFromKOTH(occupants[index])
		end
		if not self.KOTHState.IsClaimed or self.KOTHState.KingUserId ~= strongestOccupant.UserId then
			self:_setKOTHKing(strongestOccupant)
			self.PlayerService:SyncReplicatedState(strongestOccupant)
		end
	end

	self.DataService:Mutate(strongestOccupant, function(data)
		data.Stats.KOTHSeconds += 1
		if not self.KOTHState.WinCredited and os.time() - self.KOTHState.ClaimStartedAt >= GameConfig.KOTH.WinThresholdSeconds then
			data.Stats.KOTHWins += 1
			self.KOTHState.WinCredited = true
		end
	end)
end

return TrainingAreasService