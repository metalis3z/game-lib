--!strict
--[[

	We frequently add new commands to HD Admin, and although these get grouped under the most
	appropriate pack (therefore roles), developers have often asked for a second-say in what
	commands get added to their experience. This is where the Vet Commands section comes in handy

]]


-- LOCAL
local Vetting = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local User = require(modules.Objects.User)
local Remote = require(modules.Objects.Remote)
local statuses: {[string]: string} = {}
local unackedSet: {[string]: true} = {}


-- LOCAL FUNCTIONS
local function statusOf(entry: any): string?
	if entry == true then
		return "approved"
	end
	if typeof(entry) == "table" and typeof((entry :: any).status) == "string" then
		local status = (entry :: any).status
		return if status == "rejected" then "disabled" else status
	end
	return nil
end

local function getGameUser(): any?
	local success, gameUser = User.getUserAsync("Game")
	if not success then
		return nil
	end
	return gameUser
end

local function canVet(callerUser: any): boolean
	local Roles = require(modules.Parent.Services.Roles) :: any
	return Roles.hasPermission(callerUser, "mayVetCommands") or Roles.hasPermission(callerUser, "permitAll")
end


-- FUNCTIONS
function Vetting.getStatus(identity: string): string?
	return statuses[identity]
end
function Vetting.getCounts(): (number, number)
	local Commands = require(modules.Parent.Services.Commands) :: any
	local pending, unacked = 0, 0
	for identity, status in statuses do
		if status == "pending" and Commands.getCommandByIdentity(identity) ~= nil then
			pending += 1
		end
	end
	for identity in unackedSet do
		if Commands.getCommandByIdentity(identity) ~= nil then
			unacked += 1
		end
	end
	return pending, unacked
end

function Vetting.refresh()
	local gameUser = getGameUser()
	if not gameUser then
		return
	end
	local record = gameUser.perm:get("VettedCommands")
	local newStatuses: {[string]: string} = {}
	if typeof(record) == "table" then
		for identity, entry in record :: {[string]: any} do
			local status = statusOf(entry)
			if typeof(identity) == "string" and status then
				newStatuses[identity] = status
			end
		end
	end
	statuses = newStatuses
	local unacked = gameUser.perm:get("VetUnacked")
	local newUnackedSet: {[string]: true} = {}
	local unackedTotal = 0
	if typeof(unacked) == "table" then
		for identity in unacked :: {[string]: any} do
			if typeof(identity) == "string" then
				newUnackedSet[identity] = true
				unackedTotal += 1
			end
		end
	end
	unackedSet = newUnackedSet
	User.everyone:set("CommandVetting", {states = statuses, unacked = unackedTotal, unackedKeys = newUnackedSet})
end

function Vetting.syncCatalogAsync()
	local gameUser = getGameUser()
	local Commands = require(modules.Parent.Services.Commands) :: any
	local commandsArray = Commands.getCommandsArray()
	if not gameUser or typeof(commandsArray) ~= "table" then
		return
	end
	local record = gameUser.perm:get("VettedCommands")
	if typeof(record) ~= "table" then
		record = {}
	end
	local Config = require(modules.Parent.Services.Config) :: any
	local autoApprove = Config.getSetting("AutoApproveNewCommands") ~= false
	local isBaseline = next(record :: any) == nil
	local isVettable = require(modules.CommandUtil.isVettable)
	for _, command in commandsArray :: {any} do
		if not isVettable(command) then
			continue
		end
		local identity = (command :: any).identity
		if typeof(identity) ~= "string" or (record :: any)[identity] ~= nil then
			continue
		end
		-- Custom commands are the dev's own code, so they arrive approved and
		-- never join the pending queue or the notice
		local fromInternal = (command :: any).fromInternal == true
		if not fromInternal or isBaseline or autoApprove then
			gameUser.perm:set({"VettedCommands", identity}, true)
		else
			gameUser.perm:set({"VettedCommands", identity}, {status = "pending", at = os.time()})
		end
		if fromInternal and not isBaseline then
			gameUser.perm:set({"VetUnacked", identity}, true)
		end
	end
	Vetting.refresh()
