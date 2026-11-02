--!strict

--[[ 

	This contains the shared command view/unlock rules, the single source of truth 
	for both the Commands page and the cmdbar so the two can never drift on what a
	user may see, what's faded behind an unlock, and what prompting an unlock does

]]


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local RoleLockRules = require(frontend.Config.RoleLockRules)
local pickRoleGiver = require(modules.CommandUtil.pickRoleGiver)
local promptPurchaseAsync = require(modules.AssetUtil.promptPurchaseAsync)
local isInternalRole = require(modules.RoleUtil.isInternalRole)
local ClientGroupJoin = require(modules.Parent.Controllers.ClientGroupJoin)
local CommandAccess = {}


-- TYPES
export type CommandLike = {
	key: string,
	name: string,
	roles: { string }?,
	primaryRole: string?,
}
export type RunState = {
	usable: boolean,
	unlockState: string?,
	unlockRoleKey: string?,
}


-- LOCAL FUNCTIONS
local function ownedSet(youMember: any): { [string]: true }
	local set = {}
	if typeof(youMember) == "table" and typeof((youMember :: any).roleKeys) == "table" then
		for _, roleKey in (youMember :: any).roleKeys :: { string } do
			set[roleKey] = true
		end
	end
	return set
end


-- FUNCTIONS
-- The best prompt-able giver on a role (GamePass > Asset > Bundle > Group > nil)
function CommandAccess.bestGiverForRole(role: any): any
	if typeof(role) ~= "table" then
		return nil
	end
	return pickRoleGiver((role :: any).giveToProducts, (role :: any).giveToGroups)
end

-- "unlocked" when you own the role, "unlock" when it's behind a buyable giver, else nil
function CommandAccess.unlockStateForRole(youMember: any, roleInfo: any, roleKey: string): string?
	if roleKey == "" then
		return nil
	end
	if ownedSet(youMember)[roleKey] then
		return "unlocked"
	end
	if typeof(roleInfo) ~= "table" then
		return nil
	end
	return if CommandAccess.bestGiverForRole((roleInfo :: any)[roleKey]) then "unlock" else nil
end

function CommandAccess.promptUnlock(roleInfo: any, roleKey: string)
	if typeof(roleInfo) ~= "table" then
		return
	end
	local giver = CommandAccess.bestGiverForRole((roleInfo :: any)[roleKey])
	if not giver then
		return
	end
	if giver.kind == "Group" then
		ClientGroupJoin.promptAndVerify(giver.groupId)
	else
		task.spawn(promptPurchaseAsync, giver.id, nil, giver.infoType)
	end
end

-- Can this user see commands they can't use, buy or unlock?
function CommandAccess.mayViewAll(youMember: any, roleInfo: any): boolean
	if typeof(roleInfo) ~= "table" or typeof(youMember) ~= "table" then
		return false
	end
	local myRoleKeys = (youMember :: any).roleKeys
	if typeof(myRoleKeys) ~= "table" then
		return false
	end
	for _, roleKey in myRoleKeys :: { string } do
		local role = (roleInfo :: any)[roleKey]
		if typeof(role) == "table" and RoleLockRules.isEffectivelyEnabledOnRole(role, "mayViewUnavailableCommands") then
			return true
		end
	end
	return false
end

local function isInternalOnly(command: any, roleInfo: any): boolean
	local cmdRoles = (command :: any).roles
	if typeof(cmdRoles) ~= "table" or #(cmdRoles :: { any }) == 0 then
		return false
	end
	for _, cmdRoleKey in cmdRoles :: { string } do
		if not isInternalRole((roleInfo :: any)[cmdRoleKey]) then
			return false
		end
	end
	return true
end

-- Runnable or unlockable commands, everything when mayViewAll, never internal-only ones
function CommandAccess.buildViewable(commands: any, youMember: any, roleInfo: any): { any }
	if typeof(commands) ~= "table" then
		return {}
	end
	if typeof(youMember) ~= "table" or typeof(roleInfo) ~= "table" then
		return {}
	end

	local base = {}
	for _, command in commands :: { any } do
		if not isInternalOnly(command, roleInfo) then
			table.insert(base, command)
		end
	end
	if CommandAccess.mayViewAll(youMember, roleInfo) then
		return base
	end

	local owned = ownedSet(youMember)
	-- Internal roles are skipped so a buyable internal role never pulls its command into view
	local unlockable: { [string]: true } = {}
	for roleKey, role in (roleInfo :: any) :: { [string]: any } do
		if typeof(roleKey) ~= "string" or isInternalRole(role) then
			continue
		end
		if CommandAccess.bestGiverForRole(role) then
			unlockable[roleKey] = true
		end
	end

	local out = {}
	for _, command in base do
		local cmdRoles = (command :: any).roles
		if typeof(cmdRoles) ~= "table" then
			continue
		end
		for _, cmdRoleKey in cmdRoles :: { string } do
			if owned[cmdRoleKey] or unlockable[cmdRoleKey] then
				table.insert(out, command)
				break
			end
		end
	end
	return out
end

function CommandAccess.runState(command: any, youMember: any, roleInfo: any): RunState
	local state: RunState = { usable = false, unlockState = nil, unlockRoleKey = nil }
	if typeof(command) ~= "table" then
		return state
	end
	local cmdRoles = (command :: any).roles
	if typeof(cmdRoles) ~= "table" then
		return state
	end

	local owned = ownedSet(youMember)
	for _, cmdRoleKey in cmdRoles :: { string } do
		if owned[cmdRoleKey] then
			state.usable = true
			return state
		end
	end

	if typeof(roleInfo) == "table" then
		for _, cmdRoleKey in cmdRoles :: { string } do
			local role = (roleInfo :: any)[cmdRoleKey]
			if not isInternalRole(role) and CommandAccess.bestGiverForRole(role) then
				state.unlockState = "unlock"
				state.unlockRoleKey = cmdRoleKey
				return state
			end
		end
	end
	return state
end


return CommandAccess
