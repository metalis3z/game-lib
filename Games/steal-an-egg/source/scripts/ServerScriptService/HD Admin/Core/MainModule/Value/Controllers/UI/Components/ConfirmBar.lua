--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Pressable = require(frontend.Components.Pressable)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>

type Props = {
	hasPendingChanges: UsedAs<boolean>,
	confirmChanges: () -> (),
	undoChanges: () -> (),
	label: UsedAs<string>?, -- defaults to "Confirm?"
	layoutOrder: UsedAs<number>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local hasPendingChanges = props.hasPendingChanges
	local labelText: any = props.label or "Confirm?"

	return scope:New "Frame" {
		Name = "ConfirmBarWrap",
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		LayoutOrder = props.layoutOrder,
		Size = (scope :: any):Spring((scope :: any):Computed(function(use)
			return UDim2.new(1, 0, 0, if use(hasPendingChanges) then 54 else 0)
		end), 40, 1),

		[Children] = {
			scope:New "Frame" {
				Name = "ConfirmBar",
				-- Centre-anchored so the spring reveal grows symmetrically from the middle
				AnchorPoint = Vector2.new(0, 0.5),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Theme.Color.Neutral,
				Position = UDim2.new(0, 2, 0.5, 0),
				Size = UDim2.new(1, -7, 0, -2),

				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
					scope:New "UIStroke" {
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = Theme.Color.NeutralContent,
					},
					scope:New "UIPadding" {
						PaddingBottom = UDim.new(0, 14),
						PaddingLeft = UDim.new(0, 12),
						PaddingRight = UDim.new(0, 4),
						PaddingTop = UDim.new(0, 14),
					},

					scope:New "Frame" {
						Name = "LabelGroup",
						AnchorPoint = Vector2.new(0, 0.5),
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(0, 0.5),
						[Children] = {
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
							},
							scope:New "TextLabel" {
								Name = "Label",
								AutomaticSize = Enum.AutomaticSize.XY,
								BackgroundTransparency = 1,
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
								end),
								Text = labelText,
								TextColor3 = Theme.Color.BaseContent,
								TextSize = Theme.TextSize.Subtitle,
							},
						},
					},

					scope:New "Frame" {
						Name = "ButtonGroup",
						AnchorPoint = Vector2.new(1, 0.5),
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(1, 0.5),
						[Children] = {
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalFlex = Enum.UIFlexAlignment.None,
								Padding = UDim.new(0, 6),
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
							},

							Pressable(scope, {
								name = "ConfirmButton",
								size = UDim2.new(0, 0, 0, 0),
								automaticSize = Enum.AutomaticSize.XY,
								backgroundColor = Theme.Color.Primary,
								layoutOrder = 1,
								onActivate = props.confirmChanges,
								[Children] = {
									scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
									scope:New "UIPadding" {
										PaddingBottom = UDim.new(0, 7),
										PaddingLeft = UDim.new(0, 12),
										PaddingRight = UDim.new(0, 12),
										PaddingTop = UDim.new(0, 7),
									},
									scope:New "TextLabel" {
										Name = "Label",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										FontFace = (scope :: any):Computed(function(use: any)
											return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
										end),
										Text = "Confirm",
										TextColor3 = Theme.Color.PrimaryContent,
										TextSize = Theme.TextSize.Subtitle,
									},
								},
							}),

							Pressable(scope, {
								name = "UndoButton",
								size = UDim2.new(0, 0, 0, 0),
								automaticSize = Enum.AutomaticSize.XY,
								backgroundColor = Theme.Color.NeutralContent,
								layoutOrder = 2,
								onActivate = props.undoChanges,
								[Children] = {
									scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
									scope:New "UIPadding" {
										PaddingBottom = UDim.new(0, 7),
										PaddingLeft = UDim.new(0, 12),
										PaddingRight = UDim.new(0, 12),
										PaddingTop = UDim.new(0, 7),
									},
									scope:New "TextLabel" {
										Name = "Label",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										FontFace = (scope :: any):Computed(function(use: any)
											return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
										end),
										Text = "Undo",
										TextColor3 = Theme.Color.BaseContent,
										TextSize = Theme.TextSize.Subtitle,
									},
								},
							}),
						},
					},
				},
			},
		},
	}
end
