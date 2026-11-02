--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local InputRow = require(script.Parent.InputRow)
local Pressable = require(script.Parent.Pressable)
local Icons = require(frontend.Config.Icons)
local Players = game:GetService("Players")


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	title: string?,
	default: any?,
	maxItems: number?,
	value: Fusion.Value<any>?,
	validationStatus: Fusion.Value<boolean?>?, -- false if any row's filter failed, else nil
	filterText: boolean?,
	firstArgValue: Fusion.UsedAs<any>?, -- used to derive targetUserId for filtering
	labelSize: UDim2?,
	labelTextSize: number?,
}

type FieldEntry = { id: number, textVal: Fusion.Value<string> }


-- LOCAL FUNCTIONS
-- Yields, call from task.spawn
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
	if typeof(val) == "number" and val > 0 then return val end
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
	local title: string = props.title or ""
	local maxItems: number = props.maxItems or 10
	local filterText = props.filterText == true

	-- RunPage gates the run on a failed check, so only false gets surfaced
	local rowFilterStates: {[number]: boolean?} = {}
	local function refreshFilterStatus()
		if not props.validationStatus then return end
		local anyFailed = false
		for _, state in rowFilterStates do
			if state == false then anyFailed = true; break end
		end
		props.validationStatus:set(if anyFailed then false else nil)
	end

	local existingValue = if props.value then Fusion.peek(props.value) else nil
	local defaults: {string} = if typeof(existingValue) == "table" and #(existingValue :: {any}) > 0 then existingValue :: {string}
		else if typeof(props.default) == "table" and #(props.default :: {any}) > 0 then props.default
		else if typeof(props.default) == "string" and #props.default > 0 then {props.default}
		else {""}

	local nextId = 0
	local function newId(): number nextId += 1; return nextId end

	local fields: Fusion.Value<{FieldEntry}> = scope:Value({})
	local protectedId: number = -1 -- first field can't be removed

	local function rebuild()
		if props.value then
			local arr: {string} = {}
			for _, entry in Fusion.peek(fields) do
				table.insert(arr, Fusion.peek(entry.textVal))
			end
			props.value:set(arr)
		end
	end

	local function addField(text: string)
		local current = Fusion.peek(fields)
		if #current >= maxItems then return end
		local tv: Fusion.Value<string> = scope:Value(text)
		scope:Observer(tv):onChange(rebuild)
		local entry: FieldEntry = { id = newId(), textVal = tv }
		if protectedId == -1 then protectedId = entry.id end
		local newFields = table.clone(current)
		table.insert(newFields, entry)
		fields:set(newFields)
		rebuild()
	end

	local function removeField(id: number)
		if id == protectedId then return end
		local current = Fusion.peek(fields)
		local newFields: {FieldEntry} = {}
		for _, entry in current do
			if entry.id ~= id then table.insert(newFields, entry) end
		end
		fields:set(newFields)
		rebuild()
	end

	for _, text in defaults do
		addField(text)
	end

	local canAdd: Fusion.Computed<boolean> = scope:Computed(function(use)
		return #use(fields) < maxItems
	end)

	return InputRow(scope, {
		title = title,
		name = "InputFields",
		labelSize = props.labelSize,
		labelTextSize = props.labelTextSize,
		autoHeight = true,
		frameTransparency = 1,
		hideStroke = true,
		framePaddingY = 0,
		framePaddingX = 0,
		labelPaddingTop = 8,

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 6),
			},

			scope:ForValues(fields, function(_, innerScope, entry: FieldEntry)
				local canDelete: boolean = entry.id ~= protectedId
				local isFocused: Fusion.Value<boolean> = innerScope:Value(false)
				local filterState: Fusion.Value<boolean?> = innerScope:Value(nil :: boolean?)
				local filterVersion = 0
				local fieldDestroyed = false
				local isApplyingFilter = false
				table.insert(innerScope, function() fieldDestroyed = true end)

				if filterText then
					innerScope:Observer(filterState):onChange(function()
						rowFilterStates[entry.id] = Fusion.peek(filterState)
						refreshFilterStatus()
					end)
					table.insert(innerScope, function()
						rowFilterStates[entry.id] = nil
						refreshFilterStatus()
					end)
				end

				local function runFilter()
					local raw = Fusion.peek(entry.textVal)
					if #raw == 0 then filterState:set(nil); return end
					local filterTextAsync = require(modules.VerifyUtil.filterTextAsync)
					local callerUserId = Players.LocalPlayer and Players.LocalPlayer.UserId or 0
					local targetUserId = resolveTargetUserId(props.firstArgValue)
					local version = filterVersion
					task.spawn(function()
						local success, filtered = filterTextAsync(raw, callerUserId, targetUserId)
						if fieldDestroyed or filterVersion ~= version then return end
						if success then
							isApplyingFilter = true
							entry.textVal:set(filtered)
							isApplyingFilter = false
							filterState:set(true)
						else
							filterState:set(false)
						end
					end)
				end

				-- isApplyingFilter stops runFilter's own set() re-triggering a reset
				if filterText then
					innerScope:Observer(entry.textVal):onChange(function()
						if fieldDestroyed or isApplyingFilter then return end
						filterState:set(nil)
						filterVersion += 1
						local version = filterVersion
						task.delay(0.5, function()
							if fieldDestroyed or filterVersion ~= version then return end
							runFilter()
						end)
					end)
				end

				local inputRow = InputRow(innerScope, {
					name = "Field_" .. entry.id,
					strokeFocused = isFocused,

					[Children] = {
						innerScope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Horizontal,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							SortOrder = Enum.SortOrder.LayoutOrder,
							Padding = UDim.new(0, 6),
						},

						innerScope:New "TextBox" {
							Name = "TextInput",
							LayoutOrder = 1,
							AutoLocalize = false,
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							ClearTextOnFocus = false,
							ClipsDescendants = true,
							FontFace = innerScope:Computed(function(use)
								return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
							end),
							PlaceholderColor3 = Theme.Color.NeutralContentDark,
							PlaceholderText = "Enter text...",
							Text = entry.textVal,
							TextColor3 = Theme.Color.BaseContent,
							TextSize = Theme.TextSize.Subtitle,
							TextXAlignment = Enum.TextXAlignment.Left,
							TextYAlignment = Enum.TextYAlignment.Top,
							[Fusion.OnEvent "Focused"] = function()
								isFocused:set(true)
							end,
							[Fusion.OnEvent "FocusLost"] = function(_: boolean)
								isFocused:set(false)
								if filterText then
									filterVersion += 1
									runFilter()
								end
							end,
							[Fusion.OnChange "Text"] = function(new: string)
								entry.textVal:set(new)
							end,
							[Children] = {
								innerScope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
								if filterText then innerScope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									HorizontalAlignment = Enum.HorizontalAlignment.Right,
									VerticalAlignment = Enum.VerticalAlignment.Center,
									SortOrder = Enum.SortOrder.LayoutOrder,
								} else nil,
								if filterText then innerScope:New "ImageLabel" {
									Name = "FilterStatus",
									BackgroundTransparency = 1,
									Image = innerScope:Computed(function(use)
										return if use(filterState) == false then Icons.ValidationFail else Icons.ValidationSuccess
									end),
									ImageColor3 = innerScope:Computed(function(use)
										return if use(filterState) == false
											then use(Theme.Color.Error)
											else use(Theme.Color.Success)
									end),
									Size = UDim2.fromOffset(20, 20),
									Visible = innerScope:Computed(function(use)
										return use(filterState) ~= nil
									end),
								} else nil,
							},
						},

						if canDelete then Pressable(innerScope, {
							name = "RemoveButton",
							layoutOrder = 2,
							size = UDim2.fromOffset(20, 20),
							iconImage = Icons.Close,
							iconColor = Theme.Color.NeutralContentDark,
							iconSize = 12,
							onActivate = function() removeField(entry.id) end,
						}) else nil,
					},
				})

				if not filterText then
					return innerScope:New "Frame" {
						Name = "Field_" .. entry.id,
						LayoutOrder = entry.id,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 0),
						[Children] = {
							inputRow,
						},
					}
				end

				return innerScope:New "Frame" {
					Name = "Field_" .. entry.id,
					LayoutOrder = entry.id,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 0),
					[Children] = {
						innerScope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Vertical,
							HorizontalFlex = Enum.UIFlexAlignment.Fill,
							SortOrder = Enum.SortOrder.LayoutOrder,
						},
						innerScope:New "Frame" {
							LayoutOrder = 0,
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 0),
							[Children] = {
								inputRow,
							},
						},
						innerScope:New "TextLabel" {
							Name = "FilterWarning",
							LayoutOrder = 1,
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 0),
							FontFace = innerScope:Computed(function(use)
								return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
							end),
							Text = "Text may fail filter",
							TextColor3 = Theme.Color.Error,
							TextSize = innerScope:Computed(function(use)
								return (use(Theme.TextSize.Small) :: number) * 1.5
							end),
							TextXAlignment = Enum.TextXAlignment.Left,
							Visible = innerScope:Computed(function(use)
								return use(filterState) == false
							end),
							[Children] = {
								innerScope:New "UIPadding" {
									PaddingLeft = UDim.new(0, 8),
									PaddingRight = UDim.new(0, 8),
									PaddingBottom = UDim.new(0, 4),
								},
							},
						},
					},
				}
			end),

			Pressable(scope, {
				name = "AddButton",
				layoutOrder = 99999,
				size = UDim2.fromOffset(34, 34),
				backgroundColor = Theme.Color.Primary,
				darken = true,
				visible = canAdd,
				onActivate = function() addField("") end,
				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 6),
					},
					scope:New "TextLabel" {
						Name = "Label",
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
						FontFace = Font.new(
							"rbxasset://fonts/families/BuilderSans.json",
							Enum.FontWeight.Light,
							Enum.FontStyle.Normal
						),
						Text = "+",
						TextColor3 = Theme.Color.PrimaryContent,
						TextSize = 30,
					},
				},
			}),
		},
	})
end
