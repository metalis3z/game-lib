--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local RoleLockRules = require(modules.Parent.Controllers.UI.Config.RoleLockRules)
local Preview = {}


-- LOCAL FUNCTIONS
local function getRoles(): any
	return require(script.Parent) :: any
end


-- FUNCTIONS
function Preview.canPreview(user: any?, targetRoleKey: string): boolean
	if not user or typeof(targetRoleKey) ~= "string" then return false end
	local Roles = getRoles()
	-- Real permissions only, otherwise you could escalate by previewing a role that has mayPreviewRoles
	local hasFlag = false
	for _, role in Roles.getRealRolesForUser(user) do
		if RoleLockRules.isEffectivelyEnabledOnRole(role, "mayPreviewRoles") then
			hasFlag = true
			break
		end
	end
	if not hasFlag then return false end
	local targetRole = Roles.getRole(targetRoleKey)
	if not targetRole then return false end
	local targetRank = (targetRole :: any).rank or 0
	return Roles.getRealTopRank(user) >= targetRank
end

function Preview.setPreviewingRoles(user: any?, roleKeys: {string}): (boolean, string?)
	if not user then return false, "No user" end
	if typeof(roleKeys) ~= "table" then return false, "roleKeys must be an array" end
	local validated: {string} = {}
	local seen: {[string]: true} = {}
	for _, key in roleKeys do
		if typeof(key) ~= "string" then return false, "Each role key must be a string" end
		if seen[key] then continue end
		if not Preview.canPreview(user, key) then
			return false, `You don't have permission to preview role '{key}'`
		end
		seen[key] = true
		table.insert(validated, key)
	end
	user.temp:set("PreviewingRoles", validated)
	return true, nil
end

function Preview.clearPreviewingRoles(user: any?)
	if not user then return end
	user.temp:set("PreviewingRoles", {})
end

function Preview.isPreviewing(user: any?): boolean
	if not user then return false end
	local preview = user.temp:get("PreviewingRoles")
	return typeof(preview) == "table" and #(preview :: {any}) > 0
end

function Preview.getPreviewingRoles(user: any?): {string}
	if not user then return {} end
	local preview = user.temp:get("PreviewingRoles")
	if typeof(preview) ~= "table" then return {} end
	return table.clone(preview :: {string})
end

function Preview.revalidatePreview(user: any?)
	if not user then return end
	local preview = user.temp:get("PreviewingRoles")
	if typeof(preview) ~= "table" or #(preview :: {any}) == 0 then return end
	local kept: {string} = {}
	for _, key in preview :: {string} do
		if Preview.canPreview(user, key) then
			table.insert(kept, key)
		end
	end
	-- Only write if changed so we avoid unnecessary onChange fires
	local changed = #kept ~= #(preview :: {any})
	if not changed then
		for index, roleKey in kept do
			if (preview :: {any})[index] ~= roleKey then changed = true; break end
		end
	end
	if changed then
		user.temp:set("PreviewingRoles", kept)
	end
end

function Preview.attachPreviewAutoClear(user: any?)
	if not user then return end
	local janitor = (user :: any).janitor
	if not janitor then return end
	janitor:add((user :: any).perm:onChange("PermanentRoles", function()
		Preview.revalidatePreview(user)
	end))
	janitor:add((user :: any).temp:onChange("Roles", function()
		Preview.revalidatePreview(user)
	end))
end


return Preview
