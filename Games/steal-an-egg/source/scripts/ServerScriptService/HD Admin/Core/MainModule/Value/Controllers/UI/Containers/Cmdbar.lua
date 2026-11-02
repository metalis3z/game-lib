--!strict
-- SERVICES
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")


-- CONFIG
local MAX_ROWS = 8
local HAS_KEYBOARD = UserInputService.KeyboardEnabled
local EXIT_CANDIDATE = {
	kind = "exit",
	display = if HAS_KEYBOARD then "Exit <font color=\"#8a8f98\">(press <font weight=\"Heavy\"><b>;</b></font> or <font weight=\"Heavy\"><b>'</b></font> to re-open)</font>" else "Exit",
	rich = HAS_KEYBOARD,
	text = "",
}


-- LOCAL 
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Children = Fusion.Children
local CmdbarField = require(frontend.Components.CmdbarField)
local CmdbarList = require(frontend.Components.CmdbarList)
local Segmenter = require(frontend.Util.Cmdbar.Segmenter)
local Resolver = require(frontend.Util.Cmdbar.Resolver)
local Ranker = require(frontend.Util.Cmdbar.Ranker)
local Candidates = require(frontend.Util.Cmdbar.Candidates)
local Recents = require(frontend.Util.Cmdbar.Recents)
local ModifierUtil = require(frontend.Util.Cmdbar.ModifierUtil)
local CommandAccess = require(frontend.Util.CommandAccess)
local Icons = require(frontend.Config.Icons)
local Args = require(modules.Parser.Args)
local isValidPrefix = require(modules.CommandUtil.isValidPrefix)
local getGameSetting = require(modules.CommandUtil.getGameSetting)
local Remote = require(modules.Objects.Remote)
local sendMessage = Remote.get("SendMessage")


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	visible: Fusion.Value<boolean>,
}


-- HELPERS
local function trimText(text: string): string
	return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function ensurePrefixed(trimmed: string, defaultPrefix: string): string
	if isValidPrefix(trimmed:sub(1, 1)) then
		return trimmed
	end
	return defaultPrefix .. trimmed
end

local function buildSignature(command: any, activeArgIndex: number?, modifiers: { string }?): string
	local parts = {}
	if modifiers and #modifiers > 0 then
		table.insert(parts, table.concat(modifiers, " "))
	end
	table.insert(parts, command.name or "?")
	local args = ModifierUtil.effectiveArgs(command, modifiers or {})
	if typeof(args) == "table" then
		for argIndex, argName in args do
			local argDetail = Args.get(argName)
			local label = if argDetail then (argDetail.display or argDetail.key) else nil
			if typeof(label) ~= "string" then
				label = if typeof(argName) == "string" then argName else "arg"
			end
			local hint = ""
			if argDetail and typeof((argDetail :: any).inputObject) == "table" then
				local inputObject = (argDetail :: any).inputObject
				if inputObject.inputType == "NumberInput" and typeof(inputObject.min) == "number" and typeof(inputObject.max) == "number" then
					hint = ` {inputObject.min}-{inputObject.max}`
				end
			end
			local token = "<" .. tostring(label):lower() .. hint .. ">"
			if argIndex == activeArgIndex then
				token = "[ " .. token .. " ]"
			end
			table.insert(parts, token)
		end
	end
	return table.concat(parts, " ")
end

local function decorate(candidate: any): (string?, boolean)
	local kind = candidate.kind
	if kind == "player" then
		return candidate.image, true
	elseif kind == "qualifier" then
		return Icons.PersonTagFill, false
	elseif kind == "modifier" then
		return Icons.ZapFill, false
	elseif kind == "recent" then
		return Icons.RecentCalendarFill, false
	elseif kind == "exit" then
		return Icons.Close, false
	elseif kind == "duration" then
		return Icons.HourglassHalfOutline, false
	end
	return nil, false
end

local function isCompleteToken(candidate: any, query: string): boolean
	if typeof(candidate) ~= "table" then
		return false
	end
	local lowered = query:lower()
	if typeof(candidate.text) == "string" and candidate.text:lower() == lowered then
		return true
	end
	if typeof(candidate.keys) == "table" then
		for _, key in candidate.keys do
			if typeof(key) == "string" and key:lower() == lowered then
				return true
			end
		end
	end
	return false
