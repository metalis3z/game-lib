--!strict
-- LOCAL 
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local InputRow = require(script.Parent.InputRow)
local Icons = require(frontend.Config.Icons)
local Players = game:GetService("Players")


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	title: string?,
	default: any?,
	filterText: boolean?,
	mustBeStringSafe: boolean?,
	preventWhitespaces: boolean?,
	value: Fusion.Value<any>?,
	validationStatus: Fusion.Value<boolean?>?, -- nil idle, true passed, false failed
	firstArgValue: Fusion.UsedAs<any>?, -- used for text filter targeting
	verifier: ((text: string) -> (boolean, any))?, -- false + string = warn/revert, true + value = accept
	limitTextLength: number?,
	clearTextOnFocus: boolean?,
	labelSize: UDim2?,
	labelTextSize: number?,
}


-- LOCAL FUNCTIONS
-- May yield
local function resolveTargetUserId(firstArgValue: any?): number?
	if firstArgValue == nil then return nil end
	local val = if typeof(firstArgValue) == "table" then Fusion.peek(firstArgValue :: any) else firstArgValue
	if typeof(val) == "table" then
		if #val ~= 1 then return nil end
		val = val[1]
	end
	if typeof(val) == "Instance" and (val :: Instance):IsA("Player") then
		return (val :: Player).UserId
	end
	if typeof(val) == "number" and val > 0 then
		return val
	end
	if typeof(val) == "string" then
		local str = val :: string
		if str:sub(1, 1) == "@" then str = str:sub(2) end
		if #str == 0 then return nil end
		local numericId = tonumber(str)
		if numericId and numericId > 0 then return math.floor(numericId) end
		local ok, userId = pcall(function()
			return Players:GetUserIdFromNameAsync(str)
		end)
		if ok and typeof(userId) == "number" then
			return userId
		end
	end
	return nil
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local title: string = props.title or "Text"
	local filterText = props.filterText == true
	local mustBeStringSafe = props.mustBeStringSafe == true
	local preventWhitespaces = props.preventWhitespaces == true
	local verifier = props.verifier
	local showValidation = filterText or mustBeStringSafe

	-- Bail flag for async
	local destroyed = false
	table.insert(scope, function()
		destroyed = true
	end)

	local isFocused: Fusion.Value<boolean> = scope:Value(false)
	local hasInteracted = false

	-- A nil seed must become "" not tostring(nil), otherwise MaxVisibleGraphemes
	-- reveals the literal "nil" letter by letter
	local seed: any = if props.value ~= nil then Fusion.peek(props.value) else props.default
	local textValue: Fusion.Value<string> = scope:Value(if seed == nil then "" else tostring(seed))
	local previousText = Fusion.peek(textValue)

	if props.value ~= nil then
		scope:Observer(props.value :: any):onChange(function()
			if Fusion.peek(isFocused) == true then return end
			local ext = Fusion.peek(props.value :: any)
			if ext == nil then return end
			local extStr = tostring(ext)
			previousText = extStr
			if extStr == Fusion.peek(textValue) then return end
			textValue:set(extStr)
		end)
	end

	-- nil = idle, true = passed, false = failed
	local stringSafeState: Fusion.Value<boolean?> = scope:Value(nil :: boolean?)
	local filterState: Fusion.Value<boolean?> = scope:Value(nil :: boolean?)
	local validationState: Fusion.Value<boolean?> = scope:Value(nil :: boolean?)
	local validationWarning: Fusion.Value<string> = scope:Value("")

	local function updateValidationState()
		local ss = Fusion.peek(stringSafeState)
		local fs = Fusion.peek(filterState)
		if ss == false then
			validationState:set(false)
			validationWarning:set("Simple characters only")
		elseif fs == false then
			validationState:set(false)
			validationWarning:set("Text may fail filter")
		elseif (mustBeStringSafe and ss == true) or (filterText and fs == true) then
			if mustBeStringSafe and ss ~= true then
				validationState:set(nil)
			elseif filterText and fs ~= true then
				validationState:set(nil)
			else
				validationState:set(true)
			end
		else
			validationState:set(nil)
		end
		-- Mirrored out so RunPage can gate the run on a failed check
		if props.validationStatus then
			props.validationStatus:set(Fusion.peek(validationState))
		end
	end

	local filterVersion = 0

	local function runFilter()
		if not filterText then return end
		local raw = Fusion.peek(textValue)
		if #raw == 0 then filterState:set(nil); updateValidationState(); return end
		if mustBeStringSafe and Fusion.peek(stringSafeState) == false then return end
		local filterTextAsync = require(modules.VerifyUtil.filterTextAsync)
		local callerUserId = Players.LocalPlayer and Players.LocalPlayer.UserId or 0
		local targetUserId = resolveTargetUserId(props.firstArgValue)
		local version = filterVersion
		task.spawn(function()
			local success, filtered = filterTextAsync(raw, callerUserId, targetUserId)
			if destroyed or filterVersion ~= version then return end
			if success then
				textValue:set(filtered)
				filterState:set(true)
				if props.value then props.value:set(filtered) end
			else
				filterState:set(false)
			end
			updateValidationState()
		end)
	end

	local function runStringSafeCheck(): boolean
		if not mustBeStringSafe then return true end
		local raw = Fusion.peek(textValue)
		if #raw == 0 then stringSafeState:set(nil); updateValidationState(); return true end
		local isStringSafe = require(modules.VerifyUtil.isStringSafe)
		local safe = isStringSafe(raw)
		stringSafeState:set(if safe then true else false)
		updateValidationState()
		return safe
	end

	scope:Observer(textValue):onChange(function()
		if destroyed then return end
		local current = Fusion.peek(textValue)
		if preventWhitespaces then
			local stripped = current:gsub("%s", "")
			if stripped ~= current then
				task.defer(function()
					if destroyed then return end
					textValue:set(stripped)
				end)
				return
			end
		end
		if props.value and not verifier then
			props.value:set(current)
		end
		if not hasInteracted then return end
		stringSafeState:set(nil)
		filterState:set(nil)
		updateValidationState()
		local safe = runStringSafeCheck()
		if filterText and safe then
			filterVersion += 1
			local version = filterVersion
			task.delay(0.8, function()
				if destroyed or filterVersion ~= version then return end
				runFilter()
			end)
		end
	end)

	local function onFocusLost()
		filterVersion += 1 -- skip debounce, run now
		local safe = runStringSafeCheck()
		if safe then
			runFilter()
		end
		if verifier then
			local current = Fusion.peek(textValue)
			local success, result = verifier(current)
			if not success then
				local Prompt = require(modules.Prompt)
				Prompt.warn(tostring(result))
				task.defer(function()
					if destroyed then return end
					textValue:set(previousText)
					if props.value then props.value:set(previousText) end
				end)
			else
				previousText = tostring(result)
				local resultStr = tostring(result)
				if resultStr ~= current then
					task.defer(function()
						if destroyed then return end
						textValue:set(resultStr)
						if props.value then props.value:set(resultStr) end
					end)
				end
			end
		end
	end

	local inputRow = InputRow(scope, {
		title = title,
		name = "TextInput",
		labelSize = props.labelSize,
		labelTextSize = props.labelTextSize,

		strokeFocused = isFocused,

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.None,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 6),
			},

			scope:New "TextBox" {
				Name = "TextInput",
				LayoutOrder = 1,
				AutoLocalize = false,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				ClearTextOnFocus = false,
				ClipsDescendants = true,
				MaxVisibleGraphemes = props.limitTextLength or -1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
				end),
				PlaceholderColor3 = Theme.Color.NeutralContentDark,
				PlaceholderText = title ~= "" and ("Enter " .. title) or "Enter text",
				Text = textValue,
				TextColor3 = Theme.Color.BaseContent,
				TextSize = Theme.TextSize.Subtitle,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,

				[Fusion.OnEvent "Focused"] = function()
					hasInteracted = true
					isFocused:set(true)
					if props.clearTextOnFocus then
						textValue:set("")
					end
				end,
				[Fusion.OnEvent "FocusLost"] = function()
					isFocused:set(false)
					onFocusLost()
				end,
				[Fusion.OnChange "Text"] = function(new: string)
					textValue:set(new)
				end,

				[Children] = {
					scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
				},
			},

			if showValidation then scope:New "ImageLabel" {
				Name = "ValidationStatus",
				LayoutOrder = 2,
				BackgroundTransparency = 1,
				Image = scope:Computed(function(use)
					return if use(validationState) == false then Icons.ValidationFail else Icons.ValidationSuccess
				end),
				ImageColor3 = scope:Computed(function(use)
					return if use(validationState) == false
						then use(Theme.Color.Error)
						else use(Theme.Color.Success)
				end),
				Size = UDim2.fromOffset(20, 20),
				Visible = scope:Computed(function(use)
					return use(validationState) ~= nil
				end),
			} else nil,
		},
	})

	if not showValidation then
		return inputRow
	end

	return scope:New "Frame" {
		Name = "TextInput",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 0),

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			inputRow,

			scope:New "TextLabel" {
				Name = "FilterWarning",
				LayoutOrder = 1,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 0),
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
				end),
				Text = validationWarning,
				TextColor3 = Theme.Color.Error,
				TextSize = scope:Computed(function(use)
					return (use(Theme.TextSize.Small) :: number) * 1.5
				end),
				TextXAlignment = Enum.TextXAlignment.Left,
				Visible = scope:Computed(function(use)
					return use(validationState) == false
				end),
				[Children] = {
					scope:New "UIPadding" {
						PaddingLeft = UDim.new(0, if props.labelSize
							then (props.labelSize :: UDim2).X.Offset + 6
							else 78),
						PaddingRight = UDim.new(0, 8),
						PaddingBottom = UDim.new(0, 4),
					},
				},
			},
		},
	}
end
