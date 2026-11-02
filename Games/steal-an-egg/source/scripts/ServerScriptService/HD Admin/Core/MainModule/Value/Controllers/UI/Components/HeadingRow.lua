--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local SplitRow = require(frontend.Components.SplitRow)
local Pressable = require(frontend.Components.Pressable)
local HintIcon = require(frontend.Components.HintIcon)
local LoadingSpinner = require(frontend.Components.LoadingSpinner)
local Icons = require(frontend.Config.Icons)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>

export type Entry = {
	key: string,
	name: string,
	color: Color3?,
}

type Props = {
	entry: UsedAs<Entry>, -- accepts a static table OR a Value/Computed<Entry>
	onActivate: ((key: string) -> ())?,
	onDragStart: ((key: string, handle: Instance, cursorY: number, cursorX: number) -> ())?,
	hideDrag: UsedAs<boolean>?,
	roleInfoFuse: UsedAs<any>?,
	defaultRoleInfoFuse: UsedAs<any>?,
	useDefaults: UsedAs<boolean>?, -- true reads name/colour from defaultRoleInfoFuse
	active: UsedAs<boolean>?, -- when true, draws a Primary stroke around the row
	nameFontWeight: UsedAs<Enum.FontWeight>?, -- defaults to Theme.FontWeight.Body
	interactable: UsedAs<boolean>?, -- false disables the left nav slot's hover/press/click
	unlockState: UsedAs<string?>?, -- "unlock" | "unlocked" | nil hides, set replaces the drag handle
	onUnlock: ((key: string) -> ())?,
	rightLabel: UsedAs<string?>?, -- unlockState wins if both set
	previewState: UsedAs<string?>?, -- "active" | "inactive" | nil hides
	onPreviewToggle: ((key: string) -> ())?,
	hintIcon: UsedAs<string?>?, -- hover/tap reveals hintText
	hintText: UsedAs<string>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	debug.profilebegin("HD_HeadingRow")
	local entryProp = props.entry
	local onActivate = props.onActivate
	local onDragStart = props.onDragStart
	local hideDrag = props.hideDrag
	local roleInfoFuse = props.roleInfoFuse
	local defaultRoleInfoFuse = props.defaultRoleInfoFuse
	local useDefaults = props.useDefaults
	local active = props.active

	local initialEntry: Entry = Fusion.peek(entryProp :: any) :: Entry

	local headingName = scope:Computed(function(use)
		local entry = use(entryProp :: any) :: Entry
		if roleInfoFuse then
			-- Not hideDrag, rank-locked rows also hide the drag but still show saved names
			local gameWideDefaults = useDefaults ~= nil and use(useDefaults :: any) == true
			local source = if gameWideDefaults and defaultRoleInfoFuse
				then use(defaultRoleInfoFuse :: any)
				else use(roleInfoFuse :: any)
			if typeof(source) == "table" then
				local data = source[entry.key]
				if typeof(data) == "table" and typeof(data.name) == "string" then
					return data.name
				end
			end
		end
		return entry.name
	end)

	local headingColor = scope:Computed(function(use)
		local entry = use(entryProp :: any) :: Entry
		if roleInfoFuse then
			local gameWideDefaults = useDefaults ~= nil and use(useDefaults :: any) == true
			local source = if gameWideDefaults and defaultRoleInfoFuse
				then use(defaultRoleInfoFuse :: any)
				else use(roleInfoFuse :: any)
			if typeof(source) == "table" then
				local data = source[entry.key]
				if typeof(data) == "table" and typeof(data.color) == "Color3" then
					return data.color
				end
			end
		end
		return entry.color or Color3.fromRGB(161, 161, 170)
	end)

	local dragVisible: any = if hideDrag then scope:Computed(function(use)
		return use(hideDrag :: any) ~= true
	end) else nil

	local dragSlotRef: Fusion.Value<Instance?> = scope:Value(nil)

	local unlockStateProp = props.unlockState
	local hasUnlockProp = unlockStateProp ~= nil

	-- Blocks presses for two seconds so a slow purchase prompt can't be spammed
	local unlockLoading = scope:Value(false)
	local unlockDestroyed = false
	table.insert(scope, function()
		unlockDestroyed = true
	end)

	local unlockVisible: any = nil
	local unlockBg: any = nil
	local unlockText: any = nil
	local unlockTextColor: any = nil
	if hasUnlockProp then
		unlockVisible = scope:Computed(function(use)
			local state = use(unlockStateProp :: any)
			return state == "unlock" or state == "unlocked"
		end)
		-- NeutralContent blends into the row's hover highlight, NeutralStroke stays distinct
		unlockBg = scope:Computed(function(use)
			local state = use(unlockStateProp :: any)
			if state == "unlock" then return use(headingColor :: any) :: Color3 end
			return use(Theme.Color.NeutralStroke)
		end)
		unlockText = scope:Computed(function(use)
			local state = use(unlockStateProp :: any)
			if state == "unlock" then return "UNLOCK" end
			if state == "unlocked" then return "UNLOCKED" end
			return ""
		end)
		unlockTextColor = scope:Computed(function(use)
			local state = use(unlockStateProp :: any)
			if state == "unlock" then
				local bg = use(headingColor :: any) :: Color3
				local luminance = 0.299 * bg.R + 0.587 * bg.G + 0.114 * bg.B
				return if luminance > 0.55 then Color3.fromRGB(20, 20, 24) else Color3.fromRGB(255, 255, 255)
			end
			return use(Theme.Color.NeutralContentDark)
		end)
	end

	local rightLabelProp = props.rightLabel
	local hasRightLabel = rightLabelProp ~= nil and not hasUnlockProp

	local strokeColorOverride: any = if active ~= nil then scope:Computed(function(use)
		if use(active :: any) then
			return use(headingColor :: any) :: Color3
		end
		return use(Theme.Color.NeutralStroke)
	end) else nil

	local row = SplitRow(scope, {
		name = "HeadingRow_" .. initialEntry.key,
		strokeColor = strokeColorOverride,
		zIndex = 3,

		left = {
			name = "HeadingNav_" .. initialEntry.key,
			fills = true,
			interactable = props.interactable,
			onActivate = function()
				if onActivate then
					local currentEntry = Fusion.peek(entryProp :: any) :: Entry
					onActivate(currentEntry.key)
				end
			end,
			[Children] = {
				scope:New "Frame" {
					Name = "ContentGroup",
					AnchorPoint = Vector2.new(0, 0.5),
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 12, 0.5, 0),
					[Children] = {
						scope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Horizontal,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							Padding = UDim.new(0, 10),
							SortOrder = Enum.SortOrder.LayoutOrder,
						},

						scope:New "Frame" {
							Name = "ColorDot",
							BackgroundColor3 = headingColor,
							LayoutOrder = 1,
							Size = UDim2.fromOffset(10, 10),
							[Children] = {
								scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
								scope:New "UIStroke" {
									ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
									Color = Theme.Color.NeutralStroke,
									Transparency = 0.5,
								},
							},
						},

						scope:New "TextLabel" {
							Name = "Name",
							AutomaticSize = Enum.AutomaticSize.XY,
							BackgroundTransparency = 1,
							FontFace = scope:Computed(function(use)
								local weight = if props.nameFontWeight ~= nil
									then use(props.nameFontWeight :: any) :: Enum.FontWeight
									else use(Theme.FontWeight.Body)
								return Font.new(use(Theme.Font.Body), weight)
							end),
							LayoutOrder = 2,
							Text = headingName,
							TextColor3 = Theme.Color.BaseContent,
							TextSize = Theme.TextSize.Subtitle,
						},

						-- A list sibling, anchoring inside an AutomaticSize TextLabel
						-- inflates it and recentres the text
						if props.hintIcon ~= nil then scope:New "Frame" {
							Name = "HintSlot",
							BackgroundTransparency = 1,
							LayoutOrder = 3,
							Size = UDim2.fromOffset(10, 20),
							Visible = scope:Computed(function(use)
								local icon = use(props.hintIcon :: any)
								return typeof(icon) == "string" and icon ~= ""
							end),
							[Children] = {
								HintIcon(scope, {
									icon = scope:Computed(function(use)
										local icon = use(props.hintIcon :: any)
										return if typeof(icon) == "string" then icon else ""
									end),
									hintText = props.hintText or "",
									anchorPoint = Vector2.new(0, 0.5),
									position = UDim2.new(0, -6, 0.5, 0),
									size = UDim2.fromOffset(16, 20),
								}),
							},
						} else nil,
					},
				},

				-- Lives inside the left Pressable so clicks don't hit the row's nav
				if hasUnlockProp then Pressable(scope, {
					name = "UnlockButton_" .. initialEntry.key,
					anchorPoint = Vector2.new(1, 0.5),
					position = UDim2.new(1, -8, 0.5, 0),
					size = UDim2.new(0, 90, 0, 28),
					backgroundColor = unlockBg,
					visible = unlockVisible,
					zIndex = 5,
					onActivate = function()
						-- Peek the live entry, the sticky header mounts once with a placeholder key
						local state: any = if typeof(unlockStateProp) == "table"
							then Fusion.peek(unlockStateProp :: any)
							else unlockStateProp
						if state == "unlock" and props.onUnlock then
							if Fusion.peek(unlockLoading) then return end
							unlockLoading:set(true)
							task.delay(2, function()
								if not unlockDestroyed then
									unlockLoading:set(false)
								end
							end)
							local currentEntry = Fusion.peek(entryProp :: any) :: Entry
							props.onUnlock(currentEntry.key)
						end
					end,
					[Children] = {
						scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
						scope:New "TextLabel" {
							Name = "Label",
							BackgroundTransparency = 1,
							FontFace = scope:Computed(function(use)
								return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
							end),
							Size = UDim2.fromScale(1, 1),
							Text = unlockText,
							TextColor3 = unlockTextColor,
							TextSize = Theme.TextSize.Label,
							TextXAlignment = Enum.TextXAlignment.Center,
							TextYAlignment = Enum.TextYAlignment.Center,
							Visible = scope:Computed(function(use)
								return not use(unlockLoading)
							end),
						},

						scope:New "Frame" {
							Name = "Loader",
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 1),
							Visible = unlockLoading,
							[Children] = {
								scope:New "UIListLayout" {
									HorizontalAlignment = Enum.HorizontalAlignment.Center,
									VerticalAlignment = Enum.VerticalAlignment.Center,
									SortOrder = Enum.SortOrder.LayoutOrder,
								},
								LoadingSpinner(scope, {
									size = 11,
									thickness = 2,
									color = unlockTextColor,
									paddingY = 0,
									visible = unlockLoading,
								}),
							},
						},
					},
				}) else nil,

				if hasRightLabel then scope:New "TextLabel" {
					Name = "RightLabel_" .. initialEntry.key,
					AnchorPoint = Vector2.new(1, 0.5),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
					end),
					Position = UDim2.new(1, -12, 0.5, 0),
					Size = UDim2.new(0, 0, 1, 0),
					Text = rightLabelProp,
					TextColor3 = Theme.Color.NeutralContentDark,
					TextSize = Theme.TextSize.Label,
					TextXAlignment = Enum.TextXAlignment.Right,
					TextYAlignment = Enum.TextYAlignment.Center,
					ZIndex = 5,
				} else nil,
			},
		},

		center = if props.previewState ~= nil then {
			name = "PreviewSlot_" .. initialEntry.key,
			fills = false,
			visible = scope:Computed(function(use): boolean
				local raw = props.previewState
				local state = if typeof(raw) == "table" then use(raw :: any) else raw
				return state == "active" or state == "inactive"
			end),
			onActivate = function()
				local callback = props.onPreviewToggle
				if callback then
					local currentEntry = Fusion.peek(entryProp :: any) :: Entry
					callback(currentEntry.key)
				end
			end,
			[Children] = {
				scope:New "ImageLabel" {
					Name = "PreviewIcon",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Image = scope:Computed(function(use): string
						local raw = props.previewState
						local state = if typeof(raw) == "table" then use(raw :: any) else raw
						if state == "active" then return "rbxassetid://71274079722169" end
						return "rbxassetid://86304612989533"
					end),
					ImageColor3 = scope:Computed(function(use): Color3
						local raw = props.previewState
						local state = if typeof(raw) == "table" then use(raw :: any) else raw
						if state == "active" then return use(Theme.Color.Primary) end
						return use(Theme.Color.NeutralContentDark)
					end),
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromOffset(18, 18),
				},
			},
		} else nil,

		right = if hasUnlockProp or hasRightLabel then nil else {
			name = "DragHandle_" .. initialEntry.key,
			fills = false,
			visible = dragVisible,
			ref = dragSlotRef,
			onActivate = function() end,
			[Children] = {
				scope:New "ImageLabel" {
					Name = "DragIcon",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Image = Icons.DragHandle,
					ImageColor3 = Theme.Color.NeutralContentDark,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromOffset(18, 18),
				},
			},
		},
	})

	if onDragStart then
		local dragBtn = Fusion.peek(dragSlotRef) :: TextButton?
		if dragBtn then
			scope:New "TextButton" {
				Name = "DragCatcher",
				Active = true,
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Size = UDim2.fromScale(1, 1),
				Text = "",
				TextColor3 = Color3.new(),
				TextSize = 1,
				ZIndex = 5,
				Parent = dragBtn,
				[Fusion.OnEvent "InputBegan"] = function(input: InputObject)
					if input.UserInputType ~= Enum.UserInputType.MouseButton1
						and input.UserInputType ~= Enum.UserInputType.Touch then
						return
					end
					-- Only accept fresh presses, not touches that dragged in from outside
					if input.UserInputState ~= Enum.UserInputState.Begin then
						return
					end
					if onDragStart then
						local currentEntry = Fusion.peek(entryProp :: any) :: Entry
						onDragStart(currentEntry.key, dragBtn :: Instance, input.Position.Y, input.Position.X)
					end
				end,
			}
		end
	end

	debug.profileend()
	return row
end
