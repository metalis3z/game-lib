--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local User = require(modules.Objects.User)
local Janitor = require(modules.Objects.Janitor)
local Framework = require(modules.Framework)
local defaultRole: any = require(modules.References.defaultRole)
local deepCopyTable = require(modules.TableUtil.deepCopyTable)
local isInternalRole = require(modules.RoleUtil.isInternalRole)
local rolesOrdered: {Role} = {}


-- LOCAL FUNCTIONS
local function sanitiseRoleKey(input: string): string
	return (input:lower():gsub("[^a-z0-9]", ""))
end
local rolesRequireUpdating = true
local updateInFlight = false
local updateJanitor = Janitor.new()
local roleFieldSet: {[string]: true}? = nil
local Hydration = {}


-- TYPES
type Role = typeof(defaultRole)


-- LOCAL FUNCTIONS
local function buildRoleFieldSet(): {[string]: true}
	local SettingsRole = require(modules.Parent.Controllers.UI.Config.SettingsRole :: ModuleScript) :: any
	local set: {[string]: true} = {}
	for _, category in SettingsRole do
		for _, obj in category.objects do
			if typeof(obj.title) == "string" then
				set[obj.title] = true
			end
		end
	end
	return set
end

local function assignSequentialRanks(ordered: {Role})
	local rankableCount = 0
	for _, role in ordered do
		if not isInternalRole(role) then
			rankableCount += 1
		end
	end
	local position = 0
	for _, role in ordered do
		if isInternalRole(role) then
			role.rank = 0
		else
			position += 1
			role.rank = rankableCount - position + 1
		end
	end
end

local function buildRoleInto(target: {[string]: any}, partial: any, fallbackName: string, forceInternal: boolean)
	if typeof(partial) ~= "table" then
		return
	end
	local role = deepCopyTable(defaultRole) :: any
	for fieldName, value in partial do
		if defaultRole[fieldName] == nil then
			continue
		end
		role[fieldName] = value
	end
	local rawKey = if typeof(partial.key) == "string" then partial.key
		elseif typeof(partial.name) == "string" then partial.name :: string
		else fallbackName
	local key = sanitiseRoleKey(rawKey)
	if key == "" then
		return
	end
	role.name = if typeof(partial.name) == "string" then partial.name else fallbackName
	role.key = key
	if forceInternal then
		role.internal = true
	end
	target[key] = role
end


-- FUNCTIONS
function Hydration.getRoleFieldSet(): {[string]: true}
	if roleFieldSet then return roleFieldSet end
	roleFieldSet = buildRoleFieldSet()
	return roleFieldSet :: {[string]: true}
end

function Hydration.stripToSlimRole(data: any): {[string]: any}
	local slim: {[string]: any} = {}
	if typeof(data) ~= "table" then return slim end
	for fieldName, value in data do
		if typeof(fieldName) ~= "string" then continue end
		if fieldName == "key" or fieldName == "rank" then continue end
		if defaultRole[fieldName] == nil and fieldName ~= "name" then continue end
		local default = defaultRole[fieldName]
		local isSame = false
		if typeof(value) == "table" and typeof(default) == "table" then
			local valArr = value :: {any}
			local defArr = default :: {any}
			if #valArr == #defArr then
				local same = true
				for index, item in valArr do if defArr[index] ~= item then same = false; break end end
				if same then
					for index, item in defArr do if valArr[index] ~= item then same = false; break end end
				end
				isSame = same
			end
		else
			isSame = value == default
		end
		if not isSame then
			slim[fieldName] = value
		end
	end
	return slim
end

function Hydration.getOrdered(): {Role}
	return rolesOrdered
end

function Hydration.markStale()
	rolesRequireUpdating = true
end

