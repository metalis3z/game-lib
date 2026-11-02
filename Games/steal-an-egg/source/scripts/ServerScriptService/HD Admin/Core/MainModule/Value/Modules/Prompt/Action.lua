--!strict
--[[

	This is the server-side handler and remotes for action prompts


--]]


-- CONFIG
local INPUT_TYPE_TO_ARG: {[string]: string} = {
	NumberInput = "Number",
	NumberSlider = "Number",
	ColorPicker = "Color",
	Toggle = "Bool",
	Options = "Options",
}
local MAX_RAW_CONTROL_STRING = 200


-- LOCAL
local Action = {}
local Players = game:GetService("Players")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Remote = require(modules.Objects.Remote)
local Prompt = require(modules.Prompt)
local generateUID = require(modules.DataUtil.generateUID)
local createConnection = require(modules.AssetUtil.createConnection)
local controlRemote: Remote.Class? = nil
local updateRemote: Remote.Class? = nil
local activePrompts: {[string]: Entry} = {}


-- TYPES
type Entry = {
	taskRef: any,
	configRef: any,
	audienceUserId: number,
	controls: {[string]: (value: any) -> ()},
	buttons: {[string]: () -> ()},
	iconButtons: {[string]: (value: boolean) -> ()},
	state: string,
	rerunnable: boolean,
	endOnClose: boolean,
}
type Disconnect = createConnection.Disconnect


-- LOCAL FUNCTIONS
local function audiencePlayer(entry: Entry): Player?
	return Players:GetPlayerByUserId(entry.audienceUserId)
end

local function pushState(promptId: string, entry: Entry, state: string)
	entry.state = state
	local player = audiencePlayer(entry)
	if player and updateRemote then
		updateRemote:fireClient(player, promptId, state)
	end
end

local function pushButtonLoading(promptId: string, buttonId: string, isLoading: boolean)
	local entry = activePrompts[promptId]
	if not entry then
		return
	end
	local player = audiencePlayer(entry)
	if player and updateRemote then
		updateRemote:fireClient(player, promptId, nil, { buttonLoading = { [buttonId] = isLoading } })
	end
end

local function close(promptId: string)
	local entry = activePrompts[promptId]
	if not entry then
		return
	end
	activePrompts[promptId] = nil
	if entry.taskRef then
		entry.taskRef.actionPromptId = nil
	end
	local player = audiencePlayer(entry)
	if player then
		Prompt.dismissRaw(player, promptId)
	end
end

local function destroyTaskAndEntry(taskRef: any, reason: string)
	local entryUID = if typeof(taskRef.extra) == "table" then taskRef.extra.entryUID else nil
	taskRef:destroy()
	if typeof(entryUID) == "string" then
		local PermTasks = require(modules.Parent.Services.Tasks.PermTasks) :: any
		PermTasks.remove(entryUID, reason)
	end
end

local function ensureControlRemote()
	if controlRemote then
		return
	end
	-- Create both action remotes together so the client can fetch PromptUpdate as
	-- soon as it receives an action prompt
	updateRemote = Remote.new("PromptUpdate", "Event", "Low")
	controlRemote = Remote.new("PromptControl", "Event", "Low")
	if not controlRemote then
		return
	end
	controlRemote:onServerEvent(function(player: Player, promptId: unknown, actionType: unknown, id: unknown, value: any)
		if typeof(promptId) ~= "string" then
			return
		end
		local entry = activePrompts[promptId]
		if not entry then
			return
		end
		-- Only the affected player may drive their own prompt
		if player.UserId ~= entry.audienceUserId then
			return
		end
		local taskRef = entry.taskRef
		if actionType == "control" and typeof(id) == "string" then
			local handler = entry.controls[id]
			if handler then
				handler(value)
			end
		elseif actionType == "button" and typeof(id) == "string" then
			local handler = entry.buttons[id]
			if handler then
				local buttonId = id :: string
				task.spawn(function()
					pushButtonLoading(promptId :: string, buttonId, true)
					local ok, err = pcall(handler)
					pushButtonLoading(promptId :: string, buttonId, false)
					if not ok then
						warn(`HD Admin: prompt button '{buttonId}' errored: {err}`)
					end
				end)
			end
		elseif actionType == "iconButton" and typeof(id) == "string" then
			if typeof(value) == "boolean" then
				local handler = entry.iconButtons[id]
				if handler then
					handler(value)
				end
			end
		elseif actionType == "deactivate" then
			if taskRef and taskRef.isActive and not taskRef.deactivated then
				taskRef:deactivate()
				pushState(promptId :: string, entry, "inactive")
			end
		elseif actionType == "activate" then
			if taskRef and taskRef.isActive and taskRef.deactivated then
				taskRef:reactivate()
				pushState(promptId :: string, entry, "active")
			end
		elseif actionType == "rerun" then
			-- It's important that we re-run only for items actually marked
			-- rerunnable server-side, and its also important we also  call deactivate
			-- and reactivate so the previous run effects (buffs, sounds, instances)
			-- are cleaned up FIRST instead of stacking on top
			if entry.rerunnable and taskRef and taskRef.isActive and not taskRef.deactivated and taskRef.rerunCommand then
				taskRef:deactivate()
				taskRef:reactivate()
			end
		elseif actionType == "dismiss" then
			-- Closing the card ends the task if it's toggled off (no live effect) or the
			-- command opted into endOnClose (the card was its whole reason to exist), else
			-- the card just goes and the task keeps running
			if taskRef and taskRef.isActive and (taskRef.deactivated or entry.endOnClose) then
				destroyTaskAndEntry(taskRef, "prompt card dismissed")
			else
				close(promptId :: string)
			end
		elseif actionType == "end" then
			if taskRef and taskRef.isActive then
				destroyTaskAndEntry(taskRef, "prompt card end")
			else
				close(promptId :: string)
			end
		end
	end)
