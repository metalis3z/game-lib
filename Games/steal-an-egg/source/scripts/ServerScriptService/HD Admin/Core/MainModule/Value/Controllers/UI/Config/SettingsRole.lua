--!strict

--[[

	Per-role settings stored in everyone.RoleInfo[roleKey]

--]]


-- CONFIG
local USER_PRESET_PREFIX = "preset:" -- prefix stops a preset named "12345" colliding with a userId
local PRODUCT_PRESET_PREFIX = "preset:"
local PRODUCT_TYPES: {[string]: Enum.InfoType} = { -- valid product `type` values; mirrors the subset of Enum.InfoType we surface
	GamePass = Enum.InfoType.GamePass,
	Asset = Enum.InfoType.Asset,
	Bundle = Enum.InfoType.Bundle,
}


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local UI = modules.Parent.Controllers.UI
local InputObjects = require(UI.Config.InputObjects)
local Presets = require(UI.Config.Presets)
local Icons = require(UI.Config.Icons)
local Verifiers = require(modules.VerifyUtil.settingVerifiers)
local areValuesEqual = require(modules.DataUtil.areValuesEqual)


-- SHAPES
-- Preset allowlists come from Presets so a new preset auto-extends the shape
local function presetKeysFrom(table_: any): {string}
	local keys: {string} = {}
	if typeof(table_) ~= "table" then return keys end
	for key in table_ do
		if typeof(key) == "string" then table.insert(keys, key) end
	end
	return keys
end

local GIVE_TO_USERS_SHAPES: {[string]: any} = {
	UserId = { type = {oneOf = {"UserId"}}, userId = "positiveInteger" },
	Preset = { type = {oneOf = {"Preset"}}, preset = {oneOf = presetKeysFrom(Presets.users)} },
}
-- Stores rank + name since Roblox lets group roles share a rank. Matching prefers
-- exact (rank, name) and falls back to name-only after a rename
local GIVE_TO_GROUPS_SHAPES: {[string]: any} = {
	AnyMember = { type = {oneOf = {"AnyMember"}}, groupId = "positiveInteger" },
	SpecificRoles = {
		type = {oneOf = {"SpecificRoles"}},
		groupId = "positiveInteger",
		roles = { array = { shape = { rank = "nonNegativeInteger", name = "string" } }, max = 50 },
	},
}
local GIVE_TO_PRODUCTS_SHAPES: {[string]: any} = {
	GamePass = { type = {oneOf = {"GamePass"}}, id = "positiveInteger" },
	Asset    = { type = {oneOf = {"Asset"}},    id = "positiveInteger" },
	Bundle   = { type = {oneOf = {"Bundle"}},   id = "positiveInteger" },
	Preset   = { type = {oneOf = {"Preset"}},   preset = {oneOf = presetKeysFrom(Presets.products)} },
}

local function giveToUsersDedupKey(entry: any): string?
	if entry.type == "UserId" then return "UserId:" .. tostring(entry.userId) end
	if entry.type == "Preset" then return "Preset:" .. tostring(entry.preset) end
	return nil
end
local function giveToGroupsDedupKey(entry: any): string?
	return "Group:" .. tostring(entry.groupId)
end
local function giveToProductsDedupKey(entry: any): string?
	if entry.type == "Preset" then return "Preset:" .. tostring(entry.preset) end
	return string.lower(entry.type) .. ":" .. tostring(entry.id)
end


local booleanVerifier = Verifiers.boolean()


-- ESCALATION CHECKS
-- All bypass when the caller has mayEditAll. These don't go through
-- canGrantPermission so they check it directly

-- Icon hierarchy is Menu > Commands > None, an editor can grant up to their own level
local ICON_LEVEL: {[string]: number} = { None = 0, Commands = 1, Menu = 2 }
local function mayViewIconEscalation(callerUser: any, oldValue: any, newValue: any, Roles: any): (boolean, string?)
	if Roles.hasPermission(callerUser, "mayEditAll") then return true end
	if Roles.hasPermission(callerUser, "mayViewAll") then return true end
	local newLevel = ICON_LEVEL[tostring(newValue)] or 0
	if newLevel == 0 then return true end
	local callerLevel = 0
	for _, role in Roles.getRolesForUser(callerUser) do
		local lvl = ICON_LEVEL[tostring((role :: any).mayViewIcon)] or 0
		if lvl > callerLevel then callerLevel = lvl end
	end
	if newLevel <= callerLevel then return true end
	return false, `You cannot grant icon '{tostring(newValue)}' because you don't have it yourself`
end