end

local function buildRows(candidates: { any }): { any }
	local rows = {}
	for rowIndex, candidate in candidates do
		local image, rounded = decorate(candidate)
		rows[rowIndex] = {
			index = rowIndex,
			display = candidate.display or candidate.text,
			description = candidate.description,
			image = image,
			imageRounded = rounded,
			swatch = candidate.swatch,
			rich = candidate.rich == true,
			locked = candidate.locked == true,
			showUnlock = candidate.runState ~= nil and candidate.runState.unlockState == "unlock",
		}
	end
	return rows
end

-- Command names are code-defined, but escape anyway before rendering rich text
local function escapeRich(text: string): string
	return (text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

-- Alias-only matches relabel as "Speak (alias of Chat)" and type the alias on accept
local function annotateAliases(candidates: { any }, query: string): { any }
	for index, candidate in candidates do
		if typeof(candidate.keyLabels) ~= "table" then
			continue
		end
		local aliasKey = Ranker.aliasHit(query, candidate.keys)
		if aliasKey == nil then
			continue
		end
		local aliasLabel = candidate.keyLabels[aliasKey] or aliasKey
		local primaryName = if typeof(candidate.display) == "string" then candidate.display else aliasLabel
		local clone = table.clone(candidate)
		clone.display = escapeRich(aliasLabel) .. " <font color=\"#8a8f98\">(alias of " .. escapeRich(primaryName) .. ")</font>"
		clone.insert = aliasKey
		clone.rich = true
		candidates[index] = clone
	end
	return candidates
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local destroyed = false
	table.insert(scope, function()
		destroyed = true
	end)

	local defaultPrefix = ";"
	task.spawn(function()
		local fetched = getGameSetting("Prefix")
		if not destroyed and typeof(fetched) == "string" and #fetched > 0 then
			defaultPrefix = fetched
		end
	end)

	local text: Fusion.Value<string> = scope:Value("")
	local cursorPosition: Fusion.Value<number> = scope:Value(-1)
	local lastCursor: Fusion.Value<number> = scope:Value(1)
	local focused: Fusion.Value<boolean> = scope:Value(false)
	local boxRef: Fusion.Value<TextBox?> = scope:Value(nil :: TextBox?)
	local selectedIndex: Fusion.Value<number> = scope:Value(1)
	local asyncBump: Fusion.Value<number> = scope:Value(0)
	local wasDeletion: Fusion.Value<boolean> = scope:Value(false)

	local commandInfoFuse = scope:Fuse("everyone", "CommandInfo")
	local youMemberFuse = scope:Fuse("temp", "YouMember")
	local roleInfoFuse = scope:Fuse("everyone", "RoleInfo")
	local recentsFuse = scope:Fuse("perm", "RecentCommands")
	local userPrefixFuse = scope:Fuse("perm", { "YouSettings", "Prefix" })

	local function currentPrefix(): string
		local userPrefix = Fusion.peek(userPrefixFuse)
		if typeof(userPrefix) == "string" and #userPrefix > 0 then
			return userPrefix
		end
		if typeof(defaultPrefix) == "string" and #defaultPrefix > 0 then
			return defaultPrefix
		end
		return ";"
	end

	local effectiveCursor = scope:Computed(function(use): number
		local current = use(cursorPosition)
		return if current >= 1 then current else use(lastCursor)
	end)

	local scanValue = scope:Computed(function(use)
		return Segmenter.scan(use(text))
	end)
	local fieldValue = scope:Computed(function(use)
		return Resolver.resolve(use(scanValue), use(effectiveCursor), use(text))
	end)
	local recentsRowsValue = scope:Computed(function(use)
		return Recents.rows(use(recentsFuse))
	end)

	local commandIndexValue = scope:Computed(function(use)
		local info = use(commandInfoFuse)
		local youMember = use(youMemberFuse)
		local roleInfo = use(roleInfoFuse)
		local byKey: { [string]: any } = {}
		local names: { string } = {}
		local commandCandidates: { any } = {}
		if typeof(info) ~= "table" then
			return { byKey = byKey, names = names, commandCandidates = commandCandidates }
		end

		local values = {}
		for _, command in info :: { [string]: any } do
			if typeof(command) == "table" then
				table.insert(values, command)
			end
		end
		local viewable = CommandAccess.buildViewable(values, youMember, roleInfo)

		for _, command in viewable do
			local runState = CommandAccess.runState(command, youMember, roleInfo)
			local keys: { string } = {}
			local keyLabels: { [string]: string } = {}
			local function addKey(name: any)
				if typeof(name) == "string" and name ~= "" then
					local lowered = name:lower()
					table.insert(keys, lowered)
					keyLabels[lowered] = name
					byKey[lowered] = command
				end
			end
			addKey(command.name)
			if typeof(command.aliases) == "table" then
				for _, alias in command.aliases do
					addKey(alias)
				end
			end
			if typeof(command.undoAliases) == "table" then
				for _, alias in command.undoAliases do
					addKey(alias)
				end
			end
			for _, key in keys do
				table.insert(names, key)
			end

			if command.hide ~= true then
				local roleName: string? = nil
				if typeof(roleInfo) == "table" and typeof(command.primaryRole) == "string" then
					local role = (roleInfo :: any)[command.primaryRole]
					if typeof(role) == "table" then
						roleName = role.name
					end
				end
				table.insert(commandCandidates, {
					keys = keys,
					keyLabels = keyLabels,
					text = (command.name or ""):lower(),
					insert = (command.name or ""):lower(),
					display = command.name,
					kind = "command",
					command = command,
					locked = not runState.usable,
					runState = runState,
					description = roleName,
				})
			end
		end
		return { byKey = byKey, names = names, commandCandidates = commandCandidates }
	end)

	local model = scope:Computed(function(use)
		local _ = use(asyncBump)
		local field = use(fieldValue)
		local index = use(commandIndexValue)
		local candidates: { any } = {}
		local signature = ""

		if field.kind == "command" then
			if field.query == "" then
				candidates = { EXIT_CANDIDATE }
				for _, recent in Ranker.rank("", use(recentsRowsValue), { maxResults = MAX_ROWS - 1 }) do
					table.insert(candidates, recent)
				end
			else
				-- Include modifier-prefixed variants plus the modifiers themselves
				local pool = index.commandCandidates
				local expanded = ModifierUtil.expand(field.query, pool)
				local modifierRows = ModifierUtil.modifierCandidates(field.query)
				if #expanded > 0 or #modifierRows > 0 then
					pool = table.clone(pool)
					for _, candidate in expanded do
						table.insert(pool, candidate)
					end
					for _, candidate in modifierRows do
						table.insert(pool, candidate)
					end
				end
				candidates = Ranker.rank(field.query, pool, { maxResults = MAX_ROWS })
				candidates = annotateAliases(candidates, field.query)
			end
		elseif field.kind == "capsuleArg" then
			local commandText = use(scanValue).commandText
			local command, modifiers = ModifierUtil.resolve(if typeof(commandText) == "string" then commandText else "", index.byKey)
			if command then
				signature = buildSignature(command, nil, modifiers)
				local argName = ModifierUtil.capsuleArgs(command)[field.argIndex or 1]
				if argName ~= nil then
					local argDetail = Args.get(argName)
					if argDetail then
						candidates = Ranker.rank(field.query, Candidates.forArg(argDetail), { maxResults = MAX_ROWS })
					end
				end
			end
		else
			local commandText = use(scanValue).commandText
			local command, modifiers = ModifierUtil.resolve(if typeof(commandText) == "string" then commandText else "", index.byKey)
			if command then
				signature = buildSignature(command, field.argIndex, modifiers)
				local argName = ModifierUtil.effectiveArgs(command, modifiers)[field.argIndex]
				if argName ~= nil then
					local argDetail = Args.get(argName)
					if argDetail then
						candidates = Ranker.rank(field.query, Candidates.forArg(argDetail), { maxResults = MAX_ROWS })
					end
				end
			end
		end

		-- After a backspace, a sole suggestion exactly matching the remaining text
		-- is the token you already had, so empty the dropdown and let Enter run
		if use(wasDeletion) and field.query ~= "" and #candidates > 0 and isCompleteToken(candidates[1], field.query) then
			candidates = {}
		end

		return { candidates = candidates, rows = buildRows(candidates), signature = signature }
	end)

	local rowsValue = scope:Computed(function(use)
		return use(model).rows
	end)
	local signatureValue = scope:Computed(function(use)
		return use(model).signature
	end)
	local listVisible = scope:Computed(function(use): boolean
		return use(props.visible) and #use(rowsValue) > 0
	end)

	scope:Observer(cursorPosition):onChange(function()
		if destroyed then
			return
		end
		local current = Fusion.peek(cursorPosition)
		if current >= 1 then
			lastCursor:set(current)
		end
	end)

	scope:Observer(model):onChange(function()
		if not destroyed then
			selectedIndex:set(1)
		end
	end)

	scope:Observer(fieldValue):onChange(function()
		if destroyed then
			return
		end
		local field = Fusion.peek(fieldValue)
		if field.kind ~= "arg" then
			return
		end
		local commandText = Fusion.peek(scanValue).commandText
		local index = Fusion.peek(commandIndexValue)
		local command, modifiers = ModifierUtil.resolve(if typeof(commandText) == "string" then commandText else "", index.byKey)
		if not command then
			return
		end
		local argName = ModifierUtil.effectiveArgs(command, modifiers)[field.argIndex]
		if argName == nil then
			return
		end
		local argDetail = Args.get(argName)
		if argDetail and Candidates.needsPicker(argDetail) then
			Candidates.ensurePicker(argDetail, function()
				if not destroyed then
					asyncBump:set(Fusion.peek(asyncBump) + 1)
				end
			end)
		end
	end)

	-- HANDLERS
	local function refocus()
		task.spawn(function()
			-- A frame's wait makes CaptureFocus reliable right after an Enter
			RunService.Heartbeat:Wait()
			if destroyed then
				return
			end
			local box = Fusion.peek(boxRef)
			if box and Fusion.peek(props.visible) then
				box:CaptureFocus()
			end
		end)
	end

	local function setCursor(position: number)
		task.defer(function()
			if destroyed then
				return
			end
			local box = Fusion.peek(boxRef)
			if box then
				box.CursorPosition = position
			end
			cursorPosition:set(position)
			lastCursor:set(math.max(position, 1))
		end)
	end

	local function resetToPrefix()
		text:set(currentPrefix())
		selectedIndex:set(1)
	end

	local function acceptSelected(advance: boolean)
		local candidates = Fusion.peek(model).candidates
		local candidate = candidates[Fusion.peek(selectedIndex)]
		if not candidate then
			return
		end
		if candidate.kind == "exit" then
			props.visible:set(false)
			return
		end
		if candidate.kind == "recent" then
			text:set(candidate.text)
			setCursor(#candidate.text + 1)
		else
			local field = Fusion.peek(fieldValue)
			local isCapsule = field.kind == "capsuleArg"
			local doAdvance = advance and candidate.advance ~= false and not isCapsule
			local newText, newCursor = Resolver.apply(Fusion.peek(text), field, candidate.insert, doAdvance, candidate.caretBack)
			if isCapsule then
				-- A comma moves to the next capsule slot, otherwise hop past the close
				-- paren plus a space so typing flows into the qualifiers
				local totalSlots = 1
				local commandText = Fusion.peek(scanValue).commandText
				local command = ModifierUtil.resolve(if typeof(commandText) == "string" then commandText else "", Fusion.peek(commandIndexValue).byKey)
				if command then
					totalSlots = #ModifierUtil.capsuleArgs(command)
				end
				if (field.argIndex or 1) < totalSlots then
					newText = newText:sub(1, newCursor - 1) .. "," .. newText:sub(newCursor)
					newCursor += 1
				else
					if newText:sub(newCursor, newCursor) == ")" then
						newCursor += 1
					else
						newText = newText:sub(1, newCursor - 1) .. ")" .. newText:sub(newCursor)
						newCursor += 1
					end
					if newText:sub(newCursor, newCursor) ~= " " then
						newText = newText:sub(1, newCursor - 1) .. " " .. newText:sub(newCursor)
					end
					newCursor += 1
				end
			end
			text:set(newText)
			setCursor(newCursor)
		end
		refocus()
	end

	local function navigate(delta: number)
		local count = #Fusion.peek(rowsValue)
		if count == 0 then
			return
		end
		local target = Fusion.peek(selectedIndex) + delta
		if target < 1 then
			target = count
		elseif target > count then
			target = 1
		end
		selectedIndex:set(target)
	end

	local function dispatch(rawText: string)
		local trimmed = trimText(rawText)
		if #trimmed == 0 then
			return
		end
		if #trimmed == 1 and isValidPrefix(trimmed) then
			return
		end
		local message = ensurePrefixed(trimmed, currentPrefix())
		task.spawn(function()
			sendMessage:invokeServerAsync(message, "ClientCommandBar")
		end)
		props.visible:set(false)
	end

	local function submit()
		local candidate = Fusion.peek(model).candidates[Fusion.peek(selectedIndex)]
		if candidate and candidate.kind == "exit" then
			props.visible:set(false)
			return
		end

		local field = Fusion.peek(fieldValue)
		local index = Fusion.peek(commandIndexValue)
		local terminal = true
		if candidate and candidate.kind ~= "recent" then
			if candidate.kind == "command" then
				local cmd = candidate.command
				-- Judged by effective args so unfly with no args still runs in one Enter
				local _, mods = ModifierUtil.resolve(if typeof(candidate.text) == "string" then candidate.text else "", index.byKey)
				terminal = typeof(cmd) == "table" and #ModifierUtil.effectiveArgs(cmd, mods) == 0
			elseif field.kind == "arg" then
				local commandText = Fusion.peek(scanValue).commandText
				local command, modifiers = ModifierUtil.resolve(if typeof(commandText) == "string" then commandText else "", index.byKey)
				local argCount = if command ~= nil then #ModifierUtil.effectiveArgs(command, modifiers) else 0
				terminal = command == nil or field.argIndex >= argCount
			else
				terminal = false
			end
		end

		if not terminal then
			acceptSelected(true)
			return
		end

		local rawText: string
		if candidate and candidate.kind == "recent" then
			rawText = candidate.text
		elseif candidate then
			rawText = (Resolver.apply(Fusion.peek(text), field, candidate.insert, false, candidate.caretBack))
		else
			rawText = Fusion.peek(text)
		end
		dispatch(rawText)
	end

	local function runNow()
		dispatch(Fusion.peek(text))
	end

	local function close()
		props.visible:set(false)
	end

	scope:Observer(props.visible):onChange(function()
		if destroyed then
			return
		end
		if Fusion.peek(props.visible) then
			-- Collapse Roblox's chat so it doesn't fight the bar for focus
			pcall(function()
				StarterGui:SetCore("ChatActive", false)
			end)
			resetToPrefix()
			refocus()
		else
			local box = Fusion.peek(boxRef)
			if box then
				box:ReleaseFocus()
			end
		end
	end)

	return scope:New "Frame" {
		Name = "Cmdbar",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Visible = props.visible,
		ZIndex = 11,

		[Children] = {
			scope:New "Frame" {
				Name = "Group",
				AnchorPoint = Vector2.new(0.5, 1),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 1, -70),
				Size = UDim2.new(1, -40, 0, 0),
				ZIndex = 2,

				[Children] = {
					scope:New "UISizeConstraint" {
						MaxSize = Vector2.new(560, math.huge),
					},
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						VerticalAlignment = Enum.VerticalAlignment.Bottom,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 8),
					},

					CmdbarList(scope, {
						layoutOrder = 1,
						rows = rowsValue,
						selectedIndex = selectedIndex,
						signature = signatureValue,
						visible = listVisible,
						onActivateIndex = function(index: number)
							selectedIndex:set(index)
							submit()
						end,
						onHoverIndex = function(index: number)
							selectedIndex:set(index)
						end,
					}),

					CmdbarField(scope, {
						layoutOrder = 2,
						text = text,
						cursorPosition = cursorPosition,
						focused = focused,
						active = props.visible,
						wasDeletion = wasDeletion,
						boxRef = boxRef,
						onSubmit = submit,
						onRun = runNow,
						onNavigate = navigate,
						onAccept = function()
							acceptSelected(true)
						end,
						onClose = close,
					}),
				},
			},
		},
	}
end
