--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Pressable = require(frontend.Components.Pressable)
local Icons = require(frontend.Config.Icons)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
export type Props = {
	visible: Fusion.Value<boolean>,
	title: UsedAs<string>,
	titleContent: any?, -- replaces the title label
	content: {any},
	actions: {any}?, -- footer button row
	onClose: (() -> ())?, -- defaults to visible:set(false)
	dismissible: boolean?, -- defaults true, false makes backdrop/X no-ops
	backdropDismiss: boolean?, -- defaults true, false absorbs backdrop clicks (X still works)
	showClose: boolean?,
	zIndex: number?, -- card uses this + 1
	anchorPoint: Vector2?,
	cardSize: UDim2?, -- defaults to fill parent minus Theme.Layout.Padding
	cardWidth: UsedAs<number>?, -- fixed width with auto height, ignored when cardSize is set
	topPadding: number?, -- inside the card above the header, defaults to 8
	backdropTransparency: number?, -- 1 removes the dimmed click-away area
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local baseZ = props.zIndex or 10
	local cardZ = baseZ + 1
	local dismissible = if props.dismissible == nil then true else props.dismissible
	local backdropDismiss = if props.backdropDismiss == nil then true else props.backdropDismiss
	local showClose = if props.showClose == nil then true else props.showClose

	local function close()
		if not dismissible then return end
		if props.onClose then
			props.onClose()
		else
			props.visible:set(false)
		end
	end

	local function onBackdropActivate()
		if not backdropDismiss then return end
		close()
	end

	local cardChildren: {any} = {
		scope:New "UICorner" {
			CornerRadius = scope:Computed(function(use)
				return UDim.new(0, use(Theme.Layout.CornerRadius) :: number)
			end),
		},
		scope:New "UIStroke" {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Theme.Color.NeutralStroke,
		},
		scope:New "UIPadding" {
			PaddingTop = UDim.new(0, props.topPadding or 8),
			PaddingBottom = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
			PaddingLeft = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
			PaddingRight = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
		},
		scope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 10),
		},
	}

	local headerChildren: {any} = {
		scope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		},
		if props.titleContent then scope:New "Frame" {
			Name = "TitleContent",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 1,
			Size = UDim2.fromScale(0, 0),
			ZIndex = cardZ,
			[Children] = {
				scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
				scope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.None,
					VerticalFlex = Enum.UIFlexAlignment.None,
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				props.titleContent,
			},
		} else scope:New "TextLabel" {
			Name = "Title",
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundTransparency = 1,
			FontFace = scope:Computed(function(use)
				return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
			end),
			LayoutOrder = 1,
			Text = props.title,
			TextColor3 = Theme.Color.BaseContent,
			TextSize = Theme.TextSize.Subtitle,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = cardZ,
			[Children] = {
				scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
			},
		},
	}
	if showClose then
		table.insert(headerChildren, Pressable(scope, {
			name = "CloseButton",
			layoutOrder = 2,
			size = scope:Computed(function(use)
				local textSize = use(Theme.TextSize.Subtitle) :: number
				return UDim2.fromOffset(textSize, textSize)
			end),
			zIndex = cardZ,
			iconImage = Icons.Close,
			iconColor = Theme.Color.NeutralContentDark,
			iconSize = Theme.TextSize.Subtitle,
			onActivate = close,
			[Children] = {
				scope:New "UIAspectRatioConstraint" { AspectRatio = 1 },
			},
		}))
	end
	table.insert(cardChildren, scope:New "Frame" {
		Name = "Header",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 1,
		Size = UDim2.fromScale(1, 0),
		ZIndex = cardZ,
		[Children] = headerChildren,
	})

	local hasFixedCard = props.cardSize ~= nil
	local bodyChildren: {any} = {
		scope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			VerticalFlex = if hasFixedCard then Enum.UIFlexAlignment.Fill else Enum.UIFlexAlignment.None,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
		},
		table.unpack(props.content),
	}
	if hasFixedCard then
		table.insert(bodyChildren, 1, scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill })
	end
	table.insert(cardChildren, scope:New "Frame" {
		Name = "Body",
		AutomaticSize = if hasFixedCard then Enum.AutomaticSize.None else Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		ClipsDescendants = false,
		LayoutOrder = 2,
		Size = UDim2.fromScale(1, 0),
		ZIndex = cardZ,
		[Children] = bodyChildren,
	})

	if props.actions and #props.actions > 0 then
		table.insert(cardChildren, scope:New "Frame" {
			Name = "Actions",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 3,
			Size = UDim2.fromScale(1, 0),
			ZIndex = cardZ,
			[Children] = {
				scope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
				},
				table.unpack(props.actions),
			},
		})
	end

	return scope:New "Frame" {
		Name = "Popup",
		BackgroundColor3 = Theme.Color.NeutralDark,
		BackgroundTransparency = if props.backdropTransparency ~= nil then props.backdropTransparency else 0.05,
		Position = UDim2.fromScale(0, 0),
		Size = UDim2.fromScale(1, 1),
		Visible = props.visible,
		ZIndex = baseZ,

		[Children] = {
			scope:New "UICorner" {
				CornerRadius = UDim.new(0, 6),
			},
			Pressable(scope, {
				name = "Backdrop",
				size = UDim2.fromScale(1, 1),
				zIndex = baseZ,
				onActivate = onBackdropActivate,
			}),
			-- A TextButton so clicks inside the card don't reach the Backdrop
			scope:New "TextButton" {
				Name = "Card",
				Active = true,
				AutoButtonColor = false,
				AutomaticSize = if hasFixedCard then Enum.AutomaticSize.None else Enum.AutomaticSize.Y,
				AnchorPoint = props.anchorPoint or Vector2.new(0.5, 0.5),
				BackgroundColor3 = Theme.Color.Neutral,
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = props.cardSize or scope:Computed(function(use)
					if props.cardWidth ~= nil then
						return UDim2.fromOffset(use(props.cardWidth :: any) :: number, 0)
					end
					return UDim2.new(1, -(use(Theme.Layout.Padding) :: number) * 2, 0, 0)
				end),
				Text = "",
				TextSize = 1,
				TextTransparency = 1,
				ZIndex = cardZ,
				[Children] = cardChildren,
			},
		},
	}
end
