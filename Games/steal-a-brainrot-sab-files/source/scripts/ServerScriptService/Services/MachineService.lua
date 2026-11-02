
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MemoryStoreService  = game:GetService("MemoryStoreService")

local Services            = ServerScriptService:WaitForChild("Services")

local Net                 = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"))
local NotificationService = require(Services:WaitForChild("NotificationService"))
local MessagingService    = require(Services:WaitForChild("MessagingService"))

local MachineService = {}

local Machines = {
	["Divine Fuse"] = {
		pivot   = CFrame.new(-381.752, -9.5, 72.653) * CFrame.Angles(0, math.rad(180), 0),
		farAway = CFrame.new(0, 5000, 0),
		color   = "#FFD700",
		path    = function() return workspace:FindFirstChild("FuseMachine") and workspace.FuseMachine:FindFirstChild("Models") and workspace.FuseMachine.Models:WaitForChild("Divine") end,
		group   = "primary",
		isFuse  = true,
	},
	["Normal Fuse"] = {
		pivot   = CFrame.new(-381.752, -9.5, 72.653) * CFrame.Angles(0, math.rad(180), 0),
		farAway = CFrame.new(0, 5100, 1000),
		color   = "#3171DF",
		path    = function() return workspace:FindFirstChild("FuseMachine") and workspace.FuseMachine:FindFirstChild("Models") and workspace.FuseMachine.Models:WaitForChild("Normal") end,
		group   = "primary",
		isFuse  = true,
	},
	["Summer Fuse"] = {
		pivot   = CFrame.new(-381.752, -9.5, 72.653) * CFrame.Angles(0, math.rad(180), 0),
		farAway = CFrame.new(0, 5100, 1000),
		color   = "#3171DF",
		path    = function() return workspace:FindFirstChild("FuseMachine") and workspace.FuseMachine:FindFirstChild("Models") and workspace.FuseMachine.Models:WaitForChild("Summer") end,
		group   = "primary",
		isFuse  = true,
	},
	["Santa Fuse"] = {
		pivot   = CFrame.new(-381.752, -7.5, 72.653) * CFrame.Angles(0, math.rad(90), 0),
		farAway = CFrame.new(0, 5100, 1000),
		color   = "#FF0000",
		path    = function() return workspace:FindFirstChild("FuseMachine") and workspace.FuseMachine:FindFirstChild("Models") and workspace.FuseMachine.Models:WaitForChild("Santa") end,
		group   = "primary",
		isFuse  = true,
	},
	["Witch Fuse"] = {
		pivot       = CFrame.new(-378.676, -4.063, 63.714) * CFrame.Angles(0, math.rad(90), 0),
		farAway     = CFrame.new(0, 5150, 500),
		color       = "#9B59B6",
		path        = function() return workspace:FindFirstChild("Witch Fuse") end,
		group       = "primary",
		isFuse      = true,
		noRootPivot = true,
	},
	["Cyber Craft"] = {
		pivot   = CFrame.new(-382.99, -0.815, 68.78),
		farAway = CFrame.new(0, 5200, 0),
		color   = "#79dbff",
		path    = function() return workspace:WaitForChild("CraftingMachine") end,
		group   = "primary",
		isCraft = true,
		crafttype = "Cyber",
	},
	["OG Craft"] = {
		useCurrentPivot = true,
		pivot   = CFrame.new(-382.178, -4.66, 76.293),
		farAway = CFrame.new(0, 5200, 0),
		color   = "#FF82C8",
		path    = function()
			local direct = workspace:FindFirstChild("OG CraftingMachine")
			if direct then return direct end
			local folder = workspace:FindFirstChild("Og craft machine")
			return folder and folder:FindFirstChild("OG CraftingMachine")
		end,
		group   = "primary",
		isCraft = true,
		crafttype = "OG",
	},
	["Brainrot Trader"] = {
		pivot   = CFrame.new(-382.487, -4.625, 70.426),
		farAway = CFrame.new(0, 5300, 0),
		color   = "#0074FF",
		path    = function() return workspace:WaitForChild("BrainrotTrader") end,
		group   = "primary",
	},
	["Cupid's Machine"] = {
		pivot   = CFrame.new(-442.862, -9.5, 86.739) * CFrame.Angles(0, math.rad(180), 0),
		farAway = CFrame.new(0, 5300, 0),
		color   = "#FFC0CB",
		path    = function() return workspace:WaitForChild("CupidsMachine") end,
		group   = "secondary",
	},
	["Santa Merchant"] = {
		pivot   = CFrame.new(-378.352, -5.516, -2.455) * CFrame.fromOrientation(0, math.rad(90), 0),
		farAway = CFrame.new(0, 5400, 0),
		color   = "#FF0000",
		path    = function() return workspace:WaitForChild("Santa Merchant") end,
		group   = "third",
	},
}