end

local function sanitiseConfig(inputObject: any): {[string]: any}
	local config = {}
	for key, value in inputObject do
		if typeof(value) ~= "function" and key ~= "inputType" then
			config[key] = value
		end
	end
	return config
end

local function validateThroughArg(argDetail: any, rawValue: any, targetUserId: number?): any
	local Args = require(modules.Parser.Args)
	if typeof(rawValue) == "string" and #rawValue > MAX_RAW_CONTROL_STRING then
		rawValue = string.sub(rawValue, 1, MAX_RAW_CONTROL_STRING)
	end
	local unparsedOk, unparsedString = pcall(argDetail.unparse, argDetail, rawValue)
	if not unparsedOk or typeof(unparsedString) ~= "string" then
		return nil
	end
	unparsedString = Args.processStringToParse(unparsedString, argDetail.maxCharacters)
	local parsedOk, parsedValue = pcall(argDetail.parse, argDetail, unparsedString, targetUserId, targetUserId)
	if not parsedOk then
		return nil
	end
	return parsedValue
end

-- This is rebuilt on a reactivate re-run so the handlers and data follow the
-- current emote
local function buildIconButtons(entry: Entry, config: any): {any}
	local serial = {}
	entry.iconButtons = {}
	if config.iconButtons then
		for index, iconButton in config.iconButtons do
			local id = "i" .. index
			entry.iconButtons[id] = iconButton.onAction or function() end
			table.insert(serial, {
				id = id,
				component = iconButton.component, 
				active = iconButton.active == true,
				assetId = iconButton.assetId,
				emoteName = iconButton.emoteName,
				animationId = iconButton.animationId,
			})
		end
	end
	return serial
end


