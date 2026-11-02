--!strict
-- These are the internal command modules
-- Every command lives here so it can keep receiving fixes and improvements
-- without games having to manually update their loader. The packs within the
-- loader Config choose what loads via Internal.loadCommands
-- See docs/command-loading.md for the full contract


-- LOCAL
local Internal = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Framework = require(modules.Framework)
local Task = require(modules.Objects.Task)
local forEveryCommand = require(modules.CommandUtil.forEveryCommand)
local excludedLedger: {[string]: {name: string, pack: string, module: string}} = {}
local tagOrders: {[string]: number} = {}


-- TYPES
export type LoadDetails = {
	modules: {string},
	exclude: {string}?,
	onlyInclude: {string}?,
	tag: string?,
	tagOrder: number?, -- position in tag pickers; unordered tags follow alphabetically
	modify: {[string]: (command: any) -> ()}?,
}


-- FUNCTIONS
-- The identity is what vetting statuses, From Names grants and dev lists are
-- stored against. Commands only gain an 'id' when renamed, so that saved
-- references keep resolving (the id is the original name)
function Internal.getIdentity(command: any): string
	local reference = (command :: any).id or (command :: any).name
	return string.lower(tostring(reference))
end

-- Commands the dev filtered out of a loaded module. Lets saved references show
-- 'disabled by game dev' instead of 'unknown'
function Internal.getExcludedLedger()
	return excludedLedger
end

-- Each pack declares its own picker position via tagOrder, so the ordering
-- survives a dev renaming their pack module (the tag string changes, the
-- order rides along with it)
function Internal.getTagOrders(): {[string]: number}
	return tagOrders
end

