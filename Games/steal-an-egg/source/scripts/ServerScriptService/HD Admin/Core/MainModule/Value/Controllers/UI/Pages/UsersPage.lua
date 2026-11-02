--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local UserCheckbox = require(frontend.Components.UserCheckbox)
local Pressable = require(frontend.Components.Pressable)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	userIds: UsedAs<{number}>?,
	selection: Fusion.Value<{number}>?,
	confirmLabel: UsedAs<string>?,
	onConfirm: UsedAs<(selection: {number}) -> ()>?,
	onUserActivate: UsedAs<(userId: number) -> ()>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local allUserIds: any = props.userIds or scope:Value({} :: {number})
	local selection: Fusion.Value<{number}> = props.selection or scope:Value({} :: {number})
	local confirmLabel: any = props.confirmLabel or "Confirm"
	local onConfirm = props.onConfirm
	local onUserActivate = props.onUserActivate

	local searchQuery: Fusion.Value<string> = scope:Value("")

	local filteredIds = scope:Computed(function(use)
		local ids = use(allUserIds)
		local query = use(searchQuery):lower()
		if query == "" then return ids end
		return ids
	end)

	local hasSelection = scope:Computed(function(use)
		return #use(selection) > 0
	end)

	-- ForValues gives the callback no index, so rows read their position from
	-- this map to keep list order stable when the id list changes
	local orderByUserId = scope:Computed(function(use): {[number]: number}
		local map: {[number]: number} = {}
		for index, userId in use(filteredIds) :: {number} do
			map[userId] = index
		end
		return map
	end)

	local buttonText = scope:Computed(function(use)
		local label = if typeof(confirmLabel) == "table" then use(confirmLabel) else confirmLabel
		local sel = use(selection)
		if #sel > 0 then
			return label .. " (" .. tostring(#sel) .. ")"
		end
		return label
	end)

	return scope:New "Frame" {
		Name = "UsersPage",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				Padding = UDim.new(0, 0),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			scope:New "Frame" {
				Name = "SearchBar",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Theme.Color.Neutral,
				LayoutOrder = 1,
				Size = UDim2.new(1, 0, 0, 0),

				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
					scope:New "UIStroke" {
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = Theme.Color.NeutralContent,
						Transparency = 0.5,
						Thickness = 1,
					},
					scope:New "UIPadding" {
						PaddingTop = UDim.new(0, 9),
						PaddingBottom = UDim.new(0, 9),
						PaddingLeft = UDim.new(0, 12),
						PaddingRight = UDim.new(0, 12),
					},
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						Padding = UDim.new(0, 8),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},

					scope:New "ImageLabel" {
						BackgroundTransparency = 1,
						Image = "rbxassetid://3926305904",
						ImageColor3 = Theme.Color.NeutralContentDark,
						LayoutOrder = 1,
						Size = UDim2.fromOffset(14, 14),
					},
					scope:New "TextBox" {
						BackgroundTransparency = 1,
						ClearTextOnFocus = false,
						FontFace = scope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
						end),
						LayoutOrder = 2,
						PlaceholderColor3 = Theme.Color.NeutralContentDark,
						PlaceholderText = "Search users...",
						Size = UDim2.new(1, -22, 0, 20),
						Text = searchQuery,
						TextColor3 = Theme.Color.BaseContent,
						TextSize = Theme.TextSize.Label,
						TextXAlignment = Enum.TextXAlignment.Left,

						[Fusion.OnChange "Text"] = function(newText: string)
							searchQuery:set(newText)
						end,
					},
				},
			},

			scope:New "ScrollingFrame" {
				Name = "UserList",
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				CanvasSize = UDim2.new(),
				ClipsDescendants = true,
				LayoutOrder = 2,
				ScrollBarThickness = 0,
				Size = UDim2.new(1, 0, 1, -80),

				[Children] = {
					scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						Padding = UDim.new(0, 6),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					scope:New "UIPadding" { PaddingTop = UDim.new(0, 8) },

					scope:ForValues(filteredIds, function(_, innerScope, userId: number)
						local isChecked = innerScope:Computed(function(use)
							return table.find(use(selection), userId) ~= nil
						end)
						return innerScope:New "Frame" {
							Name = "Row_" .. tostring(userId),
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							LayoutOrder = innerScope:Computed(function(use): number
								return (use(orderByUserId) :: {[number]: number})[userId] or 0
							end),
							Size = UDim2.new(1, 0, 0, 0),
							[Children] = {
								UserCheckbox(innerScope, {
									userId = userId,
									isChecked = isChecked,
									onCheck = function(checked: boolean)
										local current = table.clone(Fusion.peek(selection))
										if checked then
											if not table.find(current, userId) then
												table.insert(current, userId)
											end
										else
											local idx = table.find(current, userId)
											if idx then table.remove(current, idx) end
										end
										selection:set(current)
									end,
									onUserActivate = function()
										local callback = onUserActivate
										if callback then
											local handler = if typeof(callback) == "table" then Fusion.peek(callback) else callback
											if handler then handler(userId) end
										end
									end,
								}),
							},
						}
					end),
				},
			},

			scope:New "Frame" {
				Name = "Footer",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 3,
				Size = UDim2.new(1, 0, 0, 0),

				[Children] = {
					scope:New "UIPadding" { PaddingTop = UDim.new(0, 8) },
					Pressable(scope, {
						name = "ConfirmButton",
						automaticSize = Enum.AutomaticSize.Y,
						backgroundColor = scope:Computed(function(use)
							return if use(hasSelection)
							then use(Theme.Color.Primary)
							else use(Theme.Color.NeutralContent)
						end),
						size = UDim2.new(1, 0, 0, 0),

						onActivate = function()
							if not Fusion.peek(hasSelection) then return end
							local callback = onConfirm
							if callback then
								local handler = if typeof(callback) == "table" then Fusion.peek(callback) else callback
								if handler then handler(table.clone(Fusion.peek(selection))) end
							end
						end,

						[Children] = {
							scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
							scope:New "UIPadding" {
								PaddingTop = UDim.new(0, 10),
								PaddingBottom = UDim.new(0, 10),
							},
							scope:New "TextLabel" {
								Name = "Label",
								AutomaticSize = Enum.AutomaticSize.XY,
								BackgroundTransparency = 1,
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
								end),
								Text = buttonText,
								TextColor3 = scope:Computed(function(use)
									return if use(hasSelection)
										then use(Theme.Color.BaseContent)
										else use(Theme.Color.NeutralContentDark)
									end),
								TextSize = Theme.TextSize.Body,
							},
						},
					}),
				},
			},
		},
	}
end