local DEFAULT_ACTIVE = {
	primary   = "Summer Fuse",
}

local MEMORY_HASH_NAME = "MachineService_GlobalActive"
local MEMORY_EXPIRY    = 60 * 60 * 24 * 30
local MS_TOPIC         = "MachineService/Replace"

local SERVER_ID        = game.JobId ~= "" and game.JobId
	or game:GetService("HttpService"):GenerateGUID(false)

local Paths              = {}
local lowerKeyMap        = {}
local ActiveMachines     = {}
local fuseMachineRoot
local FuseMachinePivot   = CFrame.new(-381.752, -9.5, 72.653) * CFrame.Angles(0, math.rad(180), 0)
local FuseMachineRootFar = CFrame.new(0, 5050, 0)

local started        = false
local globalHashMap
local msConnection

local function resolveKey(name)
	if type(name) ~= "string" then return nil end
	return lowerKeyMap[string.lower(name)]
end

local function formatMachineName(machineName)
	local config = Machines[machineName]
	if not config or not config.color then
		return machineName
	end

	local colorData = config.color

	if type(colorData) == "string" then
		return string.format('<font color="%s">%s</font>', colorData, machineName)
	elseif type(colorData) == "table" then
		local chars = {}
		local nameLen = #machineName
		local colorCount = #colorData

		for i = 1, nameLen do
			local char = machineName:sub(i, i)
			local colorIndex = math.floor((i - 1) / nameLen * colorCount) + 1
			colorIndex = math.clamp(colorIndex, 1, colorCount)
			local color = colorData[colorIndex]
			table.insert(chars, string.format('<font color="%s">%s</font>', color, char))
		end

		return table.concat(chars)
	end

	return machineName
end

local function hideMachine(machine, name)
	local config = Machines[name]
	if config then
		machine:PivotTo(config.farAway)
		machine:SetAttribute("Hidden", true)
		if config.isCraft then
			machine:SetAttribute("Crafttype", nil)
		end
	end
end

local function showMachine(machine, name)
	local config = Machines[name]
	if config then
		machine:PivotTo(config.pivot)
		machine:SetAttribute("Hidden", false)
		if config.isCraft then
			machine:SetAttribute("Crafttype", config.crafttype)
		end
	end
end

local function notifyCraftType(craftType)
	task.spawn(function()
		local module = Services:FindFirstChild("CraftingMachineService")
		if not module then return end
		local ok, svc = pcall(require, module)
		if ok and type(svc) == "table" and svc.SetCraftType then
			svc:SetCraftType(craftType)
		end
	end)
end