function Internal.loadCommands(details: LoadDetails): Task.Commands
	local packTag = if typeof(details.tag) == "string" then details.tag else "UnknownPack"
	if typeof(details.tagOrder) == "number" then
		tagOrders[packTag] = details.tagOrder
	end
	local serverModules = Framework.getServerModules() :: any
	if not serverModules then
		warn("HD Admin: loadCommands must be called from the server")
		return {}
	end
	local exclude = details.exclude
	local onlyInclude = details.onlyInclude
	local hasExclude = typeof(exclude) == "table" and #exclude :: any > 0
	local hasOnlyInclude = typeof(onlyInclude) == "table" and #onlyInclude :: any > 0
	if hasExclude and hasOnlyInclude then
		warn(`HD Admin: {packTag} sets both exclude and onlyInclude, ignoring exclude`)
		hasExclude = false
	end

	-- A requested module can be a top-level child of Internal/Commands, or a
	-- child of one of those (like Troll under Fun). Client halves never match
	local function findRequestedModule(moduleName: string): (Instance?, Instance?, string?)
		local serverContainer = serverModules.Internal.Commands
		local sharedContainer = modules.Internal.Commands
		local serverDirect = serverContainer:FindFirstChild(moduleName)
		local sharedDirect = sharedContainer:FindFirstChild(moduleName)
		if serverDirect and sharedDirect then
			return serverDirect, sharedDirect, moduleName
		end
		local matches: {{server: Instance, shared: Instance, path: string}} = {}
		for _, topLevel in sharedContainer:GetChildren() do
			if not topLevel:IsA("ModuleScript") then
				continue
			end
			local sharedChild = topLevel:FindFirstChild(moduleName)
			if not sharedChild or not sharedChild:IsA("ModuleScript") then
				continue
			end
			if string.lower(sharedChild.Name) == "client" then
				continue
			end
			local serverTop = serverContainer:FindFirstChild(topLevel.Name)
			local serverChild = if serverTop then serverTop:FindFirstChild(moduleName) else nil
			if serverChild then
				table.insert(matches, {server = serverChild, shared = sharedChild, path = `{topLevel.Name}/{moduleName}`})
			end
		end
		if #matches > 1 then
			local paths = {}
			for _, match in matches do
				table.insert(paths, match.path)
			end
			warn(`HD Admin: module '{moduleName}' is ambiguous ({table.concat(paths, ", ")}), requested by {packTag}`)
			return nil, nil, nil
		end
		local match = matches[1]
		if match then
			return match.server, match.shared, match.path
		end
		warn(`HD Admin: internal module '{moduleName}' not found (requested by {packTag})`)
		return nil, nil, nil
	end

	-- Collect every command from the requested modules
	local collected: {{command: any, module: string, sharedModule: Instance}} = {}
	for _, moduleName in details.modules do
		local serverModule, sharedModule, modulePath = findRequestedModule(moduleName)
		if not serverModule or not sharedModule or not modulePath then
			continue
		end
		-- Re-referencing a module another pack loaded is fine. The require is
		-- cached so the same command tables come back, every pack's tag and
		-- modify layer on, and registration dedupes so commands exist once
		local success, moduleCommands = pcall(require, serverModule)
		if not success then
			warn(`HD Admin: internal module '{modulePath}' failed to load: {moduleCommands}`)
			continue
		end
		forEveryCommand(moduleCommands, function(command: any)
			table.insert(collected, {command = command, module = modulePath, sharedModule = sharedModule})
		end)
	end

	-- Dev lists accept the identity, current name or an alias, so all three
	-- point at an index here. Typos warn instead of silently matching nothing
	local resolver: {[string]: number} = {}
	local function offer(key: string?, index: number)
		if typeof(key) ~= "string" then
			return
		end
		local keyLower = string.lower(key)
		if resolver[keyLower] == nil then
			resolver[keyLower] = index
		end
	end
	for index, entry in collected do
		offer(Internal.getIdentity(entry.command), index)
		offer(entry.command.name, index)
		if typeof(entry.command.aliases) == "table" then
			for _, alias in entry.command.aliases :: {any} do
				offer(alias, index)
			end
		end
	end
	local function resolveKey(key: string, sourceName: string): number?
		local index = resolver[string.lower(key)]
		if not index then
			warn(`HD Admin: {packTag} {sourceName} references unknown command '{key}'`)
		end
		return index
	end

	-- Work out which collected commands this pack drops
	local droppedSet: {[number]: boolean} = {}
	if hasOnlyInclude then
		local keepSet: {[number]: boolean} = {}
		for _, key in onlyInclude :: {string} do
			local index = resolveKey(key, "onlyInclude")
			if index then
				keepSet[index] = true
			end
		end
		for index = 1, #collected do
			if not keepSet[index] then
				droppedSet[index] = true
			end
		end
	elseif hasExclude then
		for _, key in exclude :: {string} do
			local index = resolveKey(key, "exclude")
			if index then
				droppedSet[index] = true
			end
		end
	end

	-- Build the kept array, recording drops in the ledger and remembering which
	-- child modules contributed so their client halves get flagged active
	local commands: {any} = {}
	local activeSources: {[Instance]: {[string]: boolean}} = {}
	for index, entry in collected do
		local command = entry.command
		if droppedSet[index] then
			excludedLedger[Internal.getIdentity(command)] = {name = command.name, pack = packTag, module = entry.module}
			continue
		end
		if typeof(command.config) ~= "table" then
			command.config = {}
		end
		if typeof(command.tags) ~= "table" then
			command.tags = {}
		end
		-- Only internally loaded commands enter vetting, never Custom or Booster
		command.fromInternal = true
		-- Migrated modules share one tags table across their commands, so
		-- guard against appending the pack tag once per command
		if not table.find(command.tags, packTag) then
			table.insert(command.tags, packTag)
		end
		table.insert(commands, command)
		local sources = activeSources[entry.sharedModule]
		if not sources then
			sources = {}
			activeSources[entry.sharedModule] = sources
		end
		if typeof(command.sourceModule) == "string" then
			sources[command.sourceModule] = true
		end
	end

	-- Apply the pack's per-command tweaks
	if typeof(details.modify) == "table" then
		for key, modifier in details.modify :: {[string]: (any) -> ()} do
			local index = resolveKey(key, "modify")
			if index and not droppedSet[index] then
				local success, problem = pcall(modifier, collected[index].command)
				if not success then
					warn(`HD Admin: {packTag} modify for '{key}' errored: {problem}`)
				end
			end
		end
	end

	-- The client only requires Client halves of modules flagged active
	for sharedModule, sources in activeSources do
		sharedModule:SetAttribute("IsActive", true)
		-- Nested loads need their parent chain active too or the client
		-- scanner never descends to them
		local parent = sharedModule.Parent
		while parent and parent:IsA("ModuleScript") do
			parent:SetAttribute("IsActive", true)
			parent = parent.Parent
		end
		for childName in sources do
			local child = sharedModule:FindFirstChild(childName)
			if child then
				child:SetAttribute("IsActive", true)
			end
		end
	end

	return commands :: Task.Commands
end


return Internal
