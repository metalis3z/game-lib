--!strict
--[[

	A giver is any non-user grant source configured on a role's giveTo fields

--]]


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Presets = require(frontend.Config.Presets)
local isInternalRole = require(modules.RoleUtil.isInternalRole)
local GroupService = game:GetService("GroupService")
local MarketplaceService = game:GetService("MarketplaceService")


-- TYPES
-- The popup explodes a Group giver into one section per group-role scope, so the
-- admin can see which HD Admin roles fire for AllMembers vs a specific role
export type GroupSectionKind = "AllMembers" | "SpecificRole"
export type GroupGiverSection = {
	kind: GroupSectionKind,
	rank: number?, -- nil for AllMembers
	name: string?, -- nil for AllMembers
	hdAdminRoleKeys: {string}, -- which HD Admin roles trigger via this section
}
export type GroupGiverBreakdown = {
	groupId: string,
	sections: {GroupGiverSection},
}
export type GiverType = "Group" | "Product" | "Friend" | "UserList" | "UserPreset" | "ProductPreset" | "Everyone" | "PrivateServerOwner"
export type Giver = {
	type: GiverType, -- identity is type:id, so the same group/product across roles collapses into one row
	id: string,
	name: string, -- row label
	subtype: string?, -- "GamePass" | "Asset" | "Bundle" for Products (from infoType for ProductPresets); lets subtitles name the specific kind
	roleKeys: {string}, -- roles this giver grants - drives the colour-dots strip
}


-- LOCAL FUNCTIONS
local function infoTypeSubtype(infoType: any): string?
	if infoType == Enum.InfoType.GamePass then return "GamePass" end
	if infoType == Enum.InfoType.Asset then return "Asset" end
	if infoType == Enum.InfoType.Bundle then return "Bundle" end
	if infoType == Enum.InfoType.Subscription then return "Subscription" end
	if infoType == Enum.InfoType.Product then return "Asset" end
	return nil
end

-- Givers found across multiple roles collapse on type:id
local function extractGivers(roleInfo: any): {Giver}
	if typeof(roleInfo) ~= "table" then return {} end

	local byKey: {[string]: Giver} = {}
	local order: {string} = {}
	local function ensure(giverType: GiverType, id: string, defaultName: string): Giver
		local key = giverType .. ":" .. id
		local existing = byKey[key]
		if existing then return existing end
		local giver: Giver = {
			type = giverType,
			id = id,
			name = defaultName,
			roleKeys = {},
		}
		byKey[key] = giver
		table.insert(order, key)
		return giver
	end
	local function addRole(giver: Giver, roleKey: string)
		for _, existingKey in giver.roleKeys do
			if existingKey == roleKey then return end
		end
		table.insert(giver.roleKeys, roleKey)
	end

	for roleKey, role in roleInfo :: any do
		if typeof(roleKey) ~= "string" or typeof(role) ~= "table" then continue end
		if isInternalRole(role) then continue end

		local groups = (role :: any).giveToGroups
		if typeof(groups) == "table" then
			for _, entry in groups :: {any} do
				if typeof(entry) ~= "table" then continue end
				local groupId = (entry :: any).groupId or (entry :: any).id
				if groupId == nil then continue end
				local idStr = tostring(groupId)
				local label = (entry :: any).name or (entry :: any).label or `Group {idStr}`
				addRole(ensure("Group", idStr, label), roleKey)
			end
		end

		local products = (role :: any).giveToProducts
		if typeof(products) == "table" then
			for _, entry in products :: {any} do
				if typeof(entry) ~= "table" then continue end
				-- Presets surface as "ProductPreset" so matching doesn't try a numeric asset id
				if (entry :: any).type == "Preset" then
					local presetKey = (entry :: any).preset
					if typeof(presetKey) ~= "string" then continue end
					local preset = Presets.products[presetKey]
					local label: string = if preset and typeof(preset.label) == "string"
						then preset.label
						else presetKey
					local giver = ensure("ProductPreset", presetKey, label)
					-- Subtype comes from the preset's infoType so the subtitle can be specific
					if preset and (giver :: any).subtype == nil then
						(giver :: any).subtype = infoTypeSubtype((preset :: any).infoType)
					end
					addRole(giver, roleKey)
					continue
				end
				local productId = (entry :: any).productId or (entry :: any).id or (entry :: any).assetId
				if productId == nil then continue end
				local idStr = tostring(productId)
				local label = (entry :: any).name or (entry :: any).label or `Product {idStr}`
				local giver = ensure("Product", idStr, label)
				-- First write wins if the same product id appears under different subtypes
				if (giver :: any).subtype == nil then
					local entryType = (entry :: any).type
					if entryType == "GamePass" or entryType == "Asset" or entryType == "Bundle" then
						(giver :: any).subtype = entryType
					end
				end
				addRole(giver, roleKey)
			end
		end

		-- Boolean flags get a synthetic id so the row shows up, collapsing across roles
		if (role :: any).giveToEveryone == true then
			addRole(ensure("Everyone", "everyone", "Everyone"), roleKey)
		end
		if (role :: any).giveToPrivateServerOwner == true then
			addRole(ensure("PrivateServerOwner", "privateserverowner", "Private Server Owner"), roleKey)
		end

		local friends = (role :: any).giveToFriends
		if friends == true then
			addRole(ensure("Friend", "friends", "Friends"), roleKey)
		elseif typeof(friends) == "table" then
			for _, entry in friends :: {any} do
				if typeof(entry) ~= "table" then continue end
				local userId = (entry :: any).userId or (entry :: any).id
				if userId == nil then continue end
				local idStr = tostring(userId)
				local label = (entry :: any).name or (entry :: any).label or `Friend of {idStr}`
				addRole(ensure("Friend", idStr, label), roleKey)
			end
		end

		-- giveToUsers UserId entries already surface as member rows, but Preset
		-- entries are abstract givers and get their own row
		local users = (role :: any).giveToUsers
		if typeof(users) == "table" then
			for _, entry in users :: {any} do
				if typeof(entry) ~= "table" then continue end
				if (entry :: any).type ~= "Preset" then continue end
				local presetKey = (entry :: any).preset
				if typeof(presetKey) ~= "string" then continue end
				local preset = Presets.users[presetKey]
				local label: string = if preset and typeof(preset.label) == "string"
					then preset.label
					else presetKey
				addRole(ensure("UserPreset", presetKey, label), roleKey)
			end
		end
	end

	local out: {Giver} = {}
	for _, key in order do
		table.insert(out, byKey[key])
	end
	return out
