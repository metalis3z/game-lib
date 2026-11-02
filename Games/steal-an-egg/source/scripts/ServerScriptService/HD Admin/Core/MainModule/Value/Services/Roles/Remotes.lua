--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local User = require(modules.Objects.User)
local Remote = require(modules.Objects.Remote)
local getDataSize = require(modules.VerifyUtil.getDataSize)
local isNumberSafe = require(modules.VerifyUtil.isNumberSafe)
local generateUID = require(modules.DataUtil.generateUID)
local validateSettingChange = require(modules.VerifyUtil.validateSettingChange)
local SettingsRole = require(modules.Parent.Controllers.UI.Config.SettingsRole)
local defaultRole = require(modules.References.defaultRole)
local isInternalRole = require(modules.RoleUtil.isInternalRole)
local Prompt = require(modules.Prompt)
local getNameFromUserIdAsync = require(modules.PlayerUtil.getNameFromUserIdAsync)
local colourRoleName = require(modules.RoleUtil.colourRoleName)
local Remotes = {}


-- FUNCTIONS
function Remotes.setup(Roles: any, Hydration: any)

	-- The server has to enforce the USD edit lock too, or a stale client could slip mutations through
	local function isUseDefaultRolesOn(): boolean
		local ok, gameUser = User.getUserAsync("Game")
		if not ok or not gameUser then return false end
		local settings = gameUser.perm:get("Settings")
		if typeof(settings) ~= "table" then return false end
		local sys: any = (settings :: any).SystemSettings
		if typeof(sys) ~= "table" then return false end
		return (sys :: any).UseDefaultRoles == true
	end

	local function runEscalationCheck(callerUser: any, row: any, oldValue: any, newValue: any, targetRole: any): (boolean, string?)
		if Roles.hasPermission(callerUser, "mayEditAll") then return true end
		if row.escalationCheck == false then return true end
		if typeof(row.escalationCheck) == "function" then
			local ok, err = row.escalationCheck(callerUser, oldValue, newValue, Roles, targetRole)
			if not ok then return false, err end
			return true
		end
		if row.inputType == "Toggle" and newValue == true and oldValue ~= true then
			if not Roles.canGrantPermission(callerUser, row.title) then
				return false, `You cannot grant '{row.title}' because you don't hold it yourself`
			end
		end
		return true
	end
	Remote.new("ChangeRoleSetting", "Function", "Low"):onServerInvoke(function(player: Player, roleKey: unknown, fieldName: unknown, newValue: unknown)
		local callerUser = User.getUser(player)
		if not callerUser then return false, "User not loaded" end
		if typeof(roleKey) ~= "string" or typeof(fieldName) ~= "string" then
			return false, "Invalid roleKey or fieldName"
		end
		if not Roles.canEditRole(callerUser, roleKey :: string) then
			return false, "You don't have permission to edit this role"
		end
		if isUseDefaultRolesOn() then
			return false, "Roles are locked while 'Use Studio Defaults' is on"
		end
		if fieldName == "useDefaults" then
			return false, "Per-role useDefaults is no longer supported"
		end
		local roleInfo = User.everyone:get("RoleInfo")
		if typeof(roleInfo) ~= "table" or not roleInfo[roleKey :: string] then
			return false, "Role does not exist"
		end
		if not require(modules.VerifyUtil.isWithinMaxSize)(newValue, 8192) then
			return false, "Remote value is too large"
		end
		local row = validateSettingChange.findRowByFieldName(SettingsRole, fieldName :: string)
		if not row then return false, `Unknown role field '{fieldName}'` end
		local ok, coercedOrErr = validateSettingChange.run(row, newValue, {
			callerUserId = player.UserId,
			source = "server",
		})
		if not ok then return false, tostring(coercedOrErr) end
		local targetRoleInfo: any = (roleInfo :: any)[roleKey :: string]
		local oldValue: any = if typeof(targetRoleInfo) == "table" then (targetRoleInfo :: any)[fieldName :: string] else nil
		local escOk, escErr = runEscalationCheck(callerUser, row, oldValue, coercedOrErr, targetRoleInfo)
		if not escOk then return false, escErr end
		local success, gameUser = User.getUserAsync("Game")
		if not success or not gameUser then
			return false, "Game user not loaded"
		end
		gameUser.perm:set({"RoleInfo", roleKey :: string, fieldName :: string}, coercedOrErr)
		return true
	end)

	-- A caller can never move a role at or above their own rank, nor promote one up to it
	local function getOrderRankError(callerUser: any, validated: {string}, roleInfo: any): string?
		local callerTopRank = Roles.getTopRank(callerUser)
		local totalRoles = #validated
		for index, key in validated do
			local newRank: number = totalRoles - index + 1
			local roleEntry: any = (roleInfo :: any)[key]
			local currentRank: number = if typeof(roleEntry) == "table" and typeof((roleEntry :: any).rank) == "number"
				then (roleEntry :: any).rank else 0
			if currentRank >= callerTopRank then
				if newRank ~= currentRank then
					return `Cannot move role '{key}' - its rank ({currentRank}) is at or above your own ({callerTopRank})`
				end
			else
				if newRank >= callerTopRank then
					return `Cannot promote role '{key}' to rank {newRank} - that would place it at or above your own rank ({callerTopRank})`
				end
			end
		end
		return nil
	end
	Remote.new("ChangeRolesOrder", "Function", "Low"):onServerInvoke(function(player: Player, orderedKeys: unknown)
		local callerUser = User.getUser(player)
		if not callerUser then return false, "User not loaded" end
		if not Roles.hasPermission(callerUser, "mayEditRoles") then
			return false, "You don't have permission to reorder roles"
		end
		if typeof(orderedKeys) ~= "table" then
			return false, "orderedKeys must be a table"
		end
		if #(orderedKeys :: {any}) == 0 then
			return false, "Order list cannot be empty"
		end
		local roleInfo = User.everyone:get("RoleInfo")
		if typeof(roleInfo) ~= "table" then
			return false, "RoleInfo not available"
		end
		local validated: {string} = {}
		local seen: {[string]: true} = {}
		for index, key in orderedKeys :: {any} do
			if typeof(key) ~= "string" then
				return false, `Entry {index}: must be a string`
			end
			if seen[key] then
				return false, `Entry {index}: duplicate role '{key}'`
			end
			if not roleInfo[key] then
				return false, `Entry {index}: unknown role '{key}'`
			end
			seen[key] = true
			table.insert(validated, key)
		end
		for existingKey in roleInfo :: {[string]: any} do
			if not seen[existingKey] then
				if isInternalRole((roleInfo :: any)[existingKey]) then continue end
				return false, `Role '{existingKey}' is missing from the order`
			end
		end
		if not require(modules.VerifyUtil.isWithinMaxSize)(validated, 4096) then
			return false, "Order list is too large"
		end
		local orderRankError = getOrderRankError(callerUser, validated, roleInfo)
		if orderRankError then
			return false, orderRankError
		end
		local success, gameUser = User.getUserAsync("Game")
		if not success or not gameUser then
			return false, "Game user not loaded"
		end
		gameUser.perm:set({"RolesOrder"}, validated)
		return true
	end)

	Remote.new("CreateRole", "Function", "Low"):onServerInvoke(function(player: Player, rolePayload: unknown): (boolean, string?)
		local callerUser = User.getUser(player)
		if not callerUser then return false, "User not loaded" end
		if not Roles.hasPermission(callerUser, "mayEditRoles") then
			return false, "You don't have permission to create roles"
		end
		if isUseDefaultRolesOn() then
			return false, "Roles are locked while 'Use Studio Defaults' is on"
		end
		if typeof(rolePayload) ~= "table" then
			return false, "rolePayload must be a table"
		end
		if getDataSize(rolePayload) > 4000 then
			return false, "Role data is too large"
		end
		if (rolePayload :: any).rank ~= nil then
			return false, "Cannot set 'rank' on creation - rank is derived from order"
		end
		if (rolePayload :: any).key ~= nil then
			return false, "Cannot set 'key' on creation - server generates a unique key"
		end
		local success, gameUser = User.getUserAsync("Game")
		if not success or not gameUser then
			return false, "Game user not loaded"
		end
		local defaultRoleInfo = User.everyone:get("DefaultRoleInfo") or {}
		local savedRoleInfo = gameUser.perm:get("RoleInfo") or {}
		local function keyExists(key: string): boolean
			return (defaultRoleInfo :: any)[key] ~= nil or (savedRoleInfo :: any)[key] ~= nil
		end
		local newKey: string = ""
		for _ = 1, 50 do
			local candidate = generateUID(8, "LettersAndNumbers"):upper()
			if not keyExists(candidate) then
				newKey = candidate
				break
			end
		end
		if newKey == "" then
			return false, "Failed to generate unique role key"
		end
		local slimRole = Hydration.stripToSlimRole(rolePayload)
		for fieldName, value in slimRole do
			if fieldName == "name" then continue end -- handled below (allows empty fallback)
			local fieldRow = validateSettingChange.findRowByFieldName(SettingsRole, fieldName)
			if not fieldRow then
				return false, `Unknown role field '{fieldName}'`
			end
			local fieldOk, fieldResult = validateSettingChange.run(fieldRow, value, {
				callerUserId = player.UserId,
				source = "server",
			})
			if not fieldOk then
				return false, `Field '{fieldName}': {tostring(fieldResult)}`
			end
			-- Treat the field's default as the "old" value since the role is brand new
			local default: any = (defaultRole :: any)[fieldName]
			local escOk, escErr = runEscalationCheck(callerUser, fieldRow, default, fieldResult, slimRole)
			if not escOk then
				return false, `Field '{fieldName}': {escErr}`
			end
			slimRole[fieldName] = fieldResult
		end
		-- The name verifies separately so we can fall back to the key when the client sent nothing usable
		if typeof(slimRole.name) == "string" and slimRole.name ~= "" then
			local nameRow = validateSettingChange.findRowByFieldName(SettingsRole, "name")
			if nameRow then
				local nameOk, nameResult = validateSettingChange.run(nameRow, slimRole.name, {
					callerUserId = player.UserId,
					source = "server",
				})
				if not nameOk then
					return false, `Field 'name': {tostring(nameResult)}`
				end
				slimRole.name = nameResult
			end
		else
			slimRole.name = newKey
		end
		-- Read existing order BEFORE writing RoleInfo, so rebuild can't contaminate rolesOrdered mid-flight
		local existingOrder = gameUser.perm:get("RolesOrder")
		gameUser.perm:set({"RoleInfo", newKey}, slimRole)
		local newOrder: {string} = {}
		if typeof(existingOrder) == "table" and #existingOrder > 0 then
			local seen: {[string]: true} = {}
			for _, key in existingOrder :: {any} do
				if typeof(key) == "string" and not seen[key] and key ~= newKey then
					seen[key] = true
					table.insert(newOrder, key)
				end
			end
		else
			local roleInfo = User.everyone:get("RoleInfo")
			if typeof(roleInfo) == "table" then
				local entries: {{key: string, rank: number}} = {}
				for roleKey, info in roleInfo :: any do
					if typeof(roleKey) == "string" and roleKey ~= newKey then
						local rank = if typeof(info) == "table" and typeof((info :: any).rank) == "number"
							then (info :: any).rank else 0
						table.insert(entries, {key = roleKey, rank = rank})
					end
				end
				table.sort(entries, function(entryA: {key: string, rank: number}, entryB: {key: string, rank: number})
					if entryA.rank ~= entryB.rank then return entryA.rank > entryB.rank end
					return entryA.key < entryB.key
				end)
				for _, entry in entries do
					table.insert(newOrder, entry.key)
				end
			end
		end
		table.insert(newOrder, newKey)
		gameUser.perm:set({"RolesOrder"}, newOrder)
		return true, newKey
	end)

	Remote.new("DeleteRole", "Function", "Low"):onServerInvoke(function(player: Player, roleKey: unknown): (boolean, string?)
		local callerUser = User.getUser(player)
		if not callerUser then return false, "User not loaded" end
		if typeof(roleKey) ~= "string" then
			return false, "roleKey must be a string"
		end
		if not Roles.hasPermission(callerUser, "mayEditRoles") then
			return false, "You don't have permission to delete roles"
		end
		if isUseDefaultRolesOn() then
			return false, "Roles are locked while 'Use Studio Defaults' is on"
		end
		-- This means you can't delete a role senior to yours
		if not Roles.canEditRole(callerUser, roleKey :: string) then
			return false, "You don't have permission to delete this role (rank check failed)"
		end
		local success, gameUser = User.getUserAsync("Game")
		if not success or not gameUser then
			return false, "Game user not loaded"
		end
		local defaultRoleInfo = User.everyone:get("DefaultRoleInfo") or {}
		local isSourceBacked = (defaultRoleInfo :: any)[roleKey :: string] ~= nil
		if isSourceBacked then
			gameUser.perm:set({"RoleInfo", roleKey :: string}, { deleted = true })
		else
			local savedRoleInfo = gameUser.perm:get("RoleInfo") or {}
			if (savedRoleInfo :: any)[roleKey :: string] == nil then
				return false, "Role does not exist"
			end
			gameUser.perm:set({"RoleInfo", roleKey :: string}, nil)
		end
		local existingOrder = gameUser.perm:get("RolesOrder") or {}
		if typeof(existingOrder) == "table" then
			local newOrder: {string} = {}
			for _, key in existingOrder :: {any} do
				if typeof(key) == "string" and key ~= roleKey then
					table.insert(newOrder, key)
				end
			end
			gameUser.perm:set({"RolesOrder"}, newOrder)
		end
		return true, nil
	end)

	Remote.new("GiveRoleToUser", "Function", "Low"):onServerInvoke(function(player: Player, targetUserId: unknown, roleKey: unknown, scope: unknown): (boolean, string?)
		local callerUser = User.getUser(player)
		if not callerUser then return false, "User not loaded" end
		if typeof(targetUserId) ~= "number" or not isNumberSafe(targetUserId) or targetUserId <= 0 or targetUserId ~= math.floor(targetUserId) then
			return false, "targetUserId must be a positive integer"
		end
		if typeof(roleKey) ~= "string" then return false, "roleKey must be a string" end
		local resolvedScope: "server" | "perm" = "perm"
		if scope == "server" then
			resolvedScope = "server"
		elseif scope ~= "perm" and scope ~= nil then
			return false, "scope must be 'server' or 'perm'"
		end
		local commandKey: string = if resolvedScope == "perm" then "givepermrole" else "giveserverrole"
		local canUse, denyReason = Roles.canUseCommand(callerUser, commandKey)
		if not canUse then
			if denyReason == "Unknown command" then
				local moduleName = if resolvedScope == "perm" then "AdminRole" else "ModRole"
				local packName = if resolvedScope == "perm" then "Admin" else "Mod"
				return false, `Role changes are disabled because the game dev disabled the "{moduleName}" commands from loading. Re-load them within the "{packName}" pack to restore.`
			end
			return false, denyReason or `Missing '{commandKey}' command permission`
		end
		local ok, err = Roles.giveRoleAsync(targetUserId, roleKey, {
			callerUser = callerUser,
			scope = resolvedScope,
		})
		if ok and targetUserId ~= player.UserId then
			task.spawn(function()
				local role = Roles.getRole(roleKey)
				local roleName = if role then colourRoleName(role) else roleKey
				local nameOk, targetName = getNameFromUserIdAsync(targetUserId)
				local resolvedName = if nameOk and typeof(targetName) == "string" then targetName else tostring(targetUserId)
				Prompt.success(player, `Gave {roleName} to {resolvedName}`)
			end)
		end
		return ok, err
	end)

	Remote.new("TakeRoleFromUser", "Function", "Low"):onServerInvoke(function(player: Player, targetUserId: unknown, roleKey: unknown, scope: unknown): (boolean, string?)
		local callerUser = User.getUser(player)
		if not callerUser then return false, "User not loaded" end
		if typeof(targetUserId) ~= "number" or not isNumberSafe(targetUserId) or targetUserId <= 0 or targetUserId ~= math.floor(targetUserId) then
			return false, "targetUserId must be a positive integer"
		end
		if typeof(roleKey) ~= "string" then return false, "roleKey must be a string" end
		local resolvedScope: "server" | "perm" = "perm"
		if scope == "server" then
			resolvedScope = "server"
		elseif scope ~= "perm" and scope ~= nil then
			return false, "scope must be 'server' or 'perm'"
		end
		local commandKey: string = if resolvedScope == "perm" then "takepermrole" else "takeserverrole"
		local canUse, denyReason = Roles.canUseCommand(callerUser, commandKey)
		if not canUse then
			if denyReason == "Unknown command" then
				local moduleName = if resolvedScope == "perm" then "AdminRole" else "ModRole"
				local packName = if resolvedScope == "perm" then "Admin" else "Mod"
				return false, `Role changes are disabled because the game dev disabled the "{moduleName}" commands from loading. Re-load them within the "{packName}" pack to restore.`
			end
			return false, denyReason or `Missing '{commandKey}' command permission`
		end
		local ok, err = Roles.takeRoleAsync(targetUserId, roleKey, {
			callerUser = callerUser,
			scope = resolvedScope,
		})
		if ok then
			task.spawn(function()
				local role = Roles.getRole(roleKey)
				local roleName = if role then colourRoleName(role) else roleKey
				local nameOk, targetName = getNameFromUserIdAsync(targetUserId)
				local resolvedName = if nameOk and typeof(targetName) == "string" then targetName else tostring(targetUserId)
				Prompt.success(player, `Removed {roleName} from {resolvedName}`)
			end)
		end
		return ok, err
	end)

	Remote.new("SetPreviewingRoles", "Function", "Low"):onServerInvoke(function(player: Player, roleKeys: unknown): (boolean, string?)
		local callerUser = User.getUser(player)
		if not callerUser then return false, "User not loaded" end
		if typeof(roleKeys) ~= "table" then return false, "roleKeys must be an array" end
		return Roles.setPreviewingRoles(callerUser, roleKeys :: {string})
	end)
	Remote.new("ClearPreviewingRoles", "Function", "Low"):onServerInvoke(function(player: Player): boolean
		local callerUser = User.getUser(player)
		if not callerUser then return false end
		Roles.clearPreviewingRoles(callerUser)
		return true
	end)
end


return Remotes
