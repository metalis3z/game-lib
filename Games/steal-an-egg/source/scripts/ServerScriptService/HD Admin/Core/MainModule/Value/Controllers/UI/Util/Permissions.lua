--!strict

--[[

	Client-side mirror of the server's Roles.canViewPage / canUseCommand,
	gathered from the replicated temp.YouMember.roleKeys + everyone.RoleInfo
	so the UI can hide / disable pages without a round-trip

--]]


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local RoleLockRules = require(modules.Parent.Controllers.UI.Config.RoleLockRules)
local isInternalRole = require(modules.RoleUtil.isInternalRole)
local ICON_LEVEL: {[string]: number} = {None = 0, Commands = 1, Menu = 2}
local ICON_MODE_BY_LEVEL: {[number]: string} = {[0] = "None", [1] = "Commands", [2] = "Menu"}


-- TYPES
type Scope = Fusion.Scope


-- HELPERS
local function anyRoleMatches(
	roleInfo: any,
	you: any,
	predicate: (role: any) -> boolean
): boolean
	if typeof(you) ~= "table" or typeof(roleInfo) ~= "table" then return false end
	local keys: any = (you :: any).roleKeys
	if typeof(keys) ~= "table" then return false end
	for _, key in keys :: {string} do
		local role: any = (roleInfo :: any)[key]
		if typeof(role) == "table" and predicate(role) then
			return true
		end
	end
	return false
end


-- FUNCTIONS
local Permissions = {}

-- While false, perm predicates treat "still loading" as denied, so pages should
-- render a spinner instead of placeholder content
function Permissions.youReady(scope: Scope): Fusion.Computed<boolean>
	local youMemberFuse: any = (scope :: any):Fuse("temp", "YouMember")
	local roleInfoFuse: any = (scope :: any):Fuse("everyone", "RoleInfo")
	return scope:Computed(function(use): boolean
		local you = use(youMemberFuse)
		local info = use(roleInfoFuse)
		if typeof(you) ~= "table" or typeof(info) ~= "table" then return false end
		return typeof((you :: any).roleKeys) == "table"
	end)
end

-- Mirrors Roles.canViewPage
function Permissions.canViewPage(scope: Scope, pageKey: string): Fusion.Computed<boolean>
	local youMemberFuse: any = (scope :: any):Fuse("temp", "YouMember")
	local roleInfoFuse: any = (scope :: any):Fuse("everyone", "RoleInfo")
	return scope:Computed(function(use): boolean
		local info = use(roleInfoFuse)
		local you = use(youMemberFuse)
		return anyRoleMatches(info, you, function(role)
			if (role :: any).mayViewAll == true then return true end
			local pages: any = (role :: any).mayViewPages
			if typeof(pages) == "table" then
				for _, page in pages :: {string} do
					if page == "All" or page == pageKey then return true end
				end
			end
			return false
		end)
	end)
end

-- An empty pageKeys list returns true
function Permissions.canViewAnyOf(scope: Scope, pageKeys: {string}): Fusion.Computed<boolean>
	if #pageKeys == 0 then
		return scope:Computed(function(): boolean return true end)
	end
	local youMemberFuse: any = (scope :: any):Fuse("temp", "YouMember")
	local roleInfoFuse: any = (scope :: any):Fuse("everyone", "RoleInfo")
	return scope:Computed(function(use): boolean
		local info = use(roleInfoFuse)
		local you = use(youMemberFuse)
		return anyRoleMatches(info, you, function(role)
			if (role :: any).mayViewAll == true then return true end
			local pages: any = (role :: any).mayViewPages
			if typeof(pages) ~= "table" then return false end
			for _, page in pages :: {string} do
				if page == "All" then return true end
				for _, target in pageKeys do
					if page == target then return true end
				end
			end
			return false
		end)
	end)
end

-- mayViewAll counts as Menu to match the role editor's locked value. While role
-- data replicates we return Menu so the icon doesn't flash away on join
function Permissions.iconMode(scope: Scope): Fusion.Computed<string>
	local youMemberFuse: any = (scope :: any):Fuse("temp", "YouMember")
	local roleInfoFuse: any = (scope :: any):Fuse("everyone", "RoleInfo")
	return scope:Computed(function(use): string
		local info = use(roleInfoFuse)
		local you = use(youMemberFuse)
		if typeof(you) ~= "table" or typeof(info) ~= "table" or typeof((you :: any).roleKeys) ~= "table" then
			return "Menu"
		end
		local best = 0
		for _, key in (you :: any).roleKeys :: {string} do
			local role: any = (info :: any)[key]
			if typeof(role) == "table" then
				local level = if role.mayViewAll == true then 2 else (ICON_LEVEL[tostring(role.mayViewIcon)] or 0)
				if level > best then
					best = level
				end
			end
		end
		return ICON_MODE_BY_LEVEL[best]
	end)
end

