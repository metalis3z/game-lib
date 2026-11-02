local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Timer = require(ReplicatedStorage.Packages.Timer)

local SPEED_SHOP_CHANNEL_ID = "BackroomsSpeedShop"
local TIMER_INTERVAL = 0.05

local GrabRemote = Net:RemoteEvent("WorldBrainrotService/Grab")
local DropRemote = Net:RemoteEvent("WorldBrainrotService/Drop")

local WorldBrainrotService = {}
local pools = {}

local brainrotRemovedEvent = Instance.new("BindableEvent")
WorldBrainrotService.OnBrainrotRemoved = brainrotRemovedEvent.Event
local timerStates = {}

local mainTimer = nil
local lastTickTime = 0

local poolsRoot = Workspace:FindFirstChild("WBPools")
if not poolsRoot then
	poolsRoot = Instance.new("Folder")
	poolsRoot.Name = "WBPools"
	poolsRoot.Parent = Workspace
end

local function toSafeName(poolId)
	return poolId:gsub("[/\\%s]", "_")
end

local function getPoolFolder(poolId)
	return poolsRoot:FindFirstChild(toSafeName(poolId))
end

local function getBrainrotPart(poolId, brainrotId)
	local folder = getPoolFolder(poolId)
	return folder and folder:FindFirstChild(brainrotId)
end

local function encodeTraits(traits)
	if not traits or #traits == 0 then return "" end
	local ok, result = pcall(HttpService.JSONEncode, HttpService, traits)
	return ok and result or ""
end

function WorldBrainrotService:CreatePool(poolId)
	if pools[poolId] then return end
	pools[poolId] = {}
	local folder = Instance.new("Folder")
	folder.Name = toSafeName(poolId)
	folder:SetAttribute("PoolId", poolId)
	folder.Parent = poolsRoot
end

function WorldBrainrotService:DestroyPool(poolId)
	local folder = getPoolFolder(poolId)
	if folder then
		for _, part in ipairs(folder:GetChildren()) do
			if part:IsA("Part") then
				timerStates[part] = nil
			end
		end
		folder:Destroy()
	end
	pools[poolId] = nil
end

function WorldBrainrotService:SpawnBrainrot(poolId, data)
	local folder = getPoolFolder(poolId)
	if not folder then return nil end
	if not pools[poolId] then pools[poolId] = {} end

	local id = data.id or HttpService:GenerateGUID(false)
	local cf = data.cframe or CFrame.new(0, 0, 0)
	local bdt = data.despawnTimer or 60
	local btim = data.timer ~= nil and data.timer or -1
	local fakemode = nil
	local rawFakeMode = data.FakeMode
	if rawFakeMode == "Grab" or rawFakeMode == "Purchase" or rawFakeMode == "Base" then
		fakemode = rawFakeMode
	end
	local part = Instance.new("Part")
	part.Name = id
	part.Size = Vector3.new(1, 1, 1)
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.Transparency = 1
	part.CFrame = cf

	part:SetAttribute("BName", data.brainrot or "")
	part:SetAttribute("BCF", cf)
	part:SetAttribute("BG", 0)
	part:SetAttribute("BMut", data.mutation or "")
	part:SetAttribute("BTr", encodeTraits(data.traits))
	part:SetAttribute("BDT", bdt)
	part:SetAttribute("BTim", btim)
	part:SetAttribute("BCaged", data.caged == true)
	part:SetAttribute("BRLOS", data.requiresLineOfSight == true)
	part:SetAttribute("BDelivered", 0)
	part:AddTag("WorldBrainrot")
	if data.customPrice ~= nil then
		part:SetAttribute("BCustomPrice", data.customPrice)
	end
	if data.customRarity and data.customRarity ~= "" then
		part:SetAttribute("BCustomRarity", data.customRarity)
	end
	if data.customGeneration ~= nil then
		part:SetAttribute("BCustomGeneration", data.customGeneration)
	end
	if fakemode == "Grab" or fakemode == "Purchase" or fakemode == "Base" then
		part:SetAttribute("FakeMode", fakemode)
	end

	part.Parent = folder
	pools[poolId][id] = true

	timerStates[part] = {
		poolId       = poolId,
		bdt          = bdt,
		btim         = btim,
		lastBDT      = nil,
		lastBDTDisplay = nil,
		lastBTim     = nil,
	}

	return id
