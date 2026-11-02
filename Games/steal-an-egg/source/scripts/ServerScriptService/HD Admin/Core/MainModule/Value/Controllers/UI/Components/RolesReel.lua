--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Navigate = require(frontend.Util.Navigate)
local Children = Fusion.Children

local RoleBadge = require(script.Parent.RoleBadge)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type RoleEntry = {
	id: string,
	name: string,
	color: Color3,
	level: number,
}
type Props = {
	roles: UsedAs<{ RoleEntry }>?,
	truncated: UsedAs<boolean>?, -- only shows top role + overflow count
	userId: UsedAs<number>?, -- badges show remove button when set
	onAddRole: UsedAs<() -> ()>?,
	onRemoveRole: UsedAs<(roleId: string, userId: number) -> ()>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local roles = props.roles or scope:Value({})
	local truncated = props.truncated or scope:Value(false)
	local userId = props.userId
	local onAddRole = props.onAddRole
	local onRemoveRole = props.onRemoveRole

	local function fireAddRole()
		local callback = onAddRole
		local handler = if typeof(callback) == "table" then Fusion.peek(callback) else callback
		if handler then handler() end
	end

	-- Caller sorts by level desc
	local primaryRole = scope:Computed(function(use)
		local list = use(roles)
		return list[1]
	end)

	local overflowCount = scope:Computed(function(use)
		local list = use(roles)
		return math.max(0, #list - 1)
	end)

	return scope:New "ScrollingFrame" {
		Name = "RolesReel",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.X,
		ScrollBarThickness = 0,
		ScrollingDirection = Enum.ScrollingDirection.X,
		Size = UDim2.fromScale(1, 0),

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 4),
			},

			scope:Computed(function(use)
				if not use(truncated) then return nil end
				local primary = use(primaryRole)
				if not primary then return nil end

				return scope:New "Frame" {
					Name = "TruncatedBadges",
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundTransparency = 1,
					[Children] = {
						scope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Horizontal,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							SortOrder = Enum.SortOrder.LayoutOrder,
							Padding = UDim.new(0, 4),
						},
						RoleBadge(scope, {
							id = scope:Value(primary.id),
							name = scope:Value(primary.name),
							color = scope:Value(primary.color),
						}),
						scope:Computed(function(use2)
							local count = use2(overflowCount)
							if count <= 0 then return nil end
							return RoleBadge(scope, {
								id = scope:Value("overflow"),
								name = scope:Value(`+{count}`),
								color = scope:Value(Theme.Color.NeutralContentDark),
							})
						end),
					},
				}
			end),

			scope:Computed(function(use)
				if use(truncated) then return nil end

				return scope:ForValues(roles, function(use2, innerScope, role: RoleEntry)
					return RoleBadge(innerScope, {
						id = innerScope:Value(role.id),
						name = innerScope:Value(role.name),
						color = innerScope:Value(role.color),
						userId = userId,
						onRemove = onRemoveRole,
					})
				end)
			end),

			scope:Computed(function(use)
				if use(truncated) then return nil end
				if not onAddRole then return nil end

				return Navigate.makeActivatable(scope:New "TextButton" {
					Name = "AddRole",
					AutoButtonColor = false,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Theme.Color.Neutral,
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
					Text = "",
					TextColor3 = Color3.new(),
					TextSize = 1,
					[Fusion.OnEvent "Activated"] = fireAddRole,
					[Children] = {
						scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
						scope:New "UIPadding" {
							PaddingTop = UDim.new(0, 4),
							PaddingBottom = UDim.new(0, 4),
							PaddingLeft = UDim.new(0, 8),
							PaddingRight = UDim.new(0, 8),
						},
						scope:New "ImageLabel" {
							BackgroundTransparency = 1,
							Image = "rbxassetid://13845892460",
							ImageColor3 = Theme.Color.NeutralContentMain,
							Size = UDim2.fromOffset(14, 14),
						},
					},
				}, fireAddRole)
			end),
		},
	}
end