local function applyInitialState(activeByGroup)
	local rootFuseName
	for _, name in pairs(activeByGroup) do
		local config = Machines[name]
		if config and config.isFuse and not config.noRootPivot then
			rootFuseName = name
			break
		end
	end

	if fuseMachineRoot then
		if rootFuseName then
			fuseMachineRoot:PivotTo(FuseMachinePivot)
			fuseMachineRoot:SetAttribute("FuseType", string.split(rootFuseName, " ")[1])
		else
			fuseMachineRoot:PivotTo(FuseMachineRootFar)
			fuseMachineRoot:SetAttribute("FuseType", nil)
		end
	end

	local activeSet = {}
	for _, name in pairs(activeByGroup) do
		activeSet[name] = true
	end

	for name in pairs(Machines) do
		local machine = Paths[name]
		if machine and not activeSet[name] then
			hideMachine(machine, name)
		end
	end

	for group, name in pairs(activeByGroup) do
		local machine = Paths[name]
		if machine then
			showMachine(machine, name)
		end
		ActiveMachines[group] = name
	end

	for _, name in pairs(activeByGroup) do
		local cfg = Machines[name]
		if cfg and cfg.isCraft then
			notifyCraftType(cfg.crafttype)
			break
		end
	end
end

local function ReplaceMachine(player, MachineName, action)
	local canonical = resolveKey(MachineName)

	if not canonical then
		if player then
			NotificationService.Error(player, "Machine not found: " .. tostring(MachineName))
		end
		return
	end

	local config = Machines[canonical]
	action = string.lower(action)

	if action == "add" then
		local machineGroup = config.group
		local previousMachine = ActiveMachines[machineGroup]

		if previousMachine == canonical then
			return
		end

		if fuseMachineRoot then
			local fuseType = config.isFuse and string.split(canonical, " ")[1] or nil

			if config.isFuse then
				if not config.noRootPivot then
					fuseMachineRoot:PivotTo(FuseMachinePivot)
				else
					fuseMachineRoot:PivotTo(FuseMachineRootFar)
				end
				fuseMachineRoot:SetAttribute("FuseType", fuseType)

			elseif previousMachine and Machines[previousMachine] and Machines[previousMachine].isFuse and not Machines[previousMachine].noRootPivot then
				fuseMachineRoot:PivotTo(FuseMachineRootFar)
				fuseMachineRoot:SetAttribute("FuseType", nil)
			end
		end

		if previousMachine and previousMachine ~= canonical then
			local prevMachine = Paths[previousMachine]
			if prevMachine then
				hideMachine(prevMachine, previousMachine)
			end
		end

		local machine = Paths[canonical]
		if machine then
			showMachine(machine, canonical)
		end

		ActiveMachines[machineGroup] = canonical

		if config.isCraft then
			notifyCraftType(config.crafttype)
		end

		local formattedOld = previousMachine and formatMachineName(previousMachine) or "nothing"
		local formattedNew = formatMachineName(canonical)

		NotificationService.Broadcast(
			"Sammy Replaced " .. formattedOld .. " with " .. formattedNew,
			5,
			"Sounds.Sfx.Success"
		)

	elseif action == "remove" then
		local machine = Paths[canonical]
		if machine then
			hideMachine(machine, canonical)

			if config.isFuse and fuseMachineRoot then
				fuseMachineRoot:PivotTo(FuseMachineRootFar)
				fuseMachineRoot:SetAttribute("FuseType", nil)
			end

			local formattedName = formatMachineName(canonical)

			NotificationService.Broadcast(
				"Sammy Removed the " .. formattedName,
				5,
				"Sounds.Sfx.Success"
			)

			if ActiveMachines[config.group] == canonical then
				ActiveMachines[config.group] = nil
			end
		end

	else
		if player then
			NotificationService.Error(player, "Invalid action: " .. tostring(action))
		end
	end
end

local function onGlobalMessage(payload)
	if type(payload) ~= "table" then return end
	if payload.sender == SERVER_ID then return end

	if payload.action == "add" and type(payload.machineName) == "string" then
		local canonical = resolveKey(payload.machineName)
		if canonical then
			ReplaceMachine(nil, canonical, "add")
		end

	elseif payload.action == "restore" and type(payload.group) == "string" then
		local default = DEFAULT_ACTIVE[payload.group]
		if default then
			ReplaceMachine(nil, default, "add")
		else
			local current = ActiveMachines[payload.group]
			if current then
				ReplaceMachine(nil, current, "remove")
			end
		end
	end