-- Mirrors the server's verify gate. Non-reactive, reading replicated state
-- directly for scope-free callers like the cmdbar
function Permissions.canUseModifierNow(modifierDetail: any): boolean
	if typeof(modifierDetail) ~= "table" then return false end
	local needsAbusive = (modifierDetail :: any).isAbusive == true
	local needsGlobal = (modifierDetail :: any).isGlobal == true
	if not needsAbusive and not needsGlobal then
		return true
	end
	local clientUser = require(modules.References.clientUser)
	local you = clientUser.temp:get("YouMember")
	local roleInfo = clientUser.everyone:get("RoleInfo")
	if needsAbusive and not anyRoleMatches(roleInfo, you, function(role)
		return RoleLockRules.isEffectivelyEnabledOnRole(role, "permitModifiersAbusive")
	end) then
		return false
	end
	if needsGlobal and not anyRoleMatches(roleInfo, you, function(role)
		return RoleLockRules.isEffectivelyEnabledOnRole(role, "permitModifiersGlobal")
	end) then
		return false
	end
	return true
end

-- Mirrors the server's Roles.hasPermission, always returns a non-nil boolean
function Permissions.hasPermission(scope: Scope, permKey: string): Fusion.Computed<boolean>
	local youMemberFuse: any = (scope :: any):Fuse("temp", "YouMember")
	local roleInfoFuse: any = (scope :: any):Fuse("everyone", "RoleInfo")
	return scope:Computed(function(use): boolean
		local info = use(roleInfoFuse)
		local you = use(youMemberFuse)
		return anyRoleMatches(info, you, function(role)
			return RoleLockRules.isEffectivelyEnabledOnRole(role, permKey)
		end)
	end)
end

-- Mirrors Roles.canEditRole. mayEditAll only bypasses the escalation check,
-- rank is enforced uniformly
function Permissions.canEditRoleByKey(scope: Scope, roleKey: Fusion.UsedAs<string>): Fusion.Computed<boolean>
	local youMemberFuse: any = (scope :: any):Fuse("temp", "YouMember")
	local roleInfoFuse: any = (scope :: any):Fuse("everyone", "RoleInfo")
	return scope:Computed(function(use): boolean
		local info = use(roleInfoFuse)
		local you = use(youMemberFuse)
		local key = if typeof(roleKey) == "string" then roleKey else use(roleKey :: any)
		if typeof(info) ~= "table" or typeof(you) ~= "table" or typeof(key) ~= "string" or key == "" then return false end
		local targetRole: any = (info :: any)[key]
		if typeof(targetRole) ~= "table" then return false end
		-- Internal roles can't be edited in-game, mirroring the server reject
		if isInternalRole(targetRole) then return false end
		local targetRank: number = if typeof((targetRole :: any).rank) == "number" then (targetRole :: any).rank else 0
		local callerTop = 0
		local callerHasEditRoles = false
		local keys: any = (you :: any).roleKeys
		if typeof(keys) ~= "table" then return false end
		for _, rk in keys :: {string} do
			local role: any = (info :: any)[rk]
			if typeof(role) == "table" then
				local rank: number = if typeof((role :: any).rank) == "number" then (role :: any).rank else 0
				if rank > callerTop then callerTop = rank end
				if RoleLockRules.isEffectivelyEnabledOnRole(role, "mayEditRoles") then callerHasEditRoles = true end
			end
		end
		if not callerHasEditRoles then return false end
		return callerTop > targetRank
	end)
end

function Permissions.canEditRoles(scope: Scope): Fusion.Computed<boolean>
	local editAll = Permissions.hasPermission(scope, "mayEditAll")
	local editRoles = Permissions.hasPermission(scope, "mayEditRoles")
	return scope:Computed(function(use): boolean
		return use(editAll) == true or use(editRoles) == true
	end)
end


-- Mirrors Roles.canUseCommand
function Permissions.canUseCommand(scope: Scope, commandKeyLower: string): Fusion.Computed<boolean>
	local youMemberFuse: any = (scope :: any):Fuse("temp", "YouMember")
	local commandInfoFuse: any = (scope :: any):Fuse("everyone", "CommandInfo")
	return scope:Computed(function(use): boolean
		local you = use(youMemberFuse)
		local infoMap = use(commandInfoFuse)
		if typeof(you) ~= "table" or typeof(infoMap) ~= "table" then return false end
		local cmd = (infoMap :: any)[commandKeyLower]
		if typeof(cmd) ~= "table" then return false end
		local cmdRoles: any = (cmd :: any).roles
		if typeof(cmdRoles) ~= "table" then return false end
		local cmdRoleSet: {[string]: true} = {}
		for _, cmdRoleKey in cmdRoles :: {string} do cmdRoleSet[cmdRoleKey] = true end
		local myRoles: any = (you :: any).roleKeys
		if typeof(myRoles) ~= "table" then return false end
		for _, myRoleKey in myRoles :: {string} do
			if cmdRoleSet[myRoleKey] then return true end
		end
		return false
	end)
end


return Permissions
