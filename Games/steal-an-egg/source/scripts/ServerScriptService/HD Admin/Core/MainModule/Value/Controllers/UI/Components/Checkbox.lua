--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	checked: UsedAs<boolean>,
	orderNumber: UsedAs<number?>?, -- shows number instead of checkmark when set
	disabled: UsedAs<boolean>?, -- dims only, the caller blocks clicks
	layoutOrder: UsedAs<number>?,
	visible: UsedAs<boolean>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local checked = props.checked
	local disabled = props.disabled

	local function isDisabled(use): boolean
		if disabled == nil then return false end
		if typeof(disabled) == "table" then return use(disabled :: any) == true end
		return disabled == true
	end

	local bgAlpha = scope:Spring(
		scope:Computed(function(use)
			if isDisabled(use) then return 1 end
			return if use(checked) then 0 else 1
		end),
		20, 1
	)

	local markAlpha = scope:Spring(
		scope:Computed(function(use)
			if isDisabled(use) then return 0.5 end
			return if use(checked) then 0 else 1
		end),
		20, 1
	)

	local markRotation = scope:Spring(
		scope:Computed(function(use)
			return if use(checked) then 0 else -30
		end),
		20, 1
	)

	local strokeColor = scope:Spring(
		scope:Computed(function(use)
			if isDisabled(use) then return use(Theme.Color.NeutralStroke) end
			return if use(checked) then use(Theme.Color.Primary) else use(Theme.Color.NeutralContentDark)
		end),
		40, 1
	)

	return scope:New "TextButton" {
		Name = "Checkbox",
		Active = false,
		AutoButtonColor = false,
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = Theme.Color.Primary,
		BackgroundTransparency = bgAlpha,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Interactable = false,
		LayoutOrder = props.layoutOrder or 0,
		Text = "",
		TextColor3 = Color3.new(),
		TextSize = 1,
		Visible = if props.visible ~= nil then props.visible else true,

		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = strokeColor,
			},

			if props.orderNumber == nil then scope:New "ImageLabel" {
				Name = "Checkmark",
				BackgroundTransparency = 1,
				Image = "rbxassetid://13858821963",
				ImageTransparency = markAlpha,
				Rotation = markRotation,
				Size = UDim2.fromOffset(18, 18),
			} else nil,

			if props.orderNumber ~= nil then scope:New "TextLabel" {
				Name = "OrderNumber",
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
				end),
				Rotation = markRotation,
				Size = UDim2.fromOffset(18, 18),
				Text = scope:Computed(function(use)
					local orderNumber = use(props.orderNumber :: any) :: number?
					return if orderNumber then tostring(orderNumber) else ""
				end),
				TextColor3 = Theme.Color.PrimaryContent,
				TextSize = Theme.TextSize.Body,
				TextTransparency = markAlpha,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
			} else nil,
		},
	}
end