end

function WorldBrainrotService:RemoveBrainrot(poolId, brainrotId)
	local part = getBrainrotPart(poolId, brainrotId)
	local existed = part ~= nil
	if part then
		timerStates[part] = nil
		part:Destroy()
	end
	if pools[poolId] then pools[poolId][brainrotId] = nil end
	if existed then
		brainrotRemovedEvent:Fire(poolId, brainrotId)
	end
end

function WorldBrainrotService:SetBrainrotAttribute(poolId, brainrotId, key, value)
	local part = getBrainrotPart(poolId, brainrotId)
	if part then part:SetAttribute(key, value) end
end

function WorldBrainrotService:UpdateCFrame(poolId, brainrotId, cf)
	local part = getBrainrotPart(poolId, brainrotId)
	if not part then return end
	part:SetAttribute("BCF", cf)
	part.CFrame = cf
end

function WorldBrainrotService:SetCaged(poolId, brainrotId, caged)
	local part = getBrainrotPart(poolId, brainrotId)
	if part then part:SetAttribute("BCaged", caged) end
end

function WorldBrainrotService:SetDespawnTimer(poolId, brainrotId, value)
	local part = getBrainrotPart(poolId, brainrotId)
	if part then
		part:SetAttribute("BDT", value)
		local state = timerStates[part]
		if state then
			state.bdt = value
			state.lastBDT = nil
			state.lastBDTDisplay = nil
		end
	end
end


function WorldBrainrotService:SetCustomPrice(poolId, brainrotId, price)
	local part = getBrainrotPart(poolId, brainrotId)
	if part then
		part:SetAttribute("BCustomPrice", price ~= nil and price or nil)
	end
end

function WorldBrainrotService:SetCustomRarity(poolId, brainrotId, rarity)
	local part = getBrainrotPart(poolId, brainrotId)
	if part then
		part:SetAttribute("BCustomRarity", (rarity and rarity ~= "") and rarity or nil)
	end
end

function WorldBrainrotService:SetCustomGeneration(poolId, brainrotId, generation)
	local part = getBrainrotPart(poolId, brainrotId)
	if part then
		part:SetAttribute("BCustomGeneration", generation ~= nil and generation or nil)
	end
end

function WorldBrainrotService:BrainrotExists(poolId, brainrotId)
	return getBrainrotPart(poolId, brainrotId) ~= nil
end

function WorldBrainrotService:GetPoolBrainrots(poolId)
	local folder = getPoolFolder(poolId)
	if not folder then return {} end
	local result = {}
	for _, p in ipairs(folder:GetChildren()) do
		if p:IsA("Part") then table.insert(result, p.Name) end
	end
	return result
end