end

local function buildGroupBreakdown(roleInfo: any, targetGroupId: string): GroupGiverBreakdown
	local result: GroupGiverBreakdown = {groupId = targetGroupId, sections = {}}
	if typeof(roleInfo) ~= "table" then return result end

	local allMembersRoleSet: {[string]: true} = {}
	local allMembersOrder: {string} = {}
	local specificByKey: {[string]: {rank: number, name: string, roleSet: {[string]: true}, order: {string}}} = {}
	local specificKeyOrder: {string} = {}

	for hdRoleKey, role in roleInfo :: any do
		if typeof(hdRoleKey) ~= "string" or typeof(role) ~= "table" then continue end
		if isInternalRole(role) then continue end
		local giveToGroups = (role :: any).giveToGroups
		if typeof(giveToGroups) ~= "table" then continue end
		for _, entry in giveToGroups :: {any} do
			if typeof(entry) ~= "table" then continue end
			local gid = (entry :: any).groupId
			if tostring(gid) ~= targetGroupId then continue end
			local et = (entry :: any).type
			if et == "AnyMember" then
				if not allMembersRoleSet[hdRoleKey] then
					allMembersRoleSet[hdRoleKey] = true
					table.insert(allMembersOrder, hdRoleKey)
				end
			elseif et == "SpecificRoles" and typeof((entry :: any).roles) == "table" then
				for _, groupRole in (entry :: any).roles :: {any} do
					if typeof(groupRole) ~= "table" then continue end
					local rRank = (groupRole :: any).rank
					local rName = (groupRole :: any).name
					if typeof(rRank) ~= "number" then continue end
					if typeof(rName) ~= "string" then rName = "" end
					local sectionKey = tostring(rRank) .. ":" .. rName
					local section = specificByKey[sectionKey]
					if section == nil then
						section = {rank = rRank, name = rName, roleSet = {}, order = {}}
						specificByKey[sectionKey] = section
						table.insert(specificKeyOrder, sectionKey)
					end
					if not section.roleSet[hdRoleKey] then
						section.roleSet[hdRoleKey] = true
						table.insert(section.order, hdRoleKey)
					end
				end
			end
		end
	end

	-- Rank descending with a stable key tiebreak so the order is deterministic
	local function sortHdKeys(keys: {string})
		table.sort(keys, function(keyA, keyB)
			local rankA = if typeof((roleInfo :: any)[keyA]) == "table" then ((roleInfo :: any)[keyA] :: any).rank or 0 else 0
			local rankB = if typeof((roleInfo :: any)[keyB]) == "table" then ((roleInfo :: any)[keyB] :: any).rank or 0 else 0
			if rankA ~= rankB then return rankA > rankB end
			return keyA < keyB
		end)
	end

	if #allMembersOrder > 0 then
		sortHdKeys(allMembersOrder)
		table.insert(result.sections, {
			kind = "AllMembers" :: GroupSectionKind,
			rank = nil,
			name = nil,
			hdAdminRoleKeys = allMembersOrder,
		})
	end

	-- Group rank descending, name tiebreak for stability
	table.sort(specificKeyOrder, function(keyA, keyB)
		local sectionA = specificByKey[keyA]
		local sectionB = specificByKey[keyB]
		if sectionA.rank ~= sectionB.rank then return sectionA.rank > sectionB.rank end
		return sectionA.name < sectionB.name
	end)
	for _, key in specificKeyOrder do
		local section = specificByKey[key]
		sortHdKeys(section.order)
		table.insert(result.sections, {
			kind = "SpecificRole" :: GroupSectionKind,
			rank = section.rank,
			name = section.name,
			hdAdminRoleKeys = section.order,
		})
	end

	return result