-- The editor must be able to view each newly-added page. Removing is always fine
local function mayViewPagesEscalation(callerUser: any, oldValue: any, newValue: any, Roles: any): (boolean, string?)
	if Roles.hasPermission(callerUser, "mayEditAll") then return true end
	if Roles.hasPermission(callerUser, "mayViewAll") then return true end
	if typeof(newValue) ~= "table" then return true end
	local oldSet: {[string]: true} = {}
	if typeof(oldValue) == "table" then
		for _, page in oldValue :: {any} do
			if typeof(page) == "string" then oldSet[page] = true end
		end
	end
	for _, page in newValue :: {any} do
		if typeof(page) == "string" and not oldSet[page] then
			if page == "All" then
				return false, "You cannot grant 'All' pages without mayViewAll"
			end
			if not Roles.canViewPage(callerUser, page) then
				return false, `You cannot grant page '{page}' because you cannot view it yourself`
			end
		end
	end
	return true
end

-- The editor's roles must list the tag themselves or be able to use every
-- command carrying it. Removing is always fine
local function canUseEveryCommandWithTag(callerUser: any, tag: string, Roles: any): boolean
	local Commands = require(modules.Parent.Services.Commands) :: any
	for _, command in Commands.getCommandsArray() do
		local cmdTags = (command :: any).tags
		if typeof(cmdTags) == "table" and table.find(cmdTags :: {any}, tag) then
			if not Roles.canUseCommand(callerUser, command) then
				return false
			end
		end
	end
	return true
end

local function inheritCommandsWithTagsEscalation(callerUser: any, oldValue: any, newValue: any, Roles: any): (boolean, string?)
	if Roles.hasPermission(callerUser, "mayEditAll") then return true end
	if typeof(newValue) ~= "table" then return true end
	local oldSet: {[string]: true} = {}
	if typeof(oldValue) == "table" then
		for _, tag in oldValue :: {any} do
			if typeof(tag) == "string" then oldSet[tag] = true end
		end
	end
	local heldTags: {[string]: true} = {}
	for _, role in Roles.getRolesForUser(callerUser) do
		local tags: any = (role :: any).inheritCommandsWithTags
		if typeof(tags) == "table" then
			for _, tag in tags :: {any} do
				if typeof(tag) == "string" then heldTags[tag] = true end
			end
		end
	end
	for _, tag in newValue :: {any} do
		if typeof(tag) == "string" and not oldSet[tag] and not heldTags[tag] then
			if not canUseEveryCommandWithTag(callerUser, tag, Roles) then
				return false, `You can't add '{tag}' because your roles can't use all of its commands`
			end
		end
	end
	return true
end

-- A giver hands the whole role to whoever matches it, skipping the per-field
-- check, so the giver set may only grow when you could grant every perm it holds
local function isPermissionField(field: string): boolean
	return field:sub(1, 6) == "permit" or field:sub(1, 7) == "mayEdit"
		or field:sub(1, 7) == "mayView" or field:sub(1, 6) == "prompt"
end

-- The editor's roles must be able to use each newly-added command, removing is fine
local function inheritCommandsWithNamesEscalation(callerUser: any, oldValue: any, newValue: any, Roles: any): (boolean, string?)
	if Roles.hasPermission(callerUser, "mayEditAll") then return true end
	if typeof(newValue) ~= "table" then return true end
	local oldSet: {[string]: true} = {}
	if typeof(oldValue) == "table" then
		for _, entry in oldValue :: {any} do
			if typeof(entry) == "string" then oldSet[string.lower(entry)] = true end
		end
	end
	local Commands = require(modules.Parent.Services.Commands) :: any
	for _, entry in newValue :: {any} do
		if typeof(entry) ~= "string" then continue end
		if oldSet[string.lower(entry)] then continue end
		local command = Commands.getCommandByIdentity(entry) or Commands.getCommand(entry)
		if not command then
			return false, `'{entry}' is not a loaded command`
		end
		local canUse = Roles.canUseCommand(callerUser, command)
		if not canUse then
			return false, `You can't grant '{entry}' because your roles can't use it`
		end
	end
	return true
end

-- The first thing on the role the caller couldn't grant themselves, or nil
local function firstUngrantableReason(callerUser: any, role: any, Roles: any): string?
	if typeof(role) ~= "table" then return nil end
	for field, value in role do
		if value == true and typeof(field) == "string" and isPermissionField(field) then
			if not Roles.canGrantPermission(callerUser, field) then
				return `has the '{field}' ability which your roles don't`
			end
		end
	end
	-- These aren't plain toggles, so run them through their own checks
	if not (mayViewPagesEscalation(callerUser, nil, (role :: any).mayViewPages, Roles)) then
		return "can view pages which your roles can't"
	end
	if not (mayViewIconEscalation(callerUser, "None", (role :: any).mayViewIcon, Roles)) then
		return "has icon access which your roles don't"
	end
	if not (inheritCommandsWithTagsEscalation(callerUser, nil, (role :: any).inheritCommandsWithTags, Roles)) then
		return "includes commands which your roles can't use"
	end
	if not (inheritCommandsWithNamesEscalation(callerUser, nil, (role :: any).inheritCommandsWithNames, Roles)) then
		return "includes commands which your roles can't use"
	end
	return nil