end

function Vetting.applyDecisions(callerUser: any, decisions: {[string]: any}): (boolean, string?)
	if not canVet(callerUser) then
		return false, "You don't have permission to vet commands"
	end
	local gameUser = getGameUser()
	if not gameUser then
		return false, "Game user not loaded"
	end
	local record = gameUser.perm:get("VettedCommands")
	if typeof(record) ~= "table" or next(record :: any) == nil then
		Vetting.syncCatalogAsync()
		record = gameUser.perm:get("VettedCommands")
	end
	if typeof(record) ~= "table" then
		return false, "Vetting record not loaded"
	end
	local total = 0
	for identity, decision in decisions do
		if typeof(identity) ~= "string" or #identity > 60 then
			continue
		end
		if decision ~= "approved" and decision ~= "disabled" then
			continue
		end
		if (record :: any)[identity] == nil then
			continue
		end
		total += 1
		if total > 500 then
			break
		end
		gameUser.perm:set({"VettedCommands", identity}, {status = decision, by = callerUser.userId, at = os.time()})
	end
	if total == 0 then
		return false, "Nothing could be saved. The vetting ledger hasn't loaded"
	end
	Vetting.refresh()
	return true
end

-- Flipping Auto Approve New on approves everything in the queue
function Vetting.approveAllPending(): number
	local gameUser = getGameUser()
	if not gameUser then
		return 0
	end
	local record = gameUser.perm:get("VettedCommands")
	if typeof(record) ~= "table" then
		return 0
	end
	local approved = 0
	for identity, entry in record :: {[string]: any} do
		if statusOf(entry) == "pending" then
			gameUser.perm:set({"VettedCommands", identity}, true)
			approved += 1
		end
	end
	if approved > 0 then
		Vetting.refresh()
	end
	return approved
end

-- Opening the vet view clears the 'new commands' notice everywhere
function Vetting.acknowledge(callerUser: any): boolean
	if not canVet(callerUser) then
		return false
	end
	local gameUser = getGameUser()
	if not gameUser then
		return false
	end
	gameUser.perm:set({"VetUnacked"}, {})
	Vetting.refresh()
	return true
end


-- SETUP
Remote.new("VetCommands", "Function", "Low"):onServerInvoke(function(player: Player, decisions: unknown): (boolean, string?)
	local callerUser = User.getUser(player)
	if not callerUser then
		return false, "User not loaded"
	end
	if typeof(decisions) ~= "table" then
		return false, "Invalid decisions"
	end
	local isWithinMaxSize = require(modules.VerifyUtil.isWithinMaxSize)
	if not isWithinMaxSize(decisions, 16384) then
		return false, "Decisions table is too large"
	end
	return Vetting.applyDecisions(callerUser, decisions :: any)
end)

Remote.new("AcknowledgeVetting", "Function", "Low"):onServerInvoke(function(player: Player): boolean
	local callerUser = User.getUser(player)
	if not callerUser then
		return false
	end
	return Vetting.acknowledge(callerUser)
end)

task.defer(function()
	Vetting.syncCatalogAsync()
	local gameUser = getGameUser()
	if not gameUser then
		return
	end
	local function readAutoApprove(): boolean
		return gameUser.perm:get({"Settings", "SystemSettings", "AutoApproveNewCommands"}) ~= false
	end
	local lastAutoApprove = readAutoApprove()
	gameUser.perm:onChange("Settings", function()
		local autoApprove = readAutoApprove()
		if autoApprove == lastAutoApprove then
			return
		end
		lastAutoApprove = autoApprove
		if autoApprove then
			Vetting.approveAllPending()
		end
	end)
end)


return Vetting
