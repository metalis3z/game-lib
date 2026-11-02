--!strict
-- LOCAL
local ClientCommands = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local services = modules.Parent.Services
local Task = require(modules.Objects.Task)
local clientCommandsArray: Task.ClientCommands = {}
local lowerCaseNameDictionary: {[string]: ClientCommand} = {}
local commandsRequireUpdating = true
local Remote = require(modules.Objects.Remote)
local endedTaskUIDs: {[string]: true} = {}
local REMEMBER_ENDED_SECONDS = 30


-- TYPES
type Task = Task.Class
type ClientCommand = Task.ClientCommand
type ClientCommands = Task.ClientCommands


-- NETOWORKING
Remote.get("RunClientCommand"):onClientEvent(function(properties: Task.Properties, ...)
	local clientCommand = ClientCommands.getCommand(properties.commandKey)
	local activeTask = Task.getTask(properties.UID)
	if not clientCommand then
		return
	end
	if activeTask then
		activeTask.clientArgs = properties.clientArgs
		activeTask:run()
		return
	end
	local task = Task.new(properties)
	-- We keep client tasks until their server one ends. A task we've already been
	-- told to end is never getting that message a second time, so we let it run
	-- once and clean itself up instead of leaving it here for good
	local uid = properties.UID
	if not (uid and endedTaskUIDs[uid]) then
		task:keep("Indefinitely")
	end
end)

Remote.get("EndClientTask"):onClientEvent(function(taskUID: string, isDeactivate: boolean?)
	local activeTask = Task.getTask(taskUID)
	-- A deactivated task can reactivate and re-run with the same UID, so only
	-- remember UIDs that ended for good
	if not isDeactivate then
		endedTaskUIDs[taskUID] = true
		task.delay(REMEMBER_ENDED_SECONDS, function()
			endedTaskUIDs[taskUID] = nil
		end)
	end
	if not activeTask then
		return
	end
	if not activeTask.hasStartedInitialRun then
		-- If the server task ended before our deferred initial run started, its
		-- essential that we defer the destroying of the client task by one frame 
		-- so fire-and-forget client commands still run once
		task.defer(function()
			activeTask:destroy()
		end)
		return
	end
	activeTask:destroy()
end)

Remote.get("ReplicateClientCommand"):onClientEvent(function(commandKey:string, ...)
	local clientCommand = ClientCommands.getCommand(commandKey)
	if clientCommand and typeof(clientCommand.replication) == "function" then
		(clientCommand.replication :: any)(...)
	end
end)

local openPreviewRemote = require(modules.References.openPreviewRemote) :: any
openPreviewRemote:onClientEvent(function(payload: any)
	if typeof(payload) ~= "table" then return end
	local commandKey = (payload :: any).commandKey
	if typeof(commandKey) ~= "string" then return end
	local argTokens = (payload :: any).argTokens
	local modifierTokens = (payload :: any).modifierTokens
	local controllers = modules.Parent.Controllers
	local Panels = require(controllers.UI.Config.Panels) :: any
	Panels.openPreview(
		commandKey,
		if typeof(argTokens) == "table" then argTokens else nil,
		if typeof(modifierTokens) == "table" then modifierTokens else nil
	)
end)

local openEmotesRemote = require(modules.References.openEmotesRemote) :: any
openEmotesRemote:onClientEvent(function()
	local Panels = require(modules.Parent.Controllers.UI.Config.Panels) :: any
	Panels.openEmotes()
end)

local openProfileRemote = require(modules.References.openProfileRemote) :: any
openProfileRemote:onClientEvent(function(userId: unknown)
	if typeof(userId) ~= "number" then return end
	local Panels = require(modules.Parent.Controllers.UI.Config.Panels) :: any
	Panels.openProfile(userId)
end)

local openCommandsRemote = require(modules.References.openCommandsRemote) :: any
openCommandsRemote:onClientEvent(function(display: any)
	local Panels = require(modules.Parent.Controllers.UI.Config.Panels) :: any
	Panels.openCommands(display)
end)

local openBoosterRemote = require(modules.References.openBoosterRemote) :: any
openBoosterRemote:onClientEvent(function(forceReopen: boolean?, productName: string?)
	local Panels = require(modules.Parent.Controllers.UI.Config.Panels) :: any
	local wasOpen = Panels.isBoosterOpen()
	Panels.openBooster(forceReopen == true)
	if forceReopen == true and wasOpen and typeof(productName) == "string" then
		local promptPurchaseAsync = require(modules.AssetUtil.promptPurchaseAsync)
		task.spawn(function()
			local success, warning = promptPurchaseAsync(productName)
			if not success and typeof(warning) == "string" and warning ~= "" then
				require(modules.Prompt).warn(warning)
			end
		end)
	end
end)