function Hydration.update(forceUpdate: boolean?, revalidateAllUsersPreview: (() -> ())?): boolean
	-- Callers arriving mid update must wait for the build to finish. The first update
	-- yields on the Game user load, and returning early during that window handed
	-- resolveRolesForPlayer an empty role list, so players loaded with zero roles
	local waitStart = os.clock()
	while updateInFlight do
		if os.clock() - waitStart > 30 then
			warn("HD Admin: Hydration.update waited over 30 seconds for an in-flight update, proceeding anyway")
			break
		end
		task.wait()
	end
	if not rolesRequireUpdating and not forceUpdate then
		return false
	end
	updateInFlight = true
	local defaultInfo = {}
	rolesRequireUpdating = false
	updateJanitor:cleanup()

	local configRoles = Framework.getInstance(modules.Parent.Services.Config, "Roles")
	if configRoles then
		for _, roleModule in configRoles:GetChildren() do
			if not roleModule:IsA("ModuleScript") then
				continue
			end
			local ok, partial = pcall(require, roleModule)
			if not ok then
				continue
			end
			buildRoleInto(defaultInfo, partial, roleModule.Name, false)
		end
	end

	local internalRoles = Framework.getInstance(modules.Internal, "Roles")
	if internalRoles then
		for _, roleModule in internalRoles:GetChildren() do
			if not roleModule:IsA("ModuleScript") then
				continue
			end
			local ok, partial = pcall(require, roleModule)
			if not ok then
				continue
			end
			buildRoleInto(defaultInfo, partial, roleModule.Name, true)
		end
	end

	local Config = require(modules.Parent.Services.Config)
	Config.updateConfig()

	-- We fetch the Game user here so we can subscribe to its perm changes below
	local success, gameUser = User.getUserAsync("Game")
	local loadedRoleInfo: {[string]: Role} = {}

	local function migrateGiveToGroups(giveToGroups: any)
		if typeof(giveToGroups) ~= "table" then return end
		for _, entry in giveToGroups :: {any} do
			if typeof(entry) ~= "table" then continue end
			if (entry :: any).type ~= "SpecificRoles" then continue end
			local legacyIds = (entry :: any).roleIds
			if typeof((entry :: any).roles) ~= "table" and typeof(legacyIds) == "table" then
				local upgraded: {{rank: number, name: string}} = {}
				for _, rid in legacyIds :: {any} do
					if typeof(rid) == "number" then
						table.insert(upgraded, {rank = rid, name = ""})
					end
				end
				(entry :: any).roles = upgraded
			end
			(entry :: any).roleIds = nil
		end
	end

	local function hydrateAndOrder(savedRoleInfo: any, savedRolesOrder: any, useDefaultRoles: boolean): {Role}
		local merged: {[string]: Role} = {}
		for roleKey, roleInfo in defaultInfo do
			local copy = deepCopyTable(roleInfo) :: any
			copy.key = roleKey
			merged[roleKey] = copy :: Role
		end
		if not useDefaultRoles and typeof(savedRoleInfo) == "table" then
			for roleKey, savedFields in savedRoleInfo do
				if typeof(savedFields) ~= "table" then continue end
				-- Internal/built-in roles are server-managed, so saved edits and tombstones can't touch them
				if isInternalRole(merged[roleKey]) then continue end
				if (savedFields :: any).deleted == true then
					merged[roleKey] = nil
					continue
				end
				local base = merged[roleKey]
				if typeof(base) ~= "table" then
					base = deepCopyTable(defaultRole) :: any
					merged[roleKey] = base
				end
				for fieldName, value in savedFields do
					-- Don't allow saved data to override rank, rank comes from order
					if fieldName == "rank" then continue end
					if fieldName == "deleted" then continue end
					(base :: any)[fieldName] = value
				end
				;(base :: any).key = roleKey
				migrateGiveToGroups((base :: any).giveToGroups)
			end
		end
		local ordered: {Role} = {}
		if useDefaultRoles or typeof(savedRolesOrder) ~= "table" or #savedRolesOrder == 0 then
			for _, roleInfo in merged do
				table.insert(ordered, roleInfo)
			end
			table.sort(ordered, function(roleA: Role, roleB: Role): boolean
				local rankA = roleA.rank or 0
				local rankB = roleB.rank or 0
				if rankA ~= rankB then return rankA > rankB end
				return roleA.key < roleB.key
			end)
		else
			local seen: {[string]: true} = {}
			for _, roleKey in savedRolesOrder do
				if typeof(roleKey) ~= "string" then continue end
				local role = merged[roleKey]
				if role and not seen[roleKey] then
					seen[roleKey] = true
					table.insert(ordered, role)
				end
			end
			local leftovers: {Role} = {}
			for roleKey, role in merged do
				if not seen[roleKey] then
					table.insert(leftovers, role)
				end
			end
			table.sort(leftovers, function(roleA: Role, roleB: Role): boolean
				local rankA = roleA.rank or 0
				local rankB = roleB.rank or 0
				if rankA ~= rankB then return rankA > rankB end
				return roleA.key < roleB.key
			end)
			for _, role in leftovers do
				table.insert(ordered, role)
			end
		end
		assignSequentialRanks(ordered)
		return ordered
	end

	local function computeUseDefaultRoles(): boolean
		if not gameUser then return false end
		local settings = gameUser.perm:get("Settings")
		if typeof(settings) ~= "table" then return false end
		local sys = (settings :: any).SystemSettings
		if typeof(sys) ~= "table" then return false end
		return sys.UseDefaultRoles == true
	end

	local function rebuild()
		local savedRoleInfoFromPerm = gameUser and gameUser.perm:get("RoleInfo")
		local savedRolesOrder = gameUser and gameUser.perm:get("RolesOrder")
		local useDefaults = computeUseDefaultRoles()
		rolesOrdered = hydrateAndOrder(savedRoleInfoFromPerm, savedRolesOrder, useDefaults)
		loadedRoleInfo = {}
		for _, role in rolesOrdered do
			loadedRoleInfo[role.key] = role
		end
		local tombstones: {[string]: boolean} = {}
		if typeof(savedRoleInfoFromPerm) == "table" then
			for roleKey, savedFields in savedRoleInfoFromPerm do
				if typeof(savedFields) == "table" and (savedFields :: any).deleted == true then
					tombstones[roleKey] = true
				end
			end
		end
		-- The saved view lets the client preview USD off while the server is still committed to on
		local savedRolesOrdered = hydrateAndOrder(savedRoleInfoFromPerm, savedRolesOrder, false)
		local savedRoleInfoMap: {[string]: Role} = {}
		for _, role in savedRolesOrdered do
			savedRoleInfoMap[role.key] = role
		end
		User.everyone:set("Roles", rolesOrdered)
		User.everyone:set("RoleInfo", loadedRoleInfo)
		User.everyone:set("TombstonedRoles", tombstones)
		User.everyone:set("SavedRoles", savedRolesOrdered)
		User.everyone:set("SavedRoleInfo", savedRoleInfoMap)
		task.defer(function()
			pcall(function()
				(require(modules.Parent.Services.Commands) :: any).updateCommands(true)
			end)
		end)
		if revalidateAllUsersPreview then
			task.defer(revalidateAllUsersPreview)
		end
	end

	rebuild()
	do
		local ordered: {Role} = {}
		for _, roleInfo in defaultInfo do
			table.insert(ordered, roleInfo)
		end
		table.sort(ordered, function(roleA: Role, roleB: Role): boolean
			local rankA = roleA.rank or 0
			local rankB = roleB.rank or 0
			if rankA ~= rankB then return rankA > rankB end
			return roleA.key < roleB.key
		end)
		assignSequentialRanks(ordered)
	end
	User.everyone:set("DefaultRoleInfo", defaultInfo)

	if success and gameUser then
		updateJanitor:add(gameUser.perm:onChange("RoleInfo", rebuild))
		updateJanitor:add(gameUser.perm:onChange("RolesOrder", rebuild))
		updateJanitor:add(gameUser.perm:onChange("Settings", rebuild))
	end

	updateInFlight = false
	return true
end


return Hydration
