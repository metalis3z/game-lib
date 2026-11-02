--!strict

--[[

	Only prompt-able givers get listed. Sources like giveToUsers stay
	hidden so game devs aren't leaking who they've whitelisted

--]]


-- LOCAL
local MarketplaceService = game:GetService("MarketplaceService")
local GroupService = game:GetService("GroupService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local isInternalRole = require(modules.RoleUtil.isInternalRole)
local Children = Fusion.Children
local Popup = require(frontend.Components.Popup)
local Pressable = require(frontend.Components.Pressable)
local RoleBadge = require(frontend.Components.RoleBadge)
local Presets = require(frontend.Config.Presets) :: any
local promptPurchaseAsync = require(modules.AssetUtil.promptPurchaseAsync)
local ClientGroupJoin = require(modules.Parent.Controllers.ClientGroupJoin)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type GiverRow = {
	kind: string, -- "GamePass" | "Asset" | "Bundle" | "Group"
	id: number,
	infoType: Enum.InfoType?,
}
type Props = {
	visible: Fusion.Value<boolean>,
	roleKey: UsedAs<string>,
	roleInfoFuse: UsedAs<any>,
	youMemberFuse: UsedAs<any>,
	commandsFuse: UsedAs<any>,
}


-- HELPERS
local infoScope = Fusion.scoped({Value = Fusion.Value})
local resolvedInfo: Fusion.Value<{[string]: {name: string?, price: number?}}> = infoScope:Value({})
local pendingFetch: {[string]: true} = {}

local function fetchGiverInfo(row: GiverRow)
	local cacheKey = `{row.kind}:{row.id}`
	if pendingFetch[cacheKey] then return end
	if Fusion.peek(resolvedInfo)[cacheKey] then return end
	pendingFetch[cacheKey] = true
	task.spawn(function()
		local name: string? = nil
		local price: number? = nil
		if row.kind == "Group" then
			local ok, info = pcall(function()
				return GroupService:GetGroupInfoAsync(row.id)
			end)
			if ok and typeof(info) == "table" and typeof((info :: any).Name) == "string" then
				name = (info :: any).Name
			end
		else
			local ok, info = pcall(function()
				return MarketplaceService:GetProductInfo(row.id, row.infoType)
			end)
			if ok and typeof(info) == "table" then
				if typeof((info :: any).Name) == "string" then
					name = (info :: any).Name
				end
				price = tonumber((info :: any).PriceInRobux)
			end
		end
		local current = Fusion.peek(resolvedInfo)
		local new = table.clone(current)
		new[cacheKey] = {name = name, price = price}
		resolvedInfo:set(new)
	end)
end

local function listGivers(role: any): {GiverRow}
	local rows: {GiverRow} = {}
	local seen: {[string]: true} = {}
	local function add(kind: string, id: number, infoType: Enum.InfoType?)
		local key = `{kind}:{id}`
		if seen[key] then return end
		seen[key] = true
		table.insert(rows, {kind = kind, id = id, infoType = infoType})
	end
	if typeof(role) ~= "table" then return rows end
	local products = (role :: any).giveToProducts
	if typeof(products) == "table" then
		for _, entry in products :: {any} do
			if typeof(entry) ~= "table" then continue end
			local entryType = entry.type
			local id = entry.id
			if entryType == "GamePass" and typeof(id) == "number" then
				add("GamePass", id, Enum.InfoType.GamePass)
			elseif entryType == "Asset" and typeof(id) == "number" then
				add("Asset", id, Enum.InfoType.Asset)
			elseif entryType == "Bundle" and typeof(id) == "number" then
				add("Bundle", id, Enum.InfoType.Bundle)
			elseif entryType == "Preset" and typeof(entry.preset) == "string" then
				local preset = Presets.products[entry.preset]
				if preset and typeof(preset.id) == "number" then
					local infoType = preset.infoType
					if infoType == Enum.InfoType.GamePass then add("GamePass", preset.id, infoType)
					elseif infoType == Enum.InfoType.Asset then add("Asset", preset.id, infoType)
					elseif infoType == Enum.InfoType.Bundle then add("Bundle", preset.id, infoType)
					end
				end
			end
		end
	end
	local groups = (role :: any).giveToGroups
	if typeof(groups) == "table" then
		for _, entry in groups :: {any} do
			if typeof(entry) == "table" and typeof((entry :: any).groupId) == "number" then
				add("Group", (entry :: any).groupId, nil)
			end
		end
	end
	return rows
end

local function escapeRich(text: string): string
	return (text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local function giverImageUrl(row: GiverRow): string
	local thumbType = if row.kind == "Group" then "GroupIcon"
		elseif row.kind == "GamePass" then "GamePass"
		elseif row.kind == "Bundle" then "BundleThumbnail"
		else "Asset"
	return `rbxthumb://type={thumbType}&id={row.id}&w=150&h=150`
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local role = scope:Computed(function(use)
		local info = use(props.roleInfoFuse)
		local key = use(props.roleKey)
		if typeof(info) ~= "table" or typeof(key) ~= "string" then return nil end
		return (info :: any)[key]
	end)
	local roleName = scope:Computed(function(use)
		local roleData: any = use(role)
		if typeof(roleData) == "table" and typeof(roleData.name) == "string" then
			return roleData.name
		end
		local key = use(props.roleKey)
		return if typeof(key) == "string" then key else ""
	end)
	local roleColor = scope:Computed(function(use): Color3
		local roleData: any = use(role)
		if typeof(roleData) == "table" and typeof(roleData.color) == "Color3" then
			return roleData.color
		end
		return Color3.fromRGB(161, 161, 170)
	end)
	local isOwned = scope:Computed(function(use)
		local you = use(props.youMemberFuse)
		local key = use(props.roleKey)
		if typeof(you) ~= "table" or typeof((you :: any).roleKeys) ~= "table" then return false end
		for _, owned in (you :: any).roleKeys :: {string} do
			if owned == key then return true end
		end
		return false
	end)
	local givers = scope:Computed(function(use): {GiverRow}
		return listGivers(use(role))
	end)
	local commandAccess = scope:Computed(function(use): {total: number, usable: number, viaKey: string?}
		local result = {total = 0, usable = 0, viaKey = nil :: string?}
		local cmds = use(props.commandsFuse)
		local key = use(props.roleKey)
		if typeof(cmds) ~= "table" or typeof(key) ~= "string" then return result end
		local you = use(props.youMemberFuse)
		local ownedSet: {[string]: true} = {}
		if typeof(you) == "table" and typeof((you :: any).roleKeys) == "table" then
			for _, owned in (you :: any).roleKeys :: {string} do
				if owned ~= key then
					ownedSet[owned] = true
				end
			end
		end
		local coveredCounts: {[string]: number} = {}
		for _, cmd in cmds :: {any} do
			local cmdRoles = (cmd :: any).roles
			if typeof(cmdRoles) ~= "table" then continue end
			local includesRole = false
			for _, cmdRoleKey in cmdRoles :: {string} do
				if cmdRoleKey == key then
					includesRole = true
					break
				end
			end
			if not includesRole then continue end
			result.total += 1
			local usableHere = false
			for _, cmdRoleKey in cmdRoles :: {string} do
				if ownedSet[cmdRoleKey] then
					usableHere = true
					coveredCounts[cmdRoleKey] = (coveredCounts[cmdRoleKey] or 0) + 1
				end
			end
			if usableHere then
				result.usable += 1
			end
		end
		local info = use(props.roleInfoFuse)
		local bestCount = 0
		local bestRank = -1
		for ownedKey, count in coveredCounts do
			local rank = 0
			if typeof(info) == "table" and typeof((info :: any)[ownedKey]) == "table" then
				rank = tonumber(((info :: any)[ownedKey] :: any).rank) or 0
			end
			if count > bestCount or (count == bestCount and rank > bestRank) then
				result.viaKey = ownedKey
				bestCount = count
				bestRank = rank
			end
		end
		-- Only credit a role that covers ALL the commands, a part-cover would mislead
		if bestCount < result.total then
			result.viaKey = nil
		end
		return result
	end)
	local inheritsJuniors = scope:Computed(function(use): boolean
		local roleData: any = use(role)
		return typeof(roleData) == "table" and roleData.inheritCommandsFromJuniorRoles == true
	end)
	local juniorRoles = scope:Computed(function(use): {any}
		local roleData: any = use(role)
		if typeof(roleData) ~= "table" or roleData.inheritCommandsFromJuniorRoles ~= true then return {} end
		local info = use(props.roleInfoFuse)
		if typeof(info) ~= "table" then return {} end
		local myRank = tonumber(roleData.rank) or 0
		local out: {any} = {}
		for key, other in info :: {[string]: any} do
			if typeof(key) ~= "string" or typeof(other) ~= "table" then continue end
			if isInternalRole(other) then continue end
			if typeof(other.rank) ~= "number" or other.rank >= myRank then continue end
			table.insert(out, {
				key = key,
				name = if typeof(other.name) == "string" then other.name else key,
				color = if typeof(other.color) == "Color3" then other.color else Color3.fromRGB(161, 161, 170),
				rank = other.rank,
			})
		end
		table.sort(out, function(roleA, roleB)
			if roleA.rank ~= roleB.rank then return roleA.rank > roleB.rank end
			return roleA.key < roleB.key
		end)
		return out
	end)
	local function sectionTitle(text: UsedAs<string>, layoutOrder: number): Instance
		return scope:New "TextLabel" {
			Name = "SectionTitle",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			FontFace = scope:Computed(function(use)
				return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
			end),
			LayoutOrder = layoutOrder,
			Size = UDim2.fromScale(1, 0),
			Text = text,
			TextColor3 = Theme.Color.NeutralContentDark,
			TextSize = Theme.TextSize.Label,
			TextXAlignment = Enum.TextXAlignment.Left,
		}
	end

	local statusLine = scope:New "TextLabel" {
		Name = "Status",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		FontFace = scope:Computed(function(use)
			return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
		end),
		LayoutOrder = 1,
		RichText = true,
		Size = UDim2.fromScale(1, 0),
		Text = scope:Computed(function(use)
			if use(isOwned) then return "You have this role!" end
			local access = use(commandAccess)
			if access.viaKey ~= nil and access.total > 0 and access.usable >= access.total then
				local info = use(props.roleInfoFuse)
				local viaRole: any = if typeof(info) == "table" then (info :: any)[access.viaKey] else nil
				local viaName = if typeof(viaRole) == "table" and typeof(viaRole.name) == "string"
					then viaRole.name
					else access.viaKey :: string
				local viaHex = if typeof(viaRole) == "table" and typeof(viaRole.color) == "Color3"
					then viaRole.color:ToHex()
					else "ffffff"
				local viaRich = `<b><font color="#{viaHex}">{escapeRich(viaName)}</font></b>`
				return `You don't own this role yet, but can use its commands via your role {viaRich}`
			end
			local roleData: any = use(role)
			local roleTable = if typeof(roleData) == "table" then roleData else nil
			if roleTable and roleTable.giveToEveryone == true then
				return "This role is given to everyone"
			end
			if #use(givers) == 0 then
				if roleTable and roleTable.giveToPrivateServerOwner == true then
					return "This role is given to the private server owner"
				end
				return "This role can't be unlocked"
			end
			return "You don't own this role yet"
		end),
		TextColor3 = scope:Computed(function(use)
			return if use(isOwned) then use(roleColor) else use(Theme.Color.NeutralContentDark)
		end),
		TextSize = Theme.TextSize.Body,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
	}

	local commandCountLine = scope:New "TextLabel" {
		Name = "CommandCount",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		FontFace = scope:Computed(function(use)
			return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
		end),
		LayoutOrder = 3,
		Size = UDim2.fromScale(1, 0),
		Text = scope:Computed(function(use)
			local count = use(commandAccess).total
			local base = `Grants access to {count} command{if count == 1 then "" else "s"}`
			if use(inheritsJuniors) and #use(juniorRoles) > 0 then
				return `{base}, including from these junior roles:`
			end
			return base
		end),
		TextColor3 = Theme.Color.BaseContent,
		TextSize = Theme.TextSize.Body,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	}

	local unlockSection = scope:New "Frame" {
		Name = "UnlockSection",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 2,
		Size = UDim2.fromScale(1, 0),
		Visible = scope:Computed(function(use)
			return #use(givers) > 0
		end),
		[Children] = {
			scope:New "UIListLayout" {
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				VerticalFlex = Enum.UIFlexAlignment.None,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 8),
			},
			sectionTitle(scope:Computed(function(use)
				return if use(isOwned) then "Unlocked via:" else "How to unlock:"
			end), 1),
			scope:New "Frame" {
				Name = "GiverRows",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 2,
				Size = UDim2.fromScale(1, 0),
				[Children] = {
					scope:New "UIListLayout" {
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						VerticalFlex = Enum.UIFlexAlignment.None,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 8),
					},
					scope:ForValues(givers, function(_, innerScope: Scope, row: GiverRow)
						fetchGiverInfo(row)
						local cacheKey = `{row.kind}:{row.id}`
						local displayName = innerScope:Computed(function(use)
							local cached = use(resolvedInfo)[cacheKey]
							if cached and typeof(cached.name) == "string" then
								return cached.name :: string
							end
							return `{row.kind} {row.id}`
						end)
						local subtitle = row.kind
						local buttonLabel = innerScope:Computed(function(use)
							if row.kind == "Group" then return "Join" end
							local cached = use(resolvedInfo)[cacheKey]
							local price = if cached then cached.price else nil
							if typeof(price) == "number" and price > 0 then
								return `\u{E002} {price}`
							end
							return if cached then "Free" else "..."
						end)
						return innerScope:New "Frame" {
							Name = `Giver_{cacheKey}`,
							BackgroundColor3 = Theme.Color.NeutralContent,
							Size = UDim2.new(1, 0, 0, 48),
							[Children] = {
								innerScope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
								innerScope:New "UIStroke" {
									ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
									Color = Theme.Color.NeutralStroke,
								},
								innerScope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									HorizontalFlex = Enum.UIFlexAlignment.None,
									VerticalFlex = Enum.UIFlexAlignment.None,
									VerticalAlignment = Enum.VerticalAlignment.Center,
									SortOrder = Enum.SortOrder.LayoutOrder,
									Padding = UDim.new(0, 10),
								},
								innerScope:New "UIPadding" {
									PaddingLeft = UDim.new(0, 8),
									PaddingRight = UDim.new(0, 8),
								},

								innerScope:New "ImageLabel" {
									Name = "Icon",
									BackgroundColor3 = Theme.Color.Neutral,
									LayoutOrder = 1,
									Size = UDim2.fromOffset(34, 34),
									Image = giverImageUrl(row),
									[Children] = {
										innerScope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
									},
								},

								innerScope:New "Frame" {
									Name = "Labels",
									AutomaticSize = Enum.AutomaticSize.Y,
									BackgroundTransparency = 1,
									LayoutOrder = 2,
									Size = UDim2.fromScale(0, 0),
									[Children] = {
										innerScope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
										innerScope:New "UIListLayout" {
											HorizontalFlex = Enum.UIFlexAlignment.Fill,
											VerticalFlex = Enum.UIFlexAlignment.None,
											SortOrder = Enum.SortOrder.LayoutOrder,
											Padding = UDim.new(0, 2),
										},
										innerScope:New "TextLabel" {
											Name = "GiverName",
											AutomaticSize = Enum.AutomaticSize.Y,
											BackgroundTransparency = 1,
											FontFace = innerScope:Computed(function(use)
												return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
											end),
											LayoutOrder = 1,
											Size = UDim2.fromScale(1, 0),
											Text = displayName,
											TextColor3 = Theme.Color.BaseContent,
											TextSize = Theme.TextSize.Body,
											TextTruncate = Enum.TextTruncate.AtEnd,
											TextXAlignment = Enum.TextXAlignment.Left,
										},
										innerScope:New "TextLabel" {
											Name = "GiverSubtitle",
											AutomaticSize = Enum.AutomaticSize.Y,
											BackgroundTransparency = 1,
											FontFace = innerScope:Computed(function(use)
												return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
											end),
											LayoutOrder = 2,
											Size = UDim2.fromScale(1, 0),
											Text = subtitle,
											TextColor3 = Theme.Color.NeutralContentDark,
											TextSize = Theme.TextSize.Label,
											TextXAlignment = Enum.TextXAlignment.Left,
										},
									},
								},

								-- Always shown so the giver stays one tap away even when already owned
								Pressable(innerScope, {
									name = "PromptGiver",
									layoutOrder = 3,
									size = UDim2.fromOffset(78, 28),
									backgroundColor = Theme.Color.Primary,
									onActivate = function()
										if row.kind == "Group" then
											ClientGroupJoin.promptAndVerify(row.id)
										else
											task.spawn(promptPurchaseAsync, row.id, nil, row.infoType)
										end
									end,
									[Children] = {
										innerScope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
										innerScope:New "TextLabel" {
											Name = "Label",
											BackgroundTransparency = 1,
											FontFace = innerScope:Computed(function(use)
												return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
											end),
											Size = UDim2.fromScale(1, 1),
											Text = buttonLabel,
											TextColor3 = Theme.Color.PrimaryContent,
											TextSize = Theme.TextSize.Label,
											TextXAlignment = Enum.TextXAlignment.Center,
											TextYAlignment = Enum.TextYAlignment.Center,
										},
									},
								}),
							},
						}
					end),
				},
			},
		},
	}

	local inheritsSection = scope:New "Frame" {
		Name = "JuniorBadges",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 4,
		Size = UDim2.fromScale(1, 0),
		Visible = scope:Computed(function(use)
			return use(inheritsJuniors) and #use(juniorRoles) > 0
		end),
		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.None,
				VerticalFlex = Enum.UIFlexAlignment.None,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Wraps = true,
				Padding = UDim.new(0, 6),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			scope:ForValues(juniorRoles, function(_, innerScope: Scope, junior: any)
				return RoleBadge(innerScope, {
					id = innerScope:Value(junior.key),
					name = innerScope:Value(junior.name),
					color = innerScope:Value(junior.color),
					large = true,
					backgroundColor = Theme.Color.NeutralContent,
				})
			end),
		},
	}

	return Popup(scope, {
		visible = props.visible,
		title = roleName,
		titleContent = RoleBadge(scope, {
			id = props.roleKey,
			name = roleName,
			color = roleColor,
			large = true,
			backgroundColor = Theme.Color.NeutralContent,
		}),
		content = {
			statusLine,
			unlockSection,
			commandCountLine,
			inheritsSection,
		},
	})
end
