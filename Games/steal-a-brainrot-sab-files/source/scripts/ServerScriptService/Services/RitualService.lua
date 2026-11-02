local RitualService = {}

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local PlotService = require(ServerScriptService.Services.PlotService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local ChatService = require(ServerScriptService.Services.ChatService)
local EventService = require(ServerScriptService.Services.EventService)
local StealService = require(ServerScriptService.Services.StealService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local SoundService = require(ServerScriptService.Services.SoundService)
local Animals = require(ReplicatedStorage.Datas.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)

local RitualStartRemote = Net:RemoteEvent("RitualService/StartRitual")
local RitualCompleteRemote = Net:RemoteEvent("RitualService/CompleteRitual")

local Config = {
	CHECK_RATE = 1,
	RITUAL_COOLDOWN = 60,

	RITUAL_TO_EVENT = {
		Ritual67 = "2026",
		Matteo = "Los Matteos",
		BombardiroCrocodilo = "Los Crocodillitos",
		LaVacca = "Las Vaquitas Saturnitas",
		DulDulDul = "Dul Dul Dul",
		ChicleteiraBicicleteira = "Chicleteira Bicicleteira",
		["1x1x1x1"] = "1x1x1x1",
	},

	MATTEO_TREE_POSITIONS_COUNT = 5,
	MATTEO_TREE_SPREAD = 8,

	CHICLETEIRA_VFX_DURATION = 5,
}

local State = {
	activeRituals = {},
	cooldowns = {},
	busyPlayers = {},
	heartbeatConnection = nil,
}

local rituals = {
	Matteo = {
		playersNeeded = 3,
		animalNeeded = "Matteo",
		style = "Vertical",
		height = 8,
		margin = 5,
		reward = "Los Matteos",
		count = 1,
		conveyor = true,
		msg = '<font color="#00ff00">[RITUAL] Matteo ritual complete!</font>',
		passRitualPosition = true,
	},
	BombardiroCrocodilo = {
		playersNeeded = 3,
		animalNeeded = "Bombardiro Crocodilo",
		style = "Line",
		margin = 8,
		reward = "Los Crocodillitos",
		count = 1,
		msg = '<font color="#ff0000">[RITUAL] Bombardiro Crocodilo ritual complete!</font>',
	},
	LaVacca = {
		playersNeeded = 3,
		animalNeeded = "La Vacca Saturno Saturnita",
		style = "Circle",
		radius = 12,
		margin = 5,
		reward = "Las Vaquitas Saturnitas",
		count = 1,
		wait = 8,
		msg = '<font color="#9d00ff">[RITUAL] La Vacca ritual complete!</font>',
	},
	DulDulDul = {
		playersNeeded = 4,
		animalNeeded = "Dul Dul Dul",
		style = "Square",
		size = 15,
		margin = 10,
		reward = "Yess my examine",
		rareReward = "Yess my examine Rare",
		rareChance = 0.05,
		count = 1,
		buildPhase = true,
		msg = '<font color="#00aaff">[RITUAL] Dul Dul Dul ritual complete!</font>',
	},
	ChicleteiraBicicleteira = {
		playersNeeded = 2,
		animalNeeded = "Chicleteira Bicicleteira",
		style = "Opposite",
		dist = 25,
		margin = 10,
		reward = "Los Chicleteiras",
		count = 1,
		wait = 3,
		msg = '<font color="#ffff00">[RITUAL] Chicleteira Bicicleteira ritual complete!</font>',
	},
	["1x1x1x1"] = {
		playersNeeded = 4,
		animalNeeded = "Guerriro Digitale",
		style = "Square",
		size = 18,
		margin = 12,
		reward = "1x1x1x1",
		secretReward = "Guest 666",
		secretChance = 0.01,
		count = 1,
		needsEvent = true,
		msg = '<rainbow>[RITUAL] LEGENDARY 1x1x1x1 RITUAL COMPLETE!</rainbow>',
	}
}


local function freezeParticipants(participants)
	for _, player in ipairs(participants) do
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = 0
				humanoid.JumpPower = 0
				humanoid:SetAttribute("RitualFrozen", true)
			end
		end
	end
end

local function unfreezeParticipants(participants)
	for _, player in ipairs(participants) do
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid:GetAttribute("RitualFrozen") then
				humanoid.WalkSpeed = 34
				humanoid.JumpPower = 50
				humanoid:SetAttribute("RitualFrozen", nil)
			end
		end
	end
end
local function applyChicleteiraVFX(participants)
	for i, player in ipairs(participants) do
		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if root then
			root:SetAttribute("ChicleteiraIndex", i)
			CollectionService:AddTag(root, "ChicleteiraPlayerVFX")
		end
	end
end

local function removeChicleteiraVFX(participants)
	for _, player in ipairs(participants) do
		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if root then
			CollectionService:RemoveTag(root, "ChicleteiraPlayerVFX")
			root:SetAttribute("ChicleteiraIndex", nil)
		end
	end
end

local function captureParticipantSpawnCFrames(participants)
	local cframes = {}
	for _, player in ipairs(participants) do
		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if root then
			local origin = root.Position + Vector3.new(0, 10, 0)
			local result = workspace:Raycast(origin, Vector3.new(0, -200, 0))
			local groundY = result and result.Position.Y or root.Position.Y
			local cf = CFrame.new(root.Position.X, groundY, root.Position.Z)
				* CFrame.Angles(0, math.atan2(-root.CFrame.LookVector.X, -root.CFrame.LookVector.Z), 0)
			table.insert(cframes, cf)
		end
	end
	return cframes
end


local function hasAnimal(rType, group)
	local data = rituals[rType]
	if not data then return false end

	if rType == "ChicleteiraBicicleteira" then
		return true
	end

	for _, ply in ipairs(group) do
		local chan = Synchronizer:Get(ply)
		if not chan then return false end

		local pods = chan:Get("AnimalPodiums")
		if not pods then return false end

		local found = false
		for _, info in pairs(pods) do
			if type(info) == "table" and info.Index == data.animalNeeded then
				found = true
				break
			end
		end
		if not found then return false end
	end
	return true
end
local function checkPos(rType, group)
	local data = rituals[rType]
	if not data or #group ~= data.playersNeeded then return false end

	if data.style == "Single" then
		local ply = group[1]
		return ply.Character and ply.Character:FindFirstChild("HumanoidRootPart")
	end

	local pos = {}
	for _, ply in ipairs(group) do
		local root = ply.Character and ply.Character:FindFirstChild("HumanoidRootPart")
		if not root then return false end
		table.insert(pos, root.Position)
	end

	if data.style == "Vertical" then
		table.sort(pos, function(a, b) return a.Y < b.Y end)
		for i = 1, #pos - 1 do
			local gap = pos[i+1].Y - pos[i].Y
			local flatDist = (Vector2.new(pos[i+1].X, pos[i+1].Z) - Vector2.new(pos[i].X, pos[i].Z)).Magnitude
			if gap < data.height * 0.7 or gap > data.height * 1.3 or flatDist > data.margin then
				return false
			end
		end
		return true

	elseif data.style == "Line" then
		if #pos < 2 then return false end
		local unit = (pos[2] - pos[1]).Unit
		for i = 3, #pos do
			local dot = (pos[i] - pos[1]):Dot(unit)
			local linePos = pos[1] + unit * dot
			if (pos[i] - linePos).Magnitude > data.margin then return false end
		end
		return true

	elseif data.style == "Circle" or data.style == "Square" then
		local mid = Vector3.new(0, 0, 0)
		for _, p in ipairs(pos) do mid += p end
		mid /= #pos

		for _, p in ipairs(pos) do
			local d = (Vector3.new(p.X, mid.Y, p.Z) - mid).Magnitude
			local target = (data.style == "Circle") and data.radius or (data.size / 2)
			if math.abs(d - target) > data.margin then return false end
		end
		return true

	elseif data.style == "Opposite" then
		local platformFolder = workspace:FindFirstChild("Events")
			and workspace.Events:FindFirstChild("Chicleteira Bicicleteira")
		if not platformFolder then return false end

		local part1 = platformFolder:FindFirstChild("1")
		local part2 = platformFolder:FindFirstChild("2")
		if not part1 or not part2 then return false end

		local roots = {}
		for _, ply in ipairs(group) do
			local root = ply.Character and ply.Character:FindFirstChild("HumanoidRootPart")
			if not root then return false end
			table.insert(roots, root)
		end

		local function isOnPart(root, part)
			local halfX = part.Size.X / 2
			local halfZ = part.Size.Z / 2
			local localDiff = part.CFrame:PointToObjectSpace(root.Position)
			if math.abs(localDiff.X) > halfX or math.abs(localDiff.Z) > halfZ then
				return false
			end
			if root.Position.Y < part.Position.Y - 1 or root.Position.Y > part.Position.Y + 6 then
				return false
			end
			return true
		end

		local function isFacingPositiveZ(root)
			local lookVector = root.CFrame.LookVector
			local look2D = Vector2.new(lookVector.X, lookVector.Z).Unit
			local dot = look2D:Dot(Vector2.new(0, 1))
			return dot > 0.7
		end

		local assignmentA = isOnPart(roots[1], part1) and isOnPart(roots[2], part2)
		local assignmentB = isOnPart(roots[1], part2) and isOnPart(roots[2], part1)

		if not assignmentA and not assignmentB then return false end

		if not isFacingPositiveZ(roots[1]) or not isFacingPositiveZ(roots[2]) then
			return false
		end

		for _, ply in ipairs(group) do
			if not StealService:IsStealing(ply) then return false end
			local stealData = StealService:GetStealData(ply)
			if not stealData or not stealData.StolenAnimalData 
				or stealData.StolenAnimalData.Index ~= "Chicleteira Bicicleteira" then
				return false
			end
		end

		return true
	end

	return false
end


local function getRitualCenterPosition(group)
	local sumX, sumZ, groundY = 0, 0, nil
	local count = 0
	for _, ply in ipairs(group) do
		local root = ply.Character and ply.Character:FindFirstChild("HumanoidRootPart")
		if root then
			sumX = sumX + root.Position.X
			sumZ = sumZ + root.Position.Z
			if not groundY then
				groundY = root.Position.Y
			else
				groundY = math.min(groundY, root.Position.Y)
			end
			count += 1
		end
	end
	if count == 0 then return Vector3.new(0, 0, 0) end

	local centerTop = Vector3.new(sumX / count, (groundY or 0) + 500, sumZ / count)
	local result = workspace:Raycast(centerTop, Vector3.new(0, -1000, 0))
	if result then
		return result.Position
	end
	return Vector3.new(sumX / count, groundY or 0, sumZ / count)
end

local function buildMatteoTreePositions(center, count, spread)
	local positions = {}
	for i = 1, count do
		local angle = (i / count) * math.pi * 2
		local r = spread * (0.5 + math.random() * 0.5)
		local x = center.X + math.cos(angle) * r
		local z = center.Z + math.sin(angle) * r

		local topPos = Vector3.new(x, center.Y + 200, z)
		local result = workspace:Raycast(topPos, Vector3.new(0, -400, 0))
		local y = result and result.Position.Y or center.Y

		positions[i] = Vector3.new(x, y, z)
	end
	return positions
end

local function removeUsedBrainrot(player, animalNeeded)
	local data = Synchronizer:Get(player)
	if not data then return end

	local podiums = data:Get("AnimalPodiums") or {}
	local podiumIndexToRemove = nil

	for i, podium in pairs(podiums) do
		if type(podium) == "table" and podium.Index == animalNeeded then
			podiumIndexToRemove = i
			break
		end
	end

	if podiumIndexToRemove then
		podiums[podiumIndexToRemove] = nil
		data:Set("AnimalPodiums", podiums)
		data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

		local animalData = Animals[animalNeeded]
		if animalData then
			local rarityData = Rarities[animalData.Rarity]
			local color = rarityData and rarityData.Color
			if color and typeof(color) == "Color3" then
				local hex = string.format("#%02X%02X%02X",
					math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
				local _ = string.format('<font color="%s">%s</font>', hex, animalData.DisplayName or animalNeeded)
			end
		end
	end
end


local function triggerRitualEvent(ritualType, participants, extraData)
	local eventToTrigger = Config.RITUAL_TO_EVENT[ritualType] or ritualType

	if eventToTrigger:match("^Ritual") then
		eventToTrigger = eventToTrigger:gsub("^Ritual", "")
	end

	if ritualType == "Matteo" and extraData and extraData.treePositions then
		for _, player in ipairs(participants) do
			local chan = Synchronizer:Get(player)
			if chan then
				chan:Set("TreePositions", extraData.treePositions)
			else
				warn(string.format("[RitualService] No Synchronizer channel for %s, skipping TreePositions", player.Name))
			end
		end
	end

	local success, err = pcall(function()
		if ritualType == "ChicleteiraBicicleteira" and extraData and extraData.spawnCFrames then
			EventService:ExecuteEvent(eventToTrigger, 180, 0, extraData)
		else
			EventService:ExecuteEvent(eventToTrigger, 60)
		end
	end)

	if not success then
		warn(string.format("[RitualService] Failed to trigger event '%s': %s", eventToTrigger, tostring(err)))
		pcall(function() EventService:StartEvent(eventToTrigger) end)
		pcall(function() EventService:ActivateEvent(eventToTrigger) end)
	end
end

local function finishRitual(id)
	local r = State.activeRituals[id]
	if not r then return end

	local conf = r.Config
	local present = {}
	for _, p in ipairs(r.Participants) do
		if p and p.Parent and p.Character then table.insert(present, p) end
	end

	if #present == 0 then
		if r.Type == "ChicleteiraBicicleteira" then
			removeChicleteiraVFX(r.Participants)
		end
		State.activeRituals[id] = nil
		return
	end

	local prize = conf.reward
	if conf.rareReward and math.random() < conf.rareChance then
		prize = conf.rareReward
	elseif conf.secretReward and math.random() < conf.secretChance then
		prize = conf.secretReward
	end

	local usedBrainrots = {}
	for _, player in ipairs(present) do
		table.insert(usedBrainrots, conf.animalNeeded)
		if r.Type == "ChicleteiraBicicleteira" then
			if StealService:IsStealing(player) then
				local stealData = StealService:GetStealData(player)
				if stealData then
					local victimChannel = Synchronizer:Get(stealData.VictimPlotUID)
					if victimChannel then
						victimChannel:Set(
							string.format("AnimalList.%d", stealData.PodiumIndex),
							"Empty"
						)
					end
				end
			end
		else
			removeUsedBrainrot(player, conf.animalNeeded)
		end
	end

	if r.Type == "ChicleteiraBicicleteira" then
		task.spawn(function()
			local spawnCFrames = captureParticipantSpawnCFrames(present)
			local extraData = { spawnCFrames = spawnCFrames }

			freezeParticipants(present)

			applyChicleteiraVFX(present)
			local soundEffect = ReplicatedStorage.Sounds.Events["Chicleteira Bicicleteira"].Activating
			SoundService:PlayAll(soundEffect)
			task.spawn(triggerRitualEvent, r.Type, present, extraData)

			local bikePathLength = 383
			local bikeSpeed = 35
			local bikeTravelTime = bikePathLength / bikeSpeed

			task.delay(3, function()
				unfreezeParticipants(present)
				removeChicleteiraVFX(present)

				for _, player in ipairs(present) do
					if StealService:IsStealing(player) then
						StealService:CancelSteal(player)
					end
				end
			end)

			local eventFolder = workspace:FindFirstChild("Events")
				and workspace.Events:FindFirstChild("Chicleteira Bicicleteira")

			if eventFolder then
				for _, child in ipairs(eventFolder:GetChildren()) do
					if child:IsA("Model") then
						for _, desc in ipairs(child:GetDescendants()) do
							if desc:IsA("ProximityPrompt") then
								desc.Enabled = false
							end
						end
					end
				end

				local bikeAddedConnection
				bikeAddedConnection = eventFolder.ChildAdded:Connect(function(child)
					if child:IsA("Model") then
						task.wait()
						for _, desc in ipairs(child:GetDescendants()) do
							if desc:IsA("ProximityPrompt") then
								desc.Enabled = false
							end
						end
					end
				end)

				task.delay(bikeTravelTime + 5, function()
					if bikeAddedConnection then
						bikeAddedConnection:Disconnect()
					end
				end)
			end

			task.wait(3 + bikeTravelTime)

			local animalData = Animals[prize]
			if animalData then
				for i = 1, conf.count do
					if conf.conveyor and workspace:FindFirstChild("ConveyorTarget") then
						AnimalService.spawnAnimalCustom(animalData, nil, nil, nil, {
							Start = workspace.Road.Start,
							End = workspace.ConveyorTarget,
							Owner = nil
						}, 2)
					else
						AnimalService.SpawnForcedAnimal(animalData)
					end
					if i < conf.count then task.wait(0.5) end
				end
			end

			RitualCompleteRemote:FireAllClients(id, r.Type, prize, usedBrainrots)
			for _, p in ipairs(r.Participants) do State.busyPlayers[p.UserId] = nil end
			State.activeRituals[id] = nil
		end)

		return
	end

	local extraData = nil
	if conf.passRitualPosition then
		local center = getRitualCenterPosition(present)
		local treeCount = Config.MATTEO_TREE_POSITIONS_COUNT
		local spread = Config.MATTEO_TREE_SPREAD
		local treePositions = buildMatteoTreePositions(center, treeCount, spread)
		extraData = {
			ritualCenter = center,
			treePositions = treePositions,
		}
	end

	task.spawn(triggerRitualEvent, r.Type, present, extraData)

	local animalData = Animals[prize]
	if animalData then
		for i = 1, conf.count do
			if conf.conveyor and workspace:FindFirstChild("ConveyorTarget") then
				AnimalService.spawnAnimalCustom(animalData, nil, nil, nil, {
					Start = workspace.Road.Start,
					End = workspace.ConveyorTarget,
					Owner = nil
				}, 2)
			else
				AnimalService.SpawnForcedAnimal(animalData)
			end
			if i < conf.count then task.wait(0.5) end
		end
	end

	RitualCompleteRemote:FireAllClients(id, r.Type, prize, usedBrainrots)
	for _, p in ipairs(r.Participants) do State.busyPlayers[p.UserId] = nil end
	State.activeRituals[id] = nil
end

local function startRitual(rType, group)
	local conf = rituals[rType]
	if not conf or (State.cooldowns[rType] and os.time() - State.cooldowns[rType] < Config.RITUAL_COOLDOWN) then
		return false
	end

	if conf.needsEvent and not ReplicatedStorage:GetAttribute("SpecialEventActive") then
		return false
	end

	State.cooldowns[rType] = os.time()
	local id = HttpService:GenerateGUID(false)

	for _, p in ipairs(group) do State.busyPlayers[p.UserId] = id end

	State.activeRituals[id] = {
		Type = rType,
		Participants = group,
		Config = conf
	}

	RitualStartRemote:FireAllClients(id, rType, group)

	if rType == "DulDulDul" and conf.buildPhase then
		ReplicatedStorage:SetAttribute("DulDulDulConstructionStart", workspace:GetServerTimeNow())
	end

	task.delay(conf.wait or 3, function()
		finishRitual(id)
	end)

	return true
end


local function ritualTick()
	local plys = Players:GetPlayers()

	for rName, conf in pairs(rituals) do
		if State.cooldowns[rName] and os.time() - State.cooldowns[rName] < Config.RITUAL_COOLDOWN then
			continue
		end

		local viable = {}
		for _, p in ipairs(plys) do
			if State.busyPlayers[p.UserId] then continue end

			if rName == "ChicleteiraBicicleteira" then
				if StealService:IsStealing(p) then
					local stealData = StealService:GetStealData(p)
					if stealData and stealData.StolenAnimalData
						and stealData.StolenAnimalData.Index == conf.animalNeeded then
						table.insert(viable, p)
					end
				end
			else
				local chan = Synchronizer:Get(p)
				if chan then
					local pods = chan:Get("AnimalPodiums")
					if pods then
						for _, d in pairs(pods) do
							if type(d) == "table" and d.Index == conf.animalNeeded then
								table.insert(viable, p)
								break
							end
						end
					end
				end
			end
		end

		if #viable >= conf.playersNeeded then
			local function search(list, count, current, start)
				if #current == count then
					if checkPos(rName, current) and hasAnimal(rName, current) then
						return current
					end
					return nil
				end
				for i = start, #list do
					table.insert(current, list[i])
					local found = search(list, count, current, i + 1)
					if found then return found end
					table.remove(current)
				end
			end

			local match = search(viable, conf.playersNeeded, {}, 1)
			if match then
				task.spawn(startRitual, rName, match)
			end
		end
	end
end

local function updateLoop()
	ritualTick()
end



function RitualService:Start()
	if State.heartbeatConnection then
		State.heartbeatConnection:Disconnect()
	end

	State.heartbeatConnection = RunService.Heartbeat:Connect(updateLoop)

	local ritualCount = 0
	for _ in pairs(rituals) do ritualCount += 1 end
	Players.PlayerRemoving:Connect(function(ply)
		local id = State.busyPlayers[ply.UserId]
		if id and State.activeRituals[id] then
			local r = State.activeRituals[id]
			if r and r.Type == "ChicleteiraBicicleteira" then
				removeChicleteiraVFX(r.Participants)
				unfreezeParticipants(r.Participants)
			end
			State.activeRituals[id] = nil
		end
		State.busyPlayers[ply.UserId] = nil
	end)
end

function RitualService:Stop()
	if State.heartbeatConnection then
		State.heartbeatConnection:Disconnect()
		State.heartbeatConnection = nil
	end
end

function RitualService:ActivateSpecialEvent(time)
	ReplicatedStorage:SetAttribute("SpecialEventActive", true)
	ChatService:SendMessage('<rainbow>[SERVER] 1x1x1x1 RITUAL ENABLED</rainbow>')
	task.delay(time or 600, function()
		ReplicatedStorage:SetAttribute("SpecialEventActive", false)
		ChatService:SendMessage('[SERVER] Event over')
	end)
end

function RitualService:ResetCooldown(rType)
	State.cooldowns[rType] = nil
end

function RitualService:ForceRitual(rType, plys)
	local success = startRitual(rType, plys)
	return success
end

function RitualService:GetState()
	local activeCount = 0
	for _ in pairs(State.activeRituals) do activeCount += 1 end
	local busyCount = 0
	for _ in pairs(State.busyPlayers) do busyCount += 1 end
	return {
		activeRituals = activeCount,
		cooldowns = State.cooldowns,
		busyPlayers = busyCount,
		rituals = rituals
	}
end

function RitualService:GetRitualConfig(rType)
	return rituals[rType]
end

function RitualService:GetRitualList()
	local list = {}
	for name, conf in pairs(rituals) do
		table.insert(list, {
			name = name,
			playersNeeded = conf.playersNeeded,
			animalNeeded = conf.animalNeeded,
			reward = conf.reward,
			onCooldown = State.cooldowns[name] ~= nil
				and (os.time() - State.cooldowns[name] < Config.RITUAL_COOLDOWN),
			cooldownRemaining = State.cooldowns[name]
				and math.max(0, Config.RITUAL_COOLDOWN - (os.time() - State.cooldowns[name]))
				or 0,
		})
	end
	table.sort(list, function(a, b) return a.name < b.name end)
	return list
end

return RitualService