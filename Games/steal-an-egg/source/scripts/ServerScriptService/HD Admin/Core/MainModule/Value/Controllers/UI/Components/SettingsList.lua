--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local InputObjects = require(frontend.Config.InputObjects)
local Pressable = require(frontend.Components.Pressable)
local ConfirmBar = require(frontend.Components.ConfirmBar)
local Children = Fusion.Children
local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local valuesEqual = require(modules.DataUtil.areValuesEqual)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>

export type LockRuleContext = {
	obj: any,
	heading: string,
	valueByTitle: {[string]: Fusion.Value<any>},
}

export type Controller = {
	hasPendingChanges: Fusion.Value<boolean>,
	confirmChanges: () -> (),
	undoChanges: () -> (),
	beginDisplayOverride: (valueMap: {[string]: any}) -> (),
	endDisplayOverride: () -> (),
	rebindToPath: ((newPrefix: {string}) -> ())?,
	restoreDefaults: (() -> ())?, -- you place the visible trigger yourself
	scrollToTop: (() -> ())?, -- no-op in noScroll mode
	setFieldValue: ((title: string, value: any) -> ())?, -- writes as if the user edited it
}

export type Props = {
	settingsData: {any}, -- flat array of {heading, objects}
	stateSource: ("perm" | "everyone" | any)?, -- also accepts a State.Class instance for scratch state
	pathPrefix: {string}?,
	onItemSelectorOpen: any?,
	onChangeRemote: any?, -- fired on Confirm
	changeRemoteArgsBuilder: ((info: any) -> ...any)?,
	getDefaults: (() -> any)?,
	isVisible: UsedAs<boolean>?,
	panelClosed: UsedAs<boolean>?,
	undoRef: Fusion.Value<(() -> ())?>?, -- written on construction
	lockRule: ((ctx: LockRuleContext) -> any?)?, -- returns a Computed<boolean>, true forces lockedDisplayValue
	softLockRule: ((ctx: LockRuleContext) -> any?)?, -- like lockRule but keeps the underlying value
	contentLocked: UsedAs<boolean>?, -- dims and disables the Restore Defaults button
	headerSlot: any?, -- scrolls with the content
	headerSlotVisible: UsedAs<boolean>?,
	footerSlot: any?,
	noScroll: boolean?, -- returns bare content, you provide the scroller and ConfirmBar
	hideConfirmBar: boolean?, -- pendingChanges still tracked, you provide the confirm UI
	hiddenByTitle: {[string]: UsedAs<boolean>}?,
	objectOverrides: {[string]: {[string]: any}}?, -- keyed by title, merged into obj.inputObject
	controllerRef: Fusion.Value<Controller?>?, -- written on construction
	undoOnDestroy: boolean?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local clientUser = require(modules.References.clientUser)
	local scrollingFrame: ScrollingFrame? = nil
	local stateSource: any = props.stateSource or "perm"
	local stateObj: any = if typeof(stateSource) == "string"
		then (clientUser :: any)[stateSource]
		else stateSource

	local destroyed = false
	table.insert(scope, function() destroyed = true end)

	local settingsData = props.settingsData
	local pathPrefix = props.pathPrefix

	local function fullPath(relative: {string}): {string}
		if not pathPrefix then return relative end
		local out = table.clone(pathPrefix)
		for _, segment in relative do
			table.insert(out, segment)
		end
		return out
	end

	local pendingChanges: { [string]: any } = {}
	local hasPendingChanges = scope:Value(false)
	local isDisplayOverride = false
	local fusedValueByTitle: {[string]: Fusion.Value<any>} = {}
	local fuseRefuseByTitle: {[string]: (...any) -> ()} = {}
	local isUndoing = false
	local isRebinding = false
	-- Stops a mid-batch replication reverting fields whose writes are still in flight
	local inflightChanges: { [string]: { intendedValue: any } } = {}

	local settingInputs: { any } = {}
	local valueByTitle: {[string]: Fusion.Value<any>} = {}
	local deferredRows: { () -> () } = {}
	local fieldRelativePaths: {[string]: {string}} = {}

	local activeDisplayOverrideMap: {[string]: any}? = nil
	local lockOverrideByTitle: {[string]: { locked: any, value: any }} = {}

	local function fetchDefaults(): any
		if not props.getDefaults then return nil end
		return props.getDefaults()
	end

	-- All Values must exist before any lockRule Computed runs
	for _, category in settingsData do
		for _, obj in category.objects do
			local path = fullPath(obj.settingPath)
			local fusedValue, refuse = (scope :: any):Fuse(stateSource, path)
			local initial = Fusion.peek(fusedValue)
			if initial == nil and (obj :: any).defaultFromEveryone then
				initial = clientUser.everyone:get(table.unpack((obj :: any).defaultFromEveryone))
			end
			if initial == nil and (obj :: any).defaultFromFunc then
				initial = (obj :: any).defaultFromFunc()
			end
			valueByTitle[obj.title] = scope:Value(initial)
			fusedValueByTitle[obj.title] = fusedValue
			fuseRefuseByTitle[obj.title] = refuse
			fieldRelativePaths[obj.title] = obj.settingPath
		end
	end

	local settingsChildren: {any} = {}

	table.insert(settingsChildren, scope:New "UIListLayout" {
		FillDirection = Enum.FillDirection.Vertical,
		HorizontalFlex = Enum.UIFlexAlignment.Fill,
		VerticalFlex = Enum.UIFlexAlignment.None,
		Padding = UDim.new(0, 18),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})
	for catIndex, category in settingsData do
		local categoryChildren: {any} = {}

		table.insert(categoryChildren, scope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			Padding = UDim.new(0, 0),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		table.insert(categoryChildren, scope:New "TextLabel" {
			Name = "Heading",
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundTransparency = 1,
			FontFace = scope:Computed(function(use)
				return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
			end),
			LayoutOrder = 1,
			Text = category.heading,
			TextColor3 = Theme.Color.BaseContent,
			TextSize = Theme.TextSize.Title,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		table.insert(categoryChildren, scope:New "Frame" {
			Name = "DividerWrap",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			Size = UDim2.new(1, 0, 0, 0),
			[Children] = {
				scope:New "UIPadding" {
					PaddingTop = UDim.new(0, 6),
					PaddingBottom = UDim.new(0, 4),
				},
				scope:New "Frame" {
					Name = "Divider",
					BackgroundColor3 = Theme.Color.NeutralContent,
					Size = UDim2.new(1, 0, 0, 1),
				},
			},
		})

		local rowsChildren: {any} = {}
		local rowVisibles: {any} = {}

		table.insert(rowsChildren, scope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			Padding = UDim.new(0, 10),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})
		table.insert(rowsChildren, scope:New "UIPadding" {
			Name = "UIPadding",
			PaddingBottom = UDim.new(0, 6),
			PaddingTop = UDim.new(0, 4),
		})

		for objIndex, obj in category.objects do
			-- Cached paths would go stale on rebindToPath and write to the old role's path
			local function currentPath(): {string} return fullPath(obj.settingPath) end
			local function currentPathKey(): string return table.concat(currentPath(), ".") end
			local fusedValue = fusedValueByTitle[obj.title]
			local inputValue = valueByTitle[obj.title]
			local isInitializing = true
			local lastFusedSync: any = nil
			local hasLastFusedSync = false

			scope:Observer(fusedValue):onChange(function()
				if destroyed then return end
				if isDisplayOverride or isRebinding then return end
				local pathKey = currentPathKey()
				local lockInfo = lockOverrideByTitle[obj.title]
				if lockInfo and Fusion.peek(lockInfo.locked) == true then
					return
				end
				local newFused = Fusion.peek(fusedValue)
				local currentInput = Fusion.peek(inputValue)

				local inflight = inflightChanges[pathKey]
				if inflight then
					if valuesEqual(newFused, inflight.intendedValue) then
						inflightChanges[pathKey] = nil
					else
						return
					end
				end

				if newFused ~= currentInput then
					task.defer(function()
						if destroyed then return end
						lastFusedSync = newFused
						hasLastFusedSync = true
						isRebinding = true
						inputValue:set(newFused)
						isRebinding = false
					end)
				end
			end)

			-- The everyone value can replicate late, so re-seed untouched fields when it lands
			if (obj :: any).defaultFromEveryone then
				local everyonePath = (obj :: any).defaultFromEveryone
				local everyoneFuse = (scope :: any):Fuse("everyone", everyonePath)
				scope:Observer(everyoneFuse):onChange(function()
					if destroyed then return end
					if isDisplayOverride or isRebinding then return end
					local pathKey = currentPathKey()
					if Fusion.peek(fusedValue) ~= nil then return end
					if pendingChanges[pathKey] then return end
					local newDefault = Fusion.peek(everyoneFuse)
					if newDefault == nil then return end
					if newDefault == Fusion.peek(inputValue) then return end
					task.defer(function()
						if destroyed then return end
						if Fusion.peek(fusedValue) ~= nil then return end
						if pendingChanges[pathKey] then return end
						lastFusedSync = newDefault
						hasLastFusedSync = true
						isRebinding = true
						inputValue:set(newDefault)
						isRebinding = false
					end)
				end)
			end

			table.insert(settingInputs, {
				heading = category.heading,
				title = obj.title,
				inputValue = inputValue,
				settingPath = currentPath(), -- rebindToPath updates this in-place
				onChanged = (obj :: any).onChanged,
			})

			if obj.updateThemeValues then
				for _, themeKey in obj.updateThemeValues do
					Theme.bindSetting(themeKey[1], themeKey[2], currentPath())
				end
			end

			task.defer(function()
				isInitializing = false
			end)

			scope:Observer(inputValue):onChange(function()
				if isInitializing or isUndoing or isDisplayOverride or isRebinding or destroyed then return end
				local path = currentPath()
				local pathKey = currentPathKey()
				local newValue = Fusion.peek(inputValue)

				-- A change matching the last fused sync is our own write landing, not a user edit
				if hasLastFusedSync and valuesEqual(newValue, lastFusedSync) then
					hasLastFusedSync = false
					lastFusedSync = nil
					return
				end
				hasLastFusedSync = false
				lastFusedSync = nil

				if obj.inputType ~= "TextInput" and obj.verifier then
					local success, result = (obj.verifier :: any)(obj.inputObject or obj, newValue)
					if not success then
						task.defer(function()
							if destroyed then return end
							inputValue:set(Fusion.peek(fusedValue))
						end)
						return
					end
					-- Verifiers return fresh tables so raw ~= always differs, compare by content
					if not valuesEqual(result, newValue) then
						task.defer(function()
							if destroyed then return end
							inputValue:set(result)
						end)
						return
					end
				end

				if not pendingChanges[pathKey] then
					local prevValue = Fusion.peek(fusedValue)
					if prevValue == nil and (obj :: any).defaultFromEveryone then
						prevValue = clientUser.everyone:get(table.unpack((obj :: any).defaultFromEveryone))
					end
					if prevValue == nil and (obj :: any).defaultFromFunc then
						prevValue = (obj :: any).defaultFromFunc()
					end
					-- A change matching the server value is a passive sync, not a user edit
					if valuesEqual(newValue, prevValue) then
						return
					end
					pendingChanges[pathKey] = {
						previousValue = prevValue,
						intendedValue = newValue,
						settingPath = path,
						heading = category.heading,
						title = obj.title,
						inputValue = inputValue,
						onChanged = (obj :: any).onChanged,
					}
				else
					pendingChanges[pathKey].intendedValue = newValue
				end

				stateObj:set(path, newValue)

				if (obj :: any).onChanged then
					(obj :: any).onChanged(newValue)
				end

				if pendingChanges[pathKey] and valuesEqual(newValue, pendingChanges[pathKey].previousValue) then
					pendingChanges[pathKey] = nil
				end
				hasPendingChanges:set(next(pendingChanges) ~= nil)
			end)

			local rowVisible: any = nil
			local perTitleHidden = if props.hiddenByTitle then props.hiddenByTitle[obj.title] else nil
			if (obj :: any).hidden == true then
				rowVisible = false
			elseif perTitleHidden ~= nil then
				rowVisible = scope:Computed(function(use)
					return use(perTitleHidden :: any) ~= true
				end)
			elseif (obj :: any).lockSetting then
				local lockPath = (obj :: any).lockSetting :: {string}
				local lockGroup = (Theme :: any)[lockPath[1]]
				if lockGroup then
					local lockValue = lockGroup[lockPath[2]]
					if lockValue then
						rowVisible = scope:Computed(function(use)
							return use(lockValue) ~= true
						end)
					end
				end
			end
			-- Store nil as true, table.insert(t, nil) is a no-op and would drop the row
			table.insert(rowVisibles, if rowVisible == nil then true else rowVisible)

			local ruleLocked: any = nil
			if props.lockRule then
				ruleLocked = props.lockRule({
					obj = obj,
					heading = category.heading,
					valueByTitle = valueByTitle,
				})
			end
			local softRuleLocked: any = nil
			if props.softLockRule then
				softRuleLocked = props.softLockRule({
					obj = obj,
					heading = category.heading,
					valueByTitle = valueByTitle,
				})
			end

			local declaredLock: any = (obj :: any).lockedDisplayValue
			local lockValueComputed: any = nil
			local function staticLockedDisplayValue(): any?
				if declaredLock ~= nil then
					if declaredLock == "none" then return nil end
					if obj.inputType == "ItemSelector" then
						return if typeof(declaredLock) == "table" then declaredLock else {declaredLock}
					end
					return declaredLock
				end
				if obj.inputType == "Toggle" then
					return true
				end
				if obj.inputType == "ItemSelector" and not (obj.inputObject and (obj.inputObject :: any).limitPickerToOneItem) then
					local getter = obj.inputObject and (obj.inputObject :: any).pickerGetter
					if typeof(getter) == "function" then
						local ok, items = pcall(getter)
						if ok and typeof(items) == "table" then
							local rawValues: {any} = {}
							for _, item in items do
								if typeof(item) == "table" and not (item :: any).hiddenFromPicker and (item :: any).rawValue ~= nil then
									table.insert(rawValues, (item :: any).rawValue)
								end
							end
							return rawValues
						end
					end
				end
				return nil
			end
			if typeof(declaredLock) == "function" then
				lockValueComputed = scope:Computed(function(use)
					local ok, result = pcall(declaredLock, { use = use, valueByTitle = valueByTitle })
					if ok then return result end
					return nil
				end)
			end
			local function computeLockedDisplayValue(): any?
				if lockValueComputed then
					return Fusion.peek(lockValueComputed)
				end
				return staticLockedDisplayValue()
			end
			local hasLockOverride = ruleLocked and computeLockedDisplayValue() ~= nil
			if hasLockOverride then
				lockOverrideByTitle[obj.title] = { locked = ruleLocked, compute = computeLockedDisplayValue }
				local function reapply()
					if destroyed or isRebinding then return end
					if Fusion.peek(ruleLocked) ~= true then return end
					local wasOverride = isDisplayOverride
					isDisplayOverride = true
					local lockedDisplayValue = computeLockedDisplayValue()
					if lockedDisplayValue ~= nil and not valuesEqual(Fusion.peek(inputValue), lockedDisplayValue) then
						inputValue:set(lockedDisplayValue)
					end
					isDisplayOverride = wasOverride
				end
				if lockValueComputed then
					scope:Observer(lockValueComputed):onChange(reapply)
				end
				scope:Observer(ruleLocked):onChange(function()
					if destroyed or isRebinding then return end
					local wasOverride = isDisplayOverride
					isDisplayOverride = true
					if Fusion.peek(ruleLocked) == true then
						local lockedDisplayValue = computeLockedDisplayValue()
						if lockedDisplayValue ~= nil and not valuesEqual(Fusion.peek(inputValue), lockedDisplayValue) then
							inputValue:set(lockedDisplayValue)
						end
					else
						local restore: any = nil
						if activeDisplayOverrideMap then
							restore = activeDisplayOverrideMap[obj.title]
						end
						if restore == nil then
							restore = Fusion.peek(fusedValue)
						end
						if restore == nil and (obj :: any).defaultFromEveryone then
							restore = clientUser.everyone:get(table.unpack((obj :: any).defaultFromEveryone))
						end
						if restore == nil and (obj :: any).defaultFromFunc then
							restore = (obj :: any).defaultFromFunc()
						end
						if not valuesEqual(Fusion.peek(inputValue), restore) then
							inputValue:set(restore)
						end
					end
					isDisplayOverride = wasOverride
				end)
				if Fusion.peek(ruleLocked) == true then
					local wasOverride = isDisplayOverride
					isDisplayOverride = true
					local initialLockValue = computeLockedDisplayValue()
					if initialLockValue ~= nil and not valuesEqual(Fusion.peek(inputValue), initialLockValue) then
						inputValue:set(initialLockValue)
					end
					isDisplayOverride = wasOverride
				end
			end

			local isImmutable = (obj :: any).immutable == true
			local function effectiveLockOR(): any
				if ruleLocked and softRuleLocked then
					return scope:Computed(function(use)
						return use(ruleLocked) == true or use(softRuleLocked) == true
					end)
				elseif ruleLocked then
					return ruleLocked
				elseif softRuleLocked then
					return softRuleLocked
				end
				return nil
			end
			local rowLocked: any = nil
			local combinedLock = effectiveLockOR()
			if isImmutable and combinedLock then
				rowLocked = scope:Computed(function(use)
					return use(combinedLock) == true or true
				end)
			elseif isImmutable then
				rowLocked = scope:Computed(function() return true end)
			elseif combinedLock then
				rowLocked = combinedLock
			end

			local rowInteractable: any = true
			if rowLocked then
				rowInteractable = scope:Computed(function(use)
					return not use(rowLocked)
				end)
			end

			local rowFrame = scope:New "Frame" {
				Name = "Setting_" .. (obj.title or tostring(objIndex)),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = objIndex,
				Size = UDim2.fromScale(1, 0),
				Visible = rowVisible,
				Interactable = rowInteractable,
			}
			table.insert(rowsChildren, rowFrame)

			table.insert(deferredRows, function()
				if destroyed then return end

				local inputConfig: any = {
					inputType = obj.inputType,
					title = (obj :: any).label or obj.title,
					value = inputValue,
					labelSize = UDim2.new(0, 105, 0, 0),
					slidersHeight = if obj.inputType == "ColorPicker" then 115 else nil,
				}
				if obj.inputObject then
					for key, value in obj.inputObject do
						inputConfig[key] = value
					end
				end
				if props.objectOverrides then
					local override = props.objectOverrides[obj.title]
					if typeof(override) == "table" then
						for key, value in override do
							inputConfig[key] = value
						end
					end
				end

				if obj.inputType == "ItemSelector" then
					inputConfig.onOpen = props.onItemSelectorOpen
				end

				if obj.inputType == "TextInput" and obj.verifier then
					inputConfig.verifier = function(text: string): (boolean, any)
						local success, result = (obj.verifier :: any)(obj.inputObject or obj, text)
						if success then
							inputValue:set(result)
						end
						return success, result
					end
				end

				local factory = (InputObjects.items :: any)[obj.inputType]
				local inputWidget = if factory then factory(scope, inputConfig) else nil

				local hasDescription = typeof((obj :: any).description) == "string" and (obj :: any).description ~= ""

				local layout = scope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalFlex = Enum.UIFlexAlignment.None,
					Padding = if hasDescription then UDim.new(0, 0) else UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}
				;(layout :: any).Parent = rowFrame

				if hasDescription then
					local pad = scope:New "UIPadding" {
						PaddingBottom = UDim.new(0, 6),
					}
					;(pad :: any).Parent = rowFrame

					local descTransparency: any = 0
					if rowLocked and not (isImmutable and not ruleLocked) then
						descTransparency = scope:Computed(function(use)
							return if use(rowLocked) then 0.65 else 0
						end)
					end
					local isToggle = obj.inputType == "Toggle"
					local descLabel = scope:New "TextLabel" {
						Name = "Description",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						FontFace = scope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Light))
						end),
						LayoutOrder = 3,
						RichText = true,
						Size = if isToggle then UDim2.fromScale(0.75, 0) else UDim2.fromScale(1, 0),
						Text = (obj :: any).description,
						TextColor3 = Theme.Color.NeutralContentDark,
						TextSize = 17,
						TextTransparency = descTransparency,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
						[Children] = if isToggle then nil else {
							scope:New "UIPadding" {
								PaddingTop = UDim.new(0, 6),
							},
						},
					}
					;(descLabel :: any).Parent = rowFrame
				end

				if inputWidget then
					local inputWrapperChildren: {any} = { inputWidget }
					if rowLocked then
						local immutableOnly = isImmutable and not ruleLocked
						table.insert(inputWrapperChildren, scope:New "Frame" {
							Name = "LockOverlay",
							BackgroundColor3 = Theme.Color.Base,
							BackgroundTransparency = scope:Computed(function(use)
								return if use(rowLocked) then 0.35 else 1
							end),
							Position = if immutableOnly then UDim2.fromOffset(111, 0) else UDim2.fromScale(0, 0),
							Size = if immutableOnly then UDim2.new(1, -111, 1, 0) else UDim2.fromScale(1, 1),
							ZIndex = 10,
						})
					end
					local wrapper = scope:New "Frame" {
						Name = "InputWrapper",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						LayoutOrder = 2,
						Size = UDim2.fromScale(1, 0),
						[Children] = inputWrapperChildren,
					}
					;(wrapper :: any).Parent = rowFrame
				end
			end)
		end

		table.insert(categoryChildren, scope:New "Frame" {
			Name = "Rows",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 3,
			Size = UDim2.fromScale(1, 0),
			[Children] = rowsChildren,
		})

		local categoryVisible: any
		if #rowVisibles == 0 then
			categoryVisible = false
		else
			local hasStaticVisible = false
			for _, rv in rowVisibles do
				if rv == nil or rv == true then
					hasStaticVisible = true
					break
				end
			end
			if hasStaticVisible then
				categoryVisible = true
			else
				categoryVisible = scope:Computed(function(use)
					for _, rv in rowVisibles do
						if rv == false then continue end
						if use(rv :: any) == true then return true end
					end
					return false
				end)
			end
		end

		-- UIListLayout still measures invisible children in some cases, so collapse Size too
		local categorySize: any
		local categoryAutoSize: any
		if categoryVisible == false then
			categorySize = UDim2.new()
			categoryAutoSize = Enum.AutomaticSize.None
		elseif categoryVisible == true then
			categorySize = UDim2.fromScale(1, 0)
			categoryAutoSize = Enum.AutomaticSize.Y
		else
			categorySize = scope:Computed(function(use)
				return if use(categoryVisible) then UDim2.fromScale(1, 0) else UDim2.new()
			end)
			categoryAutoSize = scope:Computed(function(use)
				return if use(categoryVisible) then Enum.AutomaticSize.Y else Enum.AutomaticSize.None
			end)
		end

		table.insert(settingsChildren, scope:New "Frame" {
			Name = "Category_" .. tostring(catIndex),
			AutomaticSize = categoryAutoSize,
			BackgroundTransparency = 1,
			LayoutOrder = catIndex,
			Size = categorySize,
			Visible = categoryVisible,
			[Children] = categoryChildren,
		})
	end

	local function requestRestoreDefaults()
		task.spawn(function()
			local defaults = fetchDefaults()
			if not defaults or destroyed then return end
			for _, entry in settingInputs do
				-- Rank and key are derived, never overwrite them
				if entry.title == "rank" or entry.title == "key" then continue end
				local headingDefaults = defaults[entry.heading]
				local default: any
				if headingDefaults then
					default = headingDefaults[entry.title]
				else
					default = defaults[entry.title]
				end
				if default == nil then continue end
				local current = Fusion.peek(entry.inputValue)
				if typeof(current) == "table" and typeof(default) ~= "table" then
					default = { default }
				end
				if not valuesEqual(current, default) then
					entry.inputValue:set(default)
				end
			end
		end)
	end

	local STREAM_BATCH = 2
	task.spawn(function()
		local idx = 0
		while idx < #deferredRows do
			if destroyed then return end
			local batchEnd = math.min(idx + STREAM_BATCH, #deferredRows)
			for rowIndex = idx + 1, batchEnd do
				deferredRows[rowIndex]()
			end
			idx = batchEnd
			if idx < #deferredRows then
				task.wait()
			end
		end
	end)

	local function confirmChanges()
		if not props.onChangeRemote then
			table.clear(pendingChanges)
			hasPendingChanges:set(false)
			return
		end
		local argsBuilder = props.changeRemoteArgsBuilder or function(info: any)
			return info.heading, info.title, info.intendedValue
		end
		for pathKey, info in pendingChanges do
			inflightChanges[pathKey] = {intendedValue = info.intendedValue}
		end
		for pathKey, info in pendingChanges do
			task.spawn(function()
				local success, err = (props.onChangeRemote :: any):invokeServerAsync(argsBuilder(info))
				if not success then
					inflightChanges[pathKey] = nil
					local Prompt = require(modules.Prompt)
					Prompt.warn(tostring(err or "Failed to save setting"))
				end
			end)
		end
		table.clear(pendingChanges)
		hasPendingChanges:set(false)
	end

	local function undoChanges()
		isUndoing = true
		for _, info in pendingChanges do
			info.inputValue:set(info.previousValue)
			stateObj:set(info.settingPath, info.previousValue)
			if info.onChanged then
				info.onChanged(info.previousValue)
			end
		end
		table.clear(pendingChanges)
		hasPendingChanges:set(false)
		isUndoing = false
	end

	if props.undoRef then
		props.undoRef:set(undoChanges)
	end

	local function applyLockOverrides()
		for title, info in lockOverrideByTitle do
			if Fusion.peek(info.locked) == true then
				local iv = valueByTitle[title]
				local value = info.compute()
				if iv and value ~= nil and not valuesEqual(Fusion.peek(iv), value) then
					iv:set(value)
				end
			end
		end
	end

	local function beginDisplayOverride(valueMap: {[string]: any})
		activeDisplayOverrideMap = valueMap
		isDisplayOverride = true
		for _, entry in settingInputs do
			if entry.title == "useDefaults" or entry.title == "key" or entry.title == "rank" then continue end
			local override = valueMap[entry.title]
			if override == nil then continue end
			local current = Fusion.peek(entry.inputValue)
			-- Preserve the ItemSelector array-wrap convention
			local finalVal: any = override
			if typeof(current) == "table" and typeof(finalVal) ~= "table" then
				finalVal = { finalVal }
			end
			if not valuesEqual(current, finalVal) then
				entry.inputValue:set(finalVal)
			end
		end
		applyLockOverrides()
		isDisplayOverride = false
	end

	local function endDisplayOverride()
		activeDisplayOverrideMap = nil
		isDisplayOverride = true
		-- Edits were already committed to clientUser, so fused already holds them
		for _, entry in settingInputs do
			if entry.title == "useDefaults" or entry.title == "key" or entry.title == "rank" then continue end
			local fused = fusedValueByTitle[entry.title]
			local restoreValue: any = if fused then Fusion.peek(fused) else nil
			if restoreValue == nil then continue end
			local current = Fusion.peek(entry.inputValue)
			if not valuesEqual(current, restoreValue) then
				entry.inputValue:set(restoreValue)
			end
		end
		applyLockOverrides()
		isDisplayOverride = false
	end

	local function rebindToPath(newPrefix: {string})
		if destroyed then return end
		if next(pendingChanges) ~= nil then
			undoChanges()
		end
		isRebinding = true
		pathPrefix = newPrefix

		for title, relativePath in fieldRelativePaths do
			local newPath = fullPath(relativePath)

			local refuse = fuseRefuseByTitle[title]
			if refuse then
				refuse(newPath)
			end

			local fusedValue = fusedValueByTitle[title]
			local iv = valueByTitle[title]
			if iv and fusedValue then
				local newValue = Fusion.peek(fusedValue)
				iv:set(if newValue ~= nil then newValue else "")
			end

			for _, entry in settingInputs do
				if entry.title == title then
					entry.settingPath = newPath
					break
				end
			end
		end

		isRebinding = false
		local wasOverride = isDisplayOverride
		isDisplayOverride = true
		applyLockOverrides()
		isDisplayOverride = wasOverride
	end

	local function scrollToTop()
		if scrollingFrame then
			(scrollingFrame :: ScrollingFrame).CanvasPosition = Vector2.zero
		end
	end

	local function setFieldValue(title: string, value: any)
		local iv = valueByTitle[title]
		if not iv then return end
		iv:set(value)
	end

	if props.controllerRef then
		props.controllerRef:set({
			hasPendingChanges = hasPendingChanges,
			confirmChanges = confirmChanges,
			undoChanges = undoChanges,
			beginDisplayOverride = beginDisplayOverride,
			endDisplayOverride = endDisplayOverride,
			rebindToPath = rebindToPath,
			restoreDefaults = if props.getDefaults then requestRestoreDefaults else nil,
			scrollToTop = scrollToTop,
			setFieldValue = setFieldValue,
		})
	end

	if props.panelClosed then
		scope:Observer(props.panelClosed :: any):onChange(function()
			if destroyed then return end
			if Fusion.peek(props.panelClosed :: any) == true then
				undoChanges()
			end
		end)
	end

	if props.undoOnDestroy then
		table.insert(scope, function()
			if next(pendingChanges) then
				undoChanges()
			end
		end)
	end

	if props.noScroll then
		return scope:New "Frame" {
			Name = "SettingsListContent",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0),
			[Children] = settingsChildren,
		}
	end

	scrollingFrame = scope:New "ScrollingFrame" {
				Name = "Scroll",
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				BottomImage = "rbxassetid://16547643439",
				CanvasSize = UDim2.new(),
				ClipsDescendants = true,
				LayoutOrder = 1,
				MidImage = "rbxassetid://16547330984",
				ScrollBarImageColor3 = Theme.Color.NeutralContentDark,
				ScrollBarImageTransparency = if isMobile
					then 1
					elseif props.isVisible ~= nil then (scope :: any):Computed(function(use)
						return if use(props.isVisible :: any) then 0 else 1
					end)
					else 0,
				ScrollBarThickness = if isMobile then 2 else 8,
				ScrollingDirection = Enum.ScrollingDirection.Y,
				Selectable = false,
				Size = UDim2.fromScale(1, 0),
				TopImage = "rbxassetid://16547667444",
				VerticalScrollBarInset = if isMobile then Enum.ScrollBarInset.Always else Enum.ScrollBarInset.ScrollBar,
				[Children] = {
					scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
					scope:New "UIPadding" {
						Name = "UIPadding",
						PaddingLeft = UDim.new(0, 2),
						PaddingRight = UDim.new(0, 5),
						PaddingTop = UDim.new(0, 2),
						PaddingBottom = UDim.new(0, 2),
					},
					if props.headerSlot then scope:New "Frame" {
						Name = "HeaderSlot",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						LayoutOrder = 0,
						Size = UDim2.fromScale(1, 0),
						Visible = if props.headerSlotVisible ~= nil then props.headerSlotVisible else true,
						[Children] = { props.headerSlot },
					} else nil,
					settingsChildren,
					if props.footerSlot then scope:New "Frame" {
						Name = "FooterSlot",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						LayoutOrder = 9999,
						Size = UDim2.fromScale(1, 0),
						[Children] = { props.footerSlot },
					} else nil,
				},
			} :: ScrollingFrame

	return scope:New "Frame" {
		Name = "SettingsList",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			scrollingFrame,

			if props.hideConfirmBar then nil else ConfirmBar(scope, {
				layoutOrder = 2,
				hasPendingChanges = hasPendingChanges,
				confirmChanges = confirmChanges,
				undoChanges = undoChanges,
			}),
		},
	}
end