end


function MachineService:ReplaceGlobalMachine(machineName)
	assert(started, "MachineService:Start() must be called before ReplaceGlobalMachine")

	local canonical = resolveKey(machineName)
	if not canonical then
		warn("[MachineService] ReplaceGlobalMachine: unknown machine '" .. tostring(machineName) .. "'")
		return false
	end

	local config = Machines[canonical]
	local group  = config.group

	local ok, err = pcall(function()
		globalHashMap:SetAsync(group, canonical, MEMORY_EXPIRY)
	end)
	if not ok then
		warn("[MachineService] MemoryStore SetAsync failed: " .. tostring(err))
	end

	ReplaceMachine(nil, canonical, "add")

	MessagingService:PublishAsync(MS_TOPIC, {
		sender      = SERVER_ID,
		action      = "add",
		machineName = canonical,
	})

	return true
end

function MachineService:RemoveGlobalMachine(machineName)
	assert(started, "MachineService:Start() must be called before RemoveGlobalMachine")

	local canonical = resolveKey(machineName)
	if not canonical then
		warn("[MachineService] RemoveGlobalMachine: unknown machine '" .. tostring(machineName) .. "'")
		return false
	end

	local config  = Machines[canonical]
	local group   = config.group
	local default = DEFAULT_ACTIVE[group]

	local ok, err = pcall(function()
		globalHashMap:RemoveAsync(group)
	end)
	if not ok then
		warn("[MachineService] MemoryStore RemoveAsync failed: " .. tostring(err))
	end

	if default then
		ReplaceMachine(nil, default, "add")
	else
		ReplaceMachine(nil, canonical, "remove")
	end

	MessagingService:PublishAsync(MS_TOPIC, {
		sender = SERVER_ID,
		action = "restore",
		group  = group,
	})

	return true
end

function MachineService:GetActiveMachine(group)
	return ActiveMachines[group]
end

function MachineService:Start()
	if started then return end
	started = true
	task.spawn(function()
		for name, config in pairs(Machines) do
			if type(config.path) == "function" then
				Paths[name] = config.path()
			else
				Paths[name] = config.path
			end
			lowerKeyMap[string.lower(name)] = name

			if config.useCurrentPivot and Paths[name] then
				local ok, currentPivot = pcall(function()
					return Paths[name]:GetPivot()
				end)
				if ok and currentPivot and currentPivot.Position.Y < 1000 then
					config.pivot = currentPivot
				end
			end
		end

		fuseMachineRoot = workspace:FindFirstChild("FuseMachine")

		globalHashMap = MemoryStoreService:GetHashMap(MEMORY_HASH_NAME)

		local allGroups = {}
		for _, machineConfig in pairs(Machines) do
			allGroups[machineConfig.group] = true
		end

		local activeByGroup = {}
		for group in pairs(allGroups) do
			local toApply = DEFAULT_ACTIVE[group]

			local ok, value = pcall(function()
				return globalHashMap:GetAsync(group)
			end)
			if ok then
				local resolved = resolveKey(value)
				if resolved then
					toApply = resolved
				end
			else
				warn("[MachineService] MemoryStore GetAsync failed for group '" .. group .. "': " .. tostring(value))
			end

			if toApply then
				activeByGroup[group] = toApply
			end
		end

		applyInitialState(activeByGroup)

		msConnection = MessagingService:SubscribeAsync(MS_TOPIC, onGlobalMessage)
	end)
end
local remote = Net:RemoteFunction("AdminService/SpawnMachine")
remote.OnServerInvoke = function(player, MachineName, action)
	return ReplaceMachine(player, MachineName, action)
end
return MachineService