-- PUBLIC FUNCTIONS
function Action.bind(commandTask: any, config: any): Disconnect
	ensureControlRemote()
	local audience = config.audience or commandTask.target
	if not (typeof(audience) == "Instance" and audience:IsA("Player")) then
		-- Nothing to show without a player audience
		return createConnection(function() end)
	end
	local promptId = generateUID(10)
	local entry: Entry = {
		taskRef = commandTask,
		configRef = config,
		audienceUserId = audience.UserId,
		controls = {},
		buttons = {},
		iconButtons = {},
		state = "active",
		rerunnable = config.rerun == true,
		endOnClose = config.endOnClose == true,
	}
	local serialControls = {}
	local serialButtons = {}
	local serialIconButtons = {}

	local function addControl(argName: any, spec: any, onChange: (value: any) -> ())
		local Args = require(modules.Parser.Args)
		local index = #serialControls + 1
		local id = "c" .. index
		local inputType = spec.inputType
		local controlConfig = spec.config
		local value = spec.value
		if argName then
			local argDetail = commandTask:getArgDetail(argName)
			local inputObject = argDetail and (argDetail :: any).inputObject
			if inputObject then
				inputType = inputType or inputObject.inputType
				controlConfig = controlConfig or sanitiseConfig(inputObject)
				if value == nil then
					value = commandTask:getArg(argName)
				end
				if value == nil then
					value = inputObject.default
				end
			end
		end
		-- Every incoming value is validated through the bound arg before onChange sees it
		local validationArg: any = nil
		local resolvedArgName = argName or INPUT_TYPE_TO_ARG[inputType or ""]
		local baseArg = if argName ~= nil then commandTask:getArgDetail(argName) else (resolvedArgName and Args.get(resolvedArgName))
		if baseArg then
			validationArg = table.clone(baseArg)
			if typeof(controlConfig) == "table" then
				if controlConfig.min ~= nil then validationArg.min = controlConfig.min end
				if controlConfig.max ~= nil then validationArg.max = controlConfig.max end
				if controlConfig.step ~= nil then validationArg.step = controlConfig.step end
				if controlConfig.maxCharacters ~= nil then validationArg.maxCharacters = controlConfig.maxCharacters end
			end
		end
		entry.controls[id] = function(rawValue: any)
			if validationArg == nil then
				return -- Drop rather than trust
			end
			-- targetUserId is primarily used to bypass the check, but target-less commands
			-- (such as Music, Time, Fog, etc) have none, so we fall back to the caller's userid
			local authorityUserId = commandTask.targetUserId or commandTask.callerUserId
			local cleanValue = validateThroughArg(validationArg, rawValue, authorityUserId)
			if cleanValue == nil then
				return
			end
			if argName then
				local ArgProducts = require(modules.CommandUtil.ArgProducts)
				local argDetail = commandTask:getArgDetail(argName)
				local gateProducts = ArgProducts.getProducts(argDetail)
				if gateProducts and not ArgProducts.matchesDefault(argDetail, cleanValue) then
					local player = audiencePlayer(entry)
					if not player then
						return
					end
					if not ArgProducts.ownsAnyAsync(player, gateProducts) then
						local Commands = require(modules.Parent.Services.Commands) :: any
						local command = Commands.getCommand(commandTask.commandKey)
						local commandName = if command then (command :: any).name else commandTask.commandKey
						ArgProducts.sendUnlockNoticeAsync(player, gateProducts, argDetail, commandName)
						if updateRemote then
							updateRemote:fireClient(player, promptId, nil, {controlValues = {[id] = commandTask:getArg(argName)}})
						end
						return
					end
				end
			end
			onChange(cleanValue)
		end
		table.insert(serialControls, {
			id = id,
			inputType = inputType or "NumberInput",
			config = controlConfig or {},
			value = value,
			label = spec.label or (if baseArg then (baseArg.display or baseArg.key or tostring(resolvedArgName)) else nil),
		})
	end

	if config.args then
		for _, argEntry in config.args do
			-- An entry is the arg's name, its position, or a control spec naming one
			local isSpec = typeof(argEntry) == "table"
			local argName = if isSpec then argEntry.arg else argEntry
			local spec = if isSpec then argEntry else {}
			if argName then
				addControl(argName, spec, function(cleanValue: any)
					commandTask:setArg(argName, cleanValue)
					local liveConfig = entry.configRef
					if not commandTask.deactivated and liveConfig.onChange then
						liveConfig.onChange(argName, cleanValue)
					end
				end)
			end
		end
	end
	if config.toggle then
		addControl(nil, {
			inputType = "Toggle",
			value = config.toggle.value,
			label = config.toggle.label,
		}, function(cleanValue: any)
			local liveToggle = entry.configRef.toggle
			if liveToggle and liveToggle.onChange then
				liveToggle.onChange(cleanValue)
			end
		end)
	end
	if config.buttons then
		for index, button in config.buttons do
			local id = "b" .. index
			local buttonIndex = index
			entry.buttons[id] = function()
				local liveButtons = entry.configRef.buttons
				local liveButton = if typeof(liveButtons) == "table" then liveButtons[buttonIndex] else nil
				local onActivate = liveButton and liveButton.onActivate
				if onActivate then
					onActivate()
				end
			end
			table.insert(serialButtons, { id = id, label = button.label, style = button.style, confirm = button.confirm == true })
		end
	end
	-- Favourite / unlock icon buttons
	for _, serial in buildIconButtons(entry, config) do
		table.insert(serialIconButtons, serial)
	end
	local toggleable = config.deactivate ~= false
	local rerunnable = entry.rerunnable

	activePrompts[promptId] = entry
	commandTask.actionPromptId = promptId

	local Commands = require(modules.Parent.Services.Commands)
	local command = Commands.getCommand(commandTask.commandKey)
	local title = config.title or (command and command.name) or commandTask.commandKey

	if typeof(config.votePreview) == "table" and config.votePreview.fromUserId ~= nil then
		Prompt.addUserInfoAsync(config.votePreview)
	end

	local options = {
		title = title,
		duration = if typeof(config.duration) == "number" then config.duration else 0,
		subtext = config.subtext,
		votePreview = config.votePreview,
		controls = serialControls,
		buttons = serialButtons,
		iconButtons = serialIconButtons,
		catalogLink = config.catalogLink, -- this is just the assetId to be used for a display
		toggleable = toggleable,
		rerun = rerunnable,
		state = "active",
	}
	Prompt.fireRaw(audience, "action", config.text or "", options, promptId)

	return createConnection(function()
		close(promptId)
	end)
end

function Action.update(commandTask: any, config: any)
	local promptId = commandTask.actionPromptId
	if typeof(promptId) ~= "string" then
		return
	end
	local entry = activePrompts[promptId]
	if not entry then
		return
	end
	entry.configRef = config
	entry.rerunnable = config.rerun == true
	entry.endOnClose = config.endOnClose == true
	local serialIconButtons = buildIconButtons(entry, config)
	local player = audiencePlayer(entry)
	if player and updateRemote then
		updateRemote:fireClient(player, promptId, nil, { iconButtons = serialIconButtons })
	end
end

function Action.unbind(commandTask: any)
	local promptId = commandTask.actionPromptId
	if typeof(promptId) == "string" then
		close(promptId)
	end
end


return Action
