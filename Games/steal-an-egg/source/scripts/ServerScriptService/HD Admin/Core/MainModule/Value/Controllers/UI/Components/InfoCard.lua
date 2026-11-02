--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Navigate = require(frontend.Util.Navigate)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	title: UsedAs<string>?,
	titleIcon: UsedAs<string>?,
	body: UsedAs<string>?,
	color: UsedAs<Color3>?,
	onActivate: UsedAs<() -> ()>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local title = props.title or scope:Value("Title")
	local titleIcon = props.titleIcon
	local body = props.body or scope:Value("")
	local color = props.color or Theme.Color.Neutral
	local onActivate = props.onActivate

	local function fireActivate()
		local callback = onActivate
		if callback then
			local handler = if typeof(callback) == "table" then Fusion.peek(callback) else callback
			if handler then handler() end
		end
	end

	return Navigate.makeActivatable(scope:New "TextButton" {
		Name = "InfoCard",
		AutoButtonColor = false,
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = color,
		Size = UDim2.fromScale(1, 0),
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Text = "",
		TextColor3 = Color3.new(),
		TextSize = 1,

		[Fusion.OnEvent "Activated"] = fireActivate,

		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 9) },
			scope:New "UIPadding" {
				PaddingTop = UDim.new(0, 16),
				PaddingBottom = UDim.new(0, 16),
				PaddingLeft = UDim.new(0, 16),
				PaddingRight = UDim.new(0, 16),
			},
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralContent,
				Transparency = 0.5,
			},
			scope:New "UIListLayout" {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 8),
			},

			scope:New "Frame" {
				Name = "TitleRow",
				LayoutOrder = 1,
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				[Children] = {
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 6),
					},
					scope:Computed(function(use)
						local icon = titleIcon and use(titleIcon) or nil
						if icon and #icon > 0 then
							return scope:New "ImageLabel" {
								Name = "Icon",
								LayoutOrder = 1,
								BackgroundTransparency = 1,
								Image = icon,
								ImageColor3 = Theme.Color.BaseContent,
								Size = UDim2.fromOffset(18, 18),
							}
						end
						return nil
					end),
					scope:New "TextLabel" {
						Name = "Title",
						LayoutOrder = 2,
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
					end),
					Text = title,
					TextColor3 = Theme.Color.BaseContent,
					TextSize = Theme.TextSize.Body,
					},
				},
			},

			scope:New "TextLabel" {
				Name = "Body",
				LayoutOrder = 2,
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
				end),
				Text = body,
				TextColor3 = Theme.Color.NeutralContentMain,
				TextSize = Theme.TextSize.Label,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				Size = UDim2.fromScale(1, 0),
			},
		},
	}, fireActivate)
end
