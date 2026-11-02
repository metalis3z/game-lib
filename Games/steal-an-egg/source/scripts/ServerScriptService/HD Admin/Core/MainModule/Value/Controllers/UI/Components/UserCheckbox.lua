--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Navigate = require(frontend.Util.Navigate)
local Children = Fusion.Children

local UserDetails = require(script.Parent.UserDetails)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	userId: UsedAs<number>?,
	checked: UsedAs<boolean>?,
	label: UsedAs<string>?,
	onCheck: UsedAs<(checked: boolean) -> ()>?,
	onUserActivate: UsedAs<() -> ()>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local userId = props.userId or scope:Value(1)
	local isChecked = scope:Value(false)
	if props.checked ~= nil then
		isChecked = scope:Value(Fusion.peek(props.checked))
	end
	local label = props.label
	local onCheck = props.onCheck
	local onUserActivate = props.onUserActivate

	local function fireCheck()
		local next = not Fusion.peek(isChecked)
		isChecked:set(next)
		local callback = onCheck
		if callback then
			local handler = if typeof(callback) == "table" then Fusion.peek(callback) else callback
			if handler then handler(next) end
		end
	end

	local function fireUserActivate()
		local callback = onUserActivate
		if callback then
			local handler = if typeof(callback) == "table" then Fusion.peek(callback) else callback
			if handler then handler() end
		end
	end

	local checkColor = scope:Computed(function(use)
		return if use(isChecked) then Theme.Color.Primary else Theme.Color.NeutralContentDark
	end)

	return scope:New "Frame" {
		Name = "UserCheckbox",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = Theme.Color.Neutral,
		Size = UDim2.fromScale(1, 0),

		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 9) },
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
				Transparency = 0.5,
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 0),
			},

			Navigate.makeActivatable(scope:New "TextButton" {
				Name = "CheckZone",
				LayoutOrder = 1,
				AutoButtonColor = false,
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "",
				TextColor3 = Color3.new(),
				TextSize = 1,
				[Fusion.OnEvent "Activated"] = fireCheck,
				[Children] = {
					scope:New "UIPadding" {
						PaddingTop = UDim.new(0, 12),
						PaddingBottom = UDim.new(0, 12),
						PaddingLeft = UDim.new(0, 12),
						PaddingRight = UDim.new(0, 8),
					},
					scope:New "Frame" {
						Name = "Checkbox",
						Size = UDim2.fromOffset(18, 18),
						BackgroundColor3 = scope:Computed(function(use)
							return if use(isChecked)
									then use(Theme.Color.Primary)
									else use(Theme.Color.Neutral)
						end),
						[Children] = {
							scope:New "UICorner" { CornerRadius = UDim.new(0, 4) },
							scope:New "UIStroke" {
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
								Color = checkColor,
							},
							scope:New "ImageLabel" {
								Name = "Check",
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.5),
								Size = UDim2.fromScale(0.75, 0.75),
								BackgroundTransparency = 1,
								Image = "rbxassetid://13858820127",
								ImageColor3 = Theme.Color.PrimaryContent,
								Visible = isChecked,
							},
						},
					},
				},
			}, fireCheck),

			Navigate.makeActivatable(scope:New "TextButton" {
				Name = "UserZone",
				LayoutOrder = 2,
				AutoButtonColor = false,
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "",
				TextColor3 = Color3.new(),
				TextSize = 1,
				[Fusion.OnEvent "Activated"] = fireUserActivate,
				[Children] = {
					scope:New "UIPadding" {
						PaddingTop = UDim.new(0, 8),
						PaddingBottom = UDim.new(0, 8),
						PaddingLeft = UDim.new(0, 4),
						PaddingRight = UDim.new(0, 12),
					},
					UserDetails(scope, { userId = userId }),
				},
			}, fireUserActivate),

			scope:Computed(function(use)
				local text = label and use(label) or nil
				if not text or #text == 0 then return nil end
				return scope:New "TextLabel" {
					Name = "Label",
					LayoutOrder = 3,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
					end),
					Text = text,
					TextColor3 = Theme.Color.NeutralContentDark,
					TextSize = Theme.TextSize.Label,
					TextWrapped = false,
					[Children] = {
						scope:New "UIPadding" { PaddingRight = UDim.new(0, 12) },
					},
				}
			end),
		},
	}
end