local function highlightBooster(message: string, phrases: {string}): string
	local Fusion = require(modules.Parent.Packages.Fusion)
	local primary = Fusion.peek(require(modules.Parent.Controllers.UI.Util.Theme).Color.Primary) :: Color3
	local hex = string.format("%02X%02X%02X", math.floor(primary.R * 255 + 0.5), math.floor(primary.G * 255 + 0.5), math.floor(primary.B * 255 + 0.5))
	for _, phrase in phrases do
		local escaped = (phrase:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0"))
		message = (message:gsub(escaped, function(matched: string): string
			return `<font color="#{hex}"><b>{matched}</b></font>`
		end))
	end
	return message
end

local showBoosterOfferRemote = require(modules.References.showBoosterOfferRemote) :: any
showBoosterOfferRemote:onClientEvent(function(message: string, activatesDiscount: boolean?)
	local Panels = require(modules.Parent.Controllers.UI.Config.Panels) :: any
	if Panels.isBoosterOpen() then
		return
	end
	require(modules.Prompt).info(highlightBooster(message, {"20% off", "bonus chat commands"}), {
		duration = 0,
		onActivate = function()
			task.spawn(function()
				if activatesDiscount then
					Remote.get("StartBoosterOffer"):invokeServerAsync()
				end
				Panels.openBooster()
			end)
		end,
	})
end)

local boosterUnlockedRemote = require(modules.References.boosterUnlockedRemote) :: any
boosterUnlockedRemote:onClientEvent(function(display: any)
	local frontend = modules.Parent.Controllers.UI
	require(modules.Prompt).info(highlightBooster("You've unlocked Chat Commands! Type /commands in chat any time to view these commands", {"Chat Commands", "/commands"}), {duration = 0})
	local Panels = require(frontend.Config.Panels) :: any
	Panels.swapBoosterToCommands(if typeof(display) == "table" then display else nil)
end)

local MarketplaceService = game:GetService("MarketplaceService")
local recheckBoosterPurchaseRemote = require(modules.References.recheckBoosterPurchaseRemote) :: any
local productPromptClosedRemote = require(modules.References.productPromptClosedRemote) :: any
local boosterProducts = require(modules.References.products)
MarketplaceService.PromptBulkPurchaseFinished:Connect(function(_player, _status, results: any)
	local items = if typeof(results) == "table" then ((results :: any).Items or results) else nil
	if typeof(items) ~= "table" then return end
	local pokedBooster = false
	for _, entry: any in items :: {any} do
		if typeof(entry) ~= "table" then continue end
		local itemId = tonumber((entry).id or (entry).Id)
		if not itemId then continue end
		local succeeded = ((entry).status or (entry).Status) == Enum.MarketplaceItemPurchaseStatus.Success
		if not pokedBooster and succeeded and (itemId == boosterProducts.Booster.id or itemId == boosterProducts.BoosterDiscount.id) then
			recheckBoosterPurchaseRemote:fireServer()
			pokedBooster = true
		end
		productPromptClosedRemote:fireServer(itemId)
	end
end)

local openPageRemote = require(modules.References.openPageRemote) :: any
openPageRemote:onClientEvent(function(pageId: unknown, tabLabel: unknown)
	if typeof(pageId) ~= "string" then return end
	local Navigate = require(modules.Parent.Controllers.UI.Util.Navigate) :: any
	Navigate.openPanel()
	Navigate.toPage(pageId)
	if typeof(tabLabel) == "string" then
		-- Defer so the tab click can wait for the page to render
		task.defer(function()
			Navigate.waitForLabel(tabLabel, 2)
			Navigate.activate("Tab_" .. tabLabel)
		end)
	end
end)


-- FUNCTIONS
function ClientCommands.updateCommands()
	if not commandsRequireUpdating then
		return false
	end
	commandsRequireUpdating = false
	clientCommandsArray = {}
	lowerCaseNameDictionary = {}
	local forEveryCommand = require(modules.CommandUtil.forEveryCommand)
	local function scanContainerForClientCommands(container: Instance, requiresActiveModule: boolean?)
		for _, commandModule in container:GetChildren() do
			if not commandModule:IsA("ModuleScript") then
				if commandModule:IsA("Folder") then
					scanContainerForClientCommands(commandModule, requiresActiveModule)
				end
				continue
			end
			if requiresActiveModule == true and not commandModule:GetAttribute("IsActive") then
				continue
			end
			for _, clientCommandModule in commandModule:GetChildren() do
				if not clientCommandModule:IsA("ModuleScript") then
					continue
				end
				if clientCommandModule.Name:lower() ~= "client" then
					continue
				end
				local requireOk, commandsInside = pcall(require, clientCommandModule)
				if not requireOk then
					warn(`HD Admin: client command module '{clientCommandModule:GetFullName()}' failed to load: {commandsInside}`)
					continue
				end
				forEveryCommand(commandsInside :: any, function(command: any)
					table.insert(clientCommandsArray, command :: ClientCommand)
					lowerCaseNameDictionary[command.name:lower()] = command :: ClientCommand
				end)
			end
			scanContainerForClientCommands(commandModule, requiresActiveModule)
		end
	end
	scanContainerForClientCommands(modules.Internal.Commands, true)
	local commandsService = services:FindFirstChild("Commands")
	if commandsService then
		scanContainerForClientCommands(commandsService)
	end
	return true
end

function ClientCommands.getCommand(name: string): ClientCommand?
	ClientCommands.updateCommands()
	local lowerName = name:lower()
	local command = lowerCaseNameDictionary[lowerName] :: ClientCommand?
	return command
end

function ClientCommands.getCommandsArray()
	ClientCommands.updateCommands()
	return clientCommandsArray
end


return ClientCommands