function WorldBrainrotService:Start()
	local AnimalsData = require(ReplicatedStorage.Datas.Animals)
	local StealService = require(ServerScriptService.Services.StealService)

	GrabRemote.OnServerEvent:Connect(function(player, poolId, brainrotId)
		if typeof(poolId) ~= "string" or typeof(brainrotId) ~= "string" then return end

		local part = getBrainrotPart(poolId, brainrotId)
		if not part then return end
		if part:GetAttribute("BG") ~= 0 then return end
		if part:GetAttribute("BCaged") then return end

		local char = player.Character
		if not char or not char.PrimaryPart then return end
		local cf = part:GetAttribute("BCF")
		if cf and (char.PrimaryPart.Position - cf.Position).Magnitude > 30 then return end

		local eggName = part:GetAttribute("BName")
		local eggData = eggName and AnimalsData[eggName]

		local fakeModeAttr = part:GetAttribute("FakeMode")
		if fakeModeAttr == "Grab" then
			local vfxPosition = cf and cf.Position + Vector3.new(0, 1, 0) or Vector3.new(0, 0, 0)
			pcall(function()
				Net:RemoteEvent("SpawnFakeBrainrot/Poof"):FireAllClients({Position = vfxPosition})
			end)
			pcall(function()
				Net:RemoteEvent("SpawnFakeBrainrot/Camera"):FireClient(player, nil, nil)
			end)
			timerStates[part] = nil
			if pools[poolId] then pools[poolId][brainrotId] = nil end
			part:Destroy()
			brainrotRemovedEvent:Fire(poolId, brainrotId)
			return
		end

		if eggName == "Gold Egg" then
			part:SetAttribute("BG", player.UserId)
			return
		end

		if not eggData then return end
		if StealService:IsGrabbingEgg(player) then return end
		if StealService:IsStealing(player) then return end

		local savedBDT = part:GetAttribute("BDT") or 60
		part:SetAttribute("BG", player.UserId)

		local speedBonus = 0
		if poolId == "Backrooms/Brainrots" then
			local speedChannel = Synchronizer:Get(SPEED_SHOP_CHANNEL_ID)
			if speedChannel then
				speedBonus = tonumber((speedChannel:Get(tostring(player.UserId)))) or 0
			end
		end

		local success = StealService:SimulateEggGrab(player, eggName, poolId, brainrotId, savedBDT, speedBonus)
		if not success then
			part:SetAttribute("BG", 0)
		end
	end)

	DropRemote.OnServerEvent:Connect(function(player, poolId)
		if typeof(poolId) ~= "string" then return end
		StealService:CancelEggGrab(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		StealService:CancelEggGrab(player)
	end)

	mainTimer = Timer.new(TIMER_INTERVAL)
	mainTimer.UpdateSignal = RunService.Heartbeat
	mainTimer.TimeFunction = time
	mainTimer.AllowDrift = false

	lastTickTime = time()

	mainTimer.Tick:Connect(function()
		local currentTime = time()
		local dt = currentTime - lastTickTime
		lastTickTime = currentTime

		for part, state in pairs(timerStates) do
			if not part.Parent then
				local poolId = state.poolId
				local brainrotId = part.Name
				timerStates[part] = nil
				if pools[poolId] then pools[poolId][brainrotId] = nil end
				brainrotRemovedEvent:Fire(poolId, brainrotId)
				continue
			end

			if state.bdt > 0 and (part:GetAttribute("BG") or 0) == 0 then
				state.bdt = state.bdt - dt
				if state.bdt <= 0 then
					local poolId = state.poolId
					local brainrotId = part.Name
					timerStates[part] = nil
					if pools[poolId] then pools[poolId][brainrotId] = nil end
					part:Destroy()
					brainrotRemovedEvent:Fire(poolId, brainrotId)
				else
					local intBDT = math.floor(state.bdt)
					if intBDT ~= state.lastBDT then
						part:SetAttribute("BDT", intBDT)
						state.lastBDT = intBDT
					end
					local rounded = math.max(10, math.ceil(state.bdt / 10) * 10)
					if rounded ~= state.lastBDTDisplay then
						part:SetAttribute("BDTDisplay", rounded)
						state.lastBDTDisplay = rounded
					end
				end
			end

			if state.btim >= 0 then
				state.btim = state.btim - dt
				local intBTim = math.max(0, math.floor(state.btim))
				if intBTim ~= state.lastBTim then
					part:SetAttribute("BTim", intBTim)
					state.lastBTim = intBTim
				end
			end
		end
	end)

	mainTimer:Start()
end

function WorldBrainrotService:Stop()
	if mainTimer then
		mainTimer:Destroy()
		mainTimer = nil
	end
end

return WorldBrainrotService