end

-- A removal or no-op is always fine
local function giverExpanded(oldValue: any, newValue: any): boolean
	if typeof(newValue) == "boolean" then
		return newValue == true and oldValue ~= true
	end
	if typeof(newValue) ~= "table" then return false end
	local oldArray: {any} = if typeof(oldValue) == "table" then oldValue else {}
	for _, entry in newValue :: {any} do
		local found = false
		for _, oldEntry in oldArray do
			if areValuesEqual(entry, oldEntry) then
				found = true
				break
			end
		end
		if not found then return true end
	end
	return false
end

local function giverEscalation(callerUser: any, oldValue: any, newValue: any, Roles: any, targetRole: any): (boolean, string?)
	if Roles.hasPermission(callerUser, "mayEditAll") then return true end
	if not giverExpanded(oldValue, newValue) then return true end
	local reason = firstUngrantableReason(callerUser, targetRole, Roles)
	if reason then
		return false, `This role can't be given out automatically because it {reason}. Ask a higher rank to set this up`
	end
	return true
end


-- TYPES
type InputType = InputObjects.InputType


-- LOCAL FUNCTIONS
local function pascalSplit(text: string): string
	local out = text:gsub("(%l)(%u)", "%1 %2")
	return out:sub(1, 1):upper() .. out:sub(2)
end

local function stripFirstWord(text: string): string
	local afterFirst = text:match("^%l+(.*)$")
	if not afterFirst or afterFirst == "" then
		return pascalSplit(text)
	end
	return pascalSplit(afterFirst)
end

-- "giveToEveryone" -> "Everyone", "mayEditAll" -> "All"
local function stripTwoWords(text: string): string
	local afterFirst = text:match("^%l+(.*)$")
	if not afterFirst or afterFirst == "" then
		return pascalSplit(text)
	end
	local afterSecond = afterFirst:match("^%u%l*(.*)$")
	if not afterSecond or afterSecond == "" then
		return pascalSplit(afterFirst)
	end
	return pascalSplit(afterSecond)
end

local function toggleFor(title: string, label: string?): any
	return {
		title = title,
		label = label or pascalSplit(title),
		inputType = "Toggle" :: InputType,
		settingPath = { title },
		verifier = booleanVerifier,
	}
end

local function stripToggle(title: string, description: string?): any
	return {
		title = title,
		label = stripFirstWord(title),
		inputType = "Toggle" :: InputType,
		settingPath = { title },
		description = description,
		verifier = booleanVerifier,
	}
end

local function stripTextField(title: string): any
	return {
		title = title,
		label = stripFirstWord(title),
		inputType = "TextInput" :: InputType,
		settingPath = { title },
		verifier = Verifiers.safeString(64),
	}
end

local function stripTwoToggle(title: string, escalationCheck: any?): any
	return {
		title = title,
		label = stripTwoWords(title),
		inputType = "Toggle" :: InputType,
		settingPath = { title },
		verifier = booleanVerifier,
		escalationCheck = escalationCheck,
	}
end

local function stripTwoTextField(title: string): any
	return {
		title = title,
		label = stripTwoWords(title),
		inputType = "TextInput" :: InputType,
		settingPath = { title },
		verifier = Verifiers.safeString(64),
	}
end