end


-- Keyed "type:id", displayName Computeds read this so names appear when the API returns
local nameScope = Fusion.scoped({ Value = Fusion.Value })
local resolvedNames: Fusion.Value<{[string]: string}> = nameScope:Value({})
local pendingFetch: {[string]: true} = {}
local function fetchGroupName(id: string)
	local numId = tonumber(id)
	if not numId then return end
	local ok, info = pcall(function()
		return GroupService:GetGroupInfoAsync(numId)
	end)
	if ok and typeof(info) == "table" and typeof((info :: any).Name) == "string" then
		local key = "Group:" .. id
		local cur = Fusion.peek(resolvedNames)
		local new = table.clone(cur)
		new[key] = (info :: any).Name
		resolvedNames:set(new)
	end
end

local function fetchProductName(id: string)
	local numId = tonumber(id)
	if not numId then return end
	-- Most products are GamePasses, fall back to Asset when the lookup misses
	local function tryInfo(infoType: Enum.InfoType): string?
		local ok, info = pcall(function()
			return MarketplaceService:GetProductInfo(numId, infoType)
		end)
		if ok and typeof(info) == "table" and typeof((info :: any).Name) == "string" then
			return (info :: any).Name
		end
		return nil
	end
	local name = tryInfo(Enum.InfoType.GamePass) or tryInfo(Enum.InfoType.Asset) or tryInfo(Enum.InfoType.Product)
	if name then
		local key = "Product:" .. id
		local cur = Fusion.peek(resolvedNames)
		local new = table.clone(cur)
		new[key] = name
		resolvedNames:set(new)
	end
end

local function ensureFetch(giverType: GiverType, id: string)
	local key = giverType .. ":" .. id
	if pendingFetch[key] then return end
	if Fusion.peek(resolvedNames)[key] then return end
	pendingFetch[key] = true
	if giverType == "Group" then
		task.spawn(fetchGroupName, id)
	elseif giverType == "Product" then
		task.spawn(fetchProductName, id)
	end
end

-- Falls back to giver.name while the API call is in flight, fetching on first call
local function makeNameComputed(scope: Fusion.Scope, giver: Giver): Fusion.UsedAs<string>
	ensureFetch(giver.type, giver.id)
	local key = giver.type .. ":" .. giver.id
	return scope:Computed(function(use)
		local cache = use(resolvedNames)
		return cache[key] or giver.name
	end)
end

local function typeLabel(giver: Giver): string
	if giver.type == "Friend" and giver.id == "friends" then return "Friends" end
	if giver.type == "UserPreset" then return "User Preset" end
	if giver.type == "Everyone" or giver.type == "PrivateServerOwner" then return "Preset" end
	if giver.type == "Product" then
		return if typeof(giver.subtype) == "string" then giver.subtype :: string else "Product"
	end
	if giver.type == "ProductPreset" then
		return if typeof(giver.subtype) == "string" then giver.subtype :: string else "Product Preset"
	end
	return giver.type
end

local function giverSubtitle(giver: Giver): string
	local label = typeLabel(giver)
	if giver.type == "Friend" and giver.id == "friends" then return label end
	if giver.type == "UserPreset" or giver.type == "ProductPreset" then return label end
	if giver.type == "Everyone" or giver.type == "PrivateServerOwner" then return label end
	return label .. ": " .. giver.id
end

-- Just the type label, the id is noisy when the row already shows the name
local function compactSubtitle(giver: Giver): string
	return typeLabel(giver)
end

local function giverImageUrl(giver: Giver): string
	local id = giver.id
	if giver.type == "Group" then
		return `rbxthumb://type=GroupIcon&id={id}&w=150&h=150`
	elseif giver.type == "Product" then
		-- The asset endpoint can't resolve game-pass ids and returns the game's
		-- default image, so route by subtype
		local thumbType = if giver.subtype == "GamePass" then "GamePass"
			elseif giver.subtype == "Bundle" then "BundleThumbnail"
			else "Asset"
		return `rbxthumb://type={thumbType}&id={id}&w=150&h=150`
	elseif giver.type == "Friend" then
		if id == "friends" then
			return ""
		end
		return `rbxthumb://type=AvatarHeadShot&id={id}&w=150&h=150`
	elseif giver.type == "Everyone" or giver.type == "PrivateServerOwner" then
		-- Same icon as the Creator preset
		local preset = Presets.users.Creator
		return if preset and typeof(preset.icon) == "string" then preset.icon else ""
	elseif giver.type == "UserPreset" then
		local preset = Presets.users[id]
		return if preset and typeof(preset.icon) == "string" then preset.icon else ""
	elseif giver.type == "ProductPreset" then
		local preset = Presets.products[id]
		return if preset and typeof(preset.icon) == "string" then preset.icon else ""
	end
	return ""
end

return {
	extract = extractGivers,
	imageUrl = giverImageUrl,
	subtitleFor = giverSubtitle,
	compactSubtitleFor = compactSubtitle,
	makeNameComputed = makeNameComputed,
	buildGroupBreakdown = buildGroupBreakdown,
}