-- SETTINGS
return
{
	--------------------------------------
	{
		heading = "About",
		objects = {
			{
				title = "key",
				label = "Key",
				inputType = "TextInput" :: InputType,
				settingPath = { "key" },
				immutable = true,
				inputObject = {
					limitTextLength = 32,
					preventWhitespaces = true,
				},
			},
			{
				title = "rank",
				label = "Rank",
				inputType = "NumberInput" :: InputType,
				settingPath = { "rank" },
				immutable = true,
				inputObject = {
					default = 1,
					min = 0,
					max = 255,
					step = 1,
					useSlider = false,
				},
			},
			{
				title = "data", -- opens the Copy/Load popup; onActivate wired per-page via SettingsList's objectOverrides (committed RoleInfo on Settings vs scratch State on Create)
				label = "Data",
				inputType = "ActionButton" :: InputType,
				settingPath = { "__data" }, -- unused, kept non-colliding
				inputObject = {
					buttonText = "Copy or Load",
					buttonIcon = "rbxassetid://131861503167070", -- Icons.Copy
				},
			},
		},
	},

	--------------------------------------
	{
		heading = "Display",
		objects = {
			{
				title = "name",
				label = "Name",
				inputType = "TextInput" :: InputType,
				settingPath = { "name" },
				inputObject = {
					limitTextLength = 32,
					mustBeStringSafe = true,
					filterText = true,
				},
				verifier = Verifiers.filteredText(128),
			},
			{
				title = "color",
				label = "Color",
				inputType = "ColorPicker" :: InputType,
				settingPath = { "color" },
				verifier = Verifiers.color3(),
			},
		},
	},

	--------------------------------------
	{
		heading = "Give To",
		objects = {
			stripTwoToggle("giveToEveryone", giverEscalation),
			stripTwoToggle("giveToPrivateServerOwner", giverEscalation),
			{
				title = "giveToUsers",
				label = "Users",
				inputType = "ItemSelector" :: InputType,
				settingPath = { "giveToUsers" },
				verifier = Verifiers.taggedArray(GIVE_TO_USERS_SHAPES, 50, 2048, giveToUsersDedupKey),
				escalationCheck = giverEscalation,
				inputObject = {
					canAnyUserBeAddedToPicker = true,
					displayServerPlayersInPicker = true,
					presetGetter = function()
						local items: { any } = {}
						for presetKey, preset in Presets.users do
							table.insert(items, {
								key = USER_PRESET_PREFIX .. presetKey,
								label = preset.label,
								header = preset.label,
								body = preset.description,
								icon = preset.icon,
								rawValue = presetKey,
								category = "preset",
							})
						end
						return items
					end,
					itemToEntry = function(item: any): any
						if item.category == "preset" then
							return {type = "Preset", preset = item.rawValue}
						end
						local raw = item.rawValue
						local uid: number? = if typeof(raw) == "Instance" and raw:IsA("Player")
							then (raw :: Player).UserId
							else tonumber(raw)
						return {type = "UserId", userId = uid or 0}
					end,
					entryToKey = function(entry: any): string?
						if typeof(entry) ~= "table" then return nil end
						local entryType = (entry :: any).type
						if entryType == "Preset" and typeof((entry :: any).preset) == "string" then
							return USER_PRESET_PREFIX .. (entry :: any).preset
						elseif entryType == "UserId" and typeof((entry :: any).userId) == "number" then
							return tostring((entry :: any).userId)
						end
						return nil
					end,
					hydrateEntry = function(entry: any): any?
						if typeof(entry) ~= "table" then return nil end
						if (entry :: any).type ~= "UserId" then return nil end
						local uid = tonumber((entry :: any).userId)
						if not uid then return nil end
						local Players = game:GetService("Players")
						local ok, name = pcall(Players.GetNameFromUserIdAsync, Players, uid)
						local username = if ok and typeof(name) == "string" then name else tostring(uid)
						return {
							key = tostring(uid),
							label = username .. " @" .. username,
							header = username,
							body = "@" .. username,
							icon = "https://www.roblox.com/headshot-thumbnail/image?userId="
								.. uid .. "&width=48&height=48&format=png",
							rawValue = uid,
							category = "custom",
						}
					end,
				},
			},
			{
				title = "giveToGroups",
				label = "Groups",
				inputType = "ItemSelector" :: InputType,
				settingPath = { "giveToGroups" },
				verifier = Verifiers.taggedArray(GIVE_TO_GROUPS_SHAPES, 20, 2048, giveToGroupsDedupKey),
				escalationCheck = giverEscalation,
				inputObject = {
					addFlow = "Group",
					itemToEntry = function(item: any): any
						local raw = item.rawValue
						if typeof(raw) == "table" and typeof((raw :: any).type) == "string" then
							return raw
						end
						return nil
					end,
					entryToKey = function(entry: any): string?
						if typeof(entry) ~= "table" then return nil end
						local gid = tonumber((entry :: any).groupId)
						if not gid then return nil end
						return "group:" .. tostring(gid)
					end,
					hydrateEntry = function(entry: any): any?
						if typeof(entry) ~= "table" then return nil end
						local gid = tonumber((entry :: any).groupId)
						if not gid then return nil end
						local entryType = (entry :: any).type
						if entryType ~= "AnyMember" and entryType ~= "SpecificRoles" then return nil end
						local GroupService = game:GetService("GroupService")
						local ok, info: any = pcall(function()
							return GroupService:GetGroupInfoAsync(gid)
						end)
						local groupName: string = if ok and typeof(info) == "table" and typeof(info.Name) == "string"
							then info.Name
							else "Group " .. tostring(gid)
						local subtitle: string
						if entryType == "SpecificRoles" and typeof((entry :: any).roles) == "table" then
							local cfgRoles = (entry :: any).roles :: { {rank: number, name: string} }
							if #cfgRoles == 0 then
								subtitle = "All Roles"
							else
								local names: { string } = {}
								-- If the role no longer exists the stored name still reads sensibly
								for _, cfgRole in cfgRoles do
									if typeof(cfgRole.name) == "string" and #cfgRole.name > 0 then
										table.insert(names, cfgRole.name)
									else
										table.insert(names, "Rank " .. tostring(cfgRole.rank))
									end
								end
								subtitle = table.concat(names, ", ")
							end
						else
							subtitle = "All Roles"
						end
						return {
							key = "group:" .. tostring(gid),
							label = groupName,
							header = groupName,
							body = tostring(gid),
							icon = "rbxthumb://type=GroupIcon&id=" .. tostring(gid) .. "&w=150&h=150",
							rawValue = entry,
							category = "custom",
							groupConfig = true,
							roleLabel = subtitle,
						}
					end,
				},
			},
			{
				title = "giveToProducts",
				label = "Products",
				inputType = "ItemSelector" :: InputType,
				settingPath = { "giveToProducts" },
				verifier = Verifiers.taggedArray(GIVE_TO_PRODUCTS_SHAPES, 50, 4096, giveToProductsDedupKey),
				escalationCheck = giverEscalation,
				inputObject = {
					addFlow = "Product",
					presetGetter = function()
						local items: { any } = {}
						for presetKey, preset in Presets.products do
							table.insert(items, {
								key = PRODUCT_PRESET_PREFIX .. presetKey,
								label = preset.label,
								header = preset.label,
								body = preset.description,
								icon = preset.icon,
								rawValue = presetKey,
								category = "preset",
							})
						end
						return items
					end,
					itemToEntry = function(item: any): any
						if item.category == "preset" then
							return {type = "Preset", preset = item.rawValue}
						end
						local raw = item.rawValue
						if typeof(raw) == "table" and typeof((raw :: any).type) == "string" then
							return {type = (raw :: any).type, id = (raw :: any).id}
						end
						return nil
					end,
					entryToKey = function(entry: any): string?
						if typeof(entry) ~= "table" then return nil end
						local entryType = (entry :: any).type
						if entryType == "Preset" and typeof((entry :: any).preset) == "string" then
							return PRODUCT_PRESET_PREFIX .. (entry :: any).preset
						elseif PRODUCT_TYPES[entryType] and typeof((entry :: any).id) == "number" then
							return string.lower(entryType) .. ":" .. tostring((entry :: any).id)
						end
						return nil
					end,
					hydrateEntry = function(entry: any): any?
						if typeof(entry) ~= "table" then return nil end
						local entryType = (entry :: any).type
						local infoEnum = PRODUCT_TYPES[entryType]
						if not infoEnum then return nil end
						local id = tonumber((entry :: any).id)
						if not id then return nil end
						local MarketplaceService = game:GetService("MarketplaceService")
						local ok, info: any = pcall(function()
							return MarketplaceService:GetProductInfo(id, infoEnum)
						end)
						local name: string = if ok and typeof(info) == "table" and typeof(info.Name) == "string"
							then info.Name
							else ("#" .. tostring(id))
						local iconImage: string = ""
						if ok and typeof(info) == "table" and typeof(info.IconImageAssetId) == "number" and info.IconImageAssetId > 0 then
							iconImage = "rbxassetid://" .. tostring(info.IconImageAssetId)
						end
						return {
							key = string.lower(entryType) .. ":" .. tostring(id),
							label = name,
							header = name,
							icon = if #iconImage > 0 then iconImage else nil,
							rawValue = {type = entryType, id = id},
							category = "custom",
							productConfig = true,
						}
					end,
				},
			},
		},
	},

	--------------------------------------
	{
		heading = "Commands",
		objects = {
			{
				title = "inheritCommandsFromJuniorRoles",
				label = "From Roles Below",
				inputType = "Toggle" :: InputType,
				settingPath = { "inheritCommandsFromJuniorRoles" },
				description = "This role can use the commands of all roles below this role",
				verifier = booleanVerifier,
			},
			{
				title = "inheritCommandsWithTags",
				label = "From Tags",
				inputType = "ItemSelector" :: InputType,
				settingPath = { "inheritCommandsWithTags" },
				description = "This role can use commands with these tags",
				escalationCheck = inheritCommandsWithTagsEscalation,
				verifier = function(_inputObject: any, value: any, _context: any?): (boolean, any)
					-- Tags are user-chosen so there's no fixed allowlist, capped on entries and bytes
					if typeof(value) ~= "table" then return false, "Expected an array" end
					local isWithinMaxSize = require(modules.VerifyUtil.isWithinMaxSize)
					local isStringSafe = require(modules.VerifyUtil.isStringSafe)
					if not isWithinMaxSize(value, 2048) then return false, "Array too large" end
					local seen: {[string]: true} = {}
					local cleaned: {string} = {}
					for index = 1, #value do
						local entry = (value :: {any})[index]
						if not isStringSafe(entry) then return false, `Entry {index} is not a safe string` end
						if not seen[entry] then
							seen[entry] = true
							table.insert(cleaned, entry)
						end
					end
					if #cleaned > 100 then return false, "Too many tags (max 100)" end
					return true, cleaned
				end,
				inputObject = {
					itemsGetter = function(itemScope: any)
						local modules = script:FindFirstAncestor("MainModule").Value.Modules
						local Fusion = require(modules.Parent.Packages.Fusion)
						local commandTagsFuse = itemScope:Fuse("everyone", "CommandTags")
						return itemScope:Computed(function(use: any)
							local data = use(commandTagsFuse)
							if typeof(data) ~= "table" then return {} end
							local items: {any} = {}
							for _, entry in data :: {any} do
								local tag = entry.Tag
								local total = entry.TotalCommands or 0
								if typeof(tag) == "string" and (tag :: string):sub(1, 1) ~= "_" then
									table.insert(items, {
										key = tag,
										label = tag,
										header = tag,
										body = `{total} Commands`,
										rawValue = tag,
										category = "qualifier",
										tagConfig = true,
									})
								end
							end
							-- CommandTags arrives pre-sorted, so the order passes through
							return items
						end)
					end,
				},
			},
			{
				title = "inheritCommandsWithNames",
				label = "From Names",
				inputType = "ItemSelector" :: InputType,
				settingPath = { "inheritCommandsWithNames" },
				description = "This role can use these commands",
				escalationCheck = inheritCommandsWithNamesEscalation,
				verifier = function(_inputObject: any, value: any, _context: any?): (boolean, any)
					if typeof(value) ~= "table" then return false, "Expected an array" end
					local isWithinMaxSize = require(modules.VerifyUtil.isWithinMaxSize)
					local isStringSafe = require(modules.VerifyUtil.isStringSafe)
					if not isWithinMaxSize(value, 2048) then return false, "Array too large" end
					local seen: {[string]: true} = {}
					local cleaned: {string} = {}
					for index = 1, #value do
						local entry = (value :: {any})[index]
						if not isStringSafe(entry) then return false, `Entry {index} is not a safe string` end
						if not seen[entry] then
							seen[entry] = true
							table.insert(cleaned, entry)
						end
					end
					if #cleaned > 100 then return false, "Too many commands (max 100)" end
					return true, cleaned
				end,
				inputObject = {
					itemsGetter = function(itemScope: any)
						local commandsFuse = itemScope:Fuse("everyone", "Commands")
						local vettingFuse = itemScope:Fuse("everyone", "CommandVetting")
						local unresolvedFuse = itemScope:Fuse("everyone", "UnresolvedCommandGrants")
						return itemScope:Computed(function(use: any)
							local data = use(commandsFuse)
							if typeof(data) ~= "table" then return {} end
							-- Commands awaiting vetting are granted but inert, so flag them
							local vetData = use(vettingFuse)
							local vetStates = if typeof(vetData) == "table" then (vetData :: any).states else nil
							local items: {any} = {}
							for _, command in data :: {any} do
								if typeof(command) ~= "table" then continue end
								if (command :: any).hide == true then continue end
								local isInternalOnly = false
								local tags = (command :: any).tags
								if typeof(tags) == "table" then
									for _, tag in tags :: {any} do
										if typeof(tag) == "string" and (tag :: string):sub(1, 1) == "_" then
											isInternalOnly = true
											break
										end
									end
								end
								if isInternalOnly then continue end
								local identity = (command :: any).identity or (command :: any).key
								local name = (command :: any).name
								if typeof(identity) ~= "string" or typeof(name) ~= "string" then continue end
								local isPending = typeof(vetStates) == "table" and vetStates[identity] == "pending"
								table.insert(items, {
									key = identity,
									label = name,
									header = name,
									body = if isPending then "Awaiting vetting" else nil,
									rawValue = identity,
									category = "qualifier",
								})
							end
							-- Saved grants that no longer resolve still render as chips,
							-- otherwise the row shows None while the grant sits stuck
							local unresolved = use(unresolvedFuse)
							if typeof(unresolved) == "table" then
								local seenUnresolved: {[string]: true} = {}
								for _, entry in unresolved :: {any} do
									if typeof(entry) ~= "table" or typeof((entry :: any).key) ~= "string" then continue end
									local rawKey = (entry :: any).key :: string
									if seenUnresolved[rawKey] then continue end
									seenUnresolved[rawKey] = true
									local isExcluded = (entry :: any).state == "excluded"
									local displayName = rawKey:sub(1, 1):upper() .. rawKey:sub(2)
									table.insert(items, {
										key = rawKey,
										label = displayName,
										header = displayName,
										rawValue = rawKey,
										category = "qualifier",
										hiddenFromPicker = true,
										unresolved = true,
										hintIcon = Icons.WarningFill,
										hintText = if isExcluded
											then "This command was disabled by the game dev in Config > Commands."
											else "This command no longer exists. Consider removing it from the role.",
									})
								end
							end
							table.sort(items, function(itemA: any, itemB: any)
								-- Unresolved grants float to the top so they get seen
								if (itemA.unresolved == true) ~= (itemB.unresolved == true) then
									return itemA.unresolved == true
								end
								return itemA.label < itemB.label
							end)
							return items
						end)
					end,
				},
			},
			{
				title = "viewCommands", -- opens CommandsFiltered for this role; onActivate wired by RoleSettingsPage via objectOverrides, no effect outside that page
				label = "View",
				inputType = "ActionButton" :: InputType,
				settingPath = { "__viewCommands" },
				description = "The commands this role is able to use",
				inputObject = {
					buttonText = "View Commands",
					buttonIcon = "rbxassetid://116538790441934", -- Icons.Pages.Commands
				},
			},
		},
	},

	--------------------------------------
	{
		heading = "Command Permissions",
		objects = {
			{ title = "permitAll", label = "All Permissions", inputType = "Toggle" :: InputType, settingPath = { "permitAll" }, description = "This is DANGEROUS", verifier = booleanVerifier },
			stripToggle("permitTargetingOthers", "Can use commands on other players instead of solely yourself (like ;jump @ForeverHD)"),
			{
				title = "permitMultipleTargets",
				label = stripFirstWord("permitMultipleTargets"),
				inputType = "Toggle" :: InputType,
				settingPath = { "permitMultipleTargets" },
				description = "Can use commands on more than one player in a single command-run (like ;jump all, ;fly others)",
				verifier = booleanVerifier,
				lockedDisplayValue = function(ctx: any): any
					-- Display true under the permitAll umbrella, otherwise display false
					local permitAllValue = ctx.valueByTitle["permitAll"]
					if permitAllValue and ctx.use(permitAllValue) == true then
						return true
					end
					return false
				end,
			},
			stripToggle("permitModifiersAbusive", "Permits potentially-abusive modifiers including 'loop', 'spawn', and 'delay'"),
			stripToggle("permitModifiersGlobal", "Permits EXTREMELY DANGEROUS modifiers including 'global', 'perm' and 'join'"),
			stripToggle("permitBypassLimits", "Ignores role limits and command-specific limits (such as scale limits for ;width, ;size, etc). This is DANGEROUS and can crash servers if abused."),
		},
	},

	--------------------------------------
	{
		heading = "Command Limits",
		objects = {
			{
				title = "limitCommandsPerMinute",
				label = stripFirstWord("limitCommandsPerMinute"),
				inputType = "NumberInput" :: InputType,
				settingPath = { "limitCommandsPerMinute" },
				inputObject = {
					default = 60,
					min = 0,
					max = 600,
					step = 1,
					useSlider = false,
				},
				verifier = Verifiers.integerRange(0, 600),
			},
			{
				title = "limitRequestsPerSecond",
				label = stripFirstWord("limitRequestsPerSecond"),
				inputType = "NumberInput" :: InputType,
				settingPath = { "limitRequestsPerSecond" },
				inputObject = {
					default = 10,
					min = 0,
					max = 60,
					step = 1,
					useSlider = false,
				},
				verifier = Verifiers.integerRange(0, 60),
			},
		},
	},

	--------------------------------------
	{
		heading = "Role Permissions",
		objects = {
			{
				title = "mayPreviewRoles",
				label = "Preview Roles",
				inputType = "Toggle" :: InputType,
				settingPath = { "mayPreviewRoles" },
				description = "Can preview and act-as selected roles equal or below this role. Be careful because it grants all permissions from roles below.",
				verifier = booleanVerifier,
			},
		},
	},

	--------------------------------------
	{
		heading = "View Permissions",
		objects = {
			{ title = "mayViewAll", label = "All Permissions", inputType = "Toggle" :: InputType, settingPath = { "mayViewAll" }, verifier = booleanVerifier },
			{
				title = "mayViewIcon",
				label = "Icon",
				inputType = "ItemSelector" :: InputType,
				settingPath = { "mayViewIcon" },
				lockedDisplayValue = "Menu",
				description = "Should the TopbarPlus Icon appear, and for which page? If 'Commands', only the Commands page is accessible (not the dashboard)",
				escalationCheck = mayViewIconEscalation,
				verifier = Verifiers.oneOfString({"Menu", "Commands", "None"}),
				inputObject = {
					limitPickerToOneItem = true,
					pickerGetter = function()
						return {
							{ key = "None", label = "None", header = "None", rawValue = "None", category = "qualifier" },
							{ key = "Commands", label = "Commands", header = "Commands", rawValue = "Commands", category = "qualifier" },
							{ key = "Menu", label = "Menu", header = "Menu", rawValue = "Menu", category = "qualifier" },
						}
					end,
				},
			},
			{
				title = "mayViewPages",
				label = "Pages",
				inputType = "ItemSelector" :: InputType,
				settingPath = { "mayViewPages" },
				lockedDisplayValue = "All",
				escalationCheck = mayViewPagesEscalation,
				verifier = Verifiers.arrayOfOneOfString(
					{"Commands", "CommandBar", "Analytics", "Bans", "Warns", "Roles", "RoleSettings",
					 "MembersServer", "MembersPermanent", "Tasks", "Logs", "YouSettings", "GameSettings"},
					13, 512
				),
				inputObject = {
					pickerGetter = function()
						return {
							{ key = "All", label = "All", header = "All", rawValue = "All", category = "qualifier", hiddenFromPicker = true },
							{ key = "Commands", label = "Commands", header = "Commands", rawValue = "Commands", category = "qualifier" },
							{ key = "CommandBar", label = "Command Bar", header = "Command Bar", rawValue = "CommandBar", category = "qualifier" },
							{ key = "Analytics", label = "Analytics", header = "Analytics", rawValue = "Analytics", category = "qualifier" },
							{ key = "Bans", label = "Bans", header = "Bans", rawValue = "Bans", category = "qualifier" },
							{ key = "Warns", label = "Warns", header = "Warns", rawValue = "Warns", category = "qualifier" },
							{ key = "Roles", label = "Roles", header = "Roles", rawValue = "Roles", category = "qualifier" },
							{ key = "RoleSettings", label = "Role Settings", header = "Role Settings", rawValue = "RoleSettings", category = "qualifier" },
							{ key = "MembersServer", label = "Members Server", header = "Members Server", rawValue = "MembersServer", category = "qualifier" },
							{ key = "MembersPermanent", label = "Members Permanent", header = "Members Permanent", rawValue = "MembersPermanent", category = "qualifier" },
							{ key = "Tasks", label = "Tasks", header = "Tasks", rawValue = "Tasks", category = "qualifier" },
							{ key = "Logs", label = "Logs", header = "Logs", rawValue = "Logs", category = "qualifier" },
							{ key = "YouSettings", label = "You Settings", header = "You Settings", rawValue = "YouSettings", category = "qualifier" },
							{ key = "GameSettings", label = "Game Settings", header = "Game Settings", rawValue = "GameSettings", category = "qualifier" },
						}
					end,
				},
			},
			{
				title = "mayViewUnavailableCommands",
				label = "Unavailable Commands",
				inputType = "Toggle" :: InputType,
				settingPath = { "mayViewUnavailableCommands" },
				description = "Can the user see commands that can't be used, bought or unlocked?",
				verifier = booleanVerifier,
			},
		},
	},

	--------------------------------------
	{
		heading = "Edit Permissions",
		objects = {
			{ title = "mayEditAll", label = "All Permissions", inputType = "Toggle" :: InputType, settingPath = { "mayEditAll" }, description = "This is DANGEROUS", verifier = booleanVerifier },
			{ title = "mayEditRoles", label = "Roles", inputType = "Toggle" :: InputType, settingPath = { "mayEditRoles" }, description = "Can create, edit, delete, and reorder roles ranked below this one. Can only grant permissions this role already holds.", verifier = booleanVerifier },
			{ title = "mayEditTasks", label = "Tasks", inputType = "Toggle" :: InputType, settingPath = { "mayEditTasks" }, description = "Can pause, resume, and cancel any running command task within the Tasks page", verifier = booleanVerifier },
			{ title = "mayEditSettingsYou", label = "You Settings", inputType = "Toggle" :: InputType, settingPath = { "mayEditSettingsYou" }, description = "Can edit personal settings like theme, prefix, and sound", verifier = booleanVerifier },
			{ title = "mayEditSettingsGame", label = "Game Settings", inputType = "Toggle" :: InputType, settingPath = { "mayEditSettingsGame" }, description = "This is DANGEROUS. Users of this role can make universe-wide changes", verifier = booleanVerifier },
			{ title = "mayVetCommands", label = "Vet Commands", inputType = "Toggle" :: InputType, settingPath = { "mayVetCommands" }, description = "Can approve, disable and test new commands that arrive from HD Admin updates", verifier = booleanVerifier },
		},
	},

	--------------------------------------
	{
		heading = "Prompt",
		objects = {
			{ title = "promptAll", label = "All Prompts", inputType = "Toggle" :: InputType, settingPath = { "promptAll" }, verifier = booleanVerifier },
			stripToggle("promptWarnings", "Shows warning notices (like invalid command, missing permission)"),
			stripToggle("promptWelcome", "Shows welcome notices on join (like 'your roles are [xyz]')"),
		},
	